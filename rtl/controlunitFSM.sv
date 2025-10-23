module controlunitFSM (
	input logic clk, rst_n, run, finish,
	input logic [31:0] IR, G,
	output logic [3:0] ALUControl,
	output logic IRin, Gout, DINout, Sinout, Cosout, incr_pc, Ain, Bin, Gin, Sinin, Cosin, ADDRin, DOUTin, W_D, Done, start,
	output logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R16out, R17out, R18out, R19out, R20out, R21out, R22out, R23out, R24out, R25out, R26out, R27out, R28out, R29out, R30out, R31out,
	output logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, R16in, R17in, R18in, R19in, R20in, R21in, R22in, R23in, R24in, R25in, R26in, R27in, R28in, R29in, R30in, R31in 
);

logic [31:0] outX, outY, outZ;
logic RXout, RYout, RZout, RXin, RYin, RZin;
logic R31out1, R31out2;

always @(*) begin
	case (IR[14:10])
		5'b00000: outZ = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
		5'b00001: outZ = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
		5'b00010: outZ = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
		5'b00011: outZ = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		5'b00100: outZ = 32'b0000_0000_0000_0000_0000_0000_0001_0000;
		5'b00101: outZ = 32'b0000_0000_0000_0000_0000_0000_0010_0000;
		5'b00110: outZ = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
		5'b00111: outZ = 32'b0000_0000_0000_0000_0000_0000_1000_0000;
		5'b01000: outZ = 32'b0000_0000_0000_0000_0000_0001_0000_0000;
		5'b01001: outZ = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
		5'b01010: outZ = 32'b0000_0000_0000_0000_0000_0100_0000_0000;
		5'b01011: outZ = 32'b0000_0000_0000_0000_0000_1000_0000_0000;
		5'b01100: outZ = 32'b0000_0000_0000_0000_0001_0000_0000_0000;
		5'b01101: outZ = 32'b0000_0000_0000_0000_0010_0000_0000_0000;
		5'b01110: outZ = 32'b0000_0000_0000_0000_0100_0000_0000_0000;
		5'b01111: outZ = 32'b0000_0000_0000_0000_1000_0000_0000_0000;
		5'b10000: outZ = 32'b0000_0000_0000_0001_0000_0000_0000_0000;
		5'b10001: outZ = 32'b0000_0000_0000_0010_0000_0000_0000_0000;
		5'b10010: outZ = 32'b0000_0000_0000_0100_0000_0000_0000_0000;
		5'b10011: outZ = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
		5'b10100: outZ = 32'b0000_0000_0001_0000_0000_0000_0000_0000;
		5'b10101: outZ = 32'b0000_0000_0010_0000_0000_0000_0000_0000;
		5'b10110: outZ = 32'b0000_0000_0100_0000_0000_0000_0000_0000;
		5'b10111: outZ = 32'b0000_0000_1000_0000_0000_0000_0000_0000;
		5'b11000: outZ = 32'b0000_0001_0000_0000_0000_0000_0000_0000;
		5'b11001: outZ = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
		5'b11010: outZ = 32'b0000_0100_0000_0000_0000_0000_0000_0000;
		5'b11011: outZ = 32'b0000_1000_0000_0000_0000_0000_0000_0000;
		5'b11100: outZ = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
		5'b11101: outZ = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
		5'b11110: outZ = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
		5'b11111: outZ = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
		default: outZ = 32'b0;
	endcase
end

