module ALU (
    input wire clk,           // Clock input
    input wire reset,         // Reset signal (active high)
    input wire [31:0] operand_A,
    input wire [31:0] operand_B,
    input wire [3:0] alu_control,
    output wire [31:0] alu_result,
    output wire zero_flag,
    output wire [9:0] ram_address // 10-bit wide address for the RAM
);

reg [31:0] temp_result; // Declare a temporary reg for ALU result

always @(posedge clk or posedge reset) begin
    if (reset) begin
        temp_result <= 32'b0;  // Reset ALU result to 0
    end else begin
        case (alu_control)
            4'b0010: temp_result <= operand_A + operand_B; // ADD
            4'b0011: temp_result <= operand_A - operand_B; // SUB
            4'b0100: temp_result <= operand_A & operand_B; // AND
            4'b0101: temp_result <= operand_A | operand_B; // OR
            4'b0110: temp_result <= operand_A ^ operand_B; // XOR
            4'b0111: temp_result <= ~operand_A;             // NOT
            4'b1000: temp_result <= operand_A << operand_B[4:0]; // SLL
            4'b1001: temp_result <= operand_A >> operand_B[4:0]; // SRL
				4'b1010: temp_result <= ~ (operand_A | operand_B); // NOR
            default: temp_result <= 32'b0;                   // Default to zero for an undefined operation
        endcase
    end
end

assign alu_result = temp_result; // Assign the temporary result to alu_result
assign zero_flag = (temp_result == 32'b0) ? 1'b1 : 1'b0; // Set zero flag based on temp_result

assign ram_address = alu_result[4:0]; // Assign the lower 5 bits of ALU result as the RAM address

endmodule
