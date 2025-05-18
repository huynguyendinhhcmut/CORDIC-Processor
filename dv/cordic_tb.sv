module cordic_tb;

  logic clk = 0, rst_n = 0;
  logic [31:0] angle;
  logic start;
  logic [31:0] sin, cos;

  // Instantiate DUT
  cordic dut (
    .clk(clk),
    .rst_n(rst_n),
    .angle(angle),
    .start(start),
    .sin(sin),
    .cos(cos)
  );

  initial begin
    $dumpfile("cordic_wave.vcd"); 
    $dumpvars(0, cordic_tb);
    clk = 0;
    forever #1 clk = ~clk;
  end

  initial begin
    // Reset
    rst_n = 0;
    start = 0;
    angle = 0;
    #4 rst_n = 1;

    repeat_test_cases();

    $finish;
  end

  task repeat_test_cases;
    integer i;
    reg [31:0] test_angles [0:20];  // You can add more angles here
    begin
      	// Floating point 32-bit angles in radians
      	test_angles[0] = 32'h3e685696;  // 13
      	test_angles[1] = 32'h3efa35dd;  // 28
      	test_angles[2] = 32'h3f490fdb;  // 45
      	test_angles[3] = 32'h3f95adf0;  // 67
      	test_angles[4] = 32'h3fbba866;  // 84
      	test_angles[5] = 32'h3fd8b338;  // 97
      	test_angles[6] = 32'h3ffc71c6;  // 113
      	test_angles[7] = 32'h40101829;  // 129
      	test_angles[8] = 32'h4028ab2b;  // 151
      	test_angles[9] = 32'h40425c20;  // 174
      	test_angles[10] = 32'h404c69b8; // 183 
      	test_angles[11] = 32'h405d2b0a; // 198
      	test_angles[12] = 32'h406bb073; // 211
      	test_angles[13] = 32'h40833faf; // 235
      	test_angles[14] = 32'h4095adf0; // 268
      	test_angles[15] = 32'h409ab4bb; // 277
      	test_angles[16] = 32'h40a2866a; // 291
      	test_angles[17] = 32'h40afeddf; // 315
      	test_angles[18] = 32'h40bcc65a; // 338
      	test_angles[19] = 32'h40c880e0; // 359

      for (i = 0; i < 20; i = i + 1) begin
        start = 0;
        #4;
	angle = test_angles[i];
	#2;
        start = 1;
        #2 start = 0;

        repeat (17) @(posedge clk);

        $display("\n==== TEST CASE %0d ====", i);
        $display("Angle: %b", angle);
        $display("Sin: %b", sin);
        $display("Cos: %b", cos);
	$display("Time: %0t", $time);

      end
    end
  endtask

endmodule
