After adding the program counter module and test bench to your ModelSim project, simulate this test bench by running these commands in the ModelSim transcript:
# compile 
vlog ProgramCounter.v
vlog testbench_ProgramCounter.sv

# simulate
vsim -novopt work.testbench_ProgramCounter

# run
run -all

===========================================   OUTPUT  =======================================
# Starting program counter test...
# Program counter with reset: 00
# Program counter without reset, increment enabled: 0a
# Program counter without reset, increment enabled: 14
# Program counter without reset, increment enabled: 1e
# Program counter without reset, increment enabled: 28
# Program counter without reset, increment enabled: 32
# Program counter without reset, increment disabled: 32
# Program counter without reset, increment disabled: 32
# Program counter without reset, increment disabled: 32
# Program counter without reset, increment disabled: 32
# Program counter without reset again, increment enabled: 3c
# Program counter without reset again, increment enabled: 46
# Program counter without reset again, increment enabled: 50
# Program counter reset after run: 00
# Program counter without reset again, increment enabled: 0a
# Program counter without reset again, increment enabled: 14
# Program counter without reset again, increment enabled: 1e
# ** Note: $finish    : C:/Users/adels/Desktop/TestBenches/testbench_ProgramCounter/testbench_ProgramCounter.sv(123)
#    Time: 1700 ps  Iteration: 0  Instance: /testbench_ProgramCounter