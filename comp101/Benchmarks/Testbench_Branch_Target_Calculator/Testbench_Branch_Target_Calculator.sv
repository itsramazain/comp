module Testbench_Branch_Target_Calculator;
    reg [15:0] immediate;          // Input immediate value
    reg [7:0] program_counter;    // Input program counter (8 bits wide)
    wire [7:0] BT;                // Output branch target

    // Instantiate the Branch_Target_Calculator module
    Branch_Target_Calculator BTC (
        .immediate(immediate),
        .program_counter(program_counter),
        .BT(BT)
    );

    // Clock generation
    reg clk = 0;
    always begin
        #5 clk = ~clk;
    end

    // Initialize signals and run test cases
    initial begin
        $display("Testing Branch_Target_Calculator module...");
        $display("==========================================");

        // Test case 1: Positive immediate value
        immediate = 16'h1234;
        program_counter = 8'h80;
        #500;
        $display("Test Case 1: immediate (Positive immediate value) = %h", immediate);
        $display("Test Case 1: program_counter (8 bits) = %h", program_counter);
        $display("Test Case 1: BT = %h", BT);
        $display("==========================================");

        // Test case 2: Negative immediate value
        immediate = 16'hFFFF; // Sign-extended to -1
        program_counter = 8'h84; // Program counter with +4 offset
        #500;
        $display("Test Case 2: immediate (Sign-extended to -1) = %h", immediate);
        $display("Test Case 2: Program counter (8 bits) with +4 offset = %h", program_counter);
        $display("Test Case 2: BT = %h", BT);
        $display("==========================================");

        // Test case 3: Large positive immediate value
        immediate = 16'h7FFF; // Sign-extended to 32767
        program_counter = 8'h88; // Program counter with +8 offset
        #500;
        $display("Test Case 3: immediate (Sign-extended to 32767) = %h", immediate);
        $display("Test Case 3: Program counter (8 bits) with +8 offset = %h", program_counter);
        $display("Test Case 3: BT = %h", BT);
        $display("==========================================");

        // Test case 4: Zero immediate value
        immediate = 16'h0000; // Sign-extended to 0
        program_counter = 8'h8C; // Program counter with +12 offset
        #500;
        $display("Test Case 4: immediate (Sign-extended to 0) = %h", immediate);
        $display("Test Case 4: Program counter (8 bits) with +12 offset = %h", program_counter);
        $display("Test Case 4: BT = %h", BT);
        $display("==========================================");

        // Test case 5: Negative offset
        immediate = 16'h8000; // Sign-extended to -32768
        program_counter = 8'h90; // Program counter with +16 offset
        #500;
        $display("Test Case 5: immediate (Sign-extended to -32768) = %h", immediate);
        $display("Test Case 5: Program counter (8 bits) with +16 offset = %h", program_counter);
        $display("Test Case 5: BT = %h", BT);
        $display("==========================================");

        $finish;
    end
endmodule