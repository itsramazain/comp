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