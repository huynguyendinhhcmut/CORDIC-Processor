module fpu (
	input logic [31:0] A, B,
	input logic control,
	output logic [31:0] result
);

logic cout, addsub;
logic [7:0] d, dComp, shiftAmount, bigExponent;
logic [31:0] smallShiftedOperand; 
logic [32:0] sumOperand;
logic [22:0] smallOperand, bigOperand;

signComputation sign (.signA(A[31]), .signB(B[31]), .cout(cout), .cin(control), .addsub(addsub), .resultSign(result[31]));

fullAdder8b exponentDifference (.a(A[30:23]), .b(B[30:23]), .cin(1'b1), .cout(cout), .sum(d));

fullAdder8b twoscomplement (.a(~d), .b(8'h1), .cin(1'b0), .sum(dComp));	
	
always @(*) begin
	case (cout)
		1'b0: shiftAmount = d;
		1'b1: shiftAmount = dComp;
	endcase
end

always @(*) begin
	case (cout)
		1'b0: bigOperand = A[22:0];
		1'b1: bigOperand = B[22:0];
	endcase
end

always @(*) begin
	case (cout)
		1'b0: smallOperand = B[22:0];
		1'b1: smallOperand = A[22:0];
	endcase
end

rightShifter rightshift(.shiftAmount(shiftAmount), .smallOperand(smallOperand), .shiftedOperand(smallShiftedOperand));

prefixAdder32b prefixAdder32b1 (.a({1'b1, bigOperand, 8'b0}), .b(smallShiftedOperand), .cin(addsub), .sum(sumOperand[31:0]), .cout(sumOperand[32]));
	
always @(*) begin
		case (cout)
			1'b0: bigExponent = A[30:23];
			1'b1: bigExponent = B[30:23];
		endcase
end

normalized normalized (.sumOperand(sumOperand[32:1]), .bigExponent(bigExponent), .resultOperand(result[22:0]), .resultExponent(result[30:23]));
	
endmodule




module signComputation (
	input logic signA, signB,
	input logic cin, cout,
	output logic resultSign, addsub
);

logic sign1, sign2, sign3, sign4;

always @(*) begin
	case (signA ^ signB)
		1'b0: addsub = cin;
		1'b1: addsub = ~cin;
	endcase
end

always @(*) begin
	case (cout)
		1'b0: sign1 = 0;
		1'b1: sign1 = 1;
	endcase
end

always @(*) begin
	case (cout)
		1'b0: sign2 = 1;
		1'b1: sign2 = 0;
	endcase
end

always @(*) begin
	case ((~signA) & cin & (~signB) | (~signA) & (~cin) & signB)
		1'b0: sign3 = 0;
		1'b1: sign3 = sign1;
	endcase
end

always @(*) begin
	case (signA & (~cin) & (~signB) | signA & cin & signB)
		1'b0: sign4 = 1;
		1'b1: sign4 = sign2;
	endcase
end

always @(*) begin
	case (signA)
		1'b0: resultSign = sign3;
		1'b1: resultSign = sign4;
	endcase
end

endmodule




module normalized ( 
	input logic [31:0] sumOperand,
	input logic [7:0] bigExponent,
	output logic [22:0] resultOperand,
	output logic [7:0] resultExponent
);

logic [4:0] pre_addsubAmountExponent, addsubAmountExponent;
logic addsub;
logic [22:0] pre_resultOperand1, pre_resultOperand2, pre_resultOperand3;

encoder32to5 encoder3251 (.a(sumOperand), .b(pre_addsubAmountExponent));

mux32to1 addsubExp (.a(pre_addsubAmountExponent), .b(addsubAmountExponent), .addsub(addsub));

fullAdder8b finalExponent (.a(bigExponent), .b({3'b000, addsubAmountExponent}), .cin(addsub), .sum(resultExponent));

always @(*) begin
	case (addsubAmountExponent)
		5'b0_0000: pre_resultOperand1 = sumOperand[29:7];
		5'b0_0001: pre_resultOperand1 = sumOperand[28:6];
		5'b0_0010: pre_resultOperand1 = sumOperand[27:5];
		5'b0_0011: pre_resultOperand1 = sumOperand[26:4];
		5'b0_0100: pre_resultOperand1 = sumOperand[25:3];
		5'b0_0101: pre_resultOperand1 = sumOperand[24:2];
		5'b0_0110: pre_resultOperand1 = sumOperand[23:1];
		5'b0_0111: pre_resultOperand1 = sumOperand[22:0];
		5'b0_1000: pre_resultOperand1 = {sumOperand[21:0], 1'b0};
		5'b0_1001: pre_resultOperand1 = {sumOperand[20:0], 2'b0};
		5'b0_1010: pre_resultOperand1 = {sumOperand[19:0], 3'b0};
		5'b0_1011: pre_resultOperand1 = {sumOperand[18:0], 4'b0};
		5'b0_1100: pre_resultOperand1 = {sumOperand[17:0], 5'b0};
		5'b0_1101: pre_resultOperand1 = {sumOperand[16:0], 6'b0};
		5'b0_1110: pre_resultOperand1 = {sumOperand[15:0], 7'b0};
		5'b0_1111: pre_resultOperand1 = {sumOperand[14:0], 8'b0};

		5'b1_0000: pre_resultOperand1 = {sumOperand[13:0], 9'b0};
		5'b1_0001: pre_resultOperand1 = {sumOperand[12:0], 10'b0};
		5'b1_0010: pre_resultOperand1 = {sumOperand[11:0], 11'b0};
		5'b1_0011: pre_resultOperand1 = {sumOperand[10:0], 12'b0};
		5'b1_0100: pre_resultOperand1 = {sumOperand[9:0], 13'b0};
		5'b1_0101: pre_resultOperand1 = {sumOperand[8:0], 14'b0};
		5'b1_0110: pre_resultOperand1 = {sumOperand[7:0], 15'b0};
		5'b1_0111: pre_resultOperand1 = {sumOperand[6:0], 16'b0};
		5'b1_1000: pre_resultOperand1 = {sumOperand[5:0], 17'b0};
		5'b1_1001: pre_resultOperand1 = {sumOperand[4:0], 18'b0};
		5'b1_1010: pre_resultOperand1 = {sumOperand[3:0], 19'b0};
		5'b1_1011: pre_resultOperand1 = {sumOperand[2:0], 20'b0};
		5'b1_1100: pre_resultOperand1 = {sumOperand[1:0], 21'b0};
		5'b1_1101: pre_resultOperand1 = {sumOperand[0], 22'b0};
		5'b1_1110: pre_resultOperand1 = 23'b0;
		5'b1_1111: pre_resultOperand1 = 23'b0;
	endcase
