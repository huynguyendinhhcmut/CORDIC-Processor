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
      	test_angles[0] = 32'h00000000;  // 0
      	test_angles[1] = 32'h3ea0d97c;  // 18
      	test_angles[2] = 32'h3f20d97c;  // 36
      	test_angles[3] = 32'h3f71463a;  // 54
      	test_angles[4] = 32'h3fa0d97c;  // 72
      	test_angles[5] = 32'h3fc90fdb;  // 90
      	test_angles[6] = 32'h3ff1463a;  // 108
      	test_angles[7] = 32'h400cbe4c;  // 126
      	test_angles[8] = 32'h4020d97c;  // 144
      	test_angles[9] = 32'h4034f4ab;  // 162
      	test_angles[10] = 32'h40490fdb; // 180 
      	test_angles[11] = 32'h405d2b0a; // 198
      	test_angles[12] = 32'h4071463a; // 216
      	test_angles[13] = 32'h4082b0b5; // 234
      	test_angles[14] = 32'h408cbe4c; // 252
      	test_angles[15] = 32'h4096cbe4; // 270
      	test_angles[16] = 32'h40a0d97c; // 288
      	test_angles[17] = 32'h40aae713; // 306
      	test_angles[18] = 32'h40b4f4ab; // 324
      	test_angles[19] = 32'h40bf0243; // 342
      	test_angles[20] = 32'h40c90fdb; // 360

      for (i = 0; i < 21; i = i + 1) begin
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
