After adding the branch module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog Branch_Target_Calculator.v
vlog Testbench_Branch_Target_Calculator.sv

# Load the design
vsim -c Testbench_Branch_Target_Calculator

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_Branch_Target_Calculator/*
run 2500ps

# Save and close the simulation
quit -sim

# The sumulation will stop automatically, Dont close the program after finishing to see the output waves and transcript.

===========================================   OUTPUT  =======================================
# Testing Branch_Target_Calculator module...
# ==========================================
# Test Case 1: immediate (Positive immediate value) = 1234
# Test Case 1: program_counter (8 bits) = 80
# Test Case 1: BT = b4
# ==========================================
# Test Case 2: immediate (Sign-extended to -1) = ffff
# Test Case 2: Program counter (8 bits) with +4 offset = 84
# Test Case 2: BT = 83
# ==========================================
# Test Case 3: immediate (Sign-extended to 32767) = 7fff
# Test Case 3: Program counter (8 bits) with +8 offset = 88
# Test Case 3: BT = 87
# ==========================================
# Test Case 4: immediate (Sign-extended to 0) = 0000
# Test Case 4: Program counter (8 bits) with +12 offset = 8c
# Test Case 4: BT = 8c
# ==========================================
# Test Case 5: immediate (Sign-extended to -32768) = 8000
# Test Case 5: Program counter (8 bits) with +16 offset = 90
# Test Case 5: BT = 90
# ==========================================
# ** Note: $finish    : Testbench_Branch_Target_Calculator.sv(69)
#    Time: 2500 ps  Iteration: 0  Instance: /Testbench_Branch_Target_Calculator