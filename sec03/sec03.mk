#=========================================================================
# sec03
#=========================================================================

sec03_srcs = \
  PairTripleDetector_GL.v \
  PairTripleDetector2_GL.v \

sec03_tests = \
  PairTripleDetector_GL-test.v \
  PairTripleDetector2_GL-test.v \

sec03_sims = \
  detector2-sim.v \

$(eval $(call check_part,sec03))
