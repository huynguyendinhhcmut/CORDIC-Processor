module shift_tb;

    reg [31:0] a;
    reg rightleft;
    wire [31:0] shifted;

shift u_dut (.a(a), .rightleft(rightleft), .shifted(shifted));

    initial begin
        $dumpfile("shift_wave.vcd");
        $dumpvars(0, shift_tb);
    end

    task check_result;
        input [31:0] expected_shifted;
        begin
            if (shifted === expected_shifted) begin
                $display("Test Passed! a = %h, rightleft = %b | shifted = %h", a, rightleft, shifted);
            end else begin
                $display("Test Failed! a = %h, rightleft = %b | shifted = %h (expected %h)", 
                         a, rightleft, shifted, expected_shifted);
            end
        end
    endtask

    initial begin
        $display("===== START TESTING shift.v =====");

        a = 32'hAAAAAAAA; // 10101010...
        rightleft = 0;
        #10 check_result(32'h55555555); 
      
        a = 32'hAAAAAAAA;
        rightleft = 1;
        #10 check_result(32'h55555554);
      
        a = 32'h00000005;
        rightleft = 0;
        #10 check_result(32'h00000002);
      
        a = 32'h00000005; 
        rightleft = 1;
        #10 check_result(32'h0000000A); 
      
        a = 32'h80000000; 
        rightleft = 0;
        #10 check_result(32'h40000000);
      
        a = 32'h00000001;
        rightleft = 1;
        #10 check_result(32'h00000002);

        $display("===== TEST COMPLETED =====");
        $finish;
    end

endmodule
