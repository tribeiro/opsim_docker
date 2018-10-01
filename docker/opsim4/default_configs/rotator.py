import lsst.sims.ocs.configuration.instrument.rotator
assert type(config)==lsst.sims.ocs.configuration.instrument.Rotator, 'config is of type %s.%s instead of lsst.sims.ocs.configuration.survey.Survey' % (type(config).__module__, type(config).__name__)
config.follow_sky=True
config.resume_angle=True
