module prefixAdder32b (
	input logic [31:0] a, b,
	input logic cin,
	output logic [31:0] sum,
	output logic cout
);

logic [31:0] g, p;
KSA_stage1 stage1 (.a(a), .b(b), .g(g), .p(p));

logic [31:0] g_stage2, p_stage2;
KSA_stage2 stage2 (.g_in(g), .p_in(p), .g_out(g_stage2), .p_out(p_stage2));

logic [31:0] g_stage3, p_stage3;
KSA_stage3 stage3 (.g_in(g_stage2), .p_in(p_stage2), .g_out(g_stage3), .p_out(p_stage3));

logic [31:0] g_stage4, p_stage4;
KSA_stage4 stage4 (.g_in(g_stage3), .p_in(p_stage3), .g_out(g_stage4), .p_out(p_stage4));

logic [31:0] g_stage5, p_stage5;
KSA_stage5 stage5 (.g_in(g_stage4), .p_in(p_stage4), .g_out(g_stage5), .p_out(p_stage5));

logic [31:0] g_stage6, p_stage6;
KSA_stage6 stage6 (.g_in(g_stage5), .p_in(p_stage5), .g_out(g_stage6), .p_out(p_stage6));

logic [32:0] Carry;
KSA_stage7 stage7 (.g_in(g_stage6), .p_in(p_stage6), .cin(cin), .Carry(Carry));

always @(*) begin
	case (cin)
		1'b0: cout = Carry[32];
		1'b1: cout = !Carry[32];
	endcase
end
assign sum = p[31:0] ^ Carry[31:0];

endmodule



module KSA_stage7 (
	input logic [31:0] g_in,
	input logic [31:0] p_in,
	input logic cin,
	output logic [32:0] Carry
);
	
assign Carry[0] = cin;
assign Carry[1] = g_in[0] | (p_in[0] & cin);
assign Carry[2] = g_in[1] | (p_in[1] & cin);
assign Carry[3] = g_in[2] | (p_in[2] & cin);
assign Carry[4] = g_in[3] | (p_in[3] & cin);
assign Carry[5] = g_in[4] | (p_in[4] & cin);
assign Carry[6] = g_in[5] | (p_in[5] & cin);
assign Carry[7] = g_in[6] | (p_in[6] & cin);
assign Carry[8] = g_in[7] | (p_in[7] & cin);
assign Carry[9] = g_in[8] | (p_in[8] & cin);
assign Carry[10] = g_in[9] | (p_in[9] & cin);
assign Carry[11] = g_in[10] | (p_in[10] & cin);
assign Carry[12] = g_in[11] | (p_in[11] & cin);
assign Carry[13] = g_in[12] | (p_in[12] & cin);
assign Carry[14] = g_in[13] | (p_in[13] & cin);
assign Carry[15] = g_in[14] | (p_in[14] & cin);
assign Carry[16] = g_in[15] | (p_in[15] & cin);
assign Carry[17] = g_in[16] | (p_in[16] & cin);
assign Carry[18] = g_in[17] | (p_in[17] & cin);
assign Carry[19] = g_in[18] | (p_in[18] & cin);
assign Carry[20] = g_in[19] | (p_in[19] & cin);
assign Carry[21] = g_in[20] | (p_in[20] & cin);
assign Carry[22] = g_in[21] | (p_in[21] & cin);
assign Carry[23] = g_in[22] | (p_in[22] & cin);
assign Carry[24] = g_in[23] | (p_in[23] & cin);
assign Carry[25] = g_in[24] | (p_in[24] & cin);
assign Carry[26] = g_in[25] | (p_in[25] & cin);
assign Carry[27] = g_in[26] | (p_in[26] & cin);
assign Carry[28] = g_in[27] | (p_in[27] & cin);
assign Carry[29] = g_in[28] | (p_in[28] & cin);
assign Carry[30] = g_in[29] | (p_in[29] & cin);
assign Carry[31] = g_in[30] | (p_in[30] & cin);
assign Carry[32] = g_in[31] | (p_in[31] & cin);

endmodule



module KSA_stage6 (
	input logic [31:0] g_in,
	input logic [31:0] p_in,
	output logic [31:0] g_out,
	output logic [31:0] p_out
);

