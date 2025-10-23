module counterR31 (
	input logic clk, rst_n,
	input logic [31:0] BUS,
	input logic R31in, incr_pc,
	output logic [31:0] R31
);

logic [31:0] pre_R311, pre_R312;

fullAdder32b fa32b (.a(R31), .b(32'h1), .cin(1'b0), .sum(pre_R311));

always @(*) begin
	case ({R31in, incr_pc})
		2'b00: pre_R312 = R31;
		2'b01: pre_R312 = pre_R311;
		2'b10: pre_R312 = BUS;
		2'b11: pre_R312 = BUS;
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		R31 <=  32'b0;
	end else begin
		R31 <= pre_R312;
	end
end
endmodule
