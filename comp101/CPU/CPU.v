module CPU (
    input wire MAX10_CLK1_50,        // Clock input from DE-10 Lite FPGA (50MHZ)
    input wire reset                 // Reset signal (active high)
);

wire [7:0] pc_next;           // PC Output (ROM address)
wire pc_increment;            // fetch instruction control signal
wire [31:0] instruction;      // instruction fetched from ROM (send to Control unit to decode)
wire [31:0]BT;
wire [31:0]BT_or_next_pc;
wire [4:0] rom_address;
wire alu_src;
wire jumptwocon;
wire write_en;
wire jump;
wire [31:0]jump_or_next_pc_or_branch;
wire branch;
wire [4:0] selected_register;
wire [31:0] alu_result;  // Explicit declaration for alu_result signal
wire zero_flag;  // Explicit declaration for zero_flag signal
wire [4:0] read_register_1;  // Explicit declaration for read_register_1 signal
wire [4:0] read_register_2;  // Explicit declaration for read_register_2 signal
wire [4:0] write_register;  // Explicit declaration for write_register signal
wire [31:0] write_data;  // Explicit declaration for write_data signal
wire [31:0] read_data_1;  // Explicit declaration for read_data_1 signal
wire [31:0] read_data_2;  // Explicit declaration for read_data_2 signal
wire [4:0] ram_address;
wire zero;
wire jr;
wire [31:0]reg_or_mem_or_ra;
wire less;
wire [3:0] alu_control;
wire [31:0] ram_result;
wire branch_or_not;
wire mem_reg_selector;
wire [31:0]jump_or_next_pc_or_branch_or_jr;
wire [31:0] mem_reg_result;
wire ram_read_enable;
wire jal;
wire ram_write_enable;
wire [31:0] alu_operand_A;  // Explicit declaration for alu_operand_A
wire [31:0] operand_B;      // Explicit declaration for operand_B
wire branchnotequal;
wire brachlessthat;
wire branchgreaterthan;
wire branchlessthanorequal;
wire branchgreaterthanorequal;
wire brancheq;
// Instantiate the Program Counter module
ProgramCounter program_counter (
    .clk(MAX10_CLK1_50),    // input for clock
    .reset(reset),          // input for reset
	 .enable_increment(pc_increment),
    .pc(pc_next)            // output - 8 bits address for ROM
);

// Instantiate the ROM module     -- containts 256 words each word is 32 bits


Branch_Target_calculator(
		instruction[15:0],//immedate filed from the instruction
		pc_next, //nest instruction
		BT,
		);
		
		




		
assign branch_or_not=( (brancheq&(zero)) || (branchnotequal &(~zero)) ||  (brachlessthat&(less)) || (branchgreaterthanorequal & (zero&~less)) ||  (branchlessthanorequal & (zero&less)) ||(jal) );





mux_2x1 chooseBTORnextPC(pc_next//this mux takes the branch target if it is a branch instruction
	,BT
	,branch_or_not
	,BT_or_next_pc);
	
mux_2x1 chooseJUMP(BT_or_next_pc//this mux takes the jump adress if its a jump instruction
	,{{pc_next},{instruction[25:0]}}
	,jump
	,jump_or_next_pc_or_branch);
	
	



mux_2x1 jumptoregister(jump_or_next_pc_or_branch//this mux takes the register adress if jr
	,alu_operand_A
	,jr
	,jump_or_next_pc_or_branch_or_jr);


ROM32x256 rom(
    .clock(MAX10_CLK1_50),     // input for clock
	 .address(jump_or_next_pc_or_branch_or_jr),         // input - 8 bits address from PC
    .q(instruction)            // ROM output - 32 bits instruction
);

// Instantiate the ControlUnit module
ControlUnit control_unit (
    .clk(MAX10_CLK1_50),
    .reset(reset),
    .instruction(instruction),
    .alu_op(alu_control),
	 .alu_src(alu_src),
	 .reg_write_enable(write_en),
	 .pc_increment(pc_increment),
	 .mem_to_reg(mem_reg_selector), 
	 .read_register_1(read_register_1),
	 .read_register_2(read_register_2),
	 .write_register(write_register),
	 //.rom_read_enable(rom_read_enable),
    .ram_read_enable(ram_read_enable),
	 .ram_write_enable(ram_write_enable),
	  .jump(jump),
	 	 .branchnotequal(branchnotequal),
		.brachlessthat(brachlessthat),
	.branchgreaterthan(branchgreaterthan),
	.branchlessthanorequal(branchlessthanorequal),
	.branchgreaterthanorequal(branchgreaterthanorequal),
	.brancheq(brancheq),
	.jr(jr),
	.jal(jal)

);


// Connect RegisterFile's read_data_1 and read_data_2 to read_register_1 and read_register_2

	mux_2x1(mem_reg_result,pc_next+32'd2,jal,reg_or_mem_or_ra);//this chooses to write on the reg 31 the right now pc

RegisterFile register_file (
    .clock(MAX10_CLK1_50),
    .Reset(reset),
    .read_register_1(read_register_1),
    .read_register_2(read_register_2),
    //.write_register_file(selected_register),
	 .reg_write_address(selected_register),
    .reg_write_enable(write_en),
    .write_data(reg_or_mem_or_ra),
    .read_data_1(alu_operand_A), // Connect read_data_1
    .read_data_2(alu_operand_B)  // Connect read_data_2
);


// Instantiate the ALU module and connect the ALU control signal
ALU my_alu (
    .clk(MAX10_CLK1_50),
	 .reset(reset),
    .operand_A(alu_operand_A),
    .operand_B(operand_B),
    .alu_control(alu_control),
    .alu_result(alu_result),
    .zero_flag(zero_flag),
	 .ram_address(ram_address),
	 .shmant(instruction[10:6]),
	 .zero(zero),
	 .less(less)
	 
);



ALUOperandBMux alu_operand(
	 .clk(MAX10_CLK1_50),
	 .reset(reset),
    .sign_extended_imm(sign_extended_imm),
    .read_register_2(alu_operand_B),
    .select(alu_src),  // Control signal to select the input (0 for sign_extended_imm, 1 for read_register_2)
    .operand_b(operand_B)
);

WriteRegisterMux write_reg(
	 .clk(MAX10_CLK1_50),
	 .reset(reset),
    .write_register(write_register),
    .read_register_2(read_register_2),
    .reg_write_enable(mem_reg_selector),
    .selected_register(selected_register)
);

SignExtendImmediate sign_extend(
	 .clk(MAX10_CLK1_50),
	 .reset(reset),
    .instruction(instruction[15:0]),
    .sign_extended_imm(sign_extended_imm)
);


RAM32x1024 ram(
	.address(ram_address),
	.clock(MAX10_CLK1_50),
	.data(alu_operand_B),
	.rden(ram_read_enable),
	.wren(ram_write_enable),
	.q(ram_result)
	);
	
	
DataMUX mem_reg_select(
	 .clk(MAX10_CLK1_50),
	 .reset(reset),
    .ram_result(ram_result),
    .alu_result(alu_result),
    .mux_select(mem_reg_selector),  // MUX selection control
    .data_output(mem_reg_result)
);



	

endmodule