//g0 & p0
assign g_out[0] = g_in[0];
assign p_out[0] = p_in[0];
//g1-0 & p1-0
assign g_out[1] = g_in[1];
assign p_out[1] = p_in[1];
//g2-0 & p2-0
assign g_out[2] = g_in[2];
assign p_out[2] = p_in[2];
//g3-0 & p3-0
assign g_out[3] = g_in[3];
assign p_out[3] = p_in[3];
//g4-0 & p4-0
assign g_out[4] = g_in[4];
assign p_out[4] = p_in[4];
//g5-0 & p5-0
assign g_out[5] = g_in[5];
assign p_out[5] = p_in[5];
//g6-0 & p6-0
assign g_out[6] = g_in[6];
assign p_out[6] = p_in[6];
//g7-0 & p7-0
assign g_out[7] = g_in[7];
assign p_out[7] = p_in[7];  
//g8-0 & p8-0
assign g_out[8] = g_in[8];
assign p_out[8] = p_in[8];
//g9-0 & p9-0
assign g_out[9] = g_in[9];
assign p_out[9] = p_in[9];
//g10-0 & p10-0
assign g_out[10] = g_in[10];
assign p_out[10] = p_in[10];
//g11-0 & p11-0
assign g_out[11] = g_in[11];
assign p_out[11] = p_in[11];
//g12-0 & p12-0
assign g_out[12] = g_in[12];
assign p_out[12] = p_in[12];
//g13-0 & p13-0
assign g_out[13] = g_in[13];
assign p_out[13] = p_in[13];
//g14-0 & p14-0
assign g_out[14] = g_in[14];
assign p_out[14] = p_in[14];
//g15-0 & p15-0
assign g_out[15] = g_in[15];
assign p_out[15] = p_in[15];

black_cell black_16to0 (.Gik(g_in[16]), .Gkj(g_in[0]), .Pik(p_in[16]), .Pkj(p_in[0]), .G(g_out[16]), .P(p_out[16]));
black_cell black_17to1 (.Gik(g_in[17]), .Gkj(g_in[1]), .Pik(p_in[17]), .Pkj(p_in[1]), .G(g_out[17]), .P(p_out[17]));
black_cell black_18to2 (.Gik(g_in[18]), .Gkj(g_in[2]), .Pik(p_in[18]), .Pkj(p_in[2]), .G(g_out[18]), .P(p_out[18]));
black_cell black_19to3 (.Gik(g_in[19]), .Gkj(g_in[3]), .Pik(p_in[19]), .Pkj(p_in[3]), .G(g_out[19]), .P(p_out[19]));
black_cell black_20to4 (.Gik(g_in[20]), .Gkj(g_in[4]), .Pik(p_in[20]), .Pkj(p_in[4]), .G(g_out[20]), .P(p_out[20]));
black_cell black_21to5 (.Gik(g_in[21]), .Gkj(g_in[5]), .Pik(p_in[21]), .Pkj(p_in[5]), .G(g_out[21]), .P(p_out[21]));
black_cell black_22to6 (.Gik(g_in[22]), .Gkj(g_in[6]), .Pik(p_in[22]), .Pkj(p_in[6]), .G(g_out[22]), .P(p_out[22]));
black_cell black_23to7 (.Gik(g_in[23]), .Gkj(g_in[7]), .Pik(p_in[23]), .Pkj(p_in[7]), .G(g_out[23]), .P(p_out[23]));
black_cell black_24to8 (.Gik(g_in[24]), .Gkj(g_in[8]), .Pik(p_in[24]), .Pkj(p_in[8]), .G(g_out[24]), .P(p_out[24]));
black_cell black_25to9 (.Gik(g_in[25]), .Gkj(g_in[9]), .Pik(p_in[25]), .Pkj(p_in[9]), .G(g_out[25]), .P(p_out[25]));
black_cell black_26to10 (.Gik(g_in[26]), .Gkj(g_in[10]), .Pik(p_in[26]), .Pkj(p_in[10]), .G(g_out[26]), .P(p_out[26]));
black_cell black_27to11 (.Gik(g_in[27]), .Gkj(g_in[11]), .Pik(p_in[27]), .Pkj(p_in[11]), .G(g_out[27]), .P(p_out[27]));
black_cell black_28to12 (.Gik(g_in[28]), .Gkj(g_in[12]), .Pik(p_in[28]), .Pkj(p_in[12]), .G(g_out[28]), .P(p_out[28]));
black_cell black_29to13 (.Gik(g_in[29]), .Gkj(g_in[13]), .Pik(p_in[29]), .Pkj(p_in[13]), .G(g_out[29]), .P(p_out[29]));
black_cell black_30to14 (.Gik(g_in[30]), .Gkj(g_in[14]), .Pik(p_in[30]), .Pkj(p_in[14]), .G(g_out[30]), .P(p_out[30]));
black_cell black_31to15 (.Gik(g_in[31]), .Gkj(g_in[15]), .Pik(p_in[31]), .Pkj(p_in[15]), .G(g_out[31]), .P(p_out[31]));