always @(*) begin
	case (IR[9:5])
		5'b00000: outX = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
		5'b00001: outX = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
		5'b00010: outX = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
		5'b00011: outX = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		5'b00100: outX = 32'b0000_0000_0000_0000_0000_0000_0001_0000;
		5'b00101: outX = 32'b0000_0000_0000_0000_0000_0000_0010_0000;
		5'b00110: outX = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
		5'b00111: outX = 32'b0000_0000_0000_0000_0000_0000_1000_0000;
		5'b01000: outX = 32'b0000_0000_0000_0000_0000_0001_0000_0000;
		5'b01001: outX = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
		5'b01010: outX = 32'b0000_0000_0000_0000_0000_0100_0000_0000;
		5'b01011: outX = 32'b0000_0000_0000_0000_0000_1000_0000_0000;
		5'b01100: outX = 32'b0000_0000_0000_0000_0001_0000_0000_0000;
		5'b01101: outX = 32'b0000_0000_0000_0000_0010_0000_0000_0000;
		5'b01110: outX = 32'b0000_0000_0000_0000_0100_0000_0000_0000;
		5'b01111: outX = 32'b0000_0000_0000_0000_1000_0000_0000_0000;
		5'b10000: outX = 32'b0000_0000_0000_0001_0000_0000_0000_0000;
		5'b10001: outX = 32'b0000_0000_0000_0010_0000_0000_0000_0000;
		5'b10010: outX = 32'b0000_0000_0000_0100_0000_0000_0000_0000;
		5'b10011: outX = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
		5'b10100: outX = 32'b0000_0000_0001_0000_0000_0000_0000_0000;
		5'b10101: outX = 32'b0000_0000_0010_0000_0000_0000_0000_0000;
		5'b10110: outX = 32'b0000_0000_0100_0000_0000_0000_0000_0000;
		5'b10111: outX = 32'b0000_0000_1000_0000_0000_0000_0000_0000;
		5'b11000: outX = 32'b0000_0001_0000_0000_0000_0000_0000_0000;
		5'b11001: outX = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
		5'b11010: outX = 32'b0000_0100_0000_0000_0000_0000_0000_0000;
		5'b11011: outX = 32'b0000_1000_0000_0000_0000_0000_0000_0000;
		5'b11100: outX = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
		5'b11101: outX = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
		5'b11110: outX = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
		5'b11111: outX = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
		default: outX = 32'b0;
	endcase
end

always @(*) begin
	case (IR[4:0])
		5'b00000: outY = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
		5'b00001: outY = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
		5'b00010: outY = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
		5'b00011: outY = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		5'b00100: outY = 32'b0000_0000_0000_0000_0000_0000_0001_0000;
		5'b00101: outY = 32'b0000_0000_0000_0000_0000_0000_0010_0000;
		5'b00110: outY = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
		5'b00111: outY = 32'b0000_0000_0000_0000_0000_0000_1000_0000;
		5'b01000: outY = 32'b0000_0000_0000_0000_0000_0001_0000_0000;
		5'b01001: outY = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
		5'b01010: outY = 32'b0000_0000_0000_0000_0000_0100_0000_0000;
		5'b01011: outY = 32'b0000_0000_0000_0000_0000_1000_0000_0000;
		5'b01100: outY = 32'b0000_0000_0000_0000_0001_0000_0000_0000;
		5'b01101: outY = 32'b0000_0000_0000_0000_0010_0000_0000_0000;
		5'b01110: outY = 32'b0000_0000_0000_0000_0100_0000_0000_0000;
		5'b01111: outY = 32'b0000_0000_0000_0000_1000_0000_0000_0000;
		5'b10000: outY = 32'b0000_0000_0000_0001_0000_0000_0000_0000;
		5'b10001: outY = 32'b0000_0000_0000_0010_0000_0000_0000_0000;
		5'b10010: outY = 32'b0000_0000_0000_0100_0000_0000_0000_0000;
		5'b10011: outY = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
		5'b10100: outY = 32'b0000_0000_0001_0000_0000_0000_0000_0000;
		5'b10101: outY = 32'b0000_0000_0010_0000_0000_0000_0000_0000;
		5'b10110: outY = 32'b0000_0000_0100_0000_0000_0000_0000_0000;
		5'b10111: outY = 32'b0000_0000_1000_0000_0000_0000_0000_0000;
		5'b11000: outY = 32'b0000_0001_0000_0000_0000_0000_0000_0000;
		5'b11001: outY = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
		5'b11010: outY = 32'b0000_0100_0000_0000_0000_0000_0000_0000;
		5'b11011: outY = 32'b0000_1000_0000_0000_0000_0000_0000_0000;
		5'b11100: outY = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
		5'b11101: outY = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
		5'b11110: outY = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
		5'b11111: outY = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
		default: outY = 32'b0;
	endcase
end

