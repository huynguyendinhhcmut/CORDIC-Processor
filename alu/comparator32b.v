module comparator32b (
	input wire [31:0] a, b,
	input wire sign,
	output reg Gr, Lt, Eq
);

wire gr, gr1, gr2, gr3, gr4;
wire lt, lt1, lt2, lt3, lt4;
wire eq;

wire greaterSigned, lessSigned, equalSigned;
wire [3:0] signCheck;

assign greaterSigned = (~a[31]) & b[31];
assign lessSigned = a[31] & (~b[31]);
assign equalSigned = (~a[31]) & (~b[31]);
assign signCheck = {sign, greaterSigned, lessSigned, equalSigned};

comparator10b compare1 (.a0(a[0]),  .a1(a[1]),  .a2(a[2]),  .a3(a[3]),  .a4(a[4]),  .a5(a[5]),  .a6(a[6]),  .a7(a[7]),  .a8(a[8]),  .a9(a[9]),
			.b0(b[0]),  .b1(b[1]),  .b2(b[2]),  .b3(b[3]),  .b4(b[4]),  .b5(b[5]),  .b6(b[6]),  .b7(b[7]),  .b8(b[8]),  .b9(b[9]),
			.gr(gr1), .lt(lt1));

comparator10b compare2 (.a0(gr1), .a1(a[10]), .a2(a[11]), .a3(a[12]), .a4(a[13]), .a5(a[14]), .a6(a[15]), .a7(a[16]), .a8(a[17]), .a9(a[18]),
			.b0(lt1), .b1(b[10]), .b2(b[11]), .b3(b[12]), .b4(b[13]), .b5(b[14]), .b6(b[15]), .b7(b[16]), .b8(b[17]), .b9(b[18]),
			.gr(gr2), .lt(lt2));

comparator10b compare3 (.a0(gr2), .a1(a[19]), .a2(a[20]), .a3(a[21]), .a4(a[22]), .a5(a[23]), .a6(a[24]), .a7(a[25]), .a8(a[26]), .a9(a[27]),
			.b0(lt2), .b1(b[19]), .b2(b[20]), .b3(b[21]), .b4(b[22]), .b5(b[23]), .b6(b[24]), .b7(b[25]), .b8(b[26]), .b9(b[27]),
			.gr(gr3), .lt(lt3));
		
comparator4b compare4  (.a0(gr3), .a1(a[28]), .a2(a[29]), .a3(a[30]), .b0(lt1), .b1(b[28]), .b2(b[29]), .b3(b[30]), .gr(gr4), .lt(lt4));

comparator2b compare5  (.a0(gr4), .a1(a[31]), .b0(lt4), .b1(b[31]), .eq(eq), .gr(gr), .lt(lt));

always @(*) begin
	case (signCheck)
		4'b0001: begin
						Gr = gr;
						Lt = lt;
						Eq = eq;
					end
		4'b0010: begin
						Gr = gr;
						Lt = lt;
						Eq = eq;
					end

		4'b0100: begin
						Gr = gr;
						Lt = lt;
						Eq = eq;
					end

		4'b1001: begin
						Gr = gr;
						Lt = lt;
						Eq = eq;
					end
		4'b1010: begin
						Gr = 1'b0;
						Lt = 1'b1;
						Eq = 1'b0;
					end

		4'b1100: begin
						Gr = 1'b1;
						Lt = 1'b0;
						Eq = 1'b0;
					end
		default: begin
						Gr = 1'b0;
						Lt = 1'b0;
						Eq = 1'b0;
					end
	endcase
end
endmodule

module comparator10b (
	input wire a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, 
	input wire b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, 
	output wire gr, lt, eq
);

wire gr1, gr2, lt1, lt2;

comparator4b compare1 (.a0(a0),	 .a1(a1), .a2(a2), .a3(a3), .b0(b0),  .b1(b1), .b2(b2), .b3(b3), .gr(gr1), .lt(lt1));
comparator4b compare2 (.a0(gr1), .a1(a4), .a2(a5), .a3(a6), .b0(lt1), .b1(b4), .b2(b5), .b3(b6), .gr(gr2), .lt(lt2));
comparator4b compare3 (.a0(gr2), .a1(a7), .a2(a8), .a3(a9), .b0(lt2), .b1(b7), .b2(b8), .b3(b9), .gr(gr),  .lt(lt), .eq(eq));

endmodule

module comparator4b (
	input wire a0, a1, a2, a3, b0, b1, b2, b3,
    	output wire gr, lt, eq
);

wire gr1, gr2, lt1, lt2, eq1, eq2;

comparator2b compare1(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .eq(eq1), .gr(gr1), .lt(lt1));
comparator2b compare2(.a0(a2), .a1(a3), .b0(b2), .b1(b3), .eq(eq2), .gr(gr2), .lt(lt2));

assign gr = (gr2) | (eq2 & gr1);
assign lt = (lt2) | (eq2 & lt1);
assign eq = eq1 & eq2;

endmodule

module comparator2b (
    	input wire a0, a1, b0, b1,
    	output wire gr, lt, eq
);

assign gr = (a0 & ~b1 & ~b0) | (a1 & ~b1) | (a1 & a0 & ~b0);
assign lt =  (~a1 & ~a0 & b0) | (~a1 & b1) | (~a0 & b1 & b0);
assign eq =  (~a1 & ~a0 & ~b1 & ~b0) | (~a1 & a0 & ~b1 & b0) | (a1 & ~a0 & b1 & ~b0) | (a1 & a0 & b1 & b0);

endmodule
