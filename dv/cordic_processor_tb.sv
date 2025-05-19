module cordic_processor_tb;

	logic clk, rst_n, run;

	// Instantiate the processor
	cordic_processor uut (
		.clk(clk),
		.rst_n(rst_n),
		.run(run)
	);

	// Clock generation: 10ns period
	initial begin
		clk = 0;
		forever #1 clk = ~clk;
	end

	// Stimulus: nothing changes except clk
	initial begin
		$dumpfile("cordic_processor_wave.vcd");
		$dumpvars(0, cordic_processor_tb);

		// Keep everything idle
		rst_n = 0;
		run = 0;
	
		#1;   // giữ reset 2ns
		rst_n = 1;
		run = 1;

		// Chạy clock một lúc mà không thay đổi gì
		#500;

		$finish;
	end

endmodule