assign R0in = (outX[0] & RXin) | (outY[0] & RYin) | (outZ[0] & RZin);
assign R1in = (outX[1] & RXin) | (outY[1] & RYin) | (outZ[1] & RZin);
assign R2in = (outX[2] & RXin) | (outY[2] & RYin) | (outZ[2] & RZin);
assign R3in = (outX[3] & RXin) | (outY[3] & RYin) | (outZ[3] & RZin);
assign R4in = (outX[4] & RXin) | (outY[4] & RYin) | (outZ[4] & RZin);
assign R5in = (outX[5] & RXin) | (outY[5] & RYin) | (outZ[5] & RZin);
assign R6in = (outX[6] & RXin) | (outY[6] & RYin) | (outZ[6] & RZin);
assign R7in = (outX[7] & RXin) | (outY[7] & RYin) | (outZ[7] & RZin);
assign R8in = (outX[8] & RXin) | (outY[8] & RYin) | (outZ[8] & RZin);
assign R9in = (outX[9] & RXin) | (outY[9] & RYin) | (outZ[9] & RZin);
assign R10in = (outX[10] & RXin) | (outY[10] & RYin) | (outZ[10] & RZin);
assign R11in = (outX[11] & RXin) | (outY[11] & RYin) | (outZ[11] & RZin);
assign R12in = (outX[12] & RXin) | (outY[12] & RYin) | (outZ[12] & RZin);
assign R13in = (outX[13] & RXin) | (outY[13] & RYin) | (outZ[13] & RZin);
assign R14in = (outX[14] & RXin) | (outY[14] & RYin) | (outZ[14] & RZin);
assign R15in = (outX[15] & RXin) | (outY[15] & RYin) | (outZ[15] & RZin);
assign R16in = (outX[16] & RXin) | (outY[16] & RYin) | (outZ[16] & RZin);
assign R17in = (outX[17] & RXin) | (outY[17] & RYin) | (outZ[17] & RZin);
assign R18in = (outX[18] & RXin) | (outY[18] & RYin) | (outZ[18] & RZin);
assign R19in = (outX[19] & RXin) | (outY[19] & RYin) | (outZ[19] & RZin);
assign R20in = (outX[20] & RXin) | (outY[20] & RYin) | (outZ[20] & RZin);
assign R21in = (outX[21] & RXin) | (outY[21] & RYin) | (outZ[21] & RZin);
assign R22in = (outX[22] & RXin) | (outY[22] & RYin) | (outZ[22] & RZin);
assign R23in = (outX[23] & RXin) | (outY[23] & RYin) | (outZ[23] & RZin);
assign R24in = (outX[24] & RXin) | (outY[24] & RYin) | (outZ[24] & RZin);
assign R25in = (outX[25] & RXin) | (outY[25] & RYin) | (outZ[25] & RZin);
assign R26in = (outX[26] & RXin) | (outY[26] & RYin) | (outZ[26] & RZin);
assign R27in = (outX[27] & RXin) | (outY[27] & RYin) | (outZ[27] & RZin);
assign R28in = (outX[28] & RXin) | (outY[28] & RYin) | (outZ[28] & RZin);
assign R29in = (outX[29] & RXin) | (outY[29] & RYin) | (outZ[29] & RZin);
assign R30in = (outX[30] & RXin) | (outY[30] & RYin) | (outZ[30] & RZin);
assign R31in = (outX[31] & RXin) | (outY[31] & RYin) | (outZ[31] & RZin);

