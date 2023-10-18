module ControlUnit (
    input wire clk,
    input wire reset,
    input wire [31:0] instruction,           // Input instruction	 
    output reg [3:0] alu_op,                // ALU operation control
    output reg alu_src,                     // ALU source control
    output reg reg_write_enable,            // Register write enable control
    output reg mem_to_reg,                  // Memory to register control
    output reg [4:0] read_register_1,       // Read register 1 control
    output reg [4:0] read_register_2,       // Read register 2 control
    output reg [4:0] write_register,        // Write register control for RegisterFile
    output reg pc_increment,
    output reg ram_read_enable,             // Signal to control RAM read enable
    output reg ram_write_enable             // Signal to control RAM write enable
);



    	 
   
// Opcode definitions for MIPS instructions
localparam OP_ADD  = 6'b000000;
localparam OP_ADDI = 6'b001000;
localparam OP_ADDU = 6'b000001;
localparam OP_SUB  = 6'b000010;
localparam OP_SUBU = 6'b000011;
localparam OP_SLL  = 6'b000100;
localparam OP_SRL  = 6'b000101;
localparam OP_NOR  = 6'b000110;
localparam OP_AND  = 6'b000111;
localparam OP_ANDI = 6'b001000;
localparam OP_OR   = 6'b001001;
localparam OP_ORI  = 6'b001010;
localparam OP_XOR  = 6'b001011;
localparam OP_LW   = 6'b100011;
localparam OP_SW   = 6'b101011;



always@(posedge clk)
begin 
	 if (reset) begin
        // Reset all control signals and control state to their default values
        alu_op <= 4'b0000;
        alu_src <= 1'b0;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'b0;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
        read_register_1 <= 5'b0;
        read_register_2 <= 5'b0;
        write_register <= 5'b0;
        pc_increment <= 1'b0;
		  end
	else 
		begin
			case (instruction[31:26])
				OP_ADD:
					begin
						pc_increment <= 1'b1;
						mem_to_reg <= 1'b0;
						alu_src <= 1'b1;
						alu_op <= 4'b0010;
            			reg_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			read_register_2 <= instruction[20:16];  // send reg2 -> register file -> ALU_MUX -> ALU operand B
            			write_register <= instruction[15:11];
							
					end
				OP_ADDI:
					begin
					pc_increment <= 1'b1;
					 alu_op <= 4'b0010; // ALU control for ADD
            			alu_src <= 1'b1;
            			reg_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			write_register <= instruction[20:16];
					 
					end
					OP_ADDU:
					begin
					pc_increment <= 1'b1;
					alu_op <= 4'b0010;
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							read_register_2 <= instruction[20:16];
							write_register <= instruction[15:11];
							// You might need to select the upper byte for ADDU here
							// Example: operand_A <= {16'b0, register_file[read_register_1]};
							// Example: operand_B <= {16'b0, register_file[read_register_2]};
					  
					  
						
					end
					OP_SUB:
					begin
					
            	alu_src <= 1'b1;
					pc_increment <= 1'b1;
					alu_op <= 4'b0011;
            	alu_src <= 1'b1;
            	reg_write_enable <= 1'b1;
            	read_register_1 <= instruction[25:21];
            	write_register <= instruction[20:16];
					
					
					end
					
				
				OP_SUBU:
					begin
						pc_increment <= 1'b1;
						alu_op <= 4'b0011;
							alu_src <= 1'b1;
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							write_register <= instruction[20:16];
							// You might need to select the upper byte for SUBU here
							// Example: operand_A <= {16'b0, register_file[read_register_1]};
							// Example: operand_B <= {16'b0, register_file[read_register_2]};
					end
				OP_SLL:
					begin
					pc_increment <= 1'b1;
					  alu_op <= 4'b1000; // Set the ALU control for SLL
            			alu_src <= 1'b0;
            			reg_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			write_register <= instruction[15:11];
					end
					
				OP_SRL:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b1001; // Set the ALU control for SRL
            			alu_src <= 1'b0;
            			reg_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
							write_register <= instruction[15:11];
					 
					end
				OP_NOR :
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b1010; // Set ALU control for NOR
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							read_register_2 <= instruction[20:16];
							write_register <= instruction[15:11];
					end
				OP_AND :
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0100; // Set ALU control for AND
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							read_register_2 <= instruction[20:16];
							write_register <= instruction[15:11];
					end
				OP_ANDI:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0100; // Set ALU control for AND
							alu_src <= 1'b1;
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							write_register <= instruction[20:16];
					end
				OP_OR:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0101; // Set ALU control for OR
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							read_register_2 <= instruction[20:16];
							write_register <= instruction[15:11];
					  end
					OP_ORI:
					begin
					pc_increment <= 1'b1;
					alu_op <= 4'b0101; // Set ALU control for OR
							alu_src <= 1'b1;
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							write_register <= instruction[20:16];
					 
					end
				OP_XOR:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0110; // Set ALU control for XOR
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							read_register_2 <= instruction[20:16];
							write_register <= instruction[15:11];
					end
				OP_LW:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0010;
            			alu_src <= 1'b0;
            			reg_write_enable <= 1'b1;
            			mem_to_reg <= 1'b1;
            			ram_read_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			write_register <= instruction[20:16];
					  
					end
				OP_SW:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0010;
            			alu_src <= 1'b0;
            			ram_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			read_register_2 <= instruction[20:16];
					  
					end
					default: alu_op <= 4'b0000;
				endcase
			
			
		end


end








endmodule
