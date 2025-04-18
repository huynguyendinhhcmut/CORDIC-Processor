module fpu (
	input logic [31:0] a, b,
	input logic control,
	output logic [31:0] result
);

logic cout, addsub;
logic [7:0] largerExponent;
logic [8:0] shiftAmount;
logic [22:0] biggerOperand, smallerOperand;
logic [32:0] sumOperand;
logic [31:0] shiftedOperand;

signComputation sign (.signA(a[31]), .signB(b[31]), .cout(cout), .cin(control), .addsub(addsub), .resultSign(result[31]));

exponentDifference ExponentDiffernce (.a(a[30:23]), .b(b[30:23]), .cout(cout), .shiftAmount(shiftAmount));

always @(*) begin
	case (cout)
		1'b0: biggerOperand = a[22:0];
		1'b1: biggerOperand = b[22:0];
	endcase
end

always @(*) begin
	case (cout)
		1'b0: smallerOperand = b[22:0];
		1'b1: smallerOperand = a[22:0];
	endcase
end

rightShifter RightShifter (.shiftAmount(shiftAmount), .smallerOperand(smallerOperand), .shiftedOperand(shiftedOperand));

fullAdder32b fa32(.a({1'b1, biggerOperand, 8'b0}), .b(shiftedOperand), .cin(addsub), .sum(sumOperand[31:0]), .cout(sumOperand[32]));

always @(*) begin
	case (cout)
		1'b0: largerExponent = a[30:23];
		1'b1: largerExponent = b[30:23];
	endcase
end

normalized Normalized (.largerExponent(largerExponent), .sumOperand(sumOperand[32:1]), .resultExponent(result[30:23]), .resultOperand(result[22:0]));

endmodule


//========== Sign Computation ==========
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

//========== Normalized ==========
module normalized (
	input logic [7:0] largerExponent,
	input logic [31:0] sumOperand,
	output logic [7:0] resultExponent,
	output logic [22:0] resultOperand
);

logic cin;
logic [4:0] position, normalizedAmount;

encoder32to5 encoder (.a(sumOperand), .b(position));

