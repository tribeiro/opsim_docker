#!/bin/bash
export LSST_DDS_DOMAIN=SOCS-DOCKER-${HOSTNAME}

source scl_source enable devtoolset-6; source /home/opsim/stack/lsstsw/bin/setup.sh


# sims_seeingModel
cd /home/opsim/repos/sims_seeingModel
git checkout master
setup sims_seeingModel git
scons
# sims_cloudModel
cd /home/opsim/repos/sims_cloudModel
git checkout master
setup sims_cloudModel git
scons
# sims_downtimeModel
cd /home/opsim/repos/sims_downtimeModel
git checkout master
setup sims_downtimeModel git
scons
# ts_dateloc
cd /home/opsim/repos/ts_dateloc
git checkout master
setup ts_dateloc git
scons
# throughputs
cd /home/opsim/repos/throughputs
git checkout master
setup throughputs git
# sims_skybrightness_data
cd /home/opsim/repos/sims_skybrightness_data
git checkout master
scons
# sims_photUtils
cd /home/opsim/repos/sims_photUtils
git checkout master
setup sims_photUtils git
scons
# sims_skybrightness
cd /home/opsim/repos/sims_skybrightness
setup sims_skybrightness git
# sims_skybrightness_pre
cd /home/opsim/repos/sims_skybrightness_pre
setup sims_skybrightness_pre git
scons
# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model
git checkout master
setup ts_astrosky_model git
# sims_speedObservatory
cd /home/opsim/repos/sims_speedObservatory
git checkout master
setup sims_speedObservatory git
scons
# sims_featureScheduler
cd /home/opsim/repos/sims_featureScheduler
git checkout master
setup sims_featureScheduler git
scons
# sims_ocs
cd /home/opsim/repos/sims_ocs
git checkout master
setup sims_ocs git
scons
# ts_statemachine
cd /home/opsim/repos/ts_statemachine
git checkout develop
setup ts_statemachine git
scons
# ts_scheduler
cd /home/opsim/repos/ts_scheduler
git checkout master
setup ts_scheduler git
scons
# ts_observatory_model
cd /home/opsim/repos/ts_observatory_model
git checkout master
setup ts_observatory_model git
scons
# ts_schedulerConfig
cd /home/opsim/repos/ts_schedulerConfig
git checkout master
setup ts_schedulerConfig git
scons
# ts_proposalScheduler
cd /home/opsim/repos/ts_proposalScheduler
git checkout master
setup ts_proposalScheduler git
# scheduler_config
cd /home/opsim/repos/scheduler_config
setup scheduler_config git
cd /home/opsim
# salpytools
cd /home/opsim/repos/salpytools
setup ts_salpytools git
cd /home/opsim
# ts_xml
cd /home/opsim/repos/ts_xml
git checkout scheduler/develop
setup ts_xml git
cd /home/opsim
# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model
git checkout master
setup ts_astrosky_model git
scons

cd /home/opsim

/bin/bash --rcfile /home/opsim/.opsim4_profile_fbs
