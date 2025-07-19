FROM python:2.7

SHELL ["/bin/bash", "-c"]

RUN git clone --recurse-submodules https://github.com/kendallgoto/ilo4_unlock.git

WORKDIR /ilo4_unlock

RUN ./build.sh init

RUN python2 -m virtualenv venv && source venv/bin/activate && pip install -r requirements.txt

ARG ILO4_VERSION=277

RUN source venv/bin/activate && ./build.sh $ILO4_VERSION

FROM scratch

COPY --from=0 /ilo4_unlock/build output/firmware
COPY --from=0 /ilo4_unlock/binaries/flash_ilo4 output
COPY --from=0 /ilo4_unlock/binaries/CP027911.xml output

