module full_adder_32_bit_tb;

    reg [31:0] a, b;
    reg cin;
    wire [31:0] sum;
    wire cout;

fullAdder32b u_dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer pass_count = 0;

initial begin
    $dumpfile("full_adder_32_bit_wave.vcd");
    $dumpvars(0, full_adder_32_bit_tb);
end

task check_result;
    input [31:0] expected_sum;
    input expected_cout;
    begin
        if (sum == expected_sum && cout == expected_cout) begin
            $display("Test Passed! a = %h, b = %h, cin = %b | sum = %h, cout = %b", a, b, cin, sum, cout);
            pass_count = pass_count + 1;
        end else begin
            $display("Test Failed! a = %h, b = %h, cin = %b | sum = %h, expected = %h | cout = %b, expected = %b", a, b, cin, sum, expected_sum, cout, expected_cout);
        end
    end
endtask

initial begin
    $display("===== START TESTING fullAdder32b =====");
        
    a = 32'h00000001; b = 32'h00000002; cin = 0;
    #10 check_result(32'h00000003, 0);

    a = 32'h12345678; b = 32'h00000000; cin = 0;
    #10 check_result(32'h12345678, 0);

    a = 32'h0000000F; b = 32'h00000001; cin = 1;
    #10 check_result(32'h0000000e, 0);

    a = 32'hFFFFFFFF; b = 32'h00000001; cin = 0;
    #10 check_result(32'h00000000, 1); 

    a = 32'hFFFFFFF0; b = 32'hFFFFFFF0; cin = 0;
    #10 check_result(32'hFFFFFFE0, 1);

    a = 32'h00000010; b = 32'hFFFFFFF0; cin = 0;
    #10 check_result(32'h00000000, 1);

    a = 32'h80000000; b = 32'h80000000; cin = 0;
    #10 check_result(32'h00000000, 1); 

    a = 32'h00000005; b = 32'hFFFFFFFF; cin = 0;
    #10 check_result(32'h00000004, 1);

    $display("===== TEST COMPLETED. PASSED %d/8 TEST CASES =====", pass_count);
    $finish;
end

endmodule