end

always @(*) begin
	case (addsubAmountExponent)
		5'b0_0000: pre_resultOperand2 = sumOperand[29:7];
		5'b0_0001: pre_resultOperand2 = sumOperand[30:8];
		default: pre_resultOperand2 = 22'b0;
	endcase
end

always @(*) begin
	case (addsub)
		1'b0: pre_resultOperand3 = pre_resultOperand2;
		1'b1: pre_resultOperand3 = pre_resultOperand1;
	endcase
end
		
always @(*) begin
	case (&resultExponent)
		1'b0: resultOperand = pre_resultOperand3;
		1'b1: resultOperand = 22'b0;
	endcase
end

endmodule




module mux32to1 (
	input logic [4:0] a,
	output logic [4:0] b,
	output logic addsub
);

logic [4:0] b0, b1, b2, b3;
logic addsub0, addsub1, addsub2, addsub3;

always @(*) begin
		case (a[2:0])
			3'b000: begin
					b0 = 5'b1_1110;	//30
					addsub0 = 1'b1;
			end
			3'b001: begin
					b0 = 5'b1_1101;	//29
					addsub0 = 1'b1;
			end
			
			3'b010: begin
					b0 = 5'b1_1100;	//28
					addsub0 = 1'b1;
			end
			
			3'b011: begin
					b0 = 5'b1_1011;	//27
					addsub0 = 1'b1;
			end

			3'b100: begin
					b0 = 5'b1_1010;	//26
					addsub0 = 1'b1;
			end

			3'b101: begin
					b0 = 5'b1_1001;	//25
					addsub0 = 1'b1;
			end

			3'b110: begin
					b0 = 5'b1_1000;	//24
					addsub0 = 1'b1;
			end

			3'b111: begin
					b0 = 5'b1_0111;	//23
					addsub0 = 1'b1;
			end

		endcase

