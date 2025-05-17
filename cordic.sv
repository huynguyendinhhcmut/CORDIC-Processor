module cordic (
	input logic clk, rst_n,
	input logic [31:0] angle, 
	input logic start,
	output logic [31:0] sin, cos
);

// arctan table
logic [31:0] arctan [15:0];
initial begin	
	arctan[0]  = 32'b0_01111110_10010010000111111011011; // arctan(2^-0) = 0.7853981634
	arctan[1]  = 32'b0_01111101_11011010110001100111000; // arctan(2^-1) = 0.463647609
	arctan[2]  = 32'b0_01111100_11110101101101110110000; // arctan(2^-2) = 0.2449786631
	arctan[3]  = 32'b0_01111011_11111101010110111010101; // arctan(2^-3) = 0.1243549945
	arctan[4]  = 32'b0_01111010_11111111010101011011110; // arctan(2^-4) = 0.06241881
	arctan[5]  = 32'b0_01111001_11111111110101010101110; // arctan(2^-5) = 0.03123983343
	arctan[6]  = 32'b0_01111000_11111111111101010101011; // arctan(2^-6) = 0.01562372862
	arctan[7]  = 32'b0_01110111_11111111111111010101011; // arctan(2^-7) = 0.00781234106 
	arctan[8]  = 32'b0_01110110_11111111111111110101011; // arctan(2^-8) = 0.003906230132
	arctan[9]  = 32'b0_01110101_11111111111111111101011; // arctan(2^-9) = 0.001953122516
	arctan[10] = 32'b0_01110100_11111111111111111111011; // arctan(2^-10) = 9.7656219e-4
	arctan[11] = 32'b0_01110011_11111111111111111111111; // arctan(2^-11) = 4.88281211e-4
	arctan[12] = 32'b0_01110011_00000000000000000000000; // arctan(2^-12) = 2.4414062e-4
	arctan[13] = 32'b0_01110010_00000000000000000000000; // arctan(2^-13) = 1.22070312e-4
	arctan[14] = 32'b0_01110001_00000000000000000000000; // arctan(2^-14) = 6.10351562e-5
	arctan[15] = 32'b0_01110000_00000000000000000000000; // arctan(2^-15) = 3.05175781e-5
end
	
logic pre_d, d;

// X calculate
logic [31:0] pre_Xreg, Xreg, X_out, X_div2;
logic [7:0] div2_Xreg;
logic [3:0] i, pre_i1, pre_i2;

// Y calculate
logic [31:0] pre_Yreg, Yreg, Y_out, Y_div2;
logic [7:0] div2_Yreg;

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

fullAdder8b fa1 (.a(Xreg[30:23]), .b({4'b0, i}), .cin(1'b1), .sum(div2_Xreg));

assign X_div2 = {Xreg[31], div2_Xreg, Xreg[22:0]};

fpu fpu1 (.a(Xreg), .b(Y_div2), .control(~d), .result(X_out));

// Y calculate
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

fullAdder8b fa2 (.a(Yreg[30:23]), .b({4'b0, i}), .cin(1'b1), .sum(div2_Yreg));

assign Y_div2 = {Yreg[31], div2_Yreg, Yreg[22:0]};

fpu fpu2 (.a(Yreg), .b(X_div2), .control(d), .result(Y_out));

// angle adjust
logic [31:0] comp_angle, pre_fixed_angle;
logic eq0, gr0, lt1, eq1, gr1, lt2, eq2, gr2, lt3, eq3, gr3, eq6;
logic [3:0] select;
logic [31:0] pre1_fixed_angle;
logic [31:0] fixed_angle;
logic [31:0] Z_out, pre_Zreg, Zreg;

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

logic [31:0] a, b;

always @(*) begin
	case (select)
		4'b0010: begin
			a = 32'b0_10000000_10010010000111111011011;
			b = pre_fixed_angle;
		end
		4'b0100: begin
			a = pre_fixed_angle;
			b = 32'b0_10000000_10010010000111111011011;
		end
		4'b1000: begin
			a = 32'b0_10000001_10010010000111111011011;
			b = pre_fixed_angle;
		end
		default: begin
			a = 32'b0;
			b = 32'b0;
		end
	endcase
end

fpu fpu4 (.a(a), .b(b), .control(1'b1), .result(pre1_fixed_angle));

always @(*) begin
	case (select)
		4'b0001: fixed_angle = pre_fixed_angle;
		default: fixed_angle = pre1_fixed_angle;
	endcase
end

always @(*) begin
	case (start) 
		1'b0: pre_d = Z_out [31];
		1'b1: pre_d = fixed_angle [31];
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		d <= 0;
	end else
		d <= pre_d;
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

fpu fpu7 (.a(Zreg), .b(arctan[i]), .control(~d), .result(Z_out));

fullAdder4b fa3 (.a(i), .b(4'b0001), .cin(1'b0), .sum(pre_i1));

always @(*) begin
	case (start)
		1'b0: pre_i2 = pre_i1;
		1'b1: pre_i2 = 4'b0000;
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		i <= 4'b0;
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

always @(*) begin
	case (&i)
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