endmodule



module KSA_stage5 (
	input logic [31:0] g_in,
	input logic [31:0] p_in,
	output logic [31:0] g_out,
	output logic [31:0] p_out
);
// g0-0 & p0-0
assign g_out[0] = g_in[0];
assign p_out[0] = p_in[0];
// g1-0 & p1-0
assign g_out[1] = g_in[1];
assign p_out[1] = p_in[1];
// g2-0 & p2-0
assign g_out[2] = g_in[2];
assign p_out[2] = p_in[2];
// g3-0 & p3-0
assign g_out[3] = g_in[3];
assign p_out[3] = p_in[3];
// g4-0 & p4-0
assign g_out[4] = g_in[4];
assign p_out[4] = p_in[4];
// g5-0 & p5-0
assign g_out[5] = g_in[5];
assign p_out[5] = p_in[5];
// g6-0 & p6-0
assign g_out[6] = g_in[6];
assign p_out[6] = p_in[6];
// g7-0 & p7-0
assign g_out[7] = g_in[7];
assign p_out[7] = p_in[7];

// Grey cell
black_cell black_8to0 (.Gik(g_in[8]), .Gkj(g_in[0]), .Pik(p_in[8]), .Pkj(p_in[0]), .G(g_out[8]), .P(p_out[8]));
black_cell black_9to1 (.Gik(g_in[9]), .Gkj(g_in[1]), .Pik(p_in[9]), .Pkj(p_in[1]), .G(g_out[9]), .P(p_out[9]));
black_cell black_10to2 (.Gik(g_in[10]), .Gkj(g_in[2]), .Pik(p_in[10]), .Pkj(p_in[2]), .G(g_out[10]), .P(p_out[10]));
black_cell black_11to3 (.Gik(g_in[11]), .Gkj(g_in[3]), .Pik(p_in[11]), .Pkj(p_in[3]), .G(g_out[11]), .P(p_out[11]));
black_cell black_12to4 (.Gik(g_in[12]), .Gkj(g_in[4]), .Pik(p_in[12]), .Pkj(p_in[4]), .G(g_out[12]), .P(p_out[12]));
black_cell black_13to5 (.Gik(g_in[13]), .Gkj(g_in[5]), .Pik(p_in[13]), .Pkj(p_in[5]), .G(g_out[13]), .P(p_out[13]));
black_cell black_14to6 (.Gik(g_in[14]), .Gkj(g_in[6]), .Pik(p_in[14]), .Pkj(p_in[6]), .G(g_out[14]), .P(p_out[14]));
black_cell black_15to7 (.Gik(g_in[15]), .Gkj(g_in[7]), .Pik(p_in[15]), .Pkj(p_in[7]), .G(g_out[15]), .P(p_out[15]));

