//========================================================================
// PairTripleDetector2_GL-test
//========================================================================

`include "ece2300-test.v"
`include "PairTripleDetector2_GL.v"

module Top();

  //----------------------------------------------------------------------
  // Setup
  //----------------------------------------------------------------------

  // verilator lint_off UNUSED
  logic clk;
  logic reset;
  // verilator lint_on UNUSED

  ece2300_TestUtils t( .* );

  //----------------------------------------------------------------------
  // Instantiate design under test
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
  // check
  //----------------------------------------------------------------------
  // All tasks start at #1 after the rising edge of the clock. So we
  // write the inputs #1 after the rising edge, and check the outputs #1
  // before the next rising edge.

  task check
  (
    input logic [2:0] a,
    input logic [2:0] b,
    input logic       out
  );
    if ( !t.failed ) begin

      dut_a = a;
      dut_b = b;

      #8;

      if ( t.n != 0 )
        $display( "%3d: %b %b > %b", t.cycles,
                  dut_a, dut_b, dut_out );

      `ECE2300_CHECK_EQ( dut_out, out );

      #2;

    end
  endtask

  //----------------------------------------------------------------------
  // test_case_1_basic
  //----------------------------------------------------------------------

  task test_case_1_basic();
    t.test_case_begin( "test_case_1_basic" );

    check( 3'b000, 3'b000, 0 );
    check( 3'b011, 3'b011, 1 );

  endtask

  //----------------------------------------------------------------------
  // test_case_2_few_ones
  //----------------------------------------------------------------------

  task test_case_2_few_ones();
    t.test_case_begin( "test_case_2_few_ones" );

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for case where both inputs have only 0-1 ones
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    check( 3'b000, 3'b000, 0 );
    check( 3'b001, 3'b000, 0 );
    check( 3'b010, 3'b000, 0 );
    check( 3'b100, 3'b000, 0 );
    check( 3'b000, 3'b001, 0 );
    check( 3'b000, 3'b010, 0 );
    check( 3'b000, 3'b100, 0 );

    //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  endtask

  //----------------------------------------------------------------------
  // test_case_3_many_ones
  //----------------------------------------------------------------------

  task test_case_3_many_ones();
    t.test_case_begin( "test_case_3_many_ones" );

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add checks for case where both inputs have 2+ ones
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    check( 3'b011, 3'b011, 1 );
    check( 3'b101, 3'b101, 1 );
    check( 3'b110, 3'b110, 1 );
    check( 3'b111, 3'b111, 1 );

    //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  endtask

  //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  // Add new test case for random testing
  //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  //----------------------------------------------------------------------
  // test_case_4_random
  //----------------------------------------------------------------------
  // t.seed is set to a known value in the test_case_begin, so when use
  // $urandom(t.seed) we will get reproducible random numbers no matter
  // the order that test cases are executed.

  logic [2:0] random_a;
  logic [2:0] random_b;
  logic       random_out;
  int         random_a_num_ones;
  int         random_b_num_ones;

  task test_case_4_random();
    t.test_case_begin( "test_case_4_random" );

    // Generate 20 random input values

    for ( int i = 0; i < 20; i = i+1 ) begin

      // Generate a 3-bit random value for both a and b

      random_a = 3'($urandom(t.seed));
      random_b = 3'($urandom(t.seed));

      // Calculate the number of ones in random value a

      random_a_num_ones = 0;
      for ( int j = 0; j < 3; j = j+1 ) begin
        if ( random_a[j] )
          random_a_num_ones = random_a_num_ones + 1;
      end

      // Calculate the number of ones in random value b

      random_b_num_ones = 0;
      for ( int j = 0; j < 3; j = j+1 ) begin
        if ( random_b[j] )
          random_b_num_ones = random_b_num_ones + 1;
      end

      // Calculate the correct output value

      random_out = (random_a_num_ones > 1) || (random_b_num_ones > 1);

      // Apply the random input values and check the output value

      check( random_a, random_b, random_out );

    end

  endtask

  //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  //----------------------------------------------------------------------
  // main
  //----------------------------------------------------------------------

  initial begin
    t.test_bench_begin( `__FILE__ );

    if ((t.n <= 0) || (t.n == 1)) test_case_1_basic();
    if ((t.n <= 0) || (t.n == 2)) test_case_2_few_ones();
    if ((t.n <= 0) || (t.n == 3)) test_case_3_many_ones();

    //''' ACTIVITY '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    // Add new test case for random testing to the list of test cases
    //>'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    if ((t.n <= 0) || (t.n == 4)) test_case_4_random();

    //<'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    t.test_bench_end();
  end

endmodule
