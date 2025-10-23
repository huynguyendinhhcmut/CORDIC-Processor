module fpu (
	input logic [31:0] a, b,
	input logic control, mul,
	output logic [31:0] result
);

logic [31:0] pre_result1, pre_result2;

fpu_add_sub fpuaddsub (.a(a), .b(b), .control(control), .result(pre_result1));
fpu_mul fpumul (.a(a), .b(b), .result(pre_result2));

always @(*) begin
	case (mul)
		1'b0: result = pre_result1;
		1'b1: result = pre_result2;
	endcase
end

endmodule

//========== FPU multiplication ==========
module fpu_mul (
	input logic [31:0] a, b,
	output logic [31:0] result
);

logic [7:0] pre_exp1, pre_exp2;

fullAdder8b faexp1 (.a(a[30:23]), .b(b[30:23]), .cin(1'b0), .sum(pre_exp1));
fullAdder8b faexp2 (.a(pre_exp1), .b(8'b0111_1111), .cin(1'b1), .sum(pre_exp2));

logic [4:0] positiona, positionb;

encoder32to5 encoder2 (.a({8'b0, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20], a[21], a[22], 1'b1}), .b(positiona));
encoder32to5 encoder3 (.a({8'b0, b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7], b[8], b[9], b[10], b[11], b[12], b[13], b[14], b[15], b[16], b[17], b[18], b[19], b[20], b[21], b[22], 1'b1}), .b(positionb));


logic [6:0] fixed;
logic [5:0] position, position1, totali;
logic [4:0] ai, bi;
logic [31:0] mana, manb;
logic [63:0] pre_resultman1;
logic [31:0] pre_resultman2;

always @(*) begin
	case (positiona)
		5'b00000: mana = {31'b0, 1'b1};
		5'b00001: mana = {30'b0, 1'b1, a[22]};
		5'b00010: mana = {29'b0, 1'b1, a[22:21]};
		5'b00011: mana = {28'b0, 1'b1, a[22:20]};
		5'b00100: mana = {27'b0, 1'b1, a[22:19]};
		5'b00101: mana = {26'b0, 1'b1, a[22:18]};
		5'b00110: mana = {25'b0, 1'b1, a[22:17]};
		5'b00111: mana = {24'b0, 1'b1, a[22:16]};
		5'b01000: mana = {23'b0, 1'b1, a[22:15]};
		5'b01001: mana = {22'b0, 1'b1, a[22:14]};
		5'b01010: mana = {21'b0, 1'b1, a[22:13]};
		5'b01011: mana = {20'b0, 1'b1, a[22:12]};
		5'b01100: mana = {19'b0, 1'b1, a[22:11]};
		5'b01101: mana = {18'b0, 1'b1, a[22:10]};
		5'b01110: mana = {17'b0, 1'b1, a[22:9]};
		5'b01111: mana = {16'b0, 1'b1, a[22:8]};
		5'b10000: mana = {15'b0, 1'b1, a[22:7]};
		5'b10001: mana = {14'b0, 1'b1, a[22:6]};
		5'b10010: mana = {13'b0, 1'b1, a[22:5]};
		5'b10011: mana = {12'b0, 1'b1, a[22:4]};
		5'b10100: mana = {11'b0, 1'b1, a[22:3]};
		5'b10101: mana = {10'b0, 1'b1, a[22:2]};
		5'b10110: mana = {9'b0, 1'b1, a[22:1]};
		5'b10111: mana = {8'b0, 1'b1, a[22:0]};
		default: mana = 32'b0;
	endcase
end

always @(*) begin
	case (positionb)
		5'b00000: manb = {31'b0, 1'b1};
		5'b00001: manb = {30'b0, 1'b1, b[22]};
		5'b00010: manb = {29'b0, 1'b1, b[22:21]};
		5'b00011: manb = {28'b0, 1'b1, b[22:20]};
		5'b00100: manb = {27'b0, 1'b1, b[22:19]};
		5'b00101: manb = {26'b0, 1'b1, b[22:18]};
		5'b00110: manb = {25'b0, 1'b1, b[22:17]};
		5'b00111: manb = {24'b0, 1'b1, b[22:16]};
		5'b01000: manb = {23'b0, 1'b1, b[22:15]};
		5'b01001: manb = {22'b0, 1'b1, b[22:14]};
		5'b01010: manb = {21'b0, 1'b1, b[22:13]};
		5'b01011: manb = {20'b0, 1'b1, b[22:12]};
		5'b01100: manb = {19'b0, 1'b1, b[22:11]};
		5'b01101: manb = {18'b0, 1'b1, b[22:10]};
		5'b01110: manb = {17'b0, 1'b1, b[22:9]};
		5'b01111: manb = {16'b0, 1'b1, b[22:8]};
		5'b10000: manb = {15'b0, 1'b1, b[22:7]};
		5'b10001: manb = {14'b0, 1'b1, b[22:6]};
		5'b10010: manb = {13'b0, 1'b1, b[22:5]};
		5'b10011: manb = {12'b0, 1'b1, b[22:4]};
		5'b10100: manb = {11'b0, 1'b1, b[22:3]};
		5'b10101: manb = {10'b0, 1'b1, b[22:2]};
		5'b10110: manb = {9'b0, 1'b1, b[22:1]};
		5'b10111: manb = {8'b0, 1'b1, b[22:0]};
		default: manb= 32'b0;
	endcase
end
  
multiply32x32 multiply (.a(mana), .b(manb), .mul(pre_resultman1));
  fullAdder5b fa5b1 (.a(positiona), .b(positionb), .cin(1'b0), .sum(totali[4:0]), .cout(totali[5]));

encoder64to6 encoder646 (.a(pre_resultman1), .b(position));

always @(*) begin
	case (position) //32
		6'b00_0000: pre_resultman2 = {pre_resultman1[0], 31'b0};
		6'b00_0001: pre_resultman2 = {pre_resultman1[1:0], 30'b0};
		6'b00_0010: pre_resultman2 = {pre_resultman1[2:0], 29'b0};
		6'b00_0011: pre_resultman2 = {pre_resultman1[3:0], 28'b0};
		6'b00_0100: pre_resultman2 = {pre_resultman1[4:0], 27'b0};
		6'b00_0101: pre_resultman2 = {pre_resultman1[5:0], 26'b0};
		6'b00_0110: pre_resultman2 = {pre_resultman1[6:0], 25'b0};
		6'b00_0111: pre_resultman2 = {pre_resultman1[7:0], 24'b0};
		6'b00_1000: pre_resultman2 = {pre_resultman1[8:0], 23'b0};
		6'b00_1001: pre_resultman2 = {pre_resultman1[9:0], 22'b0};
		6'b00_1010: pre_resultman2 = {pre_resultman1[10:0], 21'b0};
		6'b00_1011: pre_resultman2 = {pre_resultman1[11:0], 20'b0};
		6'b00_1100: pre_resultman2 = {pre_resultman1[12:0], 19'b0};
		6'b00_1101: pre_resultman2 = {pre_resultman1[13:0], 18'b0};
		6'b00_1110: pre_resultman2 = {pre_resultman1[14:0], 17'b0};
		6'b00_1111: pre_resultman2 = {pre_resultman1[15:0], 16'b0};
		6'b01_0000: pre_resultman2 = {pre_resultman1[16:0], 15'b0};
		6'b01_0001: pre_resultman2 = {pre_resultman1[17:0], 14'b0};
		6'b01_0010: pre_resultman2 = {pre_resultman1[18:0], 13'b0};
		6'b01_0011: pre_resultman2 = {pre_resultman1[19:0], 12'b0};
		6'b01_0100: pre_resultman2 = {pre_resultman1[20:0], 11'b0};
		6'b01_0101: pre_resultman2 = {pre_resultman1[21:0], 10'b0};
		6'b01_0110: pre_resultman2 = {pre_resultman1[22:0], 9'b0};
		6'b01_0111: pre_resultman2 = {pre_resultman1[23:0], 8'b0};
		6'b01_1000: pre_resultman2 = {pre_resultman1[24:0], 7'b0};
		6'b01_1001: pre_resultman2 = {pre_resultman1[25:0], 6'b0};
		6'b01_1010: pre_resultman2 = {pre_resultman1[26:0], 5'b0};
		6'b01_1011: pre_resultman2 = {pre_resultman1[27:0], 4'b0};
		6'b01_1100: pre_resultman2 = {pre_resultman1[28:0], 3'b0};
		6'b01_1101: pre_resultman2 = {pre_resultman1[29:0], 2'b0};
		6'b01_1110: pre_resultman2 = {pre_resultman1[30:0], 1'b0};
		6'b01_1111: pre_resultman2 = pre_resultman1[31:0];
		6'b10_0000: pre_resultman2 = pre_resultman1[32:1];
		6'b10_0001: pre_resultman2 = pre_resultman1[33:2];
		6'b10_0010: pre_resultman2 = pre_resultman1[34:3];
		6'b10_0011: pre_resultman2 = pre_resultman1[35:4];
		6'b10_0100: pre_resultman2 = pre_resultman1[36:5];
		6'b10_0101: pre_resultman2 = pre_resultman1[37:6];
		6'b10_0110: pre_resultman2 = pre_resultman1[38:7];
		6'b10_0111: pre_resultman2 = pre_resultman1[39:8];
		6'b10_1000: pre_resultman2 = pre_resultman1[40:9];
		6'b10_1001: pre_resultman2 = pre_resultman1[41:10];
		6'b10_1010: pre_resultman2 = pre_resultman1[42:11];
		6'b10_1011: pre_resultman2 = pre_resultman1[43:12];
		6'b10_1100: pre_resultman2 = pre_resultman1[44:13];
		6'b10_1101: pre_resultman2 = pre_resultman1[45:14];
		6'b10_1110: pre_resultman2 = pre_resultman1[46:15];
		6'b10_1111: pre_resultman2 = pre_resultman1[47:16];
		6'b11_0000: pre_resultman2 = pre_resultman1[48:17];
		default: pre_resultman2 = 32'b0;
	endcase
