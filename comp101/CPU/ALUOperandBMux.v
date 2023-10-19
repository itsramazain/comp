module ALUOperandBMux (
    input wire clk,                      // Clock input
    input wire reset,                    // Reset input
    input wire [31:0] sign_extended_imm, // Input for the sign-extended immediate value
    input wire [31:0] read_register_2,   // Input for the value from register file
    input wire select,                   // Control signal to select the input (0 for sign_extended_imm, 1 for read_register_2)
    output wire [31:0] operand_b         // Output for the selected operand
);

    reg [31:0] operand_b_reg;            // Register to hold the selected operand

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the selected operand to all zeros
            operand_b_reg <= 32'b0;
        end else begin
            // Select operand based on the value of 'select'
            if (select) begin
                operand_b_reg <= read_register_2;       // Select read_register_2 if 'select' is 1
            end else begin
                operand_b_reg <= sign_extended_imm;     // Select sign-extended immediate if 'select' is 0
            end
        end
    end

    // Output the selected operand
    assign operand_b = operand_b_reg;

endmodule
