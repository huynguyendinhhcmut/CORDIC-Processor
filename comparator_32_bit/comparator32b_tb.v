module comparator32b_tb;

    reg [31:0] a, b;
    wire gr, lt, eq;

    comparator32b uut (
        .a0(a[0]),  .a1(a[1]),  .a2(a[2]),  .a3(a[3]),  .a4(a[4]),  .a5(a[5]),  .a6(a[6]),  .a7(a[7]),
        .a8(a[8]),  .a9(a[9]),  .a10(a[10]), .a11(a[11]), .a12(a[12]), .a13(a[13]), .a14(a[14]), .a15(a[15]),
        .a16(a[16]), .a17(a[17]), .a18(a[18]), .a19(a[19]), .a20(a[20]), .a21(a[21]), .a22(a[22]), .a23(a[23]),
        .a24(a[24]), .a25(a[25]), .a26(a[26]), .a27(a[27]), .a28(a[28]), .a29(a[29]), .a30(a[30]), .a31(a[31]),

        .b0(b[0]),  .b1(b[1]),  .b2(b[2]),  .b3(b[3]),  .b4(b[4]),  .b5(b[5]),  .b6(b[6]),  .b7(b[7]),
        .b8(b[8]),  .b9(b[9]),  .b10(b[10]), .b11(b[11]), .b12(b[12]), .b13(b[13]), .b14(b[14]), .b15(b[15]),
        .b16(b[16]), .b17(b[17]), .b18(b[18]), .b19(b[19]), .b20(b[20]), .b21(b[21]), .b22(b[22]), .b23(b[23]),
        .b24(b[24]), .b25(b[25]), .b26(b[26]), .b27(b[27]), .b28(b[28]), .b29(b[29]), .b30(b[30]), .b31(b[31]),

        .gr(gr), .lt(lt), .eq(eq)
    );

    initial begin
        $dumpfile("comparator32b_wave.vcd");
        $dumpvars(0, comparator32b_tb);
    end

    task check_result;
        input expected_gr, expected_lt, expected_eq;
        begin
            if (gr === expected_gr && lt === expected_lt && eq === expected_eq) begin
                $display("Test Passed! a = %h, b = %h | gr = %b, lt = %b, eq = %b", 
                         a, b, gr, lt, eq);
            end else begin
                $display("Test Failed! a = %h, b = %h | gr = %b (expected %b), lt = %b (expected %b), eq = %b (expected %b)", 
                         a, b, gr, expected_gr, lt, expected_lt, eq, expected_eq);
            end
        end
    endtask

    initial begin
        $display("===== START TESTING comparator32b =====");

        a = 32'h00000000; b = 32'h00000000; #10 check_result(0, 0, 1);
        a = 32'h00000001; b = 32'h00000000; #10 check_result(1, 0, 0);
        a = 32'h00000000; b = 32'h00000001; #10 check_result(0, 1, 0);
        a = 32'h80000000; b = 32'h7FFFFFFF; #10 check_result(1, 0, 0);
        a = 32'h7FFFFFFF; b = 32'h80000000; #10 check_result(0, 1, 0);
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #10 check_result(0, 0, 1);
        a = 32'hAAAAAAAA; b = 32'h55555555; #10 check_result(1, 0, 0);
        a = 32'hCCCCCCCC; b = 32'hCCCCCCCB; #10 check_result(1, 0, 0);
        a = 32'h6D6D6D6D; b = 32'h6D6D6D6D; #10 check_result(0, 0, 1);
        a = 32'h33333333; b = 32'hCCCCCCCC; #10 check_result(0, 1, 0);
        a = 32'h55555555; b = 32'h55555555; #10 check_result(0, 0, 1);
        a = 32'hFFFFFFFE; b = 32'hFFFFFFFF; #10 check_result(0, 1, 0);

        $display("===== TEST COMPLETED =====");
        $finish;
    end

endmodule
