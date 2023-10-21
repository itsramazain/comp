After adding the RegisterFile module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog RegisterFile.v
vlog register.v
vlog flipflop.v
vlog Testbench_RegisterFile.sv

# Load the design
vsim -c Testbench_RegisterFile

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_RegisterFile/*
run 2500ps

# Save and close the simulation
quit -sim

# The sumulation will stop automatically, Dont close the program after finishing to see the output waves and transcript.

===========================================   OUTPUT  =======================================

# Scenario 1: Read data from register 1 = 0x00000000 (Expect 0xABCDEF12)
# Scenario 2: Read data from register 0 (Uninitialized) = 0x00000000 (Expect 0x00000000)
# ** Note: $finish    : Testbench_RegisterFile.sv(50)
#    Time: 30 ps  Iteration: 0  Instance: /Testbench_RegisterFile