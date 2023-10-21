After adding the branchLogic module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog BranchLogic.v
vlog Testbench_Branch_Logic.sv

# Load the design
vsim -c Testbench_Branch_Logic

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_Branch_Logic/*
run 2500ps

# Save and close the simulation
quit -sim

# The sumulation will stop automatically, Dont close the program after finishing to see the output waves and transcript.

===========================================   OUTPUT  =======================================

# Scenario 1: brancheq and zero are true, expect branch_or_not to be true
# Scenario 1: branch_or_not = 1 (Expect 1)
# ========================================================================
# Scenario 2: branchnotequal and zero are false, expect branch_or_not to be false
# Scenario 2: branch_or_not = 1 (Expect 0)
# ========================================================================
# Scenario 3: brachlessthat and less are true, expect branch_or_not to be true
# Scenario 3: branch_or_not = 1 (Expect 1)
# ========================================================================
# Scenario 4: branchgreaterthanorequal, zero, and less are true, expect branch_or_not to be true
# Scenario 4: branch_or_not = 0 (Expect 1)
# ========================================================================
# Scenario 5: branchlessthanorequal, zero, and less are true, expect branch_or_not to be true
# Scenario 5: branch_or_not = 1 (Expect 1)
# ========================================================================
# Scenario 6: jal is true, expect branch_or_not to be true
# Scenario 6: branch_or_not = 1 (Expect 1)
# ========================================================================
# Scenario 7: All conditions are false, expect branch_or_not to be false
# Scenario 7: branch_or_not = 0 (Expect 0)
# ========================================================================
# ** Note: $finish    : Testbench_Branch_Logic.sv(80)
#    Time: 70 ps  Iteration: 0  Instance: /Testbench_Branch_Logic