end

always @(*) begin
		case (a[2:0])
			3'b000: begin
					b1 = 5'b1_0110;	//22
					addsub1 = 1'b1;
			end
			3'b001: begin
					b1 = 5'b1_0101;	//21
					addsub1 = 1'b1;
			end
			
			3'b010: begin
					b1 = 5'b1_0100;	//20
					addsub1 = 1'b1;
			end
			
			3'b011: begin
					b1 = 5'b1_0011;	//19
					addsub1 = 1'b1;
			end

			3'b100: begin
					b1 = 5'b1_0010;	//18
					addsub1 = 1'b1;
			end

			3'b101: begin
					b1 = 5'b1_0001;	//17
					addsub1 = 1'b1;
			end

			3'b110: begin
					b1 = 5'b1_0000;	//16
					addsub1 = 1'b1;
			end

			3'b111: begin
					b1 = 5'b0_1111;	//15
					addsub1 = 1'b1;
			end
			
		endcase
end

always @(*) begin
		case (a[2:0])
			3'b000: begin
					b2 = 5'b0_1110;	//14
					addsub2 = 1'b1;
			end
			3'b001: begin
					b2 = 5'b0_1101;	//13
					addsub2 = 1'b1;
			end
			
			3'b010: begin
					b2 = 5'b0_1100;	//12
					addsub2 = 1'b1;
			end
			
			3'b011: begin
					b2 = 5'b0_1011;	//11
					addsub2 = 1'b1;
			end

			3'b100: begin
					b2 = 5'b0_1010;	//10
					addsub2 = 1'b1;
			end

			3'b101: begin
					b2 = 5'b0_1001;	//9
					addsub2 = 1'b1;
			end

			3'b110: begin
					b2 = 5'b0_1000;	//8
					addsub2 = 1'b1;
			end

			3'b111: begin
					b2 = 5'b0_0111;	//7
					addsub2 = 1'b1;
			end

		endcase

end

always @(*) begin
		case (a[2:0])
			3'b000: begin
					b3 = 5'b0_0110;	//6
					addsub3 = 1'b1;
			end
			3'b001: begin
					b3 = 5'b0_0101;	//5
					addsub3 = 1'b1;
			end
			
			3'b010: begin
					b3 = 5'b0_0100;	//4
					addsub3 = 1'b1;
			end
			
			3'b011: begin
					b3 = 5'b0_0011;	//3
					addsub3 = 1'b1;
			end

			3'b100: begin
					b3 = 5'b0_0010;	//2
					addsub3 = 1'b1;
			end

			3'b101: begin
					b3 = 5'b0_0001;	//1
					addsub3 = 1'b1;
			end

			3'b110: begin
					b3 = 5'b0_0000;	//0
					addsub3 = 1'b0;
			end
			
			3'b111: begin
					b3 = 5'b0_0001;	//1
					addsub3 = 1'b0;
			end

		endcase

end

always @(*) begin
		case (a[4:3])
			2'b00: begin
					b = b0;	
					addsub = addsub0;
			end
			2'b01: begin
					b = b1;	
					addsub = addsub1;
			end
			
			2'b10: begin
					b = b2;	
					addsub = addsub2;
			end
			
			2'b11: begin
					b = b3; 
					addsub = addsub3;
			end
			
		endcase

end

endmodule




module encoder32to5 (
	input logic [31:0] a,
	output logic [4:0] b
);

logic [2:0] out0, out1, out2, out3;
logic ena0, ena1, ena2, ena3;
logic [1:0] sel;

encoder8to3 encoder831 (.a(a[7:0]),   .b(out0));
encoder8to3 encoder832 (.a(a[15:8]),  .b(out1));
encoder8to3 encoder833 (.a(a[23:16]), .b(out2));
encoder8to3 encoder834 (.a(a[31:24]), .b(out3));

assign ena0 = a[0]  | a[1]  | a[2]  | a[3]  | a[4]  | a[5]  | a[6]  | a[7];
assign ena1 = a[8]  | a[9]  | a[10] | a[11] | a[12] | a[13] | a[14] | a[15];
assign ena2 = a[16] | a[17] | a[18] | a[19] | a[20] | a[21] | a[22] | a[23];
assign ena3 = a[24] | a[25] | a[26] | a[27] | a[28] | a[29] | a[30] | a[31];