assign R0out = (outX[0] & RXout) | (outY[0] & RYout) | (outZ[0] & RZout);
assign R1out = (outX[1] & RXout) | (outY[1] & RYout) | (outZ[1] & RZout);
assign R2out = (outX[2] & RXout) | (outY[2] & RYout) | (outZ[2] & RZout);
assign R3out = (outX[3] & RXout) | (outY[3] & RYout) | (outZ[3] & RZout);
assign R4out = (outX[4] & RXout) | (outY[4] & RYout) | (outZ[4] & RZout);
assign R5out = (outX[5] & RXout) | (outY[5] & RYout) | (outZ[5] & RZout);
assign R6out = (outX[6] & RXout) | (outY[6] & RYout) | (outZ[6] & RZout);
assign R7out = (outX[7] & RXout) | (outY[7] & RYout) | (outZ[7] & RZout);
assign R8out = (outX[8] & RXout) | (outY[8] & RYout) | (outZ[8] & RZout);
assign R9out = (outX[9] & RXout) | (outY[9] & RYout) | (outZ[9] & RZout);
assign R10out = (outX[10] & RXout) | (outY[10] & RYout) | (outZ[10] & RZout);
assign R11out = (outX[11] & RXout) | (outY[11] & RYout) | (outZ[11] & RZout);
assign R12out = (outX[12] & RXout) | (outY[12] & RYout) | (outZ[12] & RZout);
assign R13out = (outX[13] & RXout) | (outY[13] & RYout) | (outZ[13] & RZout);
assign R14out = (outX[14] & RXout) | (outY[14] & RYout) | (outZ[14] & RZout);
assign R15out = (outX[15] & RXout) | (outY[15] & RYout) | (outZ[15] & RZout);
assign R16out = (outX[16] & RXout) | (outY[16] & RYout) | (outZ[16] & RZout);
assign R17out = (outX[17] & RXout) | (outY[17] & RYout) | (outZ[17] & RZout);
assign R18out = (outX[18] & RXout) | (outY[18] & RYout) | (outZ[18] & RZout);
assign R19out = (outX[19] & RXout) | (outY[19] & RYout) | (outZ[19] & RZout);
assign R20out = (outX[20] & RXout) | (outY[20] & RYout) | (outZ[20] & RZout);
assign R21out = (outX[21] & RXout) | (outY[21] & RYout) | (outZ[21] & RZout);
assign R22out = (outX[22] & RXout) | (outY[22] & RYout) | (outZ[22] & RZout);
assign R23out = (outX[23] & RXout) | (outY[23] & RYout) | (outZ[23] & RZout);
assign R24out = (outX[24] & RXout) | (outY[24] & RYout) | (outZ[24] & RZout);
assign R25out = (outX[25] & RXout) | (outY[25] & RYout) | (outZ[25] & RZout);
assign R26out = (outX[26] & RXout) | (outY[26] & RYout) | (outZ[26] & RZout);
assign R27out = (outX[27] & RXout) | (outY[27] & RYout) | (outZ[27] & RZout);
assign R28out = (outX[28] & RXout) | (outY[28] & RYout) | (outZ[28] & RZout);
assign R29out = (outX[29] & RXout) | (outY[29] & RYout) | (outZ[29] & RZout);
assign R30out = (outX[30] & RXout) | (outY[30] & RYout) | (outZ[30] & RZout);
assign R31out1 = (outX[31] & RXout) | (outY[31] & RYout) | (outZ[31] & RZout);
assign R31out = R31out1 ^ R31out2;

