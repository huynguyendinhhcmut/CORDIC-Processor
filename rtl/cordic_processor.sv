module cordic_processor (
	input logic clk, rst_n, run, select,
	input logic [7:0] select_addr,
	output logic Done,
	output logic [31:0] dataout
);

logic W;
logic [31:0] DIN, DOUT, ADDR; 
logic [7:0] preADDR;

always @(*) begin
	case (select)
		1'b0: preADDR = ADDR[7:0];
		1'b1: preADDR = select_addr;
	endcase
end

processor processor (.clk(clk), .rst_n(rst_n), .run(run), .DIN(DIN), .ADDR(ADDR), .DOUT(DOUT), .W(W), .Done(Done));

ram_handmade ram1 (.clk(clk), .wr_en(W), .address(ADDR[7:0]), .data_in(DOUT), .data_out(DIN));

ram_handmade ram2 (.clk(clk), .wr_en(W), .address(preADDR), .data_in(DOUT), .data_out(dataout));

endmodule
