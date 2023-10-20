# Compile the design
vlog ProgramCounter.v
vlog testbench_ProgramCounter.sv

# Load the design
vsim -c testbench_ProgramCounter

# Set simulation options (adjust time if needed)
add wave -radix hex /testbench_ProgramCounter/*
run 1700ps

# Save and close the simulation
quit -sim