parameter reset	= 7'b000_0000; //0
parameter ldADDR  = 7'b000_0001; //1
parameter PCp 	   = 7'b000_0010; //2
parameter fetch1  = 7'b000_0011; //3
parameter fetch   = 7'b000_0100; //4
parameter mv      = 7'b000_0101; //5
parameter mvi1    = 7'b000_0110; //6
parameter mvi2    = 7'b000_0111; //7
parameter mvi3    = 7'b000_1000; //8
parameter add1    = 7'b000_1001; //9
parameter add2    = 7'b000_1010; //10
parameter add3    = 7'b000_1011; //11
parameter sub1    = 7'b000_1100; //12
parameter sub2    = 7'b000_1101; //13
parameter sub3    = 7'b000_1110; //14
parameter ld1     = 7'b000_1111; //15
parameter ld2     = 7'b001_0000; //16
parameter ld3     = 7'b001_0001; //17
parameter st1     = 7'b001_0010; //18
parameter st2     = 7'b001_0011; //19
parameter st3     = 7'b001_0100; //20
parameter and1    = 7'b001_0101; //21
parameter and2    = 7'b001_0110; //22
parameter and3    = 7'b001_0111; //23
parameter or1     = 7'b001_1000; //24
parameter or2     = 7'b001_1001; //25
parameter or3     = 7'b001_1010; //26
parameter xor1    = 7'b001_1011; //27
parameter xor2    = 7'b001_1100; //28
parameter xor3    = 7'b001_1101; //29
parameter not1    = 7'b001_1110; //30
parameter not2    = 7'b001_1111; //31
parameter not3    = 7'b010_0000; //32
parameter cpe1    = 7'b010_0001; //33
parameter cpe2    = 7'b010_0010; //34
parameter cpl1    = 7'b010_0011; //35
parameter cpl2    = 7'b010_0100; //36
parameter cpge1   = 7'b010_0101; //37
parameter cpge2   = 7'b010_0110; //38
parameter cpne1   = 7'b010_0111; //39
parameter cpne2   = 7'b010_1000; //40
parameter srl1    = 7'b010_1001; //41
parameter srl2    = 7'b010_1010; //42
parameter srl3    = 7'b010_1011; //43
parameter sll1    = 7'b010_1100; //44
parameter sll2    = 7'b010_1101; //45
parameter sll3    = 7'b010_1110; //46
parameter sra1    = 7'b010_1111; //47
parameter sra2    = 7'b011_0000; //48
parameter sra3    = 7'b011_0001; //49
parameter addf1   = 7'b011_0010; //50
parameter addf2   = 7'b011_0011; //51
parameter addf3   = 7'b011_0100; //52
parameter subf1   = 7'b011_0101; //53
parameter subf2   = 7'b011_0110; //54
parameter subf3   = 7'b011_0111; //55
parameter mulf1   = 7'b011_1000; //56
parameter mulf2   = 7'b011_1001; //57
parameter mulf3   = 7'b011_1010; //58
parameter sin1    = 7'b011_1011; //59
parameter sin2    = 7'b011_1100; //60
parameter sin3    = 7'b011_1101; //61
parameter sin4    = 7'b011_1110; //62
parameter sin5    = 7'b011_1111; //63
parameter cos1    = 7'b100_0000; //64
parameter cos2    = 7'b100_0001; //65
parameter cos3    = 7'b100_0010; //66
parameter cos4    = 7'b100_0011; //67
parameter cos5    = 7'b100_0100; //68
parameter brit    = 7'b100_0101; //69
parameter brif    = 7'b100_0110; //70

logic [7:0] state_reg, state_next;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n)
		state_reg <= reset;
	else
		state_reg <= state_next;
end

