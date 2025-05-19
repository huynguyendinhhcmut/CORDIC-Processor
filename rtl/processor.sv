module processor (
	input logic clk, rst_n, run,
	input logic [31:0] DIN, 
	output logic [31:0] ADDR, DOUT,
	output logic W, Done, V
);

logic [31:0] pre_R0, pre_R1, pre_R2, pre_R3, pre_R4, pre_R5, pre_R6, pre_R7, pre_R8, pre_R9, pre_R10, pre_R11, pre_R12, pre_R13, pre_R14, pre_R15, pre_R16, pre_R17, pre_R18, pre_R19, pre_R20, pre_R21, pre_R22, pre_R23, pre_R24, pre_R25, pre_R26, pre_R27, pre_R28, pre_R29, pre_R30, pre_R31, pre_A, pre_B, pre_G, pre_G1, pre_Sin, pre_Sin1, pre_Cos, pre_Cos1, pre_ADDR, pre_DOUT;
logic [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31, A, B, G, Sin, Cos, BUS;
logic [31:0] pre_IR, IR;
logic [3:0] ALUControl;
logic IRin, Gout, DINout, Sinout, Cosout, incr_pc, Ain, Bin, Gin, Sinin, Cosin, ADDRin, DOUTin, W_D, start;
logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R16out, R17out, R18out, R19out, R20out, R21out, R22out, R23out, R24out, R25out, R26out, R27out, R28out, R29out, R30out, R31out;
logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, R16in, R17in, R18in, R19in, R20in, R21in, R22in, R23in, R24in, R25in, R26in, R27in, R28in, R29in, R30in, R31in;

//R0in
always @(*) begin
	case (R0in)
		1'b0: pre_R0 = R0;
		1'b1: pre_R0 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R0 <= 32'b0;
	else
		R0 <= pre_R0;
end

//R1in
always @(*) begin
	case (R1in)
		1'b0: pre_R1 = R1;
		1'b1: pre_R1 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R1 <= 32'b0;
	else
		R1 <= pre_R1;
end

//R2in
always @(*) begin
	case (R2in)
		1'b0: pre_R2 = R2;
		1'b1: pre_R2 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R2 <= 32'b0;
	else
		R2 <= pre_R2;
end

//R3in
always @(*) begin
	case (R2in)
		1'b0: pre_R3 = R3;
		1'b1: pre_R3 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R3 <= 32'b0;
	else
		R3 <= pre_R3;
end

//R4in
always @(*) begin
	case (R4in)
		1'b0: pre_R4 = R4;
		1'b1: pre_R4 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R4 <= 32'b0;
	else
		R4 <= pre_R4;
end

//R5in
always @(*) begin
	case (R5in)
		1'b0: pre_R5 = R5;
		1'b1: pre_R5 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R5 <= 32'b0;
	else
		R5 <= pre_R5;
end

//R6in
always @(*) begin
	case (R6in)
		1'b0: pre_R6 = R6;
		1'b1: pre_R6 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R6 <= 32'b0;
	else
		R6 <= pre_R6;
end

//R7in
always @(*) begin
	case (R7in)
		1'b0: pre_R7 = R7;
		1'b1: pre_R7 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R7 <= 32'b0;
	else
		R7 <= pre_R7;
end

//R8in
always @(*) begin
	case (R8in)
		1'b0: pre_R8 = R8;
		1'b1: pre_R8 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R8 <= 32'b0;
	else
		R8 <= pre_R8;
end

//R9in
always @(*) begin
	case (R9in)
		1'b0: pre_R9 = R9;
		1'b1: pre_R9 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R9 <= 32'b0;
	else
		R9 <= pre_R9;
end

//R10in
always @(*) begin
	case (R10in)
		1'b0: pre_R10 = R10;
		1'b1: pre_R10 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R10 <= 32'b0;
	else
		R10 <= pre_R10;
end

//R11in
always @(*) begin
	case (R11in)
		1'b0: pre_R11 = R11;
		1'b1: pre_R11 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R11 <= 32'b0;
	else
		R11 <= pre_R11;
end

//R12in
always @(*) begin
	case (R12in)
		1'b0: pre_R12 = R12;
		1'b1: pre_R12 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R12 <= 32'b0;
	else
		R12 <= pre_R12;
end

//R13in
always @(*) begin
	case (R13in)
		1'b0: pre_R13 = R13;
		1'b1: pre_R13 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R13 <= 32'b0;
	else
		R13 <= pre_R13;
end

//R14in
always @(*) begin
	case (R14in)
		1'b0: pre_R14 = R14;
		1'b1: pre_R14 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R14 <= 32'b0;
	else
		R14 <= pre_R14;
end

//R15in
always @(*) begin
	case (R15in)
		1'b0: pre_R15 = R15;
		1'b1: pre_R15 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R15 <= 32'b0;
	else
		R15 <= pre_R15;
end

//R16in
always @(*) begin
	case (R16in)
		1'b0: pre_R16 = R16;
		1'b1: pre_R16 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R16 <= 32'b0;
	else
		R16 <= pre_R16;
end

//R17in
always @(*) begin
	case (R17in)
		1'b0: pre_R17 = R17;
		1'b1: pre_R17 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R17 <= 32'b0;
	else
		R17 <= pre_R17;
end

//R18in
always @(*) begin
	case (R18in)
		1'b0: pre_R18 = R18;
		1'b1: pre_R18 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R18 <= 32'b0;
	else
		R18 <= pre_R18;
end

//R19in
always @(*) begin
	case (R19in)
		1'b0: pre_R19 = R19;
		1'b1: pre_R19 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R19 <= 32'b0;
	else
		R19 <= pre_R19;
end

//R20in
always @(*) begin
	case (R20in)
		1'b0: pre_R20 = R20;
		1'b1: pre_R20 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R20 <= 32'b0;
	else
		R20 <= pre_R20;
end

//R21in
always @(*) begin
	case (R21in)
		1'b0: pre_R21 = R21;
		1'b1: pre_R21 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R21 <= 32'b0;
	else
		R21 <= pre_R21;
end

//R22in
always @(*) begin
	case (R22in)
		1'b0: pre_R22 = R22;
		1'b1: pre_R22 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R22 <= 32'b0;
	else
		R22 <= pre_R22;
end

//R23in
always @(*) begin
	case (R23in)
		1'b0: pre_R23 = R23;
		1'b1: pre_R23 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R23 <= 32'b0;
	else
		R23 <= pre_R23;
end

//R24in
always @(*) begin
	case (R24in)
		1'b0: pre_R24 = R24;
		1'b1: pre_R24 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R24 <= 32'b0;
	else
		R24 <= pre_R24;
end

//R25in
always @(*) begin
	case (R25in)
		1'b0: pre_R25 = R25;
		1'b1: pre_R25 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R25 <= 32'b0;
	else
		R25 <= pre_R25;
end

//R26in
always @(*) begin
	case (R26in)
		1'b0: pre_R26 = R26;
		1'b1: pre_R26 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R26 <= 32'b0;
	else
		R26 <= pre_R26;
end

//R27in
always @(*) begin
	case (R27in)
		1'b0: pre_R27 = R27;
		1'b1: pre_R27 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R27 <= 32'b0;
	else
		R27 <= pre_R27;
end

//R28in
always @(*) begin
	case (R28in)
		1'b0: pre_R28 = R28;
		1'b1: pre_R28 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R28 <= 32'b0;
	else
		R28 <= pre_R28;
end

//R29in
always @(*) begin
	case (R29in)
		1'b0: pre_R29 = R29;
		1'b1: pre_R29 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R29 <= 32'b0;
	else
		R29 <= pre_R29;
end

//R30in
always @(*) begin
	case (R30in)
		1'b0: pre_R30 = R30;
		1'b1: pre_R30 = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		R30 <= 32'b0;
	else
		R30 <= pre_R30;
end

//R31in
counterR31 counterR31 (.clk(clk), .rst_n(rst_n), .BUS(BUS), .R31in(R31in), .incr_pc(incr_pc), .R31(R31));

//Ain
always @(*) begin
	case (Ain)
		1'b0: pre_A = A;
		1'b1: pre_A = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		A <= 32'b0;
	else
		A <= pre_A;
end

//Bin
always @(*) begin
	case (Bin)
		1'b0: pre_B = B;
		1'b1: pre_B = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		B <= 32'b0;
	else
		B <= pre_B;
end

//Gin
always @(*) begin
	case (Gin)
		1'b0: pre_G = G;
		1'b1: pre_G = pre_G1;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		G <= 32'b0;
	else
		G <= pre_G;
end

//Sinin
always @(*) begin
	case (Sinin)
		1'b0: pre_Sin = Sin;
		1'b1: pre_Sin = pre_Sin1;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		Sin <= 32'b0;
	else
		Sin <= pre_Sin;
end

//Cosin
always @(*) begin
	case (Cosin)
		1'b0: pre_Cos = Cos;
		1'b1: pre_Cos = pre_Cos1;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		Cos <= 32'b0;
	else
		Cos <= pre_Cos;
end

//IRin
always @(*) begin
	case (IRin)
		1'b0: pre_IR = IR;
		1'b1: pre_IR = DIN;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		IR <= 32'b0;
	else
		IR <= pre_IR;
end

//ADDRin
always @(*) begin
	case (ADDRin)
		1'b0: pre_ADDR = ADDR;
		1'b1: pre_ADDR = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		ADDR <= 32'b0;
	else
		ADDR <= pre_ADDR;
end

//DOUTin
always @(*) begin
	case (DOUTin)
		1'b0: pre_DOUT = DOUT;
		1'b1: pre_DOUT = BUS;
	endcase
end
always @(posedge clk) begin
	if (~rst_n)
		DOUT <= 32'b0;
	else
		DOUT <= pre_DOUT;
end

//W_D
always @(posedge clk) begin
	if (~rst_n)
		W <= 32'b0;
	else
		W <= W_D;
end

controlunitFSM controlunitFSM (.clk(clk), .rst_n(rst_n), .run(run), .IR(IR), .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), .R9out(R9out), .R10out(R10out), .R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out), .R16out(R16out), .R17out(R17out), .R18out(R18out), .R19out(R19out), .R20out(R20out), .R21out(R21out), .R22out(R22out), .R23out(R23out), .R24out(R24out), .R25out(R25out), .R26out(R26out), .R27out(R27out), .R28out(R28out), .R29out(R29out), .R30out(R30out), .R31out(R31out), .R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in), .R16in(R16in), .R17in(R17in), .R18in(R18in), .R19in(R19in), .R20in(R20in), .R21in(R21in), .R22in(R22in), .R23in(R23in), .R24in(R24in), .R25in(R25in), .R26in(R26in), .R27in(R27in), .R28in(R28in), .R29in(R29in), .R30in(R30in), .R31in(R31in), .IRin(IRin), .Gout(Gout), .DINout(DINout), .incr_pc(incr_pc), .Ain(Ain), .ALUControl(ALUControl), .Gin(Gin), .Sinin(Sinin), .Cosin(Cosin), .Bin(Bin), .ADDRin(ADDRin), .DOUTin(DOUTin), .W_D(W_D), .Done(Done), .start(start), .Sinout(Sinout), .Cosout(Cosout));

multiplexer multiplexer (.DIN(DIN), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14), .R15(R15), .R16(R16), .R17(R17), .R18(R18), .R19(R19), .R20(R20), .R21(R21), .R22(R22), .R23(R23), .R24(R24), .R25(R25), .R26(R26), .R27(R27), .R28(R28), .R29(R29), .R30(R30), .R31(R31), .G(G), .Sin(Sin), .Cos(Cos), .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), .R9out(R9out), .R10out(R10out), .R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out), .R16out(R16out), .R17out(R17out), .R18out(R18out), .R19out(R19out), .R20out(R20out), .R21out(R21out), .R22out(R22out), .R23out(R23out), .R24out(R24out), .R25out(R25out), .R26out(R26out), .R27out(R27out), .R28out(R28out), .R29out(R29out), .R30out(R30out), .R31out(R31out), .Gout(Gout), .DINout(DINout), .Sinout(Sinout), .Cosout(Cosout), .BUS(BUS));

alu alu (.a(A), .b(BUS), .ALUControl(ALUControl), .result(pre_G1), .V(V));
cordic cordic (.clk(clk), .rst_n(rst_n), .angle(BUS), .start(start), .sin(pre_Sin1), .cos(pre_Cos1));

endmodule
