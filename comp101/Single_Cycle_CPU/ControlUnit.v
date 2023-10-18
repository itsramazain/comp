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
    output reg ram_write_enable,	 // Signal to control RAM write enable
	 output reg jump,
	 output reg branchnotequal,
	 output reg brachlessthat,
	 output reg branchgreaterthan,
	 output reg branchlessthanorequal,
	 output reg branchgreaterthanorequal,
	 output reg brancheq
);


/* instruction   __ opcode __ function filed 
		/add        __ 000000 __  10 0000    //implemented  
		/sub        ___ 000000 __    10 0010  //implemented
		/and       ___ 000000 ___   10 0100  //implemented
		/andi       __  001100 ___no function filed  //implemented
		/or         ____ 000000 ___  10  0101     //implemented
		/ori     ____ 00 1101 __no function filed   //implemented
		/nor       ___ 000000 ___ 10 0111     //implemented
		/sll   	___ 000000 __00000   //implemented
		/srl  		_____ 00000  ____ 00 0010   //implemented
		/addi		 ____ 00 1000 ____no functionfield   //implemented
		/addu    ______ 001001 _______ 100001   // not implemented
		/subu   ____ 00 0000 ____ 100011  //not  implemented
		/xor      ____ 000000 ____ 10 0110  //implemented
		/beq     _____ 000100 _____ no function field  //implemented
		/bnq       ____ 000101 _____ no function field  //implemented
		/jump   _____  000010 _____no function field  //implemented
		jr     ____ 000000   _____ 001001   //  not implemented
		jal    _____ 000011 ______no function field  // not implemented
		/lw    ______   100011 ______no function field //  //implemented
		/sw    ______  101011 ______no function field  //implemented
		/slt ____ 000000 _____ 101010  //implemented
		/BGT ___ 001111  __//reb loaupperimm
		/BLT ___ 110000  __//reb load linked
		/BLE ___ 100101  __//reb loadhw
		/BGE ___ 100100  __//reb loadbyte
		

*/
    	 
   
// Opcode definitions for MIPS instructions
localparam OP_ADD  = 6'b000000;
localparam OP_ADDI = 6'b001000;
localparam OP_ADDU = 6'b001001;
localparam OP_SUB  = 6'b000000;
localparam OP_SUBU = 6'b000000;
localparam OP_SLL  = 6'b000000;
localparam OP_SRL  = 6'b000000;
localparam OP_NOR  = 6'b000000;
localparam OP_AND  = 6'b000000;
localparam OP_ANDI = 6'b001100;
localparam OP_OR   = 6'b000000;
localparam OP_ORI  = 6'b001010;
localparam OP_XOR  = 6'b000000;
localparam OP_LW   = 6'b100011;
localparam OP_SW   = 6'b101011;
localparam OP_JUMP  =6'b000010;
localparam OP_BNE  = 6'b000101;
localparam OP_BEQ  = 6'b000100;
localparam OP_BLE  = 6'b100101;
localparam OP_BGE  = 6'b100100;
localparam OP_JR  =  6'b000000;
localparam OP_JAL  = 6'b000011;
localparam OP_BGT  = 6'b001111;
localparam OP_BLT  = 6'b110000;
localparam OP_SLT  = 6'b000000;
localparam FUN_ADD  =6'b100000;
localparam FUN_SUB  =6'b100010;
localparam FUN_OR  = 6'b100101;
localparam FUN_XOR  =6'b100110;
localparam FUN_AND  =6'b100100;
localparam FUN_NOR  =6'b100111;
localparam FUN_SLL  =6'b000000;
localparam FUN_SRL  =6'b000010;
localparam FUN_SUBU= 6'b100011;
localparam FUN_JR  = 6'b001001;
localparam FUN_SLT = 6'b101010;
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
		  jump=0;
		  branchnotequal=0;
			brachlessthat=0;
			branchgreaterthan=0;
			branchlessthanorequal=0;
		branchgreaterthanorequal=0;
	 brancheq=0;
		  end
	else 
		begin
			case (instruction[31:26])
				OP_ADD:
					begin
											case(instruction[5:0])
												FUN_ADD:
												begin
													pc_increment <= 1'b1;
													mem_to_reg <= 1'b0;
													alu_src <= 1'b1;
													alu_op <= 4'b0010;
													
														
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														read_register_2 <= instruction[20:16];  // send reg2 -> register file -> ALU_MUX -> ALU operand B
														write_register <= instruction[15:11];
														 branchnotequal=0;
														brachlessthat=0;
														branchgreaterthan=0;
														branchlessthanorequal=0;
													branchgreaterthanorequal=0;
												 brancheq=0;
														
														
												end
											
												
													 
														
												  
												  
													
												
												FUN_SUB:
												begin
												 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
												alu_src <= 1'b1;
												pc_increment <= 1'b1;
												alu_op <= 4'b0011;
												alu_src <= 1'b1;
												reg_write_enable <= 1'b1;
												read_register_1 <= instruction[25:21];
												write_register <= instruction[20:16];
												  branchnotequal=0;
												brachlessthat=0;
												branchgreaterthan=0;
												branchlessthanorequal=0;
											branchgreaterthanorequal=0;
										 brancheq=0;
														
														
													
												
												
												end
												
											
											FUN_SLL:
												begin
												pc_increment <= 1'b1;
												  alu_op <= 4'b1000; // Set the ALU control for SLL
														alu_src <= 1'b0;
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[20:16];
														write_register <= instruction[15:11];
														 jump=0;
														
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														 
														brachlessthat=0;
														branchgreaterthan=0;
														branchlessthanorequal=0;
													branchgreaterthanorequal=0;
												 brancheq=0;
												end
												
											FUN_SRL:
												begin
												pc_increment <= 1'b1;
													alu_op <= 4'b1001; // Set the ALU control for SRL
														alu_src <= 1'b0;
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[20:16];
														write_register <= instruction[15:11];
														 jump=0;
														 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														
												 
												end
											FUN_NOR :
												begin
												pc_increment <= 1'b1;
													alu_op <= 4'b1010; // Set ALU control for NOR
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														read_register_2 <= instruction[20:16];
														write_register <= instruction[15:11];
														 jump=0;
														 branchnotequal=0;
														brachlessthat=0;
														branchgreaterthan=0;
														branchlessthanorequal=0;
													branchgreaterthanorequal=0;
												 brancheq=0;
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														
												end
											FUN_AND :
												begin
												pc_increment <= 1'b1;
													alu_op <= 4'b0100; // Set ALU control for AND
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														read_register_2 <= instruction[20:16];
														write_register <= instruction[15:11];
														  branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
														
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														
												end
												
												
												FUN_XOR:
												begin
												pc_increment <= 1'b1;
													alu_op <= 4'b0110; // Set ALU control for XOR
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														read_register_2 <= instruction[20:16];
														write_register <= instruction[15:11];
															 
														
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														 branchnotequal=0;
														brachlessthat=0;
														branchgreaterthan=0;
														branchlessthanorequal=0;
													branchgreaterthanorequal=0;
												 brancheq=0;
												end
												
												
												
												FUN_OR:
												begin
												pc_increment <= 1'b1;
													alu_op <= 4'b0101; // Set ALU control for OR
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														read_register_2 <= instruction[20:16];
														write_register <= instruction[15:11];
														jump=0;
														 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														
												  end
							endcase
					 end
					OP_ADDI:
					begin
					pc_increment <= 1'b1;
					 ram_read_enable <= 1'b0;
							ram_write_enable <= 1'b0;
					 alu_op <= 4'b0010; // ALU control for ADD
            			alu_src <= 1'b1;
            			reg_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			write_register <= instruction[20:16]; 
							jump=0;
								 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
					 
					end
				OP_ADDU:
												begin
												 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
												pc_increment <= 1'b1;
												alu_op <= 4'b1100;
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														read_register_2 <= instruction[20:16];
														write_register <= instruction[15:11];
														 jump=0;
														 	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
														end
					
				OP_ANDI:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0100; // Set ALU control for AND
							alu_src <= 1'b1;
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							write_register <= instruction[20:16];
								 jump=0;
							
						 ram_read_enable <= 1'b0;
							ram_write_enable <= 1'b0;
							 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
					end
				
					OP_ORI:
					begin
					pc_increment <= 1'b1;
					alu_op <= 4'b0101; // Set ALU control for OR
							alu_src <= 1'b1;
							reg_write_enable <= 1'b1;
							read_register_1 <= instruction[25:21];
							write_register <= instruction[20:16];
								 jump=0;
									 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
						 ram_read_enable <= 1'b0;
							ram_write_enable <= 1'b0;
					 
					end
				OP_SUBU:
												begin
													pc_increment <= 1'b1;
													alu_op <= 4'b1011;
														alu_src <= 1'b1;
														reg_write_enable <= 1'b1;
														read_register_1 <= instruction[25:21];
														write_register <= instruction[20:16];
														 	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
														
													 ram_read_enable <= 1'b0;
														ram_write_enable <= 1'b0;
														
														
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
							 jump=0;
							 	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
						 
					  
					end
				OP_SW:
					begin
					pc_increment <= 1'b1;
						alu_op <= 4'b0010;
            			alu_src <= 1'b0;
            			ram_write_enable <= 1'b1;
            			read_register_1 <= instruction[25:21];
            			read_register_2 <= instruction[20:16];
							 jump=0;
							 	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
						 
					  
					end
				OP_JUMP:
					begin
				 alu_op <= 4'bxxxx;
        alu_src <= 1'bx;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
        read_register_1 <= 5'b0;
        read_register_2 <= 5'b0;
        write_register <= 5'b0;
        pc_increment <= 1'b1;
		  jump=1;
		  	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
		  end
		  
		  OP_BEQ:
					begin
				 alu_op <= 4'b0011;
        alu_src <= 1'b1;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
        read_register_1 <= instruction[25:21];
        read_register_2 <= instruction[20:16];
        write_register <= instruction[15:11];
        pc_increment <= 1'b1;
		  jump=0;
		 	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=1;
		  
		  end
		   OP_BNE:
					begin
				 alu_op <= 4'b0011;
        alu_src <= 1'b1;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
         read_register_1 <= instruction[25:21];
        read_register_2 <= instruction[20:16];
        write_register <= instruction[15:11];
        write_register <= 5'b0;
        pc_increment <= 1'b1;
		  jump=0;
		 	 branchnotequal=1;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
		  end
		  
		  OP_BLE:
					begin
				 alu_op <= 4'b0011;
        alu_src <= 1'b1;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
        read_register_1 <= instruction[25:21];
        read_register_2 <= instruction[20:16];
        write_register <= instruction[15:11];
        write_register <= 5'b0;
        pc_increment <= 1'b1;
		  jump=0;
		  	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=1;
														branchgreaterthanorequal=0;
													 brancheq=0;
		  
		  end
		  
		  OP_BGE:
					begin
					
				 alu_op <= 4'b0011;
        alu_src <= 1'b1;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
         read_register_1 <= instruction[25:21];
        read_register_2 <= instruction[20:16];
        write_register <= instruction[15:11];
        
        write_register <= 5'b0;
        pc_increment <= 1'b1;
		  jump=0;
		  	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=0;
															branchlessthanorequal=0;
														branchgreaterthanorequal=1;
													 brancheq=0;
		  
		  end
		   OP_BGT:
					begin
				 alu_op <= 4'b0011;
        alu_src <= 1'b1;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
         read_register_1 <= instruction[25:21];
        read_register_2 <= instruction[20:16];
        write_register <= instruction[15:11];
        write_register <= 5'b0;
        pc_increment <= 1'b1;
		  jump=0;
		  	 branchnotequal=0;
															brachlessthat=0;
															branchgreaterthan=1;
															branchlessthanorequal=0;
														branchgreaterthanorequal=0;
													 brancheq=0;
		  
		  end
		   OP_BLT:
					begin
				 alu_op <= 4'b0011;
        alu_src <= 1'b1;
        reg_write_enable <= 1'b0;
        mem_to_reg <= 1'bx;
        ram_read_enable <= 1'b0;
        ram_write_enable <= 1'b0;
         read_register_1 <= instruction[25:21];
        read_register_2 <= instruction[20:16];
        write_register <= instruction[15:11];
        write_register <= 5'b0;
        pc_increment <= 1'b1;
		  jump=0;
		 	 branchnotequal=0;
			brachlessthat=1;
			branchgreaterthan=0;
			branchlessthanorequal=0;
			branchgreaterthanorequal=0;
			brancheq=0;
		  
		  end
		   
		  
		   
		  
		  
		  		
					default: alu_op <= 4'b0000;
				endcase
			
			
		end


end








endmodule