// Rest of stage 5
black_cell black_16to8 (.Gik(g_in[16]), .Gkj(g_in[8]), .Pik(p_in[16]), .Pkj(p_in[8]), .G(g_out[16]), .P(p_out[16]));
black_cell black_17to9 (.Gik(g_in[17]), .Gkj(g_in[9]), .Pik(p_in[17]), .Pkj(p_in[9]), .G(g_out[17]), .P(p_out[17]));
black_cell black_18to10 (.Gik(g_in[18]), .Gkj(g_in[10]), .Pik(p_in[18]), .Pkj(p_in[10]), .G(g_out[18]), .P(p_out[18]));
black_cell black_19to11 (.Gik(g_in[19]), .Gkj(g_in[11]), .Pik(p_in[19]), .Pkj(p_in[11]), .G(g_out[19]), .P(p_out[19]));
black_cell black_20to12 (.Gik(g_in[20]), .Gkj(g_in[12]), .Pik(p_in[20]), .Pkj(p_in[12]), .G(g_out[20]), .P(p_out[20]));
black_cell black_21to13 (.Gik(g_in[21]), .Gkj(g_in[13]), .Pik(p_in[21]), .Pkj(p_in[13]), .G(g_out[21]), .P(p_out[21]));
black_cell black_22to14 (.Gik(g_in[22]), .Gkj(g_in[14]), .Pik(p_in[22]), .Pkj(p_in[14]), .G(g_out[22]), .P(p_out[22]));
black_cell black_23to15 (.Gik(g_in[23]), .Gkj(g_in[15]), .Pik(p_in[23]), .Pkj(p_in[15]), .G(g_out[23]), .P(p_out[23]));
black_cell black_24to16 (.Gik(g_in[24]), .Gkj(g_in[16]), .Pik(p_in[24]), .Pkj(p_in[16]), .G(g_out[24]), .P(p_out[24]));
black_cell black_25to17 (.Gik(g_in[25]), .Gkj(g_in[17]), .Pik(p_in[25]), .Pkj(p_in[17]), .G(g_out[25]), .P(p_out[25]));
black_cell black_26to18 (.Gik(g_in[26]), .Gkj(g_in[18]), .Pik(p_in[26]), .Pkj(p_in[18]), .G(g_out[26]), .P(p_out[26]));
black_cell black_27to19 (.Gik(g_in[27]), .Gkj(g_in[19]), .Pik(p_in[27]), .Pkj(p_in[19]), .G(g_out[27]), .P(p_out[27]));
black_cell black_28to20 (.Gik(g_in[28]), .Gkj(g_in[20]), .Pik(p_in[28]), .Pkj(p_in[20]), .G(g_out[28]), .P(p_out[28]));
black_cell black_29to21 (.Gik(g_in[29]), .Gkj(g_in[21]), .Pik(p_in[29]), .Pkj(p_in[21]), .G(g_out[29]), .P(p_out[29]));
black_cell black_30to22 (.Gik(g_in[30]), .Gkj(g_in[22]), .Pik(p_in[30]), .Pkj(p_in[22]), .G(g_out[30]), .P(p_out[30]));
black_cell black_31to23 (.Gik(g_in[31]), .Gkj(g_in[23]), .Pik(p_in[31]), .Pkj(p_in[23]), .G(g_out[31]), .P(p_out[31]));

endmodule




module KSA_stage4 (
	input logic [31:0] g_in,
	input logic [31:0] p_in,
	output logic [31:0] g_out,
	output logic [31:0] p_out
);

// g0 & p0
assign g_out[0] = g_in[0];
assign p_out[0] = p_in[0];
// g1 & p1
assign g_out[1] = g_in[1];
assign p_out[1] = p_in[1];
// g2 & p2
assign g_out[2] = g_in[2];
assign p_out[2] = p_in[2];
// g3 & p3
assign g_out[3] = g_in[3];
assign p_out[3] = p_in[3];
// g4-0 & p4-0
black_cell black_4to0 (.Gik(g_in[4]), .Gkj(g_in[0]), .Pik(p_in[4]), .Pkj(p_in[0]), .G(g_out[4]), .P(p_out[4]));
// g5-1 & p5-1
black_cell black_5to1 (.Gik(g_in[5]), .Gkj(g_in[1]), .Pik(p_in[5]), .Pkj(p_in[1]), .G(g_out[5]), .P(p_out[5]));
// g6-2 & p6
black_cell black_6to2 (.Gik(g_in[6]), .Gkj(g_in[2]), .Pik(p_in[6]), .Pkj(p_in[2]), .G(g_out[6]), .P(p_out[6]));
// g7-3 & p7-3
black_cell black_7to3 (.Gik(g_in[7]), .Gkj(g_in[3]), .Pik(p_in[7]), .Pkj(p_in[3]), .G(g_out[7]), .P(p_out[7]));

