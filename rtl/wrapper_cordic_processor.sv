module wrapper_cordic_processor (
	input logic CLOCK_50,
	input logic [2:0] KEY,
	input logic [9:0] SW,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [9:0] LEDR
);

logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7, hex_zero;
logic [31:0] databin;

cordic_processor cordic (.clk(CLOCK_50), .rst_n(KEY[0]), .run(~KEY[1]), .select(SW[8]), .select_addr(SW[7:0]), .Done(LEDR[9]), .dataout(databin));

decode_hex decode0 (.in(4'b0),       .out(hex_zero));
decode_hex decode1 (.in(databin[3:0]),   .out(hex0));
decode_hex decode2 (.in(databin[7:4]),   .out(hex1));
decode_hex decode3 (.in(databin[11:8]),  .out(hex2));
decode_hex decode4 (.in(databin[15:12]), .out(hex3));
decode_hex decode5 (.in(databin[19:16]), .out(hex4));
decode_hex decode6 (.in(databin[23:20]), .out(hex5));
decode_hex decode7 (.in(databin[27:24]), .out(hex6));
decode_hex decode8 (.in(databin[31:28]), .out(hex7));

assign LEDR[8:0] = SW[8:0];

always @(*) begin
	case (KEY[2])
		1'b0:	begin
					HEX0 = hex6;
					HEX1 = hex7;
					HEX2 = hex_zero;
					HEX3 = hex_zero;
					HEX4 = hex_zero;
					HEX5 = hex_zero;
				end
		
		1'b1:	begin
					HEX0 = hex0;
					HEX1 = hex1;
					HEX2 = hex2;
					HEX3 = hex3;
					HEX4 = hex4;
					HEX5 = hex5;
				end
	endcase
end

endmodule