end

fullAdder6b fa6b1 (.a(position), .b(6'b00_0001), .cin(1'b0), .sum(position1[5:0]));
fullAdder6b fa6b2 (.a(position1), .b(totali), .cin(1'b1), .sum(fixed[5:0]), .cout(fixed[6]));

logic rage;
always @(*) begin
	case (fixed[6:0])
	    7'b000_0010: rage = 1;
		default: rage = 0;
	endcase
end

fullAdder8b fa8bexp (.a(pre_exp2), .b({7'b0, rage}), .cin(1'b0), .sum(result[30:23]));
assign result[22:0] = pre_resultman2[30:8];
assign result[31] = a[31] ^ b[31];

endmodule

//========== FPU add/sub ==========
module fpu_add_sub (
	input logic [31:0] a, b,
	input logic control,
	output logic [31:0] result
);

logic cout, addsub, compare_operand;
logic [7:0] largerExponent;
logic [8:0] shiftAmount;
logic [22:0] biggerOperand, smallerOperand;
logic [22:0] pre1_biggerOperand, pre1_smallerOperand;
logic [22:0] pre2_biggerOperand, pre2_smallerOperand;
logic [32:0] sumOperand;
logic [31:0] shiftedOperand;
logic compare1, compare2, compare;

signComputation sign (.signA(a[31]), .signB(b[31]), .compare(compare), .cin(control), .addsub(addsub), .resultSign(result[31]));

exponentDifference ExponentDiffernce (.a(a[30:23]), .b(b[30:23]), .cout(cout), .shiftAmount(shiftAmount));

always @(*) begin
	case (cout)
		1'b0: pre1_biggerOperand = a[22:0];
		1'b1: pre1_biggerOperand = b[22:0];
	endcase
end

always @(*) begin
	case (cout)
		1'b0: pre1_smallerOperand = b[22:0];
		1'b1: pre1_smallerOperand = a[22:0];
	endcase
end

always @(*) begin
  case (cout)
		1'b0: compare1 = 1'b0;
		1'b1: compare1 = 1'b1;
	endcase
end  
  
fullAdder23b faoperand (.a(a[22:0]), .b(b[22:0]), .cin(1'b1), .cout(compare_operand));
  
always @(*) begin
	case (compare_operand)
		1'b0: pre2_biggerOperand = a[22:0];
		1'b1: pre2_biggerOperand = b[22:0];
	endcase
end
  
always @(*) begin
	case (compare_operand)
		1'b0: pre2_smallerOperand = b[22:0];
		1'b1: pre2_smallerOperand = a[22:0];
	endcase
end
  
always @(*) begin
	case (compare_operand)
		1'b0: compare2 = 1'b0;
		1'b1: compare2 = 1'b1;
	endcase
end  
  
always @(*) begin
  	case (shiftAmount)
		8'b0: biggerOperand =  pre2_biggerOperand;
		default: biggerOperand =  pre1_biggerOperand;
	endcase
end

always @(*) begin
  	case (shiftAmount)
		8'b0: smallerOperand =  pre2_smallerOperand;
		default: smallerOperand =  pre1_smallerOperand;
	endcase
end
  
always @(*) begin
  	case (shiftAmount)
      	8'b0: compare = compare2;
		default: compare = compare1;
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
	input logic cin, compare,
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
  case (compare)
		1'b0: sign1 = 0;
		1'b1: sign1 = 1;
	endcase
end

always @(*) begin
  case (compare)
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

encoder32to5 encoder1 (.a(sumOperand), .b(position));

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

//========== Encoder 64 to 6 ==========
module encoder64to6 (
	input logic [63:0] a,
    	output logic [5:0] b
);

logic [4:0] enc_low_out, enc_high_out;
logic sel_high;

assign sel_high = |a[63:32]; 

encoder32to5 encoder_lo (.a(a[31:0]), .b(enc_low_out));
encoder32to5 encoder_hi (.a(a[63:32]), .b(enc_high_out));

assign b = sel_high ? {1'b1, enc_high_out} : {1'b0, enc_low_out};

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

