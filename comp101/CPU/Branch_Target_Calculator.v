module Branch_Target_Calculator(
    input [7:0] immediate,          // Immediate field from the instruction
    input [7:0] program_counter,    // Next instruction's program counter
    output reg [7:0] BT             // Branch target output
);

    // The next instruction is saved in a word manner, so no need to shift it by 2
    always @(*) begin
        BT = immediate[7:0] + program_counter;  // Calculate the branch target
    end

endmodule
