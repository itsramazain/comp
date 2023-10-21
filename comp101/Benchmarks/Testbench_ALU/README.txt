After adding the ALU module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog ALU.v
vlog Testbench_ALU.sv

# Load the design
vsim -c Testbench_ALU

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_ALU/*
run 10000ps

# Save and close the simulation
quit -sim

# The sumulation will stop automatically, Dont close the program after finishing to see the output waves and transcript.

===========================================   OUTPUT  =======================================

# Test Case 1 (ADD): operand_A =         10, operand_B =          5, alu_control = 0010 (ADD)
# alu_result =         15, zero_flag = 0, overflow = 0, zero = 0, less = 0
# ========================================================================
# Test Case 2 (SUB): operand_A =         10, operand_B =          5, alu_control = 0011 (SUB)
# alu_result =          5, zero_flag = 0, overflow = 0, zero = 0, less = 0
# ========================================================================
# Test Case 3 (AND): operand_A = 10101010101010100101010101010101, operand_B = 01010101010101011010101010101010, alu_control = 0100 (AND) 
# alu_result = 00000000000000000000000000000000, zero_flag = 1, overflow = 0, zero = 1, less = 0
# ========================================================================
# Test Case 4 (OR): operand_A = 10101010101010100101010101010101, operand_B = 01010101010101011010101010101010, alu_control = 0101 (OR) 
# alu_result = 11111111111111111111111111111111, zero_flag = 0, overflow = 0, zero = 0, less = 1
# ========================================================================
# Test Case 5 (XOR): operand_A = 10101010101010100101010101010101, operand_B = 01010101010101011010101010101010, alu_control = 0110 (XOR) 
# alu_result = 11111111111111111111111111111111, zero_flag = 0, overflow = 0, zero = 0, less = 1
# ========================================================================
# Test Case 6 (NOT): operand_A = 10101010101010100101010101010101, operand_B = 00000000000000000000000000000000, alu_control = 0111 (NOT) 
# alu_result = 01010101010101011010101010101010, zero_flag = 0, overflow = 0, zero = 0, less = 0
# ========================================================================
# Test Case 7 (SLL): operand_A = 00000000000000000001000000000000, operand_B (Shift Amount) =          4, alu_control = 1000 (SLL) 
# alu_result = 00000000000000000001000000000000, zero_flag = 0, overflow = 0, zero = 0, less = 0
# ========================================================================
# Test Case 8 (SRL): operand_A (Negative) = 10000000000000000000000100000000, operand_B (Shift Amount) =          4, alu_control = 1001 (SRL) 
# alu_result = 10000000000000000000000100000000, zero_flag = 0, overflow = 0, zero = 0, less = 1
# ========================================================================
# Test Case 9 (NOR): operand_A = 10101010101010100101010101010101, operand_B = 01010101010101011010101010101010, alu_control = 1010 (NOR) 
# alu_result = 00000000000000000000000000000000, zero_flag = 0, overflow = 0, zero = 1, less = 0
# ========================================================================
# Test Case 10 (ADDU): operand_A (Negative) = 11111111111111111111111111111111, operand_B = 00000000000000000000000000000001, alu_control = 1100 (ADDU) 
# alu_result = 00000000000000000000000000000000, zero_flag = 0, overflow = 1, zero = 1, less = 0
# ========================================================================
# Test Case 11 (SUB): operand_A = 00000000000000000000000000001010, operand_B = 00000000000000000000000000000101, alu_control = 0011 (SUB) 
# alu_result = 00000000000000000000000000000101, zero_flag = 0, overflow = 0, zero = 0, less = 0
# ========================================================================
# Test Case 12 (SUB): operand_A (Negative) = 11111111111111111111111111111011, operand_B = 00000000000000000000000000000101, alu_control = 0011 (SUB) 
# alu_result = 11111111111111111111111111110110, zero_flag = 0, overflow = 0, zero = 0, less = 1
# ========================================================================
# Test Case 13 (SUB): operand_A (Negative) = 11111111111111111111111111111011, operand_B (Negative) = 11111111111111111111111111110110, alu_control = 0011 (SUB) 
# alu_result = 00000000000000000000000000000101, zero_flag = 0, overflow = 0, zero = 0, less = 0
# ========================================================================
# Test Case 14 (SUBU): operand_A = 00000000000000000000000000001010, operand_B = 00000000000000000000000000000101, alu_control = 1011 (SUBU) 
# alu_result = 00000000000000000000000000000101, zero_flag = 0, overflow = 1, zero = 0, less = 0
# ========================================================================
# Test Case 15 (SUBU): operand_A (Negative) = 11111111111111111111111111111011, operand_B = 00000000000000000000000000000101, alu_control = 1011 (SUBU) 
# alu_result = 11111111111111111111111111110110, zero_flag = 0, overflow = 1, zero = 0, less = 1
# ========================================================================
# Test Case 16 (SUBU): operand_A (Negative) = 11111111111111111111111111111011, operand_B (Negative) = 11111111111111111111111111110110, alu_control = 1011 (SUBU) 
# alu_result = 00000000000000000000000000000101, zero_flag = 0, overflow = 1, zero = 0, less = 0
# ========================================================================
# Test Case 17 (AND): operand_A (All zeros) = 00000000000000000000000000000000, operand_B (All zeros) = 00000000000000000000000000000000, alu_control = 0100 (AND) 
# alu_result = 00000000000000000000000000000000, zero_flag = 1, overflow = 1, zero = 1, less = 0
# ========================================================================
# Test Case 18 (AND): operand_A (All zeros) = 00000000000000000000000000000000, operand_B (All ones) = 11111111111111111111111111111111, alu_control = 0100 (AND) 
# alu_result = 00000000000000000000000000000000, zero_flag = 1, overflow = 1, zero = 1, less = 0
# ========================================================================
# Test Case 19 (OR): operand_A (All zeros) = 00000000000000000000000000000000, operand_B (All zeros) = 00000000000000000000000000000000, alu_control = 0101 (OR) 
# alu_result = 00000000000000000000000000000000, zero_flag = 1, overflow = 1, zero = 1, less = 0
# ========================================================================
# Test Case 20 (OR): operand_A (All ones) = 11111111111111111111111111111111, operand_B (All zeros) = 00000000000000000000000000000000, alu_control = 0101 (OR) 
# alu_result = 11111111111111111111111111111111, zero_flag = 0, overflow = 1, zero = 0, less = 1
# ========================================================================
# Test Case 21 (XOR): operand_A (All zeros) = 00000000000000000000000000000000, operand_B (All zeros) = 00000000000000000000000000000000, alu_control = 0110 (XOR) 
# alu_result = 00000000000000000000000000000000, zero_flag = 1, overflow = 1, zero = 1, less = 0
# ========================================================================
# Test Case 22 (XOR): operand_A (All zeros) = 00000000000000000000000000000000, operand_B (All ones) = 11111111111111111111111111111111, alu_control = 0110 (XOR) 
# alu_result = 11111111111111111111111111111111, zero_flag = 0, overflow = 1, zero = 0, less = 1
# ========================================================================
# Test Case 23 (NOR): operand_A (All zeros) = 00000000000000000000000000000000, operand_B (All zeros) = 00000000000000000000000000000000, alu_control = 1010 (NOR) 
# alu_result = 11111111111111111111111111111111, zero_flag = 0, overflow = 1, zero = 0, less = 1
# ========================================================================
# ** Note: $finish    : Testbench_ALU.sv(276)
#    Time: 330 ps  Iteration: 0  Instance: /Testbench_ALU