module alu (
	input logic [31:0] a, b,
	input logic [3:0] ALUControl,
	output logic [31:0] result,
	output logic V
);

logic [31:0] sum, sub, shifted, fpu;
logic cout, gr, lt, eq;

prefixAdder32b pa1 (.a(a), .b(b^{32{ALUControl[0]}}), .cin(ALUControl[0]), .sum(sum), .cout(V));

shift shift1 (.data_in(a), .shift_amount(b[4:0]), .rightleft(ALUControl[0]), .arith(ALUControl[3]), .data_out(shifted));

comparator32b compare (.a(a), .b(b), .Gr(gr), .Lt(lt), .Eq(eq));

fpu fpu1 (.a(a), .b(b), .control(~ALUControl[0]), .mul(ALUControl[1] & ALUControl[0]), .result(fpu));

always @(*) begin
	case (ALUControl)
		4'b0000: result [31:0] = sum;						// a + b
		4'b0001: result [31:0] = sum;						// a - b						
		4'b0010: result [31:0] = a & b;					// and	
		4'b0011: result [31:0] = a | b;					// or	
		4'b0100: result [31:0] = a ^ b; 					// xor	
		4'b0101: result [31:0] = ~a;						// not 
		4'b0110: result [31:0] = shifted;				// right shift logic	
		4'b0111: result [31:0] = shifted;				// left shift logic	
		4'b1000: result [31:0] = shifted; 				// right shift arithmetic
		4'b1001: case (eq) 
						1'b0: result = 32'b0;
						1'b1: result = 32'b1;				// check equal
					endcase
		4'b1010: case (lt) 
						1'b0: result = 32'b0;
						1'b1: result = 32'b1;				// check less
					endcase
		4'b1011: case (gr | eq) 
						1'b0: result = 32'b0;
						1'b1: result = 32'b1;				// check greater or equal
					endcase
		4'b1100: case (~eq) 
						1'b0: result = 32'b0;
						1'b1: result = 32'b1;				// check not equal				
					endcase				
		4'b1101: result [31:0] = fpu;						// add floating point		
		4'b1110: result [31:0] = fpu;						// sub floating point		
		4'b1111: result [31:0] = fpu;						// mul floating point
	endcase
end

endmodule
