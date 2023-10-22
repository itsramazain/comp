After adding the d_flip_flop module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
# Compile the design
vlog d_flip_flop.v
vlog Testbench_flipflop.sv

# Load the design
vsim -c Testbench_flipflop

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_flipflop/*
run 2500ps

# Save and close the simulation
quit -sim

# The sumulation will stop automatically, Dont close the program after finishing to see the output waves and transcript.

===========================================   OUTPUT  =======================================

# Scenario 1: Testing D input with E active
# Q = 0
# Scenario 2: Testing D input with E inactive
# Q = 0
# Scenario 3: Testing D input with reset (E active)
# Q = 0
# Scenario 4: Testing D input with reset (E inactive)
# Q = 0
# ** Note: $finish    : Testbench_flipflop.sv(60)
#    Time: 40 ps  Iteration: 0  Instance: /Testbench_flipflop