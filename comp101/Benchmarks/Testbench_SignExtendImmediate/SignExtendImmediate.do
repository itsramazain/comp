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

