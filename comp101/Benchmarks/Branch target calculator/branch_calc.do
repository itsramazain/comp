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