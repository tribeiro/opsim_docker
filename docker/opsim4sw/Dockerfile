FROM oboberg/opsim4_fbs_py3:stackswpy3-20180928
LABEL maintainer Owen Boberg <boberg37@gmail.com>

USER root

RUN source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh

USER opsim
WORKDIR /home/opsim

RUN mkdir repos && \
    cd repos && \
    git clone https://github.com/lsst-ts/salpytools.git && \
    git clone https://github.com/lsst-ts/scheduler_config && \
    git clone https://github.com/lsst/sims_cloudModel.git && \
    git clone https://github.com/lsst/sims_downtimeModel.git && \
    git clone https://github.com/lsst/sims_featureScheduler.git && \
    git clone https://github.com/lsst-sims/sims_ocs.git && \
    git clone https://github.com/lsst/sims_seeingModel.git && \
    git clone https://github.com/lsst/sims_skybrightness_pre.git && \
    git clone https://github.com/lsst/sims_skybrightness.git && \
    git clone https://github.com/lsst-sims/sims_speedObservatory.git && \
    git clone https://github.com/lsst/sims_utils.git && \
    git clone https://github.com/lsst-ts/ts_astrosky_model.git && \
    git clone https://github.com/lsst-ts/ts_dateloc.git && \
    git clone https://github.com/lsst-ts/ts_observatory_model.git && \
    git clone https://github.com/lsst-ts/ts_proposalScheduler.git && \
    git clone https://github.com/lsst-ts/ts_scheduler.git && \
    git clone https://github.com/lsst-ts/ts_schedulerConfig.git && \
    git clone https://github.com/lsst-ts/ts_statemachine.git && \
    git clone https://github.com/lsst-ts/ts_xml.git && \
    git clone https://github.com/lsst/sims_photUtils.git && \
    git clone https://github.com/lsst/throughputs.git && \
    git clone https://github.com/lsst/sims_skybrightness_data.git && \
    git clone https://github.com/lsst-ts/ts_opensplice.git && \
    cd ../

RUN mkdir /home/opsim/sky_brightness_data

ADD --chown=opsim:opsim ./smallSky/data /home/opsim/repos/sims_skybrightness_pre/data/
RUN ln -s /home/opsim/repos/sims_skybrightness_pre/data/healpix /home/opsim/sky_brightness_data

ENV NDDS_DISCOVERY_PEERS=builtin.shmem:// \
    OPENSPLICE_LOC=${HOME}/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux \
    SCHED_TOPIC_LIB=${HOME}/dds/lib \
    SIMS_SKYBRIGHTNESS_DATA=${HOME}/sky_brightness_data
ENV OSPL_URI=file://${OPENSPLICE_LOC}/etc/config/ospl.xml \
    LD_LIBRARY_PATH=${OPENSPLICE_LOC}/lib:${SCHED_TOPIC_LIB}:${LD_LIBRARY_PATH} \
    PYTHONPATH=${SCHED_TOPIC_LIB}:${PYTHONPATH}

### TODO: Need lsstsw build of opsim.

ADD --chown=opsim:opsim ./startup_fbs.sh /home/opsim/startup_fbs.sh
RUN chmod +x /home/opsim/startup_fbs.sh
ADD --chown=opsim:opsim ./.opsim4_profile_fbs /home/opsim/.opsim4_profile_fbs

ADD --chown=opsim:opsim ./pull_repos.sh /home/opsim/pull_repos.sh
RUN chmod +x /home/opsim/pull_repos.sh

ADD --chown=opsim:opsim ./pull_and_config.sh /home/opsim/pull_and_config.sh
RUN chmod +x /home/opsim/pull_and_config.sh

ADD --chown=opsim:opsim ./run_and_config.sh /home/opsim/run_and_config.sh
RUN chmod +x /home/opsim/run_and_config.sh

ADD --chown=opsim:opsim ./dds_libs/SALPY_scheduler.so /home/opsim/dds/lib/SALPY_scheduler.so

ADD --chown=opsim:opsim  ./dds_libs/libsacpp_scheduler_types.so /home/opsim/dds/lib/libsacpp_scheduler_types.so

RUN chmod +x /home/opsim/dds/lib/libsacpp_scheduler_types.so

RUN chmod +x /home/opsim/dds/lib/SALPY_scheduler.so

RUN mkdir /home/opsim/default_configs
ADD --chown=opsim:opsim ./default_configs/dome.py /home/opsim/default_configs/dome.py
ADD --chown=opsim:opsim ./default_configs/rotator.py /home/opsim/default_configs/rotator.py


ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/opsim/startup_fbs.sh"]
