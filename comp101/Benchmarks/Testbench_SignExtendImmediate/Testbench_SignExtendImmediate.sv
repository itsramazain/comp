module Testbench_SignExtendImmediate;
    reg clk = 0;                            // Clock signal
    reg reset = 0;                          // Reset signal
    reg [15:0] instruction;                 // Input instruction with immediate field
    wire [31:0] sign_extended_imm;          // Output sign-extended immediate

    // Instantiate the SignExtendImmediate module
    SignExtendImmediate SEI (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .sign_extended_imm(sign_extended_imm)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        reset = 1;
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        // Release reset and apply test cases
        // #10 reset = 1;

        // Test case 1: Positive immediate value (e.g., 0x1234)
        instruction = 16'h1234;
        #10;
        $display("Test Case 1: instruction = %h, sign-extended_imm = %h", instruction, sign_extended_imm);

        // Test case 2: Negative immediate value (e.g., 0xFFFF)
        instruction = 16'hFFFF;
        #10;
        $display("Test Case 2: instruction = %h, sign-extended_imm = %h", instruction, sign_extended_imm);

        // Test case 3: Large positive immediate value (e.g., 0x7FFF)
        instruction = 16'h7FFF;
        #10;
        $display("Test Case 3: instruction = %h, sign-extended_imm = %h", instruction, sign_extended_imm);

        // Test case 4: Zero immediate value (e.g., 0x0000)
        instruction = 16'h0000;
        #10;
        $display("Test Case 4: instruction = %h, sign-extended_imm = %h", instruction, sign_extended_imm);

        // Test case 5: Mixed immediate value (e.g., 0x8A12)
        instruction = 16'h8A12;
        #10;
        $display("Test Case 5: instruction = %h, sign-extended_imm = %h", instruction, sign_extended_imm);

        $finish;
    end
endmodule
