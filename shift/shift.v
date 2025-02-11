module shift (
	input wire [31:0] a,
	input wire rightleft,
	output reg [31:0] shifted
);

always @(*) begin
	case (rightleft)
		1'b0: shifted [31:0] = {1'b0, a[31:1]};
		1'b1: shifted [31:0] = {a[30:0], 1'b0};
	endcase
end

endmodule
