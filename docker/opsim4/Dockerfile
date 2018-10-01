FROM oboberg/opsim4_fbs_py3:stackpy3-20180928
LABEL maintainer Owen Boberg <boberg37@gmail.com>

USER root

RUN source scl_source enable devtoolset-6; source /home/opsim/stack/loadLSST.bash

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

RUN source scl_source enable devtoolset-6; source /home/opsim/stack/loadLSST.bash; \
    eups declare scipy system -r none -m none && \
    eups declare ephem system -r none -m none && \
    eups declare matplotlib system -r none -m none && \
    eups declare ts_salpytools git -r ./repos/salpytools -c && \
    eups declare scheduler_config git -r ./repos/scheduler_config -c && \
    eups declare sims_cloudModel git -r ./repos/sims_cloudModel -c && \
    eups declare sims_downtimeModel git -r ./repos/sims_downtimeModel -c && \
    eups declare sims_featureScheduler git -r ./repos/sims_featureScheduler -c && \
    eups declare sims_ocs git -r ./repos/sims_ocs -c && \
    eups declare sims_seeingModel git -r ./repos/sims_seeingModel -c && \
    eups declare sims_skybrightness_pre git -r ./repos/sims_skybrightness_pre -c && \
    eups declare sims_skybrightness git -r ./repos/sims_skybrightness -c && \
    eups declare sims_speedObservatory git -r ./repos/sims_speedObservatory -c && \
    eups declare sims_utils git -r ./repos/sims_utils -c && \
    eups declare sims_photUtils git -r ./repos/sims_photUtils -c && \
    eups declare throughputs git -r ./repos/throughputs -c && \
    eups declare sims_skybrightness_data git -r ./repos/sims_skybrightness_data -c && \
    eups declare ts_astrosky_model git -r ./repos/ts_astrosky_model -c && \
    eups declare ts_dateloc git -r ./repos/ts_dateloc -c && \
    eups declare ts_observatory_model git -r ./repos/ts_observatory_model -c && \
    eups declare ts_proposalScheduler git -r ./repos/ts_proposalScheduler  -c && \
    eups declare ts_scheduler git -r ./repos/ts_scheduler -c && \
    eups declare ts_schedulerConfig git -r ./repos/ts_schedulerConfig  -c && \
    eups declare ts_statemachine git -r ./repos/ts_statemachine  -c && \
    setup sims_utils -t sims && \
    # sims_seeingModel
    cd /home/opsim/repos/sims_seeingModel && \
    git checkout master && \
    setup sims_seeingModel git && \
    scons && \
    # sims_cloudModel
    cd /home/opsim/repos/sims_cloudModel && \
    git checkout master && \
    setup sims_cloudModel git && \
    scons && \
    # sims_downtimeModel
    cd /home/opsim/repos/sims_downtimeModel && \
    git checkout master && \
    setup sims_downtimeModel git && \
    scons && \
    # ts_dateloc
    cd /home/opsim/repos/ts_dateloc && \
    git checkout master && \
    setup ts_dateloc git && \
    scons && \
    # throughputs
    cd /home/opsim/repos/throughputs && \
    git checkout master && \
    setup throughputs git && \
    # sims_skybrightness_data
    cd /home/opsim/repos/sims_skybrightness_data && \
    git checkout master && \
    setup sims_skybrightness_data git && \
    # sims_photUtils
    cd /home/opsim/repos/sims_photUtils && \
    git checkout master && \
    setup sims_photUtils git && \
    scons && \
    # sims_skybrightness
    cd /home/opsim/repos/sims_skybrightness && \
    setup sims_skybrightness git && \
    scons && \
    # sims_skybrightness_pre
    cd /home/opsim/repos/sims_skybrightness_pre && \
    setup sims_skybrightness_pre git && \
    scons && \
    # ts_astrosky_model
    cd /home/opsim/repos/ts_astrosky_model && \
    git checkout master && \
    setup ts_astrosky_model git && \
    # sims_speedObservatory
    cd /home/opsim/repos/sims_speedObservatory && \
    git checkout master && \
    setup sims_speedObservatory git && \
    scons && \
    # sims_featureScheduler
    cd /home/opsim/repos/sims_featureScheduler && \
    git checkout master && \
    setup sims_featureScheduler git && \
    scons && \
    # sims_ocs
    cd /home/opsim/repos/sims_ocs && \
    git checkout master && \
    setup sims_ocs git && \
    scons && \
    # ts_statemachine
    cd /home/opsim/repos/ts_statemachine && \
    git checkout develop && \
    setup ts_statemachine git && \
    scons && \
    # ts_scheduler
    cd /home/opsim/repos/ts_scheduler && \
    git checkout master && \
    setup ts_scheduler git && \
    scons && \
    # ts_observatory_model
    cd /home/opsim/repos/ts_observatory_model && \
    git checkout master && \
    setup ts_observatory_model git && \
    scons && \
    # ts_schedulerConfig
    cd /home/opsim/repos/ts_schedulerConfig && \
    setup ts_schedulerConfig git && \
    # ts_proposalScheduler
    cd /home/opsim/repos/ts_proposalScheduler && \
    git checkout master && \
    setup ts_proposalScheduler git && \
    # scons && \
    # scheduler_config
    cd /home/opsim/repos/scheduler_config && \
    git checkout master && \
    setup scheduler_config git && \
    scons && \
    # salpytools
    cd /home/opsim/repos/salpytools && \
    git checkout master && \
    setup ts_salpytools git && \
    # ts_xml
    cd /home/opsim/repos/ts_xml && \
    git checkout scheduler/develop && \
    eups declare ts_xml git -r . -c && \
    setup ts_xml git && \
    cd /home/opsim

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
