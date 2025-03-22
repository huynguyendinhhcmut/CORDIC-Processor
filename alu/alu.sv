module alu (
	input logic [31:0] a, b,
	input logic [4:0] ALUControl,
	output logic [63:0] result, 
	output logic V, C, Z, N
);

logic [31:0] sum, sub, shifted, fpu;
logic [63:0] mul;
logic cout, gr, lt, eq;

prefixAdder32b pa1 (.a(a), .b(b^{32{ALUControl[0]}}), .cin(ALUControl[0]), .sum(sum), .cout(cout));

multiply32x32 mul32 (.a(a), .b(b), .mul(mul));

shift shift1 (.data_in(a), .shift_amount(b[4:0]), .rightleft(ALUControl[0]), .arith(ALUControl[3]), .data_out(shifted));

comparator32b compare (.a(a), .b(b), .sign(ALUControl[2]), .Gr(gr), .Lt(lt), .Eq(eq));

fpu fpu1 (.A(a), .B(b), .control(ALUControl[4] & ALUControl[0]), .result(fpu));

always @(*) begin
	case (ALUControl)
		5'b00000: begin
						result [63:33] = 31'b0;
						result [32] = cout;
						result [31:0] = sum;					// a + b
					end
		5'b00001: begin
						result [63:33] = 32'b0;
						result [32] = cout;
						result [31:0] = sum;					// a - b
			end
		5'b00010: result = mul;									// a * b
		5'b00011: begin
						result [63:32] = 32'b0;
						result [31:0] = a & b;					// and
					end	
		5'b00100: begin
						result [63:32] = 32'b0;
						result [31:0] = a | b;					// or
					end	
		5'b00101: begin
						result [63:32] = 32'b0;
						result [31:0] = a ^ b; 					// xor
					end	
		5'b00110: begin
						result [63:32] = 32'b0;
						result [31:0] = shifted;				// right shift logic 
					end	
		5'b00111: begin
						result [63:32] = 32'b0;
						result [31:0] = shifted;				// left shift logic
					end	
		5'b01000: begin
						result [63:32] = 32'b0;
						result [31:0] = shifted;				// right shift arithmetic
					
					end	
		5'b01001: begin
						case (eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check equal unsigned
						endcase
					end
		5'b01010: begin
						case (lt) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check less than unsigned
						endcase
					end
		5'b01011: begin
						case (gr | eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check greater than or equal unsigned
						endcase
					end
		5'b01100: begin
						case (lt) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check less than signed
						endcase
					end
		5'b01101: begin
						case (gr | eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check greater than or equal signed
						endcase
					end
		5'b01110: begin
						case (~eq) 
							1'b0: result = 64'b0;
							1'b1: result = {32'b0, 32'b1};	// check if not equal
						endcase
					end
		//5'b01111: result = 0;
		5'b10000: begin
						result [63:32] = 32'b0;
						result [31:0] = fpu;						// add floating point		
					end
		5'b10001: begin
						result [63:32] = 32'b0;
						result [31:0] = fpu;						// sub floating point		
					end
		default: result = 64'b0;
	endcase
end

assign C = !ALUControl[1] & cout;

endmodule