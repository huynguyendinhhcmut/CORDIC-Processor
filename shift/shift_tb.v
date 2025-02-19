module shift_tb;
  reg  [31:0] data_in;
  reg         rightleft;
  reg  [4:0]  shift_amount;
  wire [31:0] data_out;
  
  // Instance của module shift
  shift uut (
    .data_in(data_in),
    .rightleft(rightleft),
    .shift_amount(shift_amount),
    .data_out(data_out)
  );
  
  integer i;
  
  initial begin
    $display("---------- Testing shift module ----------");
    
    // Test Case 1: rightleft = 0 (không đảo bit - thực hiện shift right theo logic)
    rightleft = 1'b0;
    data_in   = 32'h12345678;  // giá trị mẫu
    $display("\nTest Case 1: rightleft = 0, data_in = %h", data_in);
    for (i = 0; i <= 32; i = i + 1) begin
      shift_amount = i;
      #10;
      $display("shift_amount = %2d, data_out = %h", i, data_out);
    end
    
    // Test Case 2: rightleft = 1 (đảo bit, sau đó shift left logic)
    rightleft = 1'b1;
    data_in   = 32'h12345678;  // giá trị mẫu
    $display("\nTest Case 2: rightleft = 1, data_in = %h", data_in);
    for (i = 0; i <= 32; i = i + 1) begin
      shift_amount = i;
      #10;
      $display("shift_amount = %2d, data_out = %h", i, data_out);
    end

    $finish;
  end

endmodule
module shift_tb;
  reg  [31:0] data_in;
  reg         rightleft;
  reg  [4:0]  shift_amount;
  wire [31:0] data_out;
  
  // Instance của module shift
  shift uut (
    .data_in(data_in),
    .rightleft(rightleft),
    .shift_amount(shift_amount),
    .data_out(data_out)
  );
  
  integer i;
  
  initial begin
    $display("---------- Testing shift module ----------");
    
    // Test Case 1: rightleft = 0 (không đảo bit - thực hiện shift right theo logic)
    rightleft = 1'b0;
    data_in   = 32'h12345678;  // giá trị mẫu
    $display("\nTest Case 1: rightleft = 0, data_in = %h", data_in);
    for (i = 0; i <= 32; i = i + 1) begin
      shift_amount = i;
      #10;
      $display("shift_amount = %2d, data_out = %h", i, data_out);
    end
    
    // Test Case 2: rightleft = 1 (đảo bit, sau đó shift left logic)
    rightleft = 1'b1;
    data_in   = 32'h12345678;  // giá trị mẫu
    $display("\nTest Case 2: rightleft = 1, data_in = %h", data_in);
    for (i = 0; i <= 32; i = i + 1) begin
      shift_amount = i;
      #10;
      $display("shift_amount = %2d, data_out = %h", i, data_out);
    end

    $finish;
  end

endmodule