always @(*) begin
	state_next = state_reg;
	case (state_reg)
		reset: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			if (~rst_n)
				state_next = reset;
			else if (rst_n & run)
				state_next = ldADDR;
		end
		
		ldADDR:	begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 1;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 1;
			start = 0;
			state_next = PCp;
		end

		PCp: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 1;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 1;
			R31out2 = 0;
			start = 0;
			state_next = fetch1;
		end
		
		fetch1: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 1;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = fetch;
		end
		
		fetch: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 1;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			if (IR[31:27] == 5'b00000)
				state_next = mv;
			else if (IR[31:27] == 5'b00001)
				state_next = mvi1;
			else if (IR[31:27] == 5'b00010)
				state_next = add1;
			else if (IR[31:27] == 5'b00011)
				state_next = sub1;
			else if (IR[31:27] == 5'b00100)
				state_next = ld1;
			else if (IR[31:27] == 5'b00101)
				state_next = st1;
			else if (IR[31:27] == 5'b00110)
				state_next = and1;
			else if (IR[31:27] == 5'b00111)
				state_next = or1;
			else if (IR[31:27] == 5'b01000)
				state_next = xor1;
			else if (IR[31:27] == 5'b01001)
				state_next = not1;
			else if (IR[31:27] == 5'b01010)
				state_next = cpe1;
			else if (IR[31:27] == 5'b01011)
				state_next = cpl1;
			else if (IR[31:27] == 5'b01100)
				state_next = cpge1;
			else if (IR[31:27] == 5'b01101)
				state_next = cpne1;
			else if (IR[31:27] == 5'b01110)
				state_next = srl1;
			else if (IR[31:27] == 5'b01111)
				state_next = sll1;
			else if (IR[31:27] == 5'b10000)
				state_next = sra1;
			else if (IR[31:27] == 5'b10001)
				state_next = addf1;
			else if (IR[31:27] == 5'b10010)
				state_next = subf1;
			else if (IR[31:27] == 5'b10011)
				state_next = mulf1;
			else if (IR[31:27] == 5'b10100)
				state_next = sin1;
			else if (IR[31:27] == 5'b10101)
				state_next = cos1;
			else if (IR[31:27] == 5'b10110)
				state_next = brit; // branch if true
			else if (IR[31:27] == 5'b10111)
				state_next = brif; // branch if false
			else 
				state_next = ldADDR;
		end
		
		mv: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 1;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		mvi1: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 1;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 1;
			start = 0;
			state_next = mvi2;
		end

		mvi2: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = mvi3;
		end

		mvi3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 1;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 1;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 1;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		add1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = add2;
		end
		
		add2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = add3;
		end
		
		add3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		sub1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sub2;
		end
		
		sub2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0001;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sub3;
		end
		
		sub3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		ld1: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 1;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ld2;
		end
		
		ld2: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ld3;
		end
		
		ld3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 1;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 1;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		st1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 1;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = st2;
		end
		
		st2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 1;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = st3;
		end
		
		st3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 1;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		and1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = and2;
		end
		
		and2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0010;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = and3;
		end
		
		and3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		or1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = or2;
		end
		
		or2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0011;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = or3;
		end
		
		or3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		xor1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = xor2;
		end
		
		xor2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0100;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = xor3;
		end
		
		xor3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		not1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = not2;
		end
		
		not2: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0101;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = not3;
		end
		
		not3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		cpe1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = cpe2;
		end
		
		cpe2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1001;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		cpl1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = cpl2;
		end
		
		cpl2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1010;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		cpge1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = cpge2;
		end
		
		cpge2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1011;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		cpne1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = cpne2;
		end
		
		cpne2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1100;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		srl1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = srl2;
		end
		
		srl2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0110;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = srl3;
		end
		
		srl3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		sll1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sll2;
		end
		
		sll2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0111;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sll3;
		end
		
		sll3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		sra1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sra2;
		end
		
		sra2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sra3;
		end
		
		sra3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		addf1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = addf2;
		end
		
		addf2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1101;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = addf3;
		end
		
		addf3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		subf1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = subf2;
		end
		
		subf2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1110;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = subf3;
		end
		
		subf3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		mulf1: begin
			RXout = 1;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = mulf2;
		end
		
		mulf2: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 1;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b1111;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = mulf3;
		end
		
		mulf3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 1;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		sin1: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 1;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 1;
			state_next = sin2;
		end
		
		sin2: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 1;
			state_next = sin3;
		end
		
		sin3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			if (~finish) begin
				state_next = sin3;
			end else if (finish) begin
				state_next = sin4;
			end
		end
		
		sin4: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 1;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = sin5;
		end
		
		sin5: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 1;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 1;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		cos1: begin
			RXout = 0;
			RYout = 1;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 1;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 1;
			state_next = cos2;
		end
		
		cos2: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 1;
			state_next = cos3;
		end
		
		cos3: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			if (~finish) begin
				state_next = cos3;
			end else if (finish) begin
				state_next = cos4;
			end
		end
		
		cos4: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 1;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = cos5;
		end
		
		cos5: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 1;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 1;
			ALUControl[3:0] = 4'b0000;
			Done = 1;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			state_next = ldADDR;
		end
		
		brit: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			if (&G) 
				state_next = mv;
			else if (~(&G))
				state_next = ldADDR;
		end
		
		brif: begin
			RXout = 0;
			RYout = 0;
			RZout = 0;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			Bin = 0;
			RXin = 0;
			RYin = 0;
			RZin = 0;
			Gin = 0;
			Sinin = 0;
			Cosin = 0;
			Sinout = 0;
			Cosout = 0;
			ALUControl[3:0] = 4'b0000;
			Done = 0;
			ADDRin = 0;
			DOUTin = 0;
			W_D = 0;
			incr_pc = 0;
			R31out2 = 0;
			start = 0;
			if (~(&G)) 
				state_next = mv;
			else if (&G)
				state_next = ldADDR;
		end
	endcase
end

endmodule
