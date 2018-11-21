FROM lsstsqre/centos:7-stackbase-devtoolset-6
LABEL maintainer Owen Boberg <boberg37@gmail.com>

ENV USER ${USER:-opsim}
ENV HOME /home/opsim

# Create user and group
RUN groupadd opsim && adduser -m -g opsim -s /bin/bash opsim

USER root

RUN yum install -y boost-devel

USER opsim

WORKDIR /home/opsim/

RUN source scl_source enable devtoolset-6; \
    mkdir stack && \
    cd stack && \
    git clone https://github.com/lsst/lsstsw.git && \
    cd lsstsw && \
    unset PYTHONPATH && \
    ./bin/deploy

# rebuild -r origin/tickets/OPSIM-748 ts_scheduler
#WORKDIR /home/opsim/stack
#
#RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh; \
#    conda update -y -n base conda && \
#    conda install -y ipython jupyter tornado jinja2 scipy ephem gitpython && \
#    conda update -y pyqt fontconfig sqlalchemy && \
#    cd ../ && \
#    python -c 'import matplotlib.pyplot' && \
#    conda clean -ay
#
#RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh; \
#    conda install -y -c conda-forge jupyterlab  basemap && \
#    jupyter serverextension enable --py jupyterlab --sys-prefix

# Create a UUID file for Qt's DBUS

#RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh; dbus-uuidgen > /etc/machine-id

USER opsim
WORKDIR /home/opsim

