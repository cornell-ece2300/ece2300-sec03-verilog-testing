//========================================================================
// detector2-sim +a=000 +b=000
//========================================================================
// Author : Christopher Batten (Cornell)
// Date   : September 7, 2024

`include "PairTripleDetector2_GL.v"

module Top();

  //----------------------------------------------------------------------
  // Instantiate detector
  //----------------------------------------------------------------------

  logic [2:0] dut_a;
  logic [2:0] dut_b;
  logic       dut_out;

  PairTripleDetector2_GL dut
  (
    .a   (dut_a),
    .b   (dut_b),
    .out (dut_out)
  );

  //----------------------------------------------------------------------
  // Perform the simulation
  //----------------------------------------------------------------------

  initial begin

    // Process command line arguments

    if ( !$value$plusargs( "a=%b", dut_a ) )
      dut_a = 3'b000;

    if ( !$value$plusargs( "b=%b", dut_b ) )
      dut_b = 3'b000;

    // Advance time

    #10;

    // Display output

    $write( "\n" );
    $display( "a   = %b", dut_a );
    $display( "b   = %b", dut_b );
    $display( "out = %b", dut_out );
    $write( "\n" );

    $finish;
  end

endmodule

