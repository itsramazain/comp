module CPU (
    input wire MAX10_CLK1_50,        // Clock input from DE-10 Lite FPGA (50MHZ)
    input wire reset                 // Reset signal (active high)
);

// Program Counter (PC) and Instruction Signals
wire [7:0] pc_next;            // PC Output (ROM address)
wire pc_increment;             // Fetch instruction control signal
wire [31:0] instruction;       // Instruction fetched from ROM (sent to Control unit to decode)

// Branch Target Calculation Signals
wire [7:0] BT;                // Branch Target
wire [7:0] BT_or_next_pc;     // MUX Output (Branch Target or Next PC)
wire [4:0] rom_address;        // Address to access ROM
wire alu_src;                  // ALU Source Selector
wire jumptwocon;               // Jump to CONtrol unit
wire write_en;                 // Register Write Enable
wire jump;                     // Jump Instruction Signal
wire [7:0] jump_or_next_pc_or_branch; // MUX Output (Jump or Next PC or Branch)
wire branch;                   // Branch Instruction Signal

// Register File Signals
wire [4:0] selected_register;   // Selected Register for Write
wire [31:0] write_data;         // Data to Write in Register File
wire [31:0] read_data_1;        // Data from Register File (Read Data 1)
wire [31:0] read_data_2;        // Data from Register File (Read Data 2)

// ALU and Control Signals
wire [4:0] read_register_1;    // Read Register 1 (ALU Operand)
wire [4:0] read_register_2;    // Read Register 2 (ALU Operand)
wire [4:0] write_register;     // Write Register
wire [31:0] alu_result;       // ALU Result
wire zero_flag;                // Zero Flag Signal
wire [31:0] alu_operand_A;     // ALU Operand A
wire [31:0] operand_B;         // Operand B for ALU
wire zero;                     // Zero Signal
wire jr;                       // Jump to Register Signal

// Additional Control Signals
wire [7:0] reg_or_mem_or_ra;  // MUX Output (Register File or Memory or RA)
wire less;                     // Less Signal
wire [3:0] alu_control;        // ALU Control Signals
wire [31:0] ram_result;        // Data from RAM
wire branch_or_not;            // Branch or Not Signal
wire mem_reg_selector;         // Memory or Register Selector
wire [7:0] jump_or_next_pc_or_branch_or_jr; // MUX Output (Jump or Next PC or Branch or JR)
//wire [31:0] mem_reg_result;    // Data Output from Memory or Register File
wire ram_read_enable;          // RAM Read Enable Signal
wire jal;                      // Jump and Link Instruction Signal
wire ram_write_enable;         // RAM Write Enable Signal

// Branch Condition Signals
wire branchnotequal;           // Branch Not Equal Signal
wire brachlessthat;            // Branch Less Than Signal
wire branchgreaterthan;        // Branch Greater Than Signal
wire branchlessthanorequal;    // Branch Less Than or Equal Signal
wire branchgreaterthanorequal; // Branch Greater Than or Equal Signal
wire brancheq;                 // Branch Equal Signal


// Instantiate the Program Counter module
ProgramCounter program_counter (
    .clk(MAX10_CLK1_50),               // input for clock
    .reset(reset),                     // input for reset
	 .enable_increment(pc_increment),   // input for enable increment
    .pc(pc_next)                       // output - 8 bits address for ROM
);



// Instantiate the branch target calculator module
Branch_Target_Calculator(
		.immediate(instruction[15:0]),               //immedate filed from the instruction
		.program_counter(pc_next),                   //nest instruction
		.BT(BT)
		);
		
// Choose between branch or next instruction logic				
BranchLogic branch_or_no(
    .brancheq(brancheq),
    .branchnotequal(branchnotequal),
    .brachlessthat(brachlessthat),
    .branchgreaterthanorequal(branchgreaterthanorequal),
    .branchlessthanorequal(branchlessthanorequal),
    .jal(jal),
    .zero(zero),
    .less(less),
    .branch_or_not(branch_or_not)
);

										
// Instantiate a 2x1 multiplexer to select the branch target or next program counter
Mux2x1 BT_OR_nextPC (
    .i0(pc_next),              // Input 0: Next program counter value
    .i1(BT),                   // Input 1: Branch target value
    .sel(branch_or_not),       // Select signal to choose between inputs
    .out(BT_or_next_pc)        // Output signal, either the branch target or next program counter
);

 defparam BT_OR_nextPC.n=8;
	
// Instantiate a 2x1 multiplexer to select the jump address if it's a jump instruction
Mux2x1 chooseJUMP (
    .i0(BT_or_next_pc),                       // Input 0: Branch target or next program counter
    .i1(instruction[7:0]),    // Input 1: Concatenation of next program counter and instruction bits[25:0]
    .sel(jump),                               // Select signal to choose between inputs
    .out(jump_or_next_pc_or_branch)           // Output signal, either the jump address or next program counter or branch target
);

 defparam chooseJUMP.n=8;


// Instantiate a 2x1 multiplexer to select the register address if it's a JR (Jump Register) instruction
Mux2x1 jumptoregister (
    .i0(jump_or_next_pc_or_branch),         // Input 0: Output of the previous multiplexer (jump address, next PC, or branch target)
    .i1(alu_operand_A),                     // Input 1: Operand A value from ALU
    .sel(jr),                               // Select signal to choose between inputs
    .out(jump_or_next_pc_or_branch_or_jr)   // Output signal, either the selected address or ALU operand A
);

 defparam jumptoregister.n=8;

