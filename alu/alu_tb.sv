module alu_tb;
    // Khai báo tín hiệu kiểm tra
    reg [31:0] a, b;
    reg [4:0] ALUControl;
    wire [63:0] result;
    wire V, C, Z, N;

    integer i;
    reg [31:0] expected_result;
    reg [32:0] expected_result1;
    reg [63:0] expected_result2;

    // Khởi tạo module ALU
    alu dut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .result(result),
        .V(V),
        .C(C),
        .Z(Z),
        .N(N)
    );
    
    // Ghi waveform
    initial begin
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, alu_tb);
    end

    // ================================
    // Task cho từng phép toán ALU
    // ================================

    // Task cho phép CỘNG
    task test_addition;
        begin
            ALUControl = 5'b00000;  // Cộng
            $display("\n=== Testing ADDITION (A + B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                expected_result1 = a + b;
                #5;
                check_result1();
            end
        end
    endtask

    // Task cho phép TRỪ
    task test_subtraction;
        begin
            ALUControl = 5'b00001;  // Trừ
            $display("\n=== Testing SUBTRACTION (A - B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                expected_result1 = a - b;
                #5;
                check_result1();
            end
        end
    endtask

    // Task cho phép NHÂN
    task test_multiplication;
        begin
            ALUControl = 5'b00010;  // Nhân
            $display("\n=== Testing MULTIPLICATION (A * B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                expected_result2 = a * b;
                #5;
                check_result2();
            end
        end
    endtask

    // Task cho phép AND
    task test_and;
        begin
            ALUControl = 5'b00011;  // AND
            $display("\n=== Testing AND (A & B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                expected_result = a & b;
                #5;
                check_result();
            end
        end
    endtask

    // Task cho phép OR
    task test_or;
        begin
            ALUControl = 5'b00100;  // OR
            $display("\n=== Testing OR (A | B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                expected_result = a | b;
                #5;
                check_result();
            end
        end
    endtask

    // Task cho phép XOR
    task test_xor;
        begin
            ALUControl = 5'b00101;  // XOR
            $display("\n=== Testing XOR (A ^ B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                expected_result = a ^ b;
                #5;
                check_result();
            end
        end
    endtask

    // Task cho phép DỊCH PHẢI LOGIC
    task test_shift_right;
        begin
            ALUControl = 5'b00110;  // Shift Right Logical
            $display("\n=== Testing SHIFT RIGHT LOGICAL (A >> B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random & 5'h1F;  // Chỉ dịch trong khoảng 0-31 bit
                expected_result = a >> b;
                #5;
                check_result();
            end
        end
    endtask

    // Task cho phép DỊCH TRÁI LOGIC
    task test_shift_left;
        begin
            ALUControl = 5'b00111;  // Shift Left Logical
            $display("\n=== Testing SHIFT LEFT LOGICAL (A << B) ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random & 5'h1F;
                expected_result = a << b;
                #5;
                check_result();
            end
        end
    endtask

    // Task cho FPU CỘNG
    task test_fpu_add;
        begin
            ALUControl = 5'b10000;  // FPU Cộng
            $display("\n=== Testing FLOATING POINT ADDITION ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                #5;
                $display("\nA = %b_%b_%b", a[31], a[30:23], a[22:0]);
                $display("B = %b_%b_%b", b[31], b[30:23], b[22:0]);
                $display("Result = %b_%b_%b %b %b %b %b %b", 
                                 result[31], result[30:23], result[22:20], 
                                 result[19:16], result[15:12], result[11:8], 
                                 result[7:4], result[3:0]); 
            end
        end
    endtask

    // Task cho FPU TRỪ
    task test_fpu_sub;
        begin
            ALUControl = 5'b10001;  // FPU Trừ
            $display("\n=== Testing FLOATING POINT SUBTRACTION ===");
            for (i = 0; i < 100; i = i + 1) begin
                a = $random;
                b = $random;
                #5;
                $display("\nA = %b_%b_%b", a[31], a[30:23], a[22:0]);
                $display("B = %b_%b_%b", b[31], b[30:23], b[22:0]);
                $display("Result = %b_%b_%b %b %b %b %b %b", 
                                 result[31], result[30:23], result[22:20], 
                                 result[19:16], result[15:12], result[11:8], 
                                 result[7:4], result[3:0]);
   	    end
        end
    endtask

    // ================================
    // Task KIỂM TRA KẾT QUẢ
    // ================================
    task check_result;
        begin
            if (result[31:0] == expected_result)
                $display("✅ PASS: A = %h, B = %h, Result = %h", a, b, result[31:0]);
            else
                $display("❌ FAIL: A = %h, B = %h, Expected = %h, Got = %h", a, b, expected_result, result[31:0]);
        end
    endtask
    
    task check_result1;
        begin
            if (result[32:0] == expected_result1)
                $display("✅ PASS: A = %h, B = %h, Result = %h", a, b, result[32:0]);
            else
                $display("❌ FAIL: A = %h, B = %h, Expected = %h, Got = %h", a, b, expected_result1, result[32:0]);
        end
    endtask
    
    task check_result2;
        begin
            if (result == expected_result2)
                $display("✅ PASS: A = %h, B = %h, Result = %h", a, b, result);
            else
                $display("❌ FAIL: A = %h, B = %h, Expected = %h, Got = %h", a, b, expected_result2, result);
        end
    endtask

    // ================================
    // Chạy tất cả các test case
    // ================================
    initial begin
        test_addition();
        test_subtraction();
        test_multiplication();
        test_and();
        test_or();
        test_xor();
        test_shift_right();
        test_shift_left();
        test_fpu_add();
        test_fpu_sub();

        #100;
    	$finish;
    end

endmodule

