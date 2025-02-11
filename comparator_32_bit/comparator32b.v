module comparator32b (
	input wire a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
	input wire b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31,
	output reg gr, lt, eq
);

wire gr1, gr2, gr3, gr4;
wire lt1, lt2, lt3, lt4;

comparator10b compare1 (.a0(a0),  .a1(a1),  .a2(a2),  .a3(a3),  .a4(a4),  .a5(a5),  .a6(a6),  .a7(a7),  .a8(a8),  .a9(a9),
			.b0(b0),  .b1(b1),  .b2(b2),  .b3(b3),  .b4(b4),  .b5(b5),  .b6(b6),  .b7(b7),  .b8(b8),  .b9(b9),
			.gr(gr1), .lt(lt1));

comparator10b compare2 (.a0(gr1), .a1(a10), .a2(a11), .a3(a12), .a4(a13), .a5(a14), .a6(a15), .a7(a16), .a8(a17), .a9(a18),
			.b0(lt1), .b1(b10), .b2(b11), .b3(b12), .b4(b13), .b5(b14), .b6(b15), .b7(b16), .b8(b17), .b9(b18),
			.gr(gr2), .lt(lt2));

comparator10b compare3 (.a0(gr2), .a1(a19), .a2(a20), .a3(a21), .a4(a22), .a5(a23), .a6(a24), .a7(a25), .a8(a26), .a9(a27),
			.b0(lt2), .b1(b19), .b2(b20), .b3(b21), .b4(b22), .b5(b23), .b6(b24), .b7(b25), .b8(b26), .b9(b27),
			.gr(gr3), .lt(lt3));
		
comparator4b compare4  (.a0(gr3), .a1(a28), .a2(a29), .a3(a30), .b0(lt1), .b1(b28), .b2(b29), .b3(b30), .gr(gr4), .lt(lt4));

comparator2b compare5  (.a0(gr4), .a1(a31), .b0(lt4), .b1(b31), .eq(eq), .gr(gr), .lt(lt));

endmodule

module comparator10b (
	input wire a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, 
	input wire b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, 
	output reg gr, lt, eq
);

wire gr1, gr2, lt1, lt2;

comparator4b compare1 (.a0(a0),	 .a1(a1), .a2(a2), .a3(a3), .b0(b0),  .b1(b1), .b2(b2), .b3(b3), .gr(gr1), .lt(lt1));
comparator4b compare2 (.a0(gr1), .a1(a4), .a2(a5), .a3(a6), .b0(lt1), .b1(b4), .b2(b5), .b3(b6), .gr(gr2), .lt(lt2));
comparator4b compare3 (.a0(gr2), .a1(a7), .a2(a8), .a3(a9), .b0(lt2), .b1(b7), .b2(b8), .b3(b9), .gr(gr),  .lt(lt), .eq(eq));

endmodule

module comparator4b (
	input wire a0, a1, a2, a3, b0, b1, b2, b3,
    	output reg gr, lt, eq
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
    	output reg gr, lt, eq
);

assign gr = (a0 & ~b1 & ~b0) | (a1 & ~b1) | (a1 & a0 & ~b0);
assign lt =  (~a1 & ~a0 & b0) | (~a1 & b1) | (~a0 & b1 & b0);
assign eq =  (~a1 & ~a0 & ~b1 & ~b0) | (~a1 & a0 & ~b1 & b0) | (a1 & ~a0 & b1 & ~b0) | (a1 & a0 & b1 & b0);

endmodule