// Rest of stage 4
black_cell black_8to4 (.Gik(g_in[8]), .Gkj(g_in[4]), .Pik(p_in[8]), .Pkj(p_in[4]), .G(g_out[8]), .P(p_out[8]));
black_cell black_9to5 (.Gik(g_in[9]), .Gkj(g_in[5]), .Pik(p_in[9]), .Pkj(p_in[5]), .G(g_out[9]), .P(p_out[9]));
black_cell black_10to6 (.Gik(g_in[10]), .Gkj(g_in[6]), .Pik(p_in[10]), .Pkj(p_in[6]), .G(g_out[10]), .P(p_out[10]));
black_cell black_11to7 (.Gik(g_in[11]), .Gkj(g_in[7]), .Pik(p_in[11]), .Pkj(p_in[7]), .G(g_out[11]), .P(p_out[11]));
black_cell black_12to8 (.Gik(g_in[12]), .Gkj(g_in[8]), .Pik(p_in[12]), .Pkj(p_in[8]), .G(g_out[12]), .P(p_out[12]));
black_cell black_13to9 (.Gik(g_in[13]), .Gkj(g_in[9]), .Pik(p_in[13]), .Pkj(p_in[9]), .G(g_out[13]), .P(p_out[13]));
black_cell black_14to10 (.Gik(g_in[14]), .Gkj(g_in[10]), .Pik(p_in[14]), .Pkj(p_in[10]), .G(g_out[14]), .P(p_out[14]));
black_cell black_15to11 (.Gik(g_in[15]), .Gkj(g_in[11]), .Pik(p_in[15]), .Pkj(p_in[11]), .G(g_out[15]), .P(p_out[15]));
black_cell black_16to12 (.Gik(g_in[16]), .Gkj(g_in[12]), .Pik(p_in[16]), .Pkj(p_in[12]), .G(g_out[16]), .P(p_out[16]));
black_cell black_17to13 (.Gik(g_in[17]), .Gkj(g_in[13]), .Pik(p_in[17]), .Pkj(p_in[13]), .G(g_out[17]), .P(p_out[17]));
black_cell black_18to14 (.Gik(g_in[18]), .Gkj(g_in[14]), .Pik(p_in[18]), .Pkj(p_in[14]), .G(g_out[18]), .P(p_out[18]));
black_cell black_19to15 (.Gik(g_in[19]), .Gkj(g_in[15]), .Pik(p_in[19]), .Pkj(p_in[15]), .G(g_out[19]), .P(p_out[19]));
black_cell black_20to16 (.Gik(g_in[20]), .Gkj(g_in[16]), .Pik(p_in[20]), .Pkj(p_in[16]), .G(g_out[20]), .P(p_out[20]));
black_cell black_21to17 (.Gik(g_in[21]), .Gkj(g_in[17]), .Pik(p_in[21]), .Pkj(p_in[17]), .G(g_out[21]), .P(p_out[21]));
black_cell black_22to18 (.Gik(g_in[22]), .Gkj(g_in[18]), .Pik(p_in[22]), .Pkj(p_in[18]), .G(g_out[22]), .P(p_out[22]));
black_cell black_23to19 (.Gik(g_in[23]), .Gkj(g_in[19]), .Pik(p_in[23]), .Pkj(p_in[19]), .G(g_out[23]), .P(p_out[23]));
black_cell black_24to20 (.Gik(g_in[24]), .Gkj(g_in[20]), .Pik(p_in[24]), .Pkj(p_in[20]), .G(g_out[24]), .P(p_out[24]));
black_cell black_25to21 (.Gik(g_in[25]), .Gkj(g_in[21]), .Pik(p_in[25]), .Pkj(p_in[21]), .G(g_out[25]), .P(p_out[25]));
black_cell black_26to22 (.Gik(g_in[26]), .Gkj(g_in[22]), .Pik(p_in[26]), .Pkj(p_in[22]), .G(g_out[26]), .P(p_out[26]));
black_cell black_27to23 (.Gik(g_in[27]), .Gkj(g_in[23]), .Pik(p_in[27]), .Pkj(p_in[23]), .G(g_out[27]), .P(p_out[27]));
black_cell black_28to24 (.Gik(g_in[28]), .Gkj(g_in[24]), .Pik(p_in[28]), .Pkj(p_in[24]), .G(g_out[28]), .P(p_out[28]));
black_cell black_29to25 (.Gik(g_in[29]), .Gkj(g_in[25]), .Pik(p_in[29]), .Pkj(p_in[25]), .G(g_out[29]), .P(p_out[29]));
black_cell black_30to26 (.Gik(g_in[30]), .Gkj(g_in[26]), .Pik(p_in[30]), .Pkj(p_in[26]), .G(g_out[30]), .P(p_out[30]));
black_cell black_31to27 (.Gik(g_in[31]), .Gkj(g_in[27]), .Pik(p_in[31]), .Pkj(p_in[27]), .G(g_out[31]), .P(p_out[31]));

endmodule




