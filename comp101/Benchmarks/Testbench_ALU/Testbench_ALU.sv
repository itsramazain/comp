module Testbench_ALU;
    reg clk = 0;                            // Clock signal
    reg reset = 0;                          // Reset signal
    reg [31:0] operand_A;                   // Input operand A
    reg [31:0] operand_B;                   // Input operand B
    reg [3:0] alu_control;                  // ALU control signals
    wire [31:0] alu_result;                // ALU result
    wire zero_flag;                        // Zero flag
    wire [9:0] ram_address;                // RAM address
    wire overflow;                         // Overflow flag
    wire zero;                             // Zero output
    wire less;                             // Less output

    // Instantiate the ALU module
    ALU alu (
        .shmant(5'b0),                     // Shmant is set to 0 for simplicity
        .clk(clk),
        .reset(reset),
        .operand_A(operand_A),
        .operand_B(operand_B),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero_flag(zero_flag),
        .ram_address(ram_address),
        .overflow(overflow),
        .zero(zero),
        .less(less)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        reset = 1;
        #10 reset = 0;

        // Test case 1: ADD
        operand_A = 32'h0000000A;
        operand_B = 32'h00000005;
        alu_control = 4'b0010; // ADD
        #10;
        $display("Test Case 1 (ADD): operand_A = %d, operand_B = %d, alu_control = %b (ADD)",
                 operand_A, operand_B, alu_control);
	$display("alu_result = %d, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
	$display("========================================================================");
        // Test case 2: SUB
        operand_A = 32'h0000000A;
        operand_B = 32'h00000005;
        alu_control = 4'b0011; // SUB
        #10;
        $display("Test Case 2 (SUB): operand_A = %d, operand_B = %d, alu_control = %b (SUB)",
                 operand_A, operand_B, alu_control);
	$display("alu_result = %d, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
	$display("========================================================================");

        // Test case 3: AND
        operand_A = 32'hAAAA5555;
        operand_B = 32'h5555AAAA;
        alu_control = 4'b0100; // AND
        #10;
        $display("Test Case 3 (AND): operand_A = %b, operand_B = %b, alu_control = %b (AND)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");

        // Test case 4: OR
        operand_A = 32'hAAAA5555;
        operand_B = 32'h5555AAAA;
        alu_control = 4'b0101; // OR
        #10;
        $display("Test Case 4 (OR): operand_A = %b, operand_B = %b, alu_control = %b (OR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");

        // Test case 5: XOR
        operand_A = 32'hAAAA5555;
        operand_B = 32'h5555AAAA;
        alu_control = 4'b0110; // XOR
        #10;
        $display("Test Case 5 (XOR): operand_A = %b, operand_B = %b, alu_control = %b (XOR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 6: NOT
        operand_A = 32'hAAAA5555;
        operand_B = 32'h00000000; // Operand B is not used in this case
        alu_control = 4'b0111; // NOT
        #10;
        $display("Test Case 6 (NOT): operand_A = %b, operand_B = %b, alu_control = %b (NOT)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");

        // Test case 7: SLL (Shift Left Logical)
        operand_A = 32'h00001000;
        operand_B = 32'h00000004; // Operand B represents the shift amount (4)
        alu_control = 4'b1000; // SLL
        #10;
        $display("Test Case 7 (SLL): operand_A = %b, operand_B (Shift Amount) = %d, alu_control = %b (SLL)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 8: SRL (Shift Right Logical)
        operand_A = 32'h80000100; // Shift a negative number (most significant bit set)
        operand_B = 32'h00000004; // Operand B represents the shift amount (4)
        alu_control = 4'b1001; // SRL
        #10;
        $display("Test Case 8 (SRL): operand_A (Negative) = %b, operand_B (Shift Amount) = %d, alu_control = %b (SRL)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 9: NOR
        operand_A = 32'hAAAA5555;
        operand_B = 32'h5555AAAA;
        alu_control = 4'b1010; // NOR
        #10;
        $display("Test Case 9 (NOR): operand_A = %b, operand_B = %b, alu_control = %b (NOR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 10: ADDU (Unsigned ADD)
        operand_A = 32'hFFFFFFFF;
        operand_B = 32'h00000001;
        alu_control = 4'b1100; // ADDU
        #10;
        $display("Test Case 10 (ADDU): operand_A (Negative) = %b, operand_B = %b, alu_control = %b (ADDU)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 11: SUB (Both positive)
        operand_A = 32'h0000000A; // 10
        operand_B = 32'h00000005; // 5
        alu_control = 4'b0011; // SUB
        #10;
        $display("Test Case 11 (SUB): operand_A = %b, operand_B = %b, alu_control = %b (SUB)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 12: SUB (A is negative)
        operand_A = 32'hFFFFFFFB; // -5 (Two's complement)
        operand_B = 32'h00000005; // 5
        alu_control = 4'b0011; // SUB
        #10;
        $display("Test Case 12 (SUB): operand_A (Negative) = %b, operand_B = %b, alu_control = %b (SUB)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 13: SUB (Both negative)
        operand_A = 32'hFFFFFFFB; // -5 (Two's complement)
        operand_B = 32'hFFFFFFF6; // -10 (Two's complement)
        alu_control = 4'b0011; // SUB
        #10;
        $display("Test Case 13 (SUB): operand_A (Negative) = %b, operand_B (Negative) = %b, alu_control = %b (SUB)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 14: SUBU (Both positive)
        operand_A = 32'h0000000A; // 10
        operand_B = 32'h00000005; // 5
        alu_control = 4'b1011; // SUBU
        #10;
        $display("Test Case 14 (SUBU): operand_A = %b, operand_B = %b, alu_control = %b (SUBU)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 15: SUBU (A is negative)
        operand_A = 32'hFFFFFFFB; // -5 (Two's complement)
        operand_B = 32'h00000005; // 5
        alu_control = 4'b1011; // SUBU
        #10;
        $display("Test Case 15 (SUBU): operand_A (Negative) = %b, operand_B = %b, alu_control = %b (SUBU)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 16: SUBU (Both negative)
        operand_A = 32'hFFFFFFFB; // -5 (Two's complement)
        operand_B = 32'hFFFFFFF6; // -10 (Two's complement)
        alu_control = 4'b1011; // SUBU
        #10;
        $display("Test Case 16 (SUBU): operand_A (Negative) = %b, operand_B (Negative) = %b, alu_control = %b (SUBU)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 17: AND (All zeros)
        operand_A = 32'h00000000; // 0
        operand_B = 32'h00000000; // 0
        alu_control = 4'b0100; // AND
        #10;
        $display("Test Case 17 (AND): operand_A (All zeros) = %b, operand_B (All zeros) = %b, alu_control = %b (AND)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 18: AND (One operand all zeros)
        operand_A = 32'h00000000; // 0
        operand_B = 32'hFFFFFFFF; // All 1s
        alu_control = 4'b0100; // AND
        #10;
        $display("Test Case 18 (AND): operand_A (All zeros) = %b, operand_B (All ones) = %b, alu_control = %b (AND)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 19: OR (All zeros)
        operand_A = 32'h00000000; // 0
        operand_B = 32'h00000000; // 0
        alu_control = 4'b0101; // OR
        #10;
        $display("Test Case 19 (OR): operand_A (All zeros) = %b, operand_B (All zeros) = %b, alu_control = %b (OR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 20: OR (One operand all ones)
        operand_A = 32'hFFFFFFFF; // All 1s
        operand_B = 32'h00000000; // 0
        alu_control = 4'b0101; // OR
        #10;
        $display("Test Case 20 (OR): operand_A (All ones) = %b, operand_B (All zeros) = %b, alu_control = %b (OR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 21: XOR (All zeros)
        operand_A = 32'h00000000; // 0
        operand_B = 32'h00000000; // 0
        alu_control = 4'b0110; // XOR
        #10;
        $display("Test Case 21 (XOR): operand_A (All zeros) = %b, operand_B (All zeros) = %b, alu_control = %b (XOR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 22: XOR (One operand all ones)
        operand_A = 32'h00000000; // 0
        operand_B = 32'hFFFFFFFF; // All 1s
        alu_control = 4'b0110; // XOR
        #10;
        $display("Test Case 22 (XOR): operand_A (All zeros) = %b, operand_B (All ones) = %b, alu_control = %b (XOR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        // Test case 23: NOR (All zeros)
        operand_A = 32'h00000000; // 0
        operand_B = 32'h00000000; // 0
        alu_control = 4'b1010; // NOR
        #10;
        $display("Test Case 23 (NOR): operand_A (All zeros) = %b, operand_B (All zeros) = %b, alu_control = %b (NOR)",
                 operand_A, operand_B, alu_control,);
	$display("alu_result = %b, zero_flag = %d, overflow = %d, zero = %d, less = %d",
                 alu_result, zero_flag, overflow, zero, less);
$display("========================================================================");
        

        $finish;
    end
endmodule
