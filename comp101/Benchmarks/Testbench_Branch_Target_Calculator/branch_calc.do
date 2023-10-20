# Compile the design
vlog Branch_Target_Calculator.v
vlog Testbench_Branch_Target_Calculator.sv

# Load the design
vsim -c Testbench_Branch_Target_Calculator

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_Branch_Target_Calculator/*
run 2500ps

# Save and close the simulation
quit -sim