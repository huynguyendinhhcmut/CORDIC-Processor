module controlunitFSM (
	input logic clk, rst_n, run,
	input logic [31:0] IR,	
	output logic [3:0] ALUControl,
	output logic IRin, Gout, DINout, Sinout, Cosout, incr_pc, Ain, Bin, Gin, Sinin, Cosin, ADDRin, DOUTin, W_D, Done, start,
	output logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R16out, R17out, R18out, R19out, R20out, R21out, R22out, R23out, R24out, R25out, R26out, R27out, R28out, R29out, R30out, R31out,
	output logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, R16in, R17in, R18in, R19in, R20in, R21in, R22in, R23in, R24in, R25in, R26in, R27in, R28in, R29in, R30in, R31in 
);

logic [31:0] outX, outY;
logic RXout, RYout, RXin, RYin;
logic R31out1, R31out2;

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

assign R0in = (outX[0] & RXin) | (outY[0] & RYin);
assign R1in = (outX[1] & RXin) | (outY[1] & RYin);
assign R2in = (outX[2] & RXin) | (outY[2] & RYin);
assign R3in = (outX[3] & RXin) | (outY[3] & RYin);
assign R4in = (outX[4] & RXin) | (outY[4] & RYin);
assign R5in = (outX[5] & RXin) | (outY[5] & RYin);
assign R6in = (outX[6] & RXin) | (outY[6] & RYin);
assign R7in = (outX[7] & RXin) | (outY[7] & RYin);
assign R8in = (outX[8] & RXin) | (outY[8] & RYin);
assign R9in = (outX[9] & RXin) | (outY[9] & RYin);
assign R10in = (outX[10] & RXin) | (outY[10] & RYin);
assign R11in = (outX[11] & RXin) | (outY[11] & RYin);
assign R12in = (outX[12] & RXin) | (outY[12] & RYin);
assign R13in = (outX[13] & RXin) | (outY[13] & RYin);
assign R14in = (outX[14] & RXin) | (outY[14] & RYin);
assign R15in = (outX[15] & RXin) | (outY[15] & RYin);
assign R16in = (outX[16] & RXin) | (outY[16] & RYin);
assign R17in = (outX[17] & RXin) | (outY[17] & RYin);
assign R18in = (outX[18] & RXin) | (outY[18] & RYin);
assign R19in = (outX[19] & RXin) | (outY[19] & RYin);
assign R20in = (outX[20] & RXin) | (outY[20] & RYin);
assign R21in = (outX[21] & RXin) | (outY[21] & RYin);
assign R22in = (outX[22] & RXin) | (outY[22] & RYin);
assign R23in = (outX[23] & RXin) | (outY[23] & RYin);
assign R24in = (outX[24] & RXin) | (outY[24] & RYin);
assign R25in = (outX[25] & RXin) | (outY[25] & RYin);
assign R26in = (outX[26] & RXin) | (outY[26] & RYin);
assign R27in = (outX[27] & RXin) | (outY[27] & RYin);
assign R28in = (outX[28] & RXin) | (outY[28] & RYin);
assign R29in = (outX[29] & RXin) | (outY[29] & RYin);
assign R30in = (outX[30] & RXin) | (outY[30] & RYin);
assign R31in = (outX[31] & RXin) | (outY[31] & RYin);

