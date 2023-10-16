module SignExtendImmediate (
    input wire clk,                   // Clock input
    input wire reset,                 // Reset input
    input wire [15:0] instruction,
    output wire [31:0] sign_extended_imm
);

    reg [31:0] sign_extended_imm_reg;  // Register to hold the sign-extended immediate value

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the sign-extended immediate to all zeros
            sign_extended_imm_reg <= 32'b0;
        end else begin
            // Sign-extend the immediate value
            sign_extended_imm_reg <= {{12{instruction[15]}}, instruction[15:0]};
        end
    end

    // Output the sign-extended immediate value
    assign sign_extended_imm = sign_extended_imm_reg;

endmodule
