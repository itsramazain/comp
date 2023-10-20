# Compile the design
vlog Mux2x1.v
vlog Testbench_Mux2x1.sv

# Load the design
vsim -c Testbench_Mux2x1

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_Mux2x1/*
run 1000ps

# Save and close the simulation
quit -sim

