//========================================================================
// PairTripleDetector2_GL
//========================================================================

`ifndef PAIR_TRIPLE_DETECTOR2_GL_V
`define PAIR_TRIPLE_DETECTOR2_GL_V

`include "ece2300/ece2300-misc.v"
`include "ptd/PairTripleDetector_GL.v"

module PairTripleDetector2_GL
(
  input  wire [2:0] a,
  input  wire [2:0] b,
  output wire       out
);

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Instantiate two PairTripleDetector modules and connect to OR gate
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  // remove these lines before starting your implementation
  // `ECE2300_UNUSED( a );
  // `ECE2300_UNUSED( b );
  // `ECE2300_UNDRIVEN( out );

  wire w0;

  PairTripleDetector_GL detector0
  (
    .in0 (a[0]),
    .in1 (a[1]),
    .in2 (a[2]),
    .out (w0)
  );

  wire w1;

  PairTripleDetector_GL detector1
  (
    .in0 (b[0]),
    .in1 (b[1]),
    .in2 (b[2]),
    .out (w1)
  );

  or (out, w0, w1);

endmodule

`endif  /* PAIR_TRIPLE_DETECTOR2_GL_V */

