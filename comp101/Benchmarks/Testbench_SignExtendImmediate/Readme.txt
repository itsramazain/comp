After adding the SignExtendImmediate module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog SignExtendImmediate.v
vlog Testbench_SignExtendImmediate.sv

# Load the design
vsim -c Testbench_SignExtendImmediate

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_SignExtendImmediate/*
run 1700ps

# Save and close the simulation
quit -sim


===========================================   OUTPUT  =======================================
# Test Case 1: instruction = 1234, sign-extended_imm = 00001234
# Test Case 2: instruction = ffff, sign-extended_imm = ffffffff
# Test Case 3: instruction = 7fff, sign-extended_imm = 00007fff
# Test Case 4: instruction = 0000, sign-extended_imm = 00000000
# Test Case 5: instruction = 8a12, sign-extended_imm = ffff8a12
# ** Note: $finish    : Testbench_SignExtendImmediate.sv(54)
#    Time: 80 ps  Iteration: 0  Instance: /Testbench_SignExtendImmediate