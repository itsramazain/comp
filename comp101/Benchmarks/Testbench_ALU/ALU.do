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