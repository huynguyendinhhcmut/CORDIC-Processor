module cordic_processor (
	input logic clk, rst_n, run
);

logic W;
logic [31:0] DIN, DOUT, ADDR;

processor processor (.clk(clk), .rst_n(rst_n), .run(run), .DIN(DIN), .ADDR(ADDR), .DOUT(DOUT), .W(W));

ram_handmade ram (.clk(clk), .wr_en(W), .address(ADDR), .data_in(DOUT), .data_out(DIN));

endmodule
