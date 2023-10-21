# Compile the design
vlog RegisterFile.v
vlog Testbench_RegisterFile.sv

# Load the design
vsim -c Testbench_RegisterFile

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_RegisterFile/*
run 2500ps

# Save and close the simulation
quit -sim