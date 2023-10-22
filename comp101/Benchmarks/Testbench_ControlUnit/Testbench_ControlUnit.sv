`timescale 1ns / 1ps

module Test_ControlUnit;
    reg clk;
    reg reset;
    reg [31:0] instruction;
    wire [3:0] alu_op;
    wire alu_src;
    wire reg_write_enable;
    wire mem_to_reg;
    wire [4:0] read_register_1;
    wire [4:0] read_register_2;
    wire [4:0] write_register;
    wire pc_increment;
    wire ram_read_enable;
    wire ram_write_enable;
    wire jump;
    wire branchnotequal;
    wire brachlessthat;
    wire branchgreaterthan;
    wire branchlessthanorequal;
    wire branchgreaterthanorequal;
    wire brancheq;
    wire jr;
    wire jal;

    // Instantiate the control unit
    ControlUnit control_unit (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .reg_write_enable(reg_write_enable),
        .mem_to_reg(mem_to_reg),
        .read_register_1(read_register_1),
        .read_register_2(read_register_2),
        .write_register(write_register),
        .pc_increment(pc_increment),
        .ram_read_enable(ram_read_enable),
        .ram_write_enable(ram_write_enable),
        .jump(jump),
        .branchnotequal(branchnotequal),
        .brachlessthat(brachlessthat),
        .branchgreaterthan(branchgreaterthan),
        .branchlessthanorequal(branchlessthanorequal),
        .branchgreaterthanorequal(branchgreaterthanorequal),
        .brancheq(brancheq),
        .jr(jr),
        .jal(jal)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test scenarios
    initial begin
        $dumpfile("ControlUnitTest.vcd");
        $dumpvars(0, Test_ControlUnit);

        // Reset the control unit
        reset = 1;
        clk = 0;
        instruction = 0;
        #10 reset = 0;

       // Scenario 1: ADD (R-type instruction)
instruction = 6'b000000_00000_00000_00100_100000; // ADD $4, $0, $0
#10;
$display("Scenario 1: ADD");
$display("ALU_OP = %b, ALU_SRC = %b, REG_WRITE_ENABLE = %b, ...", ALUOp, ALUSrc, RegWrite, ...);

// Add assertions to check control signals
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 1");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 1");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 1");
// Add more assertions for other control signals as needed
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 1");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 1");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 1");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 1");

// Scenario 2: LW (Load Word)
instruction = 6'b100011_00000_00000_00100_000001; // LW $4, 1($0)
#10;
$display("Scenario 2: LW");
$display("ALU_OP = %b, ALU_SRC = %b, REG_WRITE_ENABLE = %b, ...", ALUOp, ALUSrc, RegWrite, ...);

// Add assertions to check control signals
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 2");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 2");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 2");
// Add more assertions for other control signals as needed
assert(MemRead === 1'b1) else $display("MemRead is incorrect in Scenario 2");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 2");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 2");
assert(MemToReg === 1'b1) else $display("MemToReg is incorrect in Scenario 2");

// Scenario 3: SW (Store Word)
instruction = 6'b101011_00000_00000_00100_000001; // SW $4, 1($0)
#10;
$display("Scenario 3: SW");
$display("ALU_OP = %b, ALU_SRC = %b, REG_WRITE_ENABLE = %b, ...", ALUOp, ALUSrc, RegWrite, ...);

// Add assertions to check control signals
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 3");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 3");
assert(RegWrite === 1'b0) else $display("RegWrite is incorrect in Scenario 3");
// Add more assertions for other control signals as needed
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 3");
assert(MemWrite === 1'b1) else $display("MemWrite is incorrect in Scenario 3");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 3");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 3");

// Scenario 4: Jump (JUMP)
instruction = 6'b000010_00000_00000_00000_000000; // JUMP
#10;
$display("Scenario 4: JUMP");
$display("ALU_OP = %b, ALU_SRC = %b, REG_WRITE_ENABLE = %b, ...", ALUOp, ALUSrc, RegWrite, ...);

// Add assertions to check control signals
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 4");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 4");
assert(RegWrite === 1'b0) else $display("RegWrite is incorrect in Scenario 4");
// Add more assertions for other control signals as needed
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 4");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 4");
assert(Branch === 1'b1) else $display("Branch is incorrect in Scenario 4");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 4");

// Scenario 5: BEQ (Branch Equal)
instruction = 6'b000100_00000_00001_00010_000000; // BEQ $1, $2, target
#10;
$display("Scenario 5: BEQ");
$display("ALU_OP = %b, ALU_SRC = %b, REG_WRITE_ENABLE = %b, ...", ALUOp, ALUSrc, RegWrite, ...);

// Add assertions to check control signals
assert(ALUOp === 4'b0110) else $display("ALUOp is incorrect in Scenario 5");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 5");
assert(RegWrite === 1'b0) else $display("RegWrite is incorrect in Scenario 5");
// Add more assertions for other control signals as needed
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 5");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 5");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 5");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 5");

// Scenario 6: ADDI (Immediate)
instruction = 6'b001000_00000_00001_00100_000001; // ADDI $4, $1, 1
#10;
$display("Scenario 6: ADDI");
$display("ALU_OP = %b, ALU_SRC = %b, REG_WRITE_ENABLE = %b, ...", ALUOp, ALUSrc, RegWrite, ...);

// Add assertions to check control signals
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 6");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 6");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 6");
// Add more assertions for other control signals as needed
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 6");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 6");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 6");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 6");


// Scenario 7: SUB (R-type instruction)
instruction = 6'b000000_00001_00010_00100_100010; // SUB $4, $1, $2
#10;
$display("Scenario 7: SUB");
// Add assertions to check control signals
assert(RegDst === 1'b1) else $display("RegDst is incorrect");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect");
assert(MemRead === 1'b0) else $display("MemRead is incorrect");
assert(Branch === 1'b0) else $display("Branch is incorrect");
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect");

// Scenario 8: NOR (R-type instruction)
instruction = 6'b000000_00010_00011_00101_100111; // NOR $5, $3, $2
#10;
$display("Scenario 8: NOR");
// Add assertions to check control signals
assert(RegDst === 1'b1) else $display("RegDst is incorrect");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect");
assert(MemRead === 1'b0) else $display("MemRead is incorrect");
assert(Branch === 1'b0) else $display("Branch is incorrect");
assert(ALUOp === 4'b0110) else $display("ALUOp is incorrect");

// Scenario 9: ORI (Immediate)
instruction = 6'b001101_00011_00101_000110110101; // ORI $6, $5, 4389
#10;
$display("Scenario 9: ORI");
// Add assertions to check control signals here
assert(ALUOp === 4'b0011) else $display("ALUOp is incorrect in Scenario 9");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 9");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 9");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 9");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 9");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 9");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 9");

// Scenario 10: SLT (R-type instruction)
instruction = 6'b000000_00100_00111_00110_101010; // SLT $6, $7, $4
#10;
$display("Scenario 10: SLT");
// Add assertions to check control signals here
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 10");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 10");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 10");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 10");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 10");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 10");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 10");

// Scenario 11: BNE (Branch Not Equal)
instruction = 6'b000101_00100_00101_000100111101; // BNE $5, $4, target
#10;
$display("Scenario 11: BNE");
// Add assertions to check control signals here
assert(ALUOp === 4'b0110) else $display("ALUOp is incorrect in Scenario 11");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 11");
assert(RegWrite === 1'b0) else $display("RegWrite is incorrect in Scenario 11");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 11");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 11");
assert(Branch === 1'b1) else $display("Branch is incorrect in Scenario 11");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 11");

// Scenario 12: LUI (Load Upper Immediate)
instruction = 6'b001111_00000_00111_000000000101; // LUI $7, 5
#10;
$display("Scenario 12: LUI");
// Add assertions to check control signals here
assert(ALUOp === 4'b0011) else $display("ALUOp is incorrect in Scenario 12");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 12");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 12");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 12");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 12");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 12");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 12");

// Scenario 13: XORI (Immediate)
instruction = 6'b001110_00010_00011_011110110110; // XORI $3, $2, 398
#10;
$display("Scenario 13: XORI");
// Add assertions to check control signals here
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 13");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 13");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 13");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 13");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 13");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 13");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 13");

// Scenario 14: JALR (Jump and Link Register)
instruction = 6'b000000_00010_00011_00100_001001; // JALR $4, $2, $3
#10;
$display("Scenario 14: JALR");
// Add assertions to check control signals here
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 14");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 14");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 14");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 14");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 14");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 14");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 14");

// Scenario 15: SLTIU (R-type instruction)
instruction = 6'b000000_00110_00101_01000_101011; // SLTIU $8, $5, $6
#10;
$display("Scenario 15: SLTIU");
// Add assertions to check control signals here
assert(ALUOp === 4'b1111) else $display("ALUOp is incorrect in Scenario 15");
assert(ALUSrc === 1'b0) else $display("ALUSrc is incorrect in Scenario 15");
assert(RegWrite === 1'b1) else $display("RegWrite is incorrect in Scenario 15");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 15");
assert(MemWrite === 1'b0) else $display("MemWrite is incorrect in Scenario 15");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 15");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 15");

// Scenario 16: SB (Store Byte)
instruction = 6'b101000_00010_00011_000000000101; // SB $2, 5($3)
#10;
$display("Scenario 16: SB");
// Add assertions to check control signals here
assert(ALUOp === 4'b0010) else $display("ALUOp is incorrect in Scenario 16");
assert(ALUSrc === 1'b1) else $display("ALUSrc is incorrect in Scenario 16");
assert(RegWrite === 1'b0) else $display("RegWrite is incorrect in Scenario 16");
assert(MemRead === 1'b0) else $display("MemRead is incorrect in Scenario 16");
assert(MemWrite === 1'b1) else $display("MemWrite is incorrect in Scenario 16");
assert(Branch === 1'b0) else $display("Branch is incorrect in Scenario 16");
assert(MemToReg === 1'b0) else $display("MemToReg is incorrect in Scenario 16");




        // Finish simulation
        $finish;
    end
endmodule
