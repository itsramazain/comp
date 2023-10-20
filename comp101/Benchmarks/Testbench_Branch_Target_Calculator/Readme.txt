After adding the program counter module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript or use the DO script included:
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


===========================================   OUTPUT  =======================================
# Starting program counter test...
# ================================
# Program counter with reset: 00
# ================================
# Program counter without reset, increment enabled: 0a
# Program counter without reset, increment enabled: 14
# Program counter without reset, increment enabled: 1e
# Program counter without reset, increment enabled: 28
# Program counter without reset, increment enabled: 32
# ==========================================================
# Program counter without reset, increment disabled: 32
# Program counter without reset, increment disabled: 32
# Program counter without reset, increment disabled: 32
# Program counter without reset, increment disabled: 32
# ==========================================================
# Program counter without reset again, increment enabled: 3c
# Program counter without reset again, increment enabled: 46
# Program counter without reset again, increment enabled: 50
# ==========================================================
# Program counter reset after run: 00
# ==========================================================
# Program counter without reset again, increment enabled: 0a
# Program counter without reset again, increment enabled: 14
# Program counter without reset again, increment enabled: 1e
# ==========================================================
# ** Note: $finish    : testbench_ProgramCounter.sv(128)
#    Time: 1700 ps  Iteration: 0  Instance: /testbench_ProgramCounter