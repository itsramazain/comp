module Branch_Target_Calculator(
    input [15:0] immediate,           // Immediate field from the instruction - bits 0-15
    input [31:0] program_counter,     // Program counter of the current instruction
    output reg [31:0] BT              // Output for the branch target
);

    // The branch target is calculated by adding the sign-extended immediate value to the program counter.
    always @(*)
        BT = {immediate[15], immediate} + program_counter;

endmodule