module KSA_stage3 (
	input logic [31:0] g_in,
	input logic [31:0] p_in,
	output logic [31:0] g_out,
	output logic [31:0] p_out
);
// g0 and p0
assign g_out[0] = g_in[0];
assign p_out[0] = p_in[0];
// g1-0 and p1-0
assign g_out[1] = g_in[1];
assign p_out[1] = p_in[1];
// g2-0 and p2-0
black_cell black_2to0 (.Gik(g_in[2]), .Gkj(g_in[0]), .Pik(p_in[2]), .Pkj(p_in[0]), .G(g_out[2]), .P(p_out[2]));
// g3-1 and p3-1
black_cell black_3to1 (.Gik(g_in[3]), .Gkj(g_in[1]), .Pik(p_in[3]), .Pkj(p_in[1]), .G(g_out[3]), .P(p_out[3]));
// Rest of stage 3
black_cell black_4to2 (.Gik(g_in[4]), .Gkj(g_in[2]), .Pik(p_in[4]), .Pkj(p_in[2]), .G(g_out[4]), .P(p_out[4]));
black_cell black_5to3 (.Gik(g_in[5]), .Gkj(g_in[3]), .Pik(p_in[5]), .Pkj(p_in[3]), .G(g_out[5]), .P(p_out[5]));
black_cell black_6to4 (.Gik(g_in[6]), .Gkj(g_in[4]), .Pik(p_in[6]), .Pkj(p_in[4]), .G(g_out[6]), .P(p_out[6]));
black_cell black_7to5 (.Gik(g_in[7]), .Gkj(g_in[5]), .Pik(p_in[7]), .Pkj(p_in[5]), .G(g_out[7]), .P(p_out[7]));
black_cell black_8to6 (.Gik(g_in[8]), .Gkj(g_in[6]), .Pik(p_in[8]), .Pkj(p_in[6]), .G(g_out[8]), .P(p_out[8]));
black_cell black_9to7 (.Gik(g_in[9]), .Gkj(g_in[7]), .Pik(p_in[9]), .Pkj(p_in[7]), .G(g_out[9]), .P(p_out[9]));
black_cell black_10to8 (.Gik(g_in[10]), .Gkj(g_in[8]), .Pik(p_in[10]), .Pkj(p_in[8]), .G(g_out[10]), .P(p_out[10]));
black_cell black_11to9 (.Gik(g_in[11]), .Gkj(g_in[9]), .Pik(p_in[11]), .Pkj(p_in[9]), .G(g_out[11]), .P(p_out[11]));
black_cell black_12to10 (.Gik(g_in[12]), .Gkj(g_in[10]), .Pik(p_in[12]), .Pkj(p_in[10]), .G(g_out[12]), .P(p_out[12]));
black_cell black_13to11 (.Gik(g_in[13]), .Gkj(g_in[11]), .Pik(p_in[13]), .Pkj(p_in[11]), .G(g_out[13]), .P(p_out[13]));
black_cell black_14to12 (.Gik(g_in[14]), .Gkj(g_in[12]), .Pik(p_in[14]), .Pkj(p_in[12]), .G(g_out[14]), .P(p_out[14]));
black_cell black_15to13 (.Gik(g_in[15]), .Gkj(g_in[13]), .Pik(p_in[15]), .Pkj(p_in[13]), .G(g_out[15]), .P(p_out[15]));
black_cell black_16to14 (.Gik(g_in[16]), .Gkj(g_in[14]), .Pik(p_in[16]), .Pkj(p_in[14]), .G(g_out[16]), .P(p_out[16]));
black_cell black_17to15 (.Gik(g_in[17]), .Gkj(g_in[15]), .Pik(p_in[17]), .Pkj(p_in[15]), .G(g_out[17]), .P(p_out[17]));
black_cell black_18to16 (.Gik(g_in[18]), .Gkj(g_in[16]), .Pik(p_in[18]), .Pkj(p_in[16]), .G(g_out[18]), .P(p_out[18]));
black_cell black_19to17 (.Gik(g_in[19]), .Gkj(g_in[17]), .Pik(p_in[19]), .Pkj(p_in[17]), .G(g_out[19]), .P(p_out[19]));
black_cell black_20to18 (.Gik(g_in[20]), .Gkj(g_in[18]), .Pik(p_in[20]), .Pkj(p_in[18]), .G(g_out[20]), .P(p_out[20]));
black_cell black_21to19 (.Gik(g_in[21]), .Gkj(g_in[19]), .Pik(p_in[21]), .Pkj(p_in[19]), .G(g_out[21]), .P(p_out[21]));
black_cell black_22to20 (.Gik(g_in[22]), .Gkj(g_in[20]), .Pik(p_in[22]), .Pkj(p_in[20]), .G(g_out[22]), .P(p_out[22]));
black_cell black_23to21 (.Gik(g_in[23]), .Gkj(g_in[21]), .Pik(p_in[23]), .Pkj(p_in[21]), .G(g_out[23]), .P(p_out[23]));
black_cell black_24to22 (.Gik(g_in[24]), .Gkj(g_in[22]), .Pik(p_in[24]), .Pkj(p_in[22]), .G(g_out[24]), .P(p_out[24]));
black_cell black_25to23 (.Gik(g_in[25]), .Gkj(g_in[23]), .Pik(p_in[25]), .Pkj(p_in[23]), .G(g_out[25]), .P(p_out[25]));
black_cell black_26to24 (.Gik(g_in[26]), .Gkj(g_in[24]), .Pik(p_in[26]), .Pkj(p_in[24]), .G(g_out[26]), .P(p_out[26]));
black_cell black_27to25 (.Gik(g_in[27]), .Gkj(g_in[25]), .Pik(p_in[27]), .Pkj(p_in[25]), .G(g_out[27]), .P(p_out[27]));
black_cell black_28to26 (.Gik(g_in[28]), .Gkj(g_in[26]), .Pik(p_in[28]), .Pkj(p_in[26]), .G(g_out[28]), .P(p_out[28]));
black_cell black_29to27 (.Gik(g_in[29]), .Gkj(g_in[27]), .Pik(p_in[29]), .Pkj(p_in[27]), .G(g_out[29]), .P(p_out[29]));
black_cell black_30to28 (.Gik(g_in[30]), .Gkj(g_in[28]), .Pik(p_in[30]), .Pkj(p_in[28]), .G(g_out[30]), .P(p_out[30]));
black_cell black_31to29 (.Gik(g_in[31]), .Gkj(g_in[29]), .Pik(p_in[31]), .Pkj(p_in[29]), .G(g_out[31]), .P(p_out[31]));

