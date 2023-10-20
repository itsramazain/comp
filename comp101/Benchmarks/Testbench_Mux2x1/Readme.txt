After adding the Mux2x1 module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog Mux2x1.v
vlog Testbench_Mux2x1.sv

# Load the design
vsim -c Testbench_Mux2x1

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_Mux2x1/*
run 1000ps

# Save and close the simulation
quit -sim


================================ 7 total Muxes used in code ======================================
// Instantiate a 2x1 multiplexer to select the branch target or next program counter
Mux2x1 BT_OR_nextPC (
    .i0(pc_next),              // Input 0: Next program counter value
    .i1(BT),                   // Input 1: Branch target value
    .sel(branch_or_not),       // Select signal to choose between inputs
    .out(BT_or_next_pc)        // Output signal, either the branch target or next program counter
);

		
	
// Instantiate a 2x1 multiplexer to select the jump address if it's a jump instruction
Mux2x1 chooseJUMP (
    .i0(BT_or_next_pc),                       // Input 0: Branch target or next program counter
    .i1({{pc_next}, {instruction[25:0]}}),    // Input 1: Concatenation of next program counter and instruction bits[25:0]
    .sel(jump),                               // Select signal to choose between inputs
    .out(jump_or_next_pc_or_branch)           // Output signal, either the jump address or next program counter or branch target
);




// Instantiate a 2x1 multiplexer to select the register address if it's a JR (Jump Register) instruction
Mux2x1 jumptoregister (
    .i0(jump_or_next_pc_or_branch),         // Input 0: Output of the previous multiplexer (jump address, next PC, or branch target)
    .i1(alu_operand_A),                     // Input 1: Operand A value from ALU
    .sel(jr),                               // Select signal to choose between inputs
    .out(jump_or_next_pc_or_branch_or_jr)   // Output signal, either the selected address or ALU operand A
);

// Connect RegisterFile's read_data_1 and read_data_2 to read_register_1 and read_register_2
Mux2x1 reg_or_ra_selector (
    .i0(mem_reg_result),        // Input 0: Data from ALU result
    .i1(pc_next + 32'd2),       // Input 1: PC + 2 for the jal instruction
    .sel(jal),                  // Selector: Determines the output
    .out(reg_or_mem_or_ra)      // Output: Selected data for the register or ra
);

// ALU Operand Mux: Selects between sign-extended immediate value and ALU operand B.
Mux2x1 alu_operand (
    .i0(sign_extended_imm),   // Input 0: Sign-extended immediate value
    .i1(alu_operand_B),       // Input 1: ALU operand B (read_register_2)
    .sel(alu_src),            // Selector: Control signal to choose input (0 for sign-extended_imm, 1 for read_register_2)
    .out(operand_B)           // Output: Selected ALU operand B
);

// Write Register Mux: Selects between write register input and ALU operand B (read_register_2).
Mux2x1 write_reg (
    .i0(write_register),      // Input 0: Write register input
    .i1(read_register_2),    // Input 1: ALU operand B (read_register_2)
    .sel(mem_reg_selector),   // Selector: Register write enable signal
    .out(selected_register)   // Output: Selected register for write
);

// Memory Register Select Mux: Selects between data from RAM and ALU result.
Mux2x1 mem_reg_select (
    .i0(ram_result),          // Input 0: Data from RAM
    .i1(alu_result),          // Input 1: Data from ALU result
    .sel(mem_reg_selector),   // Selector: MUX selection control
    .out(mem_reg_result)      // Output: Selected data for memory register
);

===========================================   OUTPUT  =======================================
# Testing mux_2x1 module...
# ==========================================
# Test Case 1: Select 'i0' (sel = 0)
# Input i0 = 12345678
# Input i1 = 87654321
# Output = 12345678
# ==========================================
# Test Case 2: Select 'i1' (sel = 1)
# Input i0 = 12345678
# Input i1 = 87654321
# Output = 87654321
# ==========================================
# ** Note: $finish    : Testbench_Mux2x1.sv(40)
#    Time: 20 ps  Iteration: 0  Instance: /Testbench_Mux2x1