always @(*) begin
	case (position)
		5'b00000: begin 
				cin = 1;
				normalizedAmount = 5'b11110; //-30
				resultOperand = 23'b0;
			end
		5'b00001: begin 
				cin = 1;
				normalizedAmount = 5'b11101; //-29
				resultOperand = {sumOperand[0], 22'b0};
			end
		5'b00010: begin 
				cin = 1;
				normalizedAmount = 5'b11100; //-28
				resultOperand = {sumOperand[1:0], 21'b0};
			end
		5'b00011: begin 
				cin = 1;
				normalizedAmount = 5'b11011; //-27
				resultOperand = {sumOperand[2:0], 20'b0};
			end
		5'b00100: begin 
				cin = 1;
				normalizedAmount = 5'b11010; //-26
				resultOperand = {sumOperand[3:0], 19'b0};
			end
		5'b00101: begin 
				cin = 1;
				normalizedAmount = 5'b11001; //-25
				resultOperand = {sumOperand[4:0], 18'b0};
			end
		5'b00110: begin 
				cin = 1;
				normalizedAmount = 5'b11000; //-24
				resultOperand = {sumOperand[5:0], 17'b0};
			end
		5'b00111: begin 
				cin = 1;
				normalizedAmount = 5'b10111; //-23
				resultOperand = {sumOperand[6:0], 16'b0};
			end
		5'b01000: begin 
				cin = 1;
				normalizedAmount = 5'b10110; //-22
				resultOperand = {sumOperand[7:0], 15'b0};
			end
		5'b01001: begin 
				cin = 1;
				normalizedAmount = 5'b10101; //-21
				resultOperand = {sumOperand[8:0], 14'b0};
			end
		5'b01010: begin 
				cin = 1;
				normalizedAmount = 5'b10100; //-20
				resultOperand = {sumOperand[9:0], 13'b0};
			end
		5'b01011: begin 
				cin = 1;
				normalizedAmount = 5'b10011; //-19
				resultOperand = {sumOperand[10:0], 12'b0};
			end
		5'b01100: begin 
				cin = 1;
				normalizedAmount = 5'b10010; //-18
				resultOperand = {sumOperand[11:0], 11'b0};
			end
		5'b01101: begin 
				cin = 1;
				normalizedAmount = 5'b10001; //-17
				resultOperand = {sumOperand[12:0], 10'b0};
			end
		5'b01110: begin 
				cin = 1;
				normalizedAmount = 5'b10000; //-16
				resultOperand = {sumOperand[13:0], 9'b0};
			end
		5'b01111: begin 
				cin = 1;
				normalizedAmount = 5'b01111; //-15
				resultOperand = {sumOperand[14:0], 8'b0};
			end
		5'b10000: begin 
				cin = 1;
				normalizedAmount = 5'b01110; //-14
				resultOperand = {sumOperand[15:0], 7'b0};
			end
		5'b10001: begin 
				cin = 1;
				normalizedAmount = 5'b01101; //-13
				resultOperand = {sumOperand[16:0], 6'b0};
			end
		5'b10010: begin 
				cin = 1;
				normalizedAmount = 5'b01100; //-12
				resultOperand = {sumOperand[17:0], 5'b0};
			end
		5'b10011: begin 
				cin = 1;
				normalizedAmount = 5'b01011; //-11
				resultOperand = {sumOperand[18:0], 4'b0};
			end
		5'b10100: begin 
				cin = 1;
				normalizedAmount = 5'b01010; //-10
				resultOperand = {sumOperand[19:0], 3'b0};
			end
		5'b10101: begin 
				cin = 1;
				normalizedAmount = 5'b01001; //-9
				resultOperand = {sumOperand[20:0], 2'b0};
			end
		5'b10110: begin 
				cin = 1;
				normalizedAmount = 5'b01000; //-8
				resultOperand = {sumOperand[21:0], 1'b0};
			end
		5'b10111: begin 
				cin = 1;
				normalizedAmount = 5'b00111; //-7
				resultOperand = sumOperand[22:0];
			end
		5'b11000: begin 
				cin = 1;
				normalizedAmount = 5'b00110; //-6
				resultOperand = sumOperand[23:1];
			end
		5'b11001: begin 
				cin = 1;
				normalizedAmount = 5'b00101; //-5
				resultOperand = sumOperand[24:2];
			end

		5'b11010: begin 
				cin = 1;
				normalizedAmount = 5'b00100; //-4
				resultOperand = sumOperand[25:3];
			end

		5'b11011: begin 
				cin = 1;
				normalizedAmount = 5'b00011; //-3
				resultOperand = sumOperand[26:4];
			end

		5'b11100: begin 
				cin = 1;
				normalizedAmount = 5'b00010; //-2
				resultOperand = sumOperand[27:5];
			end

		5'b11101: begin 
				cin = 1;
				normalizedAmount = 5'b00001; //-1
				resultOperand = sumOperand[28:6];
			end

		5'b11110: begin 
				cin = 0;
				normalizedAmount = 5'b00000; //0
				resultOperand = sumOperand[29:7];
			end

		5'b11111: begin 
				cin = 0;
				normalizedAmount = 5'b00001; //+1
				resultOperand = sumOperand[30:8];
			end
	endcase
end

fullAdder8b fa8 (.a(largerExponent), .b({3'b000, normalizedAmount}), .cin(cin), .sum(resultExponent));

endmodule	

//========== Encoder 32 to 5 ==========
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


//========== Right Shifter ==========
module rightShifter (
	input logic [8:0] shiftAmount,
	input logic [22:0] smallerOperand,
	output logic [31:0] shiftedOperand
);

logic [31:0] shift1, shift2, shift3, shift4, shift5, shift6, shift7, shift8;

always @(*) begin 
	case (shiftAmount[0])
		1'b0: shift1 = {1'b1, smallerOperand, 8'b0};
		1'b1: shift1 = {1'b0, 1'b1, smallerOperand, 7'b0};
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
		1'b0: shift8 = shift7;
		1'b1: shift8 = 32'b0;
		default: shift8 = 32'b0;
	endcase
end

always @(*) begin 
	case (shiftAmount[8])
		1'b0: shiftedOperand = shift8;
		1'b1: shiftedOperand = 32'b0;
		default: shiftedOperand = 32'b0;
	endcase
end

endmodule

//========== Exponent Difference ==========
module exponentDifference (
	input logic [7:0] a, b,
	output logic cout,
	output logic [8:0] shiftAmount
);

logic [8:0] d;		// d = Ea - Eb
logic [9:0] d_2c;	// 2's complement d

assign cout = d[8];

fullAdder8b fa8 (.a(a), .b(b), .cin(1'b1), .sum(d[7:0]), .cout(d[8]));
fullAdder9b fa9 (.a(~d), .b(9'b000000001), .cin(1'b0), .sum(d_2c[8:0]), .cout(d_2c[9]));

always @(*) begin
	case (cout)
		1'b0: shiftAmount = d;
		1'b1: shiftAmount = d_2c[8:0];
	endcase
end

endmodule


//========== Full Adder ==========
module fullAdder9b (
        input logic [8:0] a, b,
	input logic cin,
        output logic [8:0] sum,
        output logic cout
);

logic [8:0] carry;

fullAdder fa9 (.sum(sum[0]),   .a(a[0]),  .b(b[0]^cin),  .cin(cin),       .cout(carry[0]));
fullAdder fa10 (.sum(sum[1]),   .a(a[1]),  .b(b[1]^cin),  .cin(carry[0]),  .cout(carry[1]));
fullAdder fa11 (.sum(sum[2]),   .a(a[2]),  .b(b[2]^cin),  .cin(carry[1]),  .cout(carry[2]));
fullAdder fa12 (.sum(sum[3]),   .a(a[3]),  .b(b[3]^cin),  .cin(carry[2]),  .cout(carry[3]));
fullAdder fa13 (.sum(sum[4]),   .a(a[4]),  .b(b[4]^cin),  .cin(carry[3]),  .cout(carry[4]));
fullAdder fa14 (.sum(sum[5]),   .a(a[5]),  .b(b[5]^cin),  .cin(carry[4]),  .cout(carry[5]));
fullAdder fa15 (.sum(sum[6]),   .a(a[6]),  .b(b[6]^cin),  .cin(carry[5]),  .cout(carry[6]));
fullAdder fa16 (.sum(sum[7]),   .a(a[7]),  .b(b[7]^cin),  .cin(carry[6]),  .cout(carry[7]));
fullAdder fa17 (.sum(sum[8]),   .a(a[8]),  .b(b[8]^cin),  .cin(carry[7]),  .cout(carry[8]));

xor (cout, carry[8], cin);

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
