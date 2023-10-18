module ALU (
    input wire clk,           // Clock input
    input wire reset,         // Reset signal (active high)
    input wire [31:0] operand_A,
    input wire [31:0] operand_B,
    input wire [3:0] alu_control,
    output wire [31:0] alu_result,
    output wire zero_flag,
    output wire [9:0] ram_address,
	overflow // 10-bit wide address for the RAM
);
output overflow;
reg [31:0] temp_result; // Declare a temporary reg for ALU result
reg over_flow_temp;

initial 
over_flow_temp=0;//it doest have to change untill a sub/add instruction
always @(posedge clk or posedge reset) begin
    if (reset) begin
        temp_result <= 32'b0;  // Reset ALU result to 0
    end else begin
        case (alu_control)
            4'b0010:
				temp_result <= operand_A + operand_B; // ADD
            4'b0011: // SUB
				
				begin
				over_flow_temp=((operand_A -operand_B>0)&(operand_A<0)&(operand_B>0))||((operand_A -operand_B<0)&(operand_A>0)&(operand_B<0));
					case({operand_A[31],operand_B[31]})
						00: //both are positive  
							temp_result <= operand_A + (~operand_B)+1;
						01://b is negative 
							temp_result <= operand_A + (~operand_B)+1;
						10://a is negative 
							temp_result <= (~((~operand_A)+1 + operand_B))+1;
						11://both negative
							begin 
								if ((~operand_A)+1>(~operand_B)+1)
									temp_result <= operand_A + (~operand_B)+1;
								else if (operand_A<operand_B)
									temp_result <= (~((~operand_A)+1 + operand_B))+1;
								else 
									temp_result <= 0;
							end
						
					 endcase
				end
				
				
				
            4'b0100: temp_result <= operand_A & operand_B; // AND
            4'b0101: temp_result <= operand_A | operand_B; // OR
            4'b0110: temp_result <= operand_A ^ operand_B; // XOR
            4'b0111: temp_result <= ~operand_A;             // NOT
            4'b1000: temp_result <= operand_A << operand_B[4:0]; // SLL
            4'b1001: temp_result <= operand_A >> operand_B[4:0]; // SRL
				4'b1010: temp_result <= ~ (operand_A | operand_B); // NOR
				4'b1011://subu
				begin
				temp_result=operand_A - operand_B;
				overflow_temp1=((temp_result>0)&(operand_A<0)&(operand_B>0))||((temp_result<0)&(operand_A>0)&(operand_B<0));
				
				if (overflow)
					temp_result=operand_A +(~operand_B+1);
				else 
				begin
				over_flow_temp=((operand_A -operand_B>0)&(operand_A<0)&(operand_B>0))||((operand_A -operand_B<0)&(operand_A>0)&(operand_B<0));
					case({operand_A[31],operand_B[31]})
						00: //both are positive  
							temp_result <= operand_A + (~operand_B)+1;
						01://b is negative 
							temp_result <= operand_A + (~operand_B)+1;
						10://a is negative 
							temp_result <= (~((~operand_A)+1 + operand_B))+1;
						11://both negative
							begin 
								if ((~operand_A)+1>(~operand_B)+1)
									temp_result <= operand_A + (~operand_B)+1;
								else if (operand_A<operand_B)
									temp_result <= (~((~operand_A)+1 + operand_B))+1;
								else 
									temp_result <= 0;
							end
						
					 endcase
				end
				
				
				end
				4'b1100://addu
				begin
				
				end
            default: temp_result <= 32'b0;                   // Default to zero for an undefined operation
        endcase
    end
end

assign alu_result = temp_result; // Assign the temporary result to alu_result
assign zero_flag = (temp_result == 32'b0) ? 1'b1 : 1'b0; // Set zero flag based on temp_result
assign overflow=over_flow_temp;
assign ram_address = alu_result[4:0]; // Assign the lower 5 bits of ALU result as the RAM address

endmodule
