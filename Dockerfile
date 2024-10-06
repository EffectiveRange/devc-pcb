FROM kicad/kicad:8.0.5

USER root

RUN apt update && apt install -y --no-install-recommends apt-utils python3-jsonschema python3-pandas python3-openpyxl python3-lxml xvfb git pigz

RUN mkdir -p /usr/share/ && \
    git clone -b master --depth=1 https://github.com/openscopeproject/InteractiveHtmlBom.git /usr/share/InteractiveHtmlBom && \
    git clone -b master --depth=1 https://gitlab.com/kicad/libraries/kicad-packages3D.git /usr/share/kicad-packages3D  && \
    ln -sfv /usr/share/kicad-packages3D /usr/share/kicad/3dmodels 



COPY scripts /usr/share/pcb-release

COPY pcb.schema.json  /usr/share/pcb-release/pcb.schema.json

RUN  /bin/bash -c "for f in \$(ls -1 /usr/share/pcb-release/*); do ln -sv \$f /usr/bin/\$(basename \$f);done"


COPY  --chown=kicad:kicad  test /home/kicad/test

RUN  /home/kicad/test/test_runner.sh && rm -rf /home/kicad/test/

USER kicad
