FROM lsstsqre/centos:7-stackbase-devtoolset-6
LABEL maintainer Owen Boberg <boberg37@gmail.com>

ENV USER ${USER:-opsim}
ENV HOME /home/opsim

# Create user and group
RUN groupadd opsim && adduser -m -g opsim -s /bin/bash opsim

USER root

RUN yum remove -y git

RUN yum groupinstall -y "Development Tools"

RUN yum install -y gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel

WORKDIR /home/opsim

# Update git
RUN wget https://www.kernel.org/pub/software/scm/git/git-2.14.1.tar.gz
RUN tar -zxf git-2.14.1.tar.gz
WORKDIR /home/opsim/git-2.14.1
RUN ./configure; \
    make && \
    make install && \
    hash -r

WORKDIR /home/opsim

RUN rm -rf /home/opsim/git-2.14.1
RUN rm git-2.14.1.tar.gz

USER opsim
WORKDIR /home/opsim

RUN source scl_source enable devtoolset-6; \
    mkdir stack && \
    cd stack && \
    git clone https://github.com/lsst/lsstsw.git && \
    cd lsstsw && \
    unset PYTHONPATH && \
    ./bin/deploy

WORKDIR /home/opsim/stack

RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh; \
    conda update -y -n base conda && \
    conda install -y ipython jupyter tornado jinja2 scipy ephem gitpython && \
    conda update -y pyqt fontconfig sqlalchemy && \
    cd ../ && \
    python -c 'import matplotlib.pyplot' && \
    conda clean -ay

RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh; \
    conda install -y -c conda-forge jupyterlab  basemap && \
    jupyter serverextension enable --py jupyterlab --sys-prefix

# Create a UUID file for Qt's DBUS
USER root

RUN yum install -y boost-devel

RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh; dbus-uuidgen > /etc/machine-id

USER opsim
WORKDIR /home/opsim

