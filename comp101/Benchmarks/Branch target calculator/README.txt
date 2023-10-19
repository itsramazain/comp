After adding the branch module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog branch.v
vlog testbench_Branch_Target_Calculator.sv

# Load the design
vsim -c testbench_Branch_Target_Calculator

# Set simulation options (adjust time if needed)
add wave -radix hex /testbench_Branch_Target_Calculator/*
run 2500ps

# Save and close the simulation
quit -sim

===========================================   OUTPUT  =======================================
# Testing Branch_Target_Calculator module...
# ==========================================
# Test Case 1: immediate (Positive immediate value) =  4660
# Test Case 1: program_counter = 2147483648
# Test Case 1: BT = 80001234
# ==========================================
# Test Case 2: immediate (Sign-extended to -1) = 65535
# Test Case 2: Program counter with +4 offset = 2147483652
# Test Case 2: BT = 80020003
# ==========================================
# Test Case 3: immediate (Sign-extended to 32767) = 32767
# Test Case 3: Program counter with +8 offset = 2147483656
# Test Case 3: BT = 80008007
# ==========================================
# Test Case 4: immediate (Sign-extended to 0) =     0
# Test Case 4: Program counter with +12 offset = 2147483660
# Test Case 4: BT = 8000000c
# ==========================================
# Test Case 5: immediate (Sign-extended to -32768) = 32768
# Test Case 5: Program counter with +16 offset = 2147483664
# Test Case 5: BT = 80018010
# ==========================================
# ** Note: $finish    : testbench_Branch_Target_Calculator.sv(69)
#    Time: 2500 ps  Iteration: 0  Instance: /testbench_Branch_Target_Calculator