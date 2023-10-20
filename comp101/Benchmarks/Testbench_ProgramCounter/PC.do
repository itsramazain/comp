# Compile the design
vlog ProgramCounter.v
vlog Testbench_ProgramCounter.sv

# Load the design
vsim -c Testbench_ProgramCounter

# Set simulation options (adjust time if needed)
add wave -radix hex /Testbench_ProgramCounter/*
run 1700ps

# Save and close the simulation
quit -sim