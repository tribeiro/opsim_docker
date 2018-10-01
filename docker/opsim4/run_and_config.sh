#!/bin/bash
NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
export LSST_DDS_DOMAIN=SOCS-DOCKER-${HOSTNAME}-${NEW_UUID}

source scl_source enable devtoolset-6; source /home/opsim/stack/loadLSST.bash

DEFAULT_FBS_SCHEDULER_BRANCH="master"
DEFAULT_OPSIM_RUN_OPTS="-h"

usage() {
  cat <<EOD

  Usage: $(basename "$0") [options]

  This command builds an OpSim4 image.

  Available options:
    -s          Version for the Scheduler code. Defaults to $DEFAULT_FBS_SCHEDULER_BRANCH
    -r		A string with options to pass to opsim. If not given will print opsim help page
EOD
}

# get the options
while getopts "h:s:r:" c; do
    case $c in
            h) usage ; exit 0 ;;
            s) FBS_SCHEDULER_BRANCH="$OPTARG" ;;
	    r) OPSIM_RUN_OPTS="$OPTARG" ;;
            \?) usage ; exit 2 ;;
    esac
done

get_branch() {
    branch_list=$FBS_SCHEDULER_BRANCH
    run_branch="master"

    for branch in $(echo $branch_list | tr "," "\n");do
	echo $branch
	echo git rev-parse --verify "origin/$branch"
	git rev-parse --verify "origin/$branch"
	branch_found=$?
	echo $branch $run_branch
	if [ $branch_found -eq 0 ]; then
            run_branch=$branch
            break
	fi
    done

    echo "Choose branch:" $run_branch
}

shift "$((OPTIND-1))"
if [ $# -ne 0 ] ; then
    usage
    exit 2
fi

if [ -z $FBS_SCHEDULER_BRANCH ] ; then
    FBS_SCHEDULER_BRANCH=$DEFAULT_FBS_SCHEDULER_BRANCH
else
    FBS_SCHEDULER_BRANCH="$FBS_SCHEDULER_BRANCH"
fi

if [ -z "$OPSIM_RUN_OPTS" ] ; then
    OPSIM_RUN_OPTS=$DEFAULT_OPSIM_RUN_OPTS
else
    OPSIM_RUN_OPTS="$OPSIM_RUN_OPTS"
fi

# sims_seeingModel
cd /home/opsim/repos/sims_seeingModel
get_branch
git checkout $run_branch
setup sims_seeingModel git
scons
# sims_cloudModel
cd /home/opsim/repos/sims_cloudModel
get_branch
git checkout $run_branch
setup sims_cloudModel git
scons
# sims_downtimeModel
cd /home/opsim/repos/sims_downtimeModel
get_branch
git checkout $run_branch
setup sims_downtimeModel git
scons
# ts_dateloc
cd /home/opsim/repos/ts_dateloc
get_branch
git checkout $run_branch
setup ts_dateloc git
scons
# throughputs
cd /home/opsim/repos/throughputs
git checkout master
setup throughputs git
# sims_skybrightness_data
cd /home/opsim/repos/sims_skybrightness_data
git checkout master
setup sims_skybrightness_data git
# sims_photUtils
cd /home/opsim/repos/sims_photUtils
git checkout master
setup sims_photUtils git
scons
# sims_skybrightness
cd /home/opsim/repos/sims_skybrightness
get_branch
git checkout $run_branch
setup sims_skybrightness git
scons
# sims_skybrightness_pre
cd /home/opsim/repos/sims_skybrightness_pre
get_branch
git checkout $run_branch
setup sims_skybrightness_pre git
scons
# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model
get_branch
git checkout $run_branch
setup ts_astrosky_model git
# sims_speedObservatory
cd /home/opsim/repos/sims_speedObservatory
git checkout master
setup sims_speedObservatory git
scons
# sims_featureScheduler
if [ $SCHEDULER = "feature" ]; then
    cd /home/opsim/repos/sims_featureScheduler && \
	# git checkout "$@" && \
    get_branch
    git checkout $run_branch
    setup sims_featureScheduler git && \
	scons
else
    echo "Skipping feature based scheduler..."
fi
# sims_ocs
cd /home/opsim/repos/sims_ocs
get_branch
git checkout $run_branch
setup sims_ocs git
scons
# ts_statemachine
cd /home/opsim/repos/ts_statemachine
get_branch
git checkout develop
setup ts_statemachine git
scons
# ts_scheduler
cd /home/opsim/repos/ts_scheduler
get_branch
git checkout $run_branch
setup ts_scheduler git
scons
# ts_observatory_model
cd /home/opsim/repos/ts_observatory_model
get_branch
git checkout $run_branch
setup ts_observatory_model git
scons
# ts_schedulerConfig
cd /home/opsim/repos/ts_schedulerConfig
get_branch
git checkout $run_branch
setup ts_schedulerConfig git
scons
# ts_proposalScheduler
cd /home/opsim/repos/ts_proposalScheduler
get_branch
git checkout $run_branch
setup ts_proposalScheduler git
# scheduler_config
cd /home/opsim/repos/scheduler_config/
git pull
git branch -a
get_branch
git checkout $run_branch
# salpytools
cd /home/opsim/repos/salpytools
get_branch
git checkout $run_branch
setup salpytools git
# ts_xml
cd /home/opsim/repos/ts_xml
get_branch
git checkout scheduler/develop
setup ts_xml git
# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model
get_branch
git checkout $run_branch
setup ts_astrosky_model git
scons

cd /home/opsim
manage_db --save-dir=/home/opsim/run_local/output
cd /home/opsim/run_local

source scl_source enable devtoolset-6; source /home/opsim/stack/loadLSST.bash; setup sims_ocs git; setup ts_scheduler git; setup ts_astrosky_model git
# if [ $SCHEDULER = "feature" ]; then
#     setup sims_featureScheduler git
# else
#     echo "Skipping feature scheduler..."
# fi
#
# echo opsim4 --frac-duration="$FRAC_DURACTION" -c "$FBS_SCHEDULER_BRANCH" -v --config "$CONFIG_PATH" --log-path "$LOG_PATH" --save-dir "$SAVE_PATH" --scheduler "$SCHEDULER" "$DDS_COM"
# if [ $DDS_COM -eq 0 ]; then
#     opsim4 --frac-duration="$FRAC_DURACTION" -c "$FBS_SCHEDULER_BRANCH" -v --config "$CONFIG_PATH" --log-path "$LOG_PATH" --save-dir "$SAVE_PATH" --scheduler "$SCHEDULER"
# else
#     opsim4 --frac-duration="$FRAC_DURACTION" -c "$FBS_SCHEDULER_BRANCH" -v --config "$CONFIG_PATH" --log-path "$LOG_PATH" --save-dir "$SAVE_PATH" --scheduler "$SCHEDULER" --dds-comm
# fi

echo opsim4 "$OPSIM_RUN_OPTS"

echo opsim4 "$OPSIM_RUN_OPTS" | bash
