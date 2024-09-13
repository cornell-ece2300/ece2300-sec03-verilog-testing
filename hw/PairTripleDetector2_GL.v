//========================================================================
// PairTripleDetector2_GL
//========================================================================

`ifndef PAIR_TRIPLE_DETECTOR2_GL_V
`define PAIR_TRIPLE_DETECTOR2_GL_V

`include "PairTripleDetector_GL.v"

module PairTripleDetector2_GL
(
  input  wire [2:0] a,
  input  wire [2:0] b,
  output wire out
);

  // First detector

  wire detector0_out;

  PairTripleDetector_GL detector0
  (
    .in0 (a[0]),
    .in1 (a[1]),
    .in2 (a[2]),
    .out (detector0_out)
  );

  // Second detector

  wire detector1_out;

  PairTripleDetector_GL detector1
  (
    .in0 (b[0]),
    .in1 (b[1]),
    .in2 (b[2]),
    .out (detector1_out)
  );

  // Final OR gate

  assign out = detector0_out | detector1_out;

endmodule

`endif /* PAIR_TRIPLE_DETECTOR2_GL_V */

