#!/bin/bash
export LSST_DDS_DOMAIN=SOCS-DOCKER-${HOSTNAME}

source scl_source enable devtoolset-6; source /home/opsim/stack/loadLSST.bash

# sims_seeingModel
cd /home/opsim/repos/sims_seeingModel && \
git pull && \
git checkout master && \
setup sims_seeingModel git && \
scons && \
# sims_cloudModel
cd /home/opsim/repos/sims_cloudModel && \
git pull && \
git checkout master && \
setup sims_cloudModel git && \
scons && \
# sims_downtimeModel
cd /home/opsim/repos/sims_downtimeModel && \
git pull && \
git checkout master && \
setup sims_downtimeModel git && \
scons && \
# ts_dateloc
cd /home/opsim/repos/ts_dateloc && \
git pull && \
git checkout master && \
setup ts_dateloc git && \
scons && \
# sims_skybrightness
cd /home/opsim/repos/sims_skybrightness && \
git pull && \
setup sims_skybrightness git && \
scons && \
# sims_skybrightness_pre
cd /home/opsim/repos/sims_skybrightness_pre && \
git pull && \
setup sims_skybrightness_pre git && \
scons && \
# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model && \
git pull && \
git checkout master && \
setup ts_astrosky_model git && \
# sims_speedObservatory
cd /home/opsim/repos/sims_speedObservatory && \
git pull && \
git checkout master && \
setup sims_speedObservatory git && \
scons && \
# sims_featureScheduler
cd /home/opsim/repos/sims_featureScheduler && \
git pull && \
git checkout master && \
setup sims_featureScheduler git && \
scons && \
# sims_schedulerConfig
cd /home/opsim/repos/sims_schedulerConfig && \
git pull && \
git checkout master && \
setup sims_schedulerConfig git && \
scons && \
# sims_ocs
cd /home/opsim/repos/sims_ocs && \
git pull && \
git checkout master && \
setup sims_ocs git && \
scons && \
# ts_statemachine
cd /home/opsim/repos/ts_statemachine && \
git pull && \
git checkout master && \
setup ts_statemachine git && \
scons && \
# ts_scheduler
cd /home/opsim/repos/ts_scheduler && \
git pull && \
git checkout master && \
setup ts_scheduler git && \
scons && \
# ts_observatory_model
cd /home/opsim/repos/ts_observatory_model && \
git pull && \
git checkout master && \
setup ts_observatory_model git && \
scons && \
# opsim4_config_ui
cd /home/opsim/repos/opsim4_config_ui && \
git pull && \
setup opsim4_config_ui git && \
scons && \
# scheduler_config
cd /home/opsim/repos/scheduler_config && \
git pull &&\
setup scheduler_config git && \
cd /home/opsim
# ts_schedulerConfig
cd /home/opsim/repos/ts_schedulerConfig && \
git pull &&\
setup ts_schedulerConfig git && \
scons && \
# salpytools
cd /home/opsim/repos/salpytools && \
git pull && \
get_branch
git checkout master && \
setup salpytools git && \
# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model
git pull
git checkout master
setup ts_astrosky_model git
scons

cd /home/opsim

/bin/bash --rcfile /home/opsim/.opsim4_profile_fbs