// Instantiate the ROM module     -- containts 256 words each word is 32 bits
ROM32x256 rom(
    .clock(MAX10_CLK1_50),                             // input for clock
	 .address(jump_or_next_pc_or_branch_or_jr),         // input - 8 bits address from PC
    .q(instruction)                                    // ROM output - 32 bits instruction
);



// Instantiate the ControlUnit module
ControlUnit control_unit (
    .clk(MAX10_CLK1_50),                               // Clock input
    .reset(reset),                                     // Reset signal
    .instruction(instruction),                         // Input instruction
    .alu_op(alu_control),                              // ALU control signal
    .alu_src(alu_src),                                 // ALU source selector
    .reg_write_enable(write_en),                       // Register file write enable
    .pc_increment(pc_increment),                       // Program counter increment signal
    .mem_to_reg(mem_reg_selector),                     // Memory-to-register selector
    .read_register_1(read_register_1),                 // Read register 1 address
    .read_register_2(read_register_2),                 // Read register 2 address
    .write_register(write_register),                   // Write register address
    // .rom_read_enable(rom_read_enable),              // Uncomment this if needed  *for funture*
    .ram_read_enable(ram_read_enable),                 // RAM read enable signal
    .ram_write_enable(ram_write_enable),               // RAM write enable signal
    .jump(jump),                                       // Jump instruction signal
    .branchnotequal(branchnotequal),                   // Branch not equal instruction signal
    .brachlessthat(brachlessthat),                     // Branch less than instruction signal
    .branchgreaterthan(branchgreaterthan),             // Branch greater than instruction signal
    .branchlessthanorequal(branchlessthanorequal),     // Branch less than or equal instruction signal
    .branchgreaterthanorequal(branchgreaterthanorequal),      // Branch greater than or equal instruction signal
    .brancheq(brancheq),                               // Branch equal instruction signal
    .jr(jr),                                           // Jump register instruction signal
    .jal(jal)                                          // Jump and link instruction signal
);



// Connect RegisterFile's read_data_1 and read_data_2 to read_register_1 and read_register_2
Mux2x1 reg_or_ra_selector (
    .i0(mem_reg_result),        // Input 0: Data from ALU result
    .i1(pc_next + 8'd2),       // Input 1: PC + 2 for the jal instruction
    .sel(jal),                  // Selector: Determines the output
    .out(reg_or_mem_or_ra)      // Output: Selected data for the register or ra
);

defparam reg_or_ra_selector.n=8;

RegisterFile register_file (
    .clock(MAX10_CLK1_50),                       // Clock input
    .Reset(reset),                               // Reset signal
    .read_register_1(read_register_1),           // Read register 1 address
    .read_register_2(read_register_2),           // Read register 2 address
    .reg_write_address(write_register),       // Register address for write (if used)
    .reg_write_enable(write_en),                 // Register write enable signal
    .write_data(reg_or_mem_or_ra),               // Data to be written to the register file
    .read_data_1(alu_operand_A),                 // Data read from read_register_1
    .read_data_2(alu_operand_B)                  // Data read from read_register_2
);



// Instantiate the ALU module and connect the ALU control signal
ALU my_alu (
    .clk(MAX10_CLK1_50),                     // Clock input
    .reset(reset),                           // Reset signal
    .operand_A(alu_operand_A),               // ALU input A
    .operand_B(operand_B),                   // ALU input B
    .alu_control(alu_control),               // ALU control signal
    .alu_result(alu_result),                 // ALU result
    .zero_flag(zero_flag),                   // Zero flag output
    .ram_address(ram_address),               // RAM address output
    .shmant(instruction[10:6]),              // Shift amount from instruction
    .zero(zero),                             // Zero signal
    .less(less)                              // Less signal
);


// ALU Operand Mux: Selects between sign-extended immediate value and ALU operand B.
Mux2x1 alu_operand (
    .i0(alu_operand_B),   // Input 0: Sign-extended immediate value
    .i1(sign_extended_imm),       // Input 1: ALU operand B (read_register_2)
    .sel(alu_src),            // Selector: Control signal to choose input (0 for sign-extended_imm, 1 for read_register_2)
    .out(operand_B)           // Output: Selected ALU operand B
);




SignExtendImmediate sign_extend (
    .clk(MAX10_CLK1_50),                      // Clock input
    .reset(reset),                            // Reset signal
    .instruction(instruction[15:0]),          // Instruction immediate field
    .sign_extended_imm(sign_extended_imm)     // Sign-extended immediate value
);

RAM32x1024 ram (
    .address(ram_address),                    // RAM address
    .clock(MAX10_CLK1_50),                    // Clock input
    .data(alu_operand_B),                     // Data input to RAM
    .rden(ram_read_enable),                   // RAM read enable
    .wren(ram_write_enable),                  // RAM write enable
    .q(ram_result)                            // RAM data output
);

// Memory Register Select Mux: Selects between data from RAM and ALU result.
Mux2x1 mem_reg_select (
    .i0(alu_result),          // Input 0: Data from RAM
    .i1(ram_result),          // Input 1: Data from ALU result
    .sel(mem_reg_selector),   // Selector: MUX selection control
    .out(mem_reg_result)      // Output: Selected data for memory register
);



endmodule
