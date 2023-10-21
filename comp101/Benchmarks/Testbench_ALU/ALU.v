module ALU (
    input [4:0] shmant,              // Shift amount
    input wire clk,                  // Clock input
    input wire reset,                // Reset signal (active high)
    input wire [31:0] operand_A,     // Input operand A
    input wire [31:0] operand_B,     // Input operand B
    input wire [3:0] alu_control,    // ALU control signals
    output wire [31:0] alu_result,   // ALU result
    output wire zero_flag,           // Zero flag
    output wire [9:0] ram_address,   // 10-bit wide address for the RAM
    output wire overflow,            // Overflow flag
    output wire zero,                // Zero output
    output wire less                 // Less output
);

    reg [32:0] temp_result;         // Temporary register for ALU result
    reg over_flow_temp;             // Overflow temporary flag

    wire [31:0] twos_complement_A;  // Two's complement of operand A
    wire [31:0] twos_complement_B;  // Two's complement of operand B

    assign twos_complement_B = (~operand_B) + 1;   // Calculate two's complement of operand B
    assign twos_complement_A = (~operand_A) + 1;   // Calculate two's complement of operand A

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_result <= 32'b0;    // Reset ALU result to 0
        end else begin
            case (alu_control)
                4'b0010:                // ADD
                    begin
                        temp_result <= operand_A + operand_B;
                        over_flow_temp = ((temp_result[31] < 0) & (operand_A[31] < 0) & (operand_B[31] < 0)) ||
                                        ((temp_result[31] > 0) & (operand_A[31] < 0) & (operand_B[31] < 0));
                    end
                4'b0011:                // SUB
                    begin
                        temp_result <= operand_A - operand_B;
                        over_flow_temp = ((temp_result[31] > 0) & (operand_A[31] < 0) & (operand_B[31] > 0));
                        case ({operand_A[31], operand_B[31]})
                            00:  // Both are positive
                                temp_result <= operand_A + twos_complement_B;
                            01:  // B is negative
                                temp_result <= operand_A + twos_complement_B;
                            10:  // A is negative
                                temp_result <= (~(twos_complement_A + operand_B)) + 1;
                            11:  // Both negative
                                begin
                                    if (twos_complement_B > twos_complement_A)
                                        temp_result <= operand_A + twos_complement_B;
                                    else if (operand_A < operand_B)
                                        temp_result <= (~(twos_complement_A + operand_B)) + 1;
                                    else
                                        temp_result <= 0;
                                end
                        endcase
                    end
                4'b0100: temp_result <= operand_A & operand_B;      // AND
                4'b0101: temp_result <= operand_A | operand_B;      // OR
                4'b0110: temp_result <= operand_A ^ operand_B;      // XOR
                4'b0111: temp_result <= ~operand_A;                 // NOT
                4'b1000: temp_result <= operand_A << shmant;        // SLL
                4'b1001: temp_result <= operand_A >> shmant;        // SRL
                4'b1010: temp_result <= ~(operand_A | operand_B);   // NOR
                4'b1011:                                            // SUBU
                    begin
                        temp_result = operand_A + twos_complement_B;
                        over_flow_temp = temp_result[32];

                        if (over_flow_temp)
                            temp_result = operand_A + (twos_complement_B);
                        else
                        begin
                            case ({operand_A[31], operand_B[31]})
                                00:  // Both are positive
                                    temp_result <= operand_A + twos_complement_B;
                                01:  // B is negative
                                    temp_result <= operand_A + twos_complement_B;
                                10:  // A is negative
                                    temp_result <= (~(twos_complement_A + operand_B)) + 1;
                                11:  // Both negative
                                    begin
                                        if (twos_complement_B > twos_complement_A)
                                            temp_result <= operand_A + twos_complement_B;
                                        else if (operand_A < operand_B)
                                            temp_result <= (~(twos_complement_A + operand_B)) + 1;
                                        else
                                            temp_result <= 0;
                                    end
                            endcase
                        end
                    end
                4'b1100:                                            // ADDU
                    begin
                        temp_result <= operand_A + operand_B;
                        over_flow_temp = temp_result[32];
                    end
                default: temp_result <= 31'b0;                       // Default to zero for an undefined operation
            endcase
        end
    end

    assign alu_result = temp_result[31:0];                    // Assign the temporary result to alu_result
    assign zero_flag = (temp_result == 31'b0) ? 1'b1 : 1'b0;  // Set zero flag based on temp_result
    assign overflow = over_flow_temp;
    assign zero = (alu_result === 0) ? 1 : 0;
    assign ram_address = alu_result[31:0];                    // Assign the lower 5 bits of ALU result as the RAM address
    assign less = (alu_result[31] == 1) ? 1 : 0;
endmodule
