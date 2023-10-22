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
