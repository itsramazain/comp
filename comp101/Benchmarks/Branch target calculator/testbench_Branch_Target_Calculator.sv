module testbench_Branch_Target_Calculator;
    reg [15:0] immediate;            // Input immediate value
    reg [31:0] program_counter;      // Input program counter
    wire [31:0] BT;                 // Output branch target

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

    // Initialize signals
    initial begin
        $display("Testing Branch_Target_Calculator module...");
        $display("==========================================");

        // Test case 1: Positive immediate value
        immediate = 16'h1234;
        program_counter = 32'h80000000;
        #500;
        $display("Test Case 1: immediate (Positive immediate value) = ", immediate);
        $display("Test Case 1: program_counter = ", program_counter);
        $display("Test Case 1: BT = %h", BT);
        $display("==========================================");

        // Test case 2: Negative immediate value
        immediate = 16'hFFFF; // Sign-extended to -1
        program_counter = 32'h80000004; // Program counter with +4 offset
        #500
        $display("Test Case 2: immediate (Sign-extended to -1) = ", immediate);
        $display("Test Case 2: Program counter with +4 offset = ", program_counter);
        $display("Test Case 2: BT = %h", BT);
        $display("==========================================");

        // Test case 3: Large positive immediate value
        immediate = 16'h7FFF; // Sign-extended to 32767
        program_counter = 32'h80000008; // Program counter with +8 offset
        #500
        $display("Test Case 3: immediate (Sign-extended to 32767) = ", immediate);
        $display("Test Case 3: Program counter with +8 offset = ", program_counter);
        $display("Test Case 3: BT = %h", BT);
        $display("==========================================");

        // Test case 4: Zero immediate value
        immediate = 16'h0000; // Sign-extended to 0
        program_counter = 32'h8000000C; // Program counter with +12 offset
        #500
        $display("Test Case 4: immediate (Sign-extended to 0) = ", immediate);
        $display("Test Case 4: Program counter with +12 offset = ", program_counter);
        $display("Test Case 4: BT = %h", BT);
        $display("==========================================");

        // Test case 5: Negative offset
        immediate = 16'h8000; // Sign-extended to -32768
        program_counter = 32'h80000010; // Program counter with +16 offset
        #500
        $display("Test Case 5: immediate (Sign-extended to -32768) = ", immediate);
        $display("Test Case 5: Program counter with +16 offset = ", program_counter);
        $display("Test Case 5: BT = %h", BT);
        $display("==========================================");

        $finish;
    end
endmodule