assign R0out = (outX[0] & RXout) | (outY[0] & RYout);
assign R1out = (outX[1] & RXout) | (outY[1] & RYout);
assign R2out = (outX[2] & RXout) | (outY[2] & RYout);
assign R3out = (outX[3] & RXout) | (outY[3] & RYout);
assign R4out = (outX[4] & RXout) | (outY[4] & RYout);
assign R5out = (outX[5] & RXout) | (outY[5] & RYout);
assign R6out = (outX[6] & RXout) | (outY[6] & RYout);
assign R7out = (outX[7] & RXout) | (outY[7] & RYout);
assign R8out = (outX[8] & RXout) | (outY[8] & RYout);
assign R9out = (outX[9] & RXout) | (outY[9] & RYout);
assign R10out = (outX[10] & RXout) | (outY[10] & RYout);
assign R11out = (outX[11] & RXout) | (outY[11] & RYout);
assign R12out = (outX[12] & RXout) | (outY[12] & RYout);
assign R13out = (outX[13] & RXout) | (outY[13] & RYout);
assign R14out = (outX[14] & RXout) | (outY[14] & RYout);
assign R15out = (outX[15] & RXout) | (outY[15] & RYout);
assign R16out = (outX[16] & RXout) | (outY[16] & RYout);
assign R17out = (outX[17] & RXout) | (outY[17] & RYout);
assign R18out = (outX[18] & RXout) | (outY[18] & RYout);
assign R19out = (outX[19] & RXout) | (outY[19] & RYout);
assign R20out = (outX[20] & RXout) | (outY[20] & RYout);
assign R21out = (outX[21] & RXout) | (outY[21] & RYout);
assign R22out = (outX[22] & RXout) | (outY[22] & RYout);
assign R23out = (outX[23] & RXout) | (outY[23] & RYout);
assign R24out = (outX[24] & RXout) | (outY[24] & RYout);
assign R25out = (outX[25] & RXout) | (outY[25] & RYout);
assign R26out = (outX[26] & RXout) | (outY[26] & RYout);
assign R27out = (outX[27] & RXout) | (outY[27] & RYout);
assign R28out = (outX[28] & RXout) | (outY[28] & RYout);
assign R29out = (outX[29] & RXout) | (outY[29] & RYout);
assign R30out = (outX[30] & RXout) | (outY[30] & RYout);
assign R31out1 = (outX[31] & RXout) | (outY[31] & RYout);
assign R31out = R31out1 ^ R31out2;

parameter reset = 6'b00_0000;
parameter ldADDR = 6'b00_0001;
parameter PCp = 6'b00_0010;
parameter fetch1 = 6'b00_0011;
parameter fetch = 6'b00_0100;
parameter mv = 6'b00_0101;
parameter mvi1 = 6'b00_0110;
parameter mvi2 = 6'b00_0111;
parameter mvi3 = 6'b00_1000;
parameter add1 = 6'b00_1001;
parameter add2 = 6'b00_1010;
parameter add3 = 6'b00_1011;
parameter sub1 = 6'b00_1100;
parameter sub2 = 6'b00_1101;
parameter sub3 = 6'b00_1110;
parameter ld1 = 6'b00_1111;
parameter ld2 = 6'b01_0000;
parameter ld3 = 6'b01_0001;
parameter st1 = 6'b01_0010;
parameter st2 = 6'b01_0011;
parameter st3 = 6'b01_0100;
parameter and1 = 6'b01_0101;
parameter and2 = 6'b01_0110;
parameter and3 = 6'b01_0111;
parameter or1 = 6'b01_1000;
parameter or2 = 6'b01_1001;
parameter or3 = 6'b01_1010;
parameter xor1 = 6'b01_1011;
parameter xor2 = 6'b01_1100;
parameter xor3 = 6'b01_1101;
parameter not1 = 6'b01_1110;
parameter not2 = 6'b01_1111;
parameter not3 = 6'b10_0000;

logic [5:0] state, state_reg, state_next;

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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 1;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 1;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 1;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			/*else if (IR[31:27] == 5'b01010)
				state_next = cpe1;
			else if (IR[31:27] == 5'b01011)
				state_next = cpge1;
			else if (IR[31:27] == 5'b01100)
				state_next = cpl1;
			else if (IR[31:27] == 5'b01101)
				state_next = cpne1;
			else if (IR[31:27] == 5'b01110)
				state_next = addf1;
			else if (IR[31:27] == 5'b01111)
				state_next = subf1;
			else if (IR[31:27] == 5'b10000)
				state_next = mulf1;
			else if (IR[31:27] == 5'b10001)
				state_next = sin1;
			else if (IR[31:27] == 5'b10010)
				state_next = cos1;*/
		end
		
		mv: begin
			RXout = 0;
			RYout = 1;
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 1;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 1;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 1;
			RXin = 0;
			RYin = 0;
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
			Gout = 0;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 0;
			RYin = 0;
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
			Gout = 1;
			DINout = 0;
			IRin = 0;
			Ain = 0;
			RXin = 1;
			RYin = 0;
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
	endcase
end

assign state = state_reg;

endmodule

