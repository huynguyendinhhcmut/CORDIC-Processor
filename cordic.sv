module cordic (
	input logic clk, rst_n,
	input logic [31:0] angle, 
	input logic start,
	output logic [31:0] sin, cos
);

// arctan table
logic [31:0] arctan [15:0];
assign arctan[0]  = 32'b0_01111110_10010010000111111011011; // arctan(2^-0) = 0.7853981634
assign arctan[1]  = 32'b0_01111101_11011010110001100111000; // arctan(2^-1) = 0.463647609
assign arctan[2]  = 32'b0_01111100_11110101101101110110000; // arctan(2^-2) = 0.2449786631
assign arctan[3]  = 32'b0_01111011_11111101010110111010101; // arctan(2^-3) = 0.1243549945
assign arctan[4]  = 32'b0_01111010_11111111010101011011110; // arctan(2^-4) = 0.06241881
assign arctan[5]  = 32'b0_01111001_11111111110101010101110; // arctan(2^-5) = 0.03123983343
assign arctan[6]  = 32'b0_01111000_11111111111101010101011; // arctan(2^-6) = 0.01562372862
assign arctan[7]  = 32'b0_01110111_11111111111111010101011; // arctan(2^-7) = 0.00781234106 
assign arctan[8]  = 32'b0_01110110_11111111111111110101011; // arctan(2^-8) = 0.003906230132
assign arctan[9]  = 32'b0_01110101_11111111111111111101011; // arctan(2^-9) = 0.001953122516
assign arctan[10] = 32'b0_01110100_11111111111111111111011; // arctan(2^-10) = 9.7656219e-4
assign arctan[11] = 32'b0_01110011_11111111111111111111111; // arctan(2^-11) = 4.88281211e-4
assign arctan[12] = 32'b0_01110011_00000000000000000000000; // arctan(2^-12) = 2.4414062e-4
assign arctan[13] = 32'b0_01110010_00000000000000000000000; // arctan(2^-13) = 1.22070312e-4
assign arctan[14] = 32'b0_01110001_00000000000000000000000; // arctan(2^-14) = 6.10351562e-5
assign arctan[15] = 32'b0_01110000_00000000000000000000000; // arctan(2^-15) = 3.05175781e-5

// X calculate
logic [31:0] pre_Xreg, Xreg, X_out, X_div2;
logic [7:0] pre1_div2_Xreg, pre2_div2_Xreg, div2_Xreg;

always @(*) begin
	case (start)
		1'b0: pre_Xreg = X_out;
		1'b1: pre_Xreg = 32'b0_01111111_00000000000000000000000;
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		Xreg <= 32'b0;
	end else begin
		Xreg <= pre_Xreg;
	end
end

always @(*) begin
	case (start)
		1'b0: pre1_div2_Xreg = div2_Xreg;
		1'b1: pre1_div2_Xreg = Xreg [30:23];
	endcase
end

fullAdder8b fa1 (.a(pre1_div2_Xreg), .b(8'b0000_0001), .cin(1'b1), .sum(pre2_div2_Xreg));

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		div2_Xreg <= 8'b0;
	end else begin
		div2_Xreg <= pre2_div2_Xreg;
	end
end

always @(*) begin
	case (start)
		1'b0: X_div2 = {Xreg[31], div2_Xreg, Xreg[22:0]};
		1'b1: X_div2 = Xreg;
	endcase
end

fpu fpu1 (.a(Xreg), .b(Y_div2), .control(d), .result(X_out));

// Y calculate
logic [31:0] pre_Yreg, Yreg, Y_out, Y_div2;
logic [7:0] pre1_div2_Yreg, pre2_div2_Yreg, div2_Yreg;

always @(*) begin
	case (start)
		1'b0: pre_Yreg = Y_out;
		1'b1: pre_Yreg = 32'b0;
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		Yreg <= 32'b0;
	end else begin
		Yreg <= pre_Yreg;
	end
end

always @(*) begin
	case (start)
		1'b0: pre1_div2_Yreg = div2_Yreg;
		1'b1: pre1_div2_Yreg = Yreg [30:23];
	endcase
end

fullAdder8b fa2 (.a(pre1_div2_Yreg), .b(8'b0000_0001), .cin (1'b1), .sum(pre2_div2_Yreg));

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		div2_Yreg <= 8'b0;
	end else begin
		div2_Yreg <= pre2_div2_Yreg;
	end
end

always @(*) begin
	case (start)
		1'b0: Y_div2 = {Yreg[31], div2_Yreg, Yreg[22:0]};
		1'b1: Y_div2 = Yreg;
	endcase
end

fpu fpu2 (.a(Yreg), .b(X_div2), .control(~d), .result(Y_out));

// angle adjust
logic [31:0] comp_angle, pre_fixed_angle;
logic eq0, gr0, lt1, eq1, gr1, lt2, eq2, gr2, lt3, eq3, gr3, gr4, gr5, eq6;
logic [3:0] select;
logic [31:0] pre1_fixed_angle [2:0];
logic [31:0] fixed_angle;
logic d;
logic [31:0] Z_out, pre_Zreg, Zreg;
logic [4:0] i, pre_i1, pre_i2;

