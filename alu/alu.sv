module alu (
	input logic [31:0] a, b,
	input logic [3:0] ALUControl,
	output logic [63:0] result, 
	output logic V, C, Z, N
);

logic [31:0] sum, sub, shifted;
logic [63:0] mul;
logic cout, gr, lt, eq;

fullAdder32b fa1 (.a(a), .b(b), .cin(ALUControl[0]), .sum(sum), .cout(cout));

multiply32x32 mul32 (.a(a), .b(b), .mul(mul));

shift shift1 (.data_in(a), .shift_amount(b[4:0]), .rightleft(ALUControl[0]), .arith(ALUControl[3]), .data_out(shifted));

comparator32b compare (.a(a), .b(b), .sign(ALUControl[2]), .Gr(gr), .Lt(lt), .Eq(eq));

always @(*) begin
	case (ALUControl)
		4'b0000: begin
						result [63:33] = 31'b0;
						result [32] = cout;
						result [31:0] = sum;					// a + b
					end
		4'b0001: begin
				case (cout)
					1'b0: begin
						result [63:32] = 32'b0;
						result [31:0] = sum;
					end					// a - b
					1'b1: begin
						result [63:32] = 32'hffffffff;
						result [31:0] = sum;
					end
				endcase
			end
		4'b0010: result = mul;									// a * b
		4'b0011: begin
						result [63:32] = 32'b0;
						result [31:0] = a & b;					// and
					end	
		4'b0100: begin
						result [63:32] = 32'b0;
						result [31:0] = a | b;					// or
					end	
		4'b0101: begin
						result [63:32] = 32'b0;
						result [31:0] = a ^ b; 					// xor
					end	
		4'b0110: begin
						result [63:32] = 32'b0;
						result [31:0] = shifted;				// right shift logic 
					end	
		4'b0111: begin
						result [63:32] = 32'b0;
						result [31:0] = shifted;				// left shift logic
					end	
		4'b1000: begin
						result [63:32] = 32'b0;
						result [31:0] = shifted;				// right shift arithmetic
					end	
		4'b1001: begin
						case (eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check equal unsigned
						endcase
					end
		4'b1010: begin
						case (lt) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check less than unsigned
						endcase
					end
		4'b1011: begin
						case (gr | eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check greater than or equal unsigned
						endcase
					end
		4'b1100: begin
						case (lt) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check less than signed
						endcase
					end
		4'b1101: begin
						case (gr | eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check greater than or equal signed
						endcase
					end
		4'b1110: begin
						case (~eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check if not equal
						endcase
					end
		//4'b1111: result = 0;
		default: result = 64'b0;
	endcase
end

assign C = !ALUControl[1] & cout;

endmodule
