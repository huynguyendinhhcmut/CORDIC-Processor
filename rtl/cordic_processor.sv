module cordic_processor (
	input logic clk, rst_n, run,
	output logic Done
);

logic W;
logic [31:0] DIN, DOUT, ADDR;

	processor processor (.clk(clk), .rst_n(rst_n), .run(run), .DIN(DIN), .ADDR(ADDR), .DOUT(DOUT), .W(W), .Done(Done));

ram_handmade ram (.clk(clk), .wr_en(W), .address(ADDR[9:0]), .data_in(DOUT), .data_out(DIN));

endmodule