fpu fpu3 (.a(32'b0_10000001_10010010000111111011011), .b(angle), .control(1'b1), .result(comp_angle));

always @(*) begin
	case (angle[31])
		1'b0: pre_fixed_angle = angle;
		1'b1: pre_fixed_angle = comp_angle;
	endcase
end

comparator32b compare0 (.a(pre_fixed_angle), .b(32'b0), .Eq(eq0), .Gr(gr0));
comparator32b compare1 (.a(pre_fixed_angle), .b(32'b0_01111111_10010010000111111011011), .Lt(lt1), .Eq(eq1), .Gr(gr1));
comparator32b compare2 (.a(pre_fixed_angle), .b(32'b0_10000000_10010010000111111011011), .Lt(lt2), .Eq(eq2), .Gr(gr2));
comparator32b compare3 (.a(pre_fixed_angle), .b(32'b0_10000001_00101101100101111100100), .Lt(lt3), .Eq(eq3), .Gr(gr3));

assign select[0] = eq0 | (gr0 & lt1) | eq1;
assign select[1] = (gr1 & lt2) | eq2;
assign select[2] = (gr2 & lt3) | eq3;
assign select[3] = gr3;

fpu fpu4 (.a(32'b0_10000000_10010010000111111011011), .b(pre_fixed_angle), .control(1'b1), .result(pre1_fixed_angle[0]));
fpu fpu5 (.a(pre_fixed_angle), .b(32'b0_10000000_10010010000111111011011), .control(1'b1), .result(pre1_fixed_angle[1]));
fpu fpu6 (.a(32'b0_10000001_10010010000111111011011), .b(pre_fixed_angle), .control(1'b1), .result(pre1_fixed_angle[2]));

always @(*) begin
	case (select)
		4'b0001: fixed_angle = pre_fixed_angle;
		4'b0010: fixed_angle = pre1_fixed_angle[0];
		4'b0100: fixed_angle = pre1_fixed_angle[1];
		4'b1000: fixed_angle = pre1_fixed_angle[2];
		default: fixed_angle = 32'b0;
	endcase
end

comparator32b compare4 (.a(fixed_angle), .b(32'b0), .Gr(gr4));
comparator32b compare5 (.a(Z_out), .b(32'b0), .Gr(gr5));

always @(*) begin
	case (start) 
		1'b0: d = gr5;
		1'b1: d = gr4;
	endcase
end

always @(*) begin
	case (start)
		1'b0: pre_Zreg = Z_out;
		1'b1: pre_Zreg = fixed_angle;
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		Zreg <= 32'b0;
	end else
		Zreg <= pre_Zreg;
end

fpu fpu7 (.a(Zreg), .b(arctan[i]), .control(d), .result(Z_out));

fullAdder5b fa3 (.a(i), .b(5'b00001), .cin(1'b0), .sum(pre_i1));

always @(*) begin
	case (start)
		1'b0: pre_i2 = pre_i1;
		1'b1: pre_i2 = 5'b00000;
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		i <= 5'b0;
	end else
		i <= pre_i2;
end

logic [31:0] pre_sin, pre_cos;

always @(*) begin
	case (select)
		4'b0001: begin
			pre_sin = Xreg;
			pre_cos = Yreg;
		end
		4'b0010: begin
			pre_sin = {1'b1, Xreg[30:0]};
			pre_cos = Yreg;
		end
		4'b0100: begin
			pre_sin = {1'b1, Xreg[30:0]};
			pre_cos = {1'b1, Yreg[30:0]};
		end
		4'b1000: begin
			pre_sin = Xreg;
			pre_cos = {1'b1, Yreg[30:0]};
		end
		default: begin
			pre_sin = 32'b0;
			pre_cos = 32'b0;
		end
	endcase
end

comparator32b compare6 (.a(32'b0000_0000_0000_0000_0000_0000_0001_1111), .b({27'b0, i}), .Eq(eq6));

always @(*) begin
	case (eq6)
		1'b0: begin 
			sin = 32'b0;
			cos = 32'b0;
		end
		1'b1: begin
			sin = pre_sin;
			cos = pre_cos;
		end
	endcase
end

endmodule

module fullAdder5b (
        input logic [4:0] a, b,
        input logic cin,
        output logic [4:0] sum,
        output logic cout
);

logic [4:0] carry;

fullAdder fa1 (.sum(sum[0]), .a(a[0]), .b(b[0]^cin), .cin(cin),      .cout(carry[0]));
fullAdder fa2 (.sum(sum[1]), .a(a[1]), .b(b[1]^cin), .cin(carry[0]), .cout(carry[1]));
fullAdder fa3 (.sum(sum[2]), .a(a[2]), .b(b[2]^cin), .cin(carry[1]), .cout(carry[2]));
fullAdder fa4 (.sum(sum[3]), .a(a[3]), .b(b[3]^cin), .cin(carry[2]), .cout(carry[3]));
fullAdder fa5 (.sum(sum[4]), .a(a[4]), .b(b[4]^cin), .cin(carry[3]), .cout(carry[4]));

xor (cout, carry[4], cin);
endmodule