encoder4to2 encoder421 (.a({ena3, ena2, ena1, ena0}), .b(sel));

always @(*) begin
	case (sel)
		2'b00: b[2:0] = out0;
		2'b01: b[2:0] = out1;
		2'b10: b[2:0] = out2;
		2'b11: b[2:0] = out3;
		default: b[2:0] = 3'b000;
	endcase
end

always @(*) begin
	b[4:3] = sel;
end

endmodule




module encoder8to3 (
	input logic [7:0] a,
	output logic [2:0] b
);

assign b[2] = a[7] | a[6] | a[5] | a[4];
assign b[1] = a[7] | a[6] | ((~a[5]) & (~a[4]) & a[3]) | ((~a[5]) & (~a[4]) & a[2]);
assign b[0] = a[7] | ((~a[6]) & a[5]) | ((~a[6]) & (~a[4]) & a[3]) | ((~a[6]) & (~a[4]) & (~a[2]) & a[1]);

endmodule




module encoder4to2 (
	input logic [3:0] a,
	output logic [1:0] b
);

assign b[1] = a[2] | a[3];
assign b[0] = (a[1] | a[3]) & ((~a[2]) | a[3]);

endmodule




module rightShifter (
	input logic [7:0] shiftAmount,
	input logic [22:0] smallOperand,
	output logic [31:0] shiftedOperand
);

logic [31:0] shift1, shift2, shift3, shift4, shift5, shift6, shift7;

always @(*) begin 
	case (shiftAmount[0])
		1'b0: shift1 = {1'b1, smallOperand, 8'b0};
		1'b1: shift1 = {1'b0, 1'b1, smallOperand, 7'b0};
		default: shift1 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[1])
		1'b0: shift2 = shift1;
		1'b1: shift2 = {2'b0, shift1[31:2]};
		default: shift2 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[2])
		1'b0: shift3 = shift2;
		1'b1: shift3 = {4'b0, shift2[31:4]};
		default: shift3 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[3])
		1'b0: shift4 = shift3;
		1'b1: shift4 = {8'b0, shift3[31:8]};
		default: shift4 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[4])
		1'b0: shift5 = shift4;
		1'b1: shift5 = {16'b0, shift4[31:16]};
		default: shift5 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[5])
		1'b0: shift6 = shift5;
		1'b1: shift6 = 32'b0;
		default: shift6 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[6])
		1'b0: shift7 = shift6;
		1'b1: shift7 = 32'b0;
		default: shift7 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[7])
		1'b0: shiftedOperand = shift7;
		1'b1: shiftedOperand = 32'b0;
		default: shiftedOperand = 32'b0;
	endcase
end

endmodule




module fullAdder8b (
        input logic [7:0] a, b,
		  input logic cin,
        output logic [7:0] sum,
        output logic cout
);

logic [7:0] carry;

fullAdder fa1 (.sum(sum[0]),   .a(a[0]),  .b(b[0]^cin),  .cin(cin),       .cout(carry[0]));
fullAdder fa2 (.sum(sum[1]),   .a(a[1]),  .b(b[1]^cin),  .cin(carry[0]),  .cout(carry[1]));
fullAdder fa3 (.sum(sum[2]),   .a(a[2]),  .b(b[2]^cin),  .cin(carry[1]),  .cout(carry[2]));
fullAdder fa4 (.sum(sum[3]),   .a(a[3]),  .b(b[3]^cin),  .cin(carry[2]),  .cout(carry[3]));
fullAdder fa5 (.sum(sum[4]),   .a(a[4]),  .b(b[4]^cin),  .cin(carry[3]),  .cout(carry[4]));
fullAdder fa6 (.sum(sum[5]),   .a(a[5]),  .b(b[5]^cin),  .cin(carry[4]),  .cout(carry[5]));
fullAdder fa7 (.sum(sum[6]),   .a(a[6]),  .b(b[6]^cin),  .cin(carry[5]),  .cout(carry[6]));
fullAdder fa8 (.sum(sum[7]),   .a(a[7]),  .b(b[7]^cin),  .cin(carry[6]),  .cout(carry[7]));

xor (cout, carry[7], cin);

endmodule