endmodule



module KSA_stage2 (
	input logic [31:0] g_in,
	input logic [31:0] p_in,
	output logic [31:0] g_out,
	output logic [31:0] p_out
);

assign g_out[0] = g_in[0];
assign p_out[0] = p_in[0];

black_cell black_1to0 (.Gik(g_in[1]), .Gkj(g_in[0]), .Pik(p_in[1]), .Pkj(p_in[0]), .G(g_out[1]), .P(p_out[1]));

black_cell black_2to1 (.Gik(g_in[2]), .Gkj(g_in[1]), .Pik(p_in[2]), .Pkj(p_in[1]), .G(g_out[2]), .P(p_out[2]));
black_cell black_3to2 (.Gik(g_in[3]), .Gkj(g_in[2]), .Pik(p_in[3]), .Pkj(p_in[2]), .G(g_out[3]), .P(p_out[3]));
black_cell black_4to3 (.Gik(g_in[4]), .Gkj(g_in[3]), .Pik(p_in[4]), .Pkj(p_in[3]), .G(g_out[4]), .P(p_out[4]));
black_cell black_5to4 (.Gik(g_in[5]), .Gkj(g_in[4]), .Pik(p_in[5]), .Pkj(p_in[4]), .G(g_out[5]), .P(p_out[5]));
black_cell black_6to5 (.Gik(g_in[6]), .Gkj(g_in[5]), .Pik(p_in[6]), .Pkj(p_in[5]), .G(g_out[6]), .P(p_out[6]));
black_cell black_7to6 (.Gik(g_in[7]), .Gkj(g_in[6]), .Pik(p_in[7]), .Pkj(p_in[6]), .G(g_out[7]), .P(p_out[7]));
black_cell black_8to7 (.Gik(g_in[8]), .Gkj(g_in[7]), .Pik(p_in[8]), .Pkj(p_in[7]), .G(g_out[8]), .P(p_out[8]));
black_cell black_9to8 (.Gik(g_in[9]), .Gkj(g_in[8]), .Pik(p_in[9]), .Pkj(p_in[8]), .G(g_out[9]), .P(p_out[9]));
black_cell black_10to9 (.Gik(g_in[10]), .Gkj(g_in[9]), .Pik(p_in[10]), .Pkj(p_in[9]), .G(g_out[10]), .P(p_out[10]));
black_cell black_11to10 (.Gik(g_in[11]), .Gkj(g_in[10]), .Pik(p_in[11]), .Pkj(p_in[10]), .G(g_out[11]), .P(p_out[11]));
black_cell black_12to11 (.Gik(g_in[12]), .Gkj(g_in[11]), .Pik(p_in[12]), .Pkj(p_in[11]), .G(g_out[12]), .P(p_out[12]));
black_cell black_13to12 (.Gik(g_in[13]), .Gkj(g_in[12]), .Pik(p_in[13]), .Pkj(p_in[12]), .G(g_out[13]), .P(p_out[13]));
black_cell black_14to13 (.Gik(g_in[14]), .Gkj(g_in[13]), .Pik(p_in[14]), .Pkj(p_in[13]), .G(g_out[14]), .P(p_out[14]));
black_cell black_15to14 (.Gik(g_in[15]), .Gkj(g_in[14]), .Pik(p_in[15]), .Pkj(p_in[14]), .G(g_out[15]), .P(p_out[15]));
black_cell black_16to15 (.Gik(g_in[16]), .Gkj(g_in[15]), .Pik(p_in[16]), .Pkj(p_in[15]), .G(g_out[16]), .P(p_out[16]));
black_cell black_17to16 (.Gik(g_in[17]), .Gkj(g_in[16]), .Pik(p_in[17]), .Pkj(p_in[16]), .G(g_out[17]), .P(p_out[17]));
black_cell black_18to17 (.Gik(g_in[18]), .Gkj(g_in[17]), .Pik(p_in[18]), .Pkj(p_in[17]), .G(g_out[18]), .P(p_out[18]));
black_cell black_19to18 (.Gik(g_in[19]), .Gkj(g_in[18]), .Pik(p_in[19]), .Pkj(p_in[18]), .G(g_out[19]), .P(p_out[19]));
black_cell black_20to19 (.Gik(g_in[20]), .Gkj(g_in[19]), .Pik(p_in[20]), .Pkj(p_in[19]), .G(g_out[20]), .P(p_out[20]));
black_cell black_21to20 (.Gik(g_in[21]), .Gkj(g_in[20]), .Pik(p_in[21]), .Pkj(p_in[20]), .G(g_out[21]), .P(p_out[21]));
black_cell black_22to21 (.Gik(g_in[22]), .Gkj(g_in[21]), .Pik(p_in[22]), .Pkj(p_in[21]), .G(g_out[22]), .P(p_out[22]));
black_cell black_23to22 (.Gik(g_in[23]), .Gkj(g_in[22]), .Pik(p_in[23]), .Pkj(p_in[22]), .G(g_out[23]), .P(p_out[23]));
black_cell black_24to23 (.Gik(g_in[24]), .Gkj(g_in[23]), .Pik(p_in[24]), .Pkj(p_in[23]), .G(g_out[24]), .P(p_out[24]));
black_cell black_25to24 (.Gik(g_in[25]), .Gkj(g_in[24]), .Pik(p_in[25]), .Pkj(p_in[24]), .G(g_out[25]), .P(p_out[25]));
black_cell black_26to25 (.Gik(g_in[26]), .Gkj(g_in[25]), .Pik(p_in[26]), .Pkj(p_in[25]), .G(g_out[26]), .P(p_out[26]));
black_cell black_27to26 (.Gik(g_in[27]), .Gkj(g_in[26]), .Pik(p_in[27]), .Pkj(p_in[26]), .G(g_out[27]), .P(p_out[27]));
black_cell black_28to27 (.Gik(g_in[28]), .Gkj(g_in[27]), .Pik(p_in[28]), .Pkj(p_in[27]), .G(g_out[28]), .P(p_out[28]));
black_cell black_29to28 (.Gik(g_in[29]), .Gkj(g_in[28]), .Pik(p_in[29]), .Pkj(p_in[28]), .G(g_out[29]), .P(p_out[29]));
black_cell black_30to29 (.Gik(g_in[30]), .Gkj(g_in[29]), .Pik(p_in[30]), .Pkj(p_in[29]), .G(g_out[30]), .P(p_out[30]));
black_cell black_31to30 (.Gik(g_in[31]), .Gkj(g_in[30]), .Pik(p_in[31]), .Pkj(p_in[30]), .G(g_out[31]), .P(p_out[31]));

endmodule




module KSA_stage1 (
	input logic [31:0] a,
	input logic [31:0] b,
	output logic [31:0] g,
	output logic [31:0] p
);

assign g[31:0] = a[31:0] & b[31:0];
assign p[31:0] = a[31:0] ^ b[31:0];

endmodule 



module grey_cell (
	input logic Gik,
	input logic Gkj,
	input logic Pik,
	output logic G
);

assign G = Gik | (Pik & Gkj);

endmodule 




module black_cell (
	input logic Gik,
	input logic Gkj,
	input logic Pik,
	input logic Pkj,
	output logic G,
	output logic P
);

assign G = Gik | (Pik & Gkj);
assign P = Pik & Pkj;

endmodule