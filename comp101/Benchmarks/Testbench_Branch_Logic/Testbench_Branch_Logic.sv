module Testbench_Branch_Logic;

    reg brancheq, branchnotequal, brachlessthat, branchgreaterthanorequal, branchlessthanorequal, jal, zero, less;
    wire branch_or_not;

    // Instantiate the BranchLogic module
    BranchLogic branch_logic (
        .brancheq(brancheq),
        .branchnotequal(branchnotequal),
        .brachlessthat(brachlessthat),
        .branchgreaterthanorequal(branchgreaterthanorequal),
        .branchlessthanorequal(branchlessthanorequal),
        .jal(jal),
        .zero(zero),
        .less(less),
        .branch_or_not(branch_or_not)
    );

    // Initial block for test scenarios
    initial begin
        // Scenario 1: brancheq and zero are true, expect branch_or_not to be true
        brancheq = 1;
        branchnotequal = 0;
        brachlessthat = 0;
        branchgreaterthanorequal = 0;
        branchlessthanorequal = 0;
        jal = 0;
        zero = 1;
        less = 0;
        #10;
        $display("Scenario 1: brancheq and zero are true, expect branch_or_not to be true");
        $display("Scenario 1: branch_or_not = %b (Expect 1)", branch_or_not);
$display("========================================================================");
        // Scenario 2: branchnotequal and zero are false, expect branch_or_not to be false
        brancheq = 0;
        branchnotequal = 1;
        zero = 0;
        #10;
        $display("Scenario 2: branchnotequal and zero are false, expect branch_or_not to be false");
        $display("Scenario 2: branch_or_not = %b (Expect 1)", branch_or_not);
$display("========================================================================");
        // Scenario 3: brachlessthat and less are true, expect branch_or_not to be true
        branchnotequal = 0;
        brachlessthat = 1;
        zero = 0;
        less = 1;
        #10;
        $display("Scenario 3: brachlessthat and less are true, expect branch_or_not to be true");
        $display("Scenario 3: branch_or_not = %b (Expect 1)", branch_or_not);
$display("========================================================================");
        // Scenario 4: branchgreaterthanorequal, zero, and less are true, expect branch_or_not to be true
        brachlessthat = 0;
        branchgreaterthanorequal = 1;
        zero = 1;
        #10;
        $display("Scenario 4: branchgreaterthanorequal, zero, and less are true, expect branch_or_not to be true");
        $display("Scenario 4: branch_or_not = %b (Expect 1)", branch_or_not);
$display("========================================================================");
        // Scenario 5: branchlessthanorequal, zero, and less are true, expect branch_or_not to be true
        branchgreaterthanorequal = 0;
        branchlessthanorequal = 1;
        #10;
        $display("Scenario 5: branchlessthanorequal, zero, and less are true, expect branch_or_not to be true");
        $display("Scenario 5: branch_or_not = %b (Expect 1)", branch_or_not);
$display("========================================================================");
        // Scenario 6: jal is true, expect branch_or_not to be true
        branchlessthanorequal = 0;
        jal = 1;
        #10;
        $display("Scenario 6: jal is true, expect branch_or_not to be true");
        $display("Scenario 6: branch_or_not = %b (Expect 1)", branch_or_not);
$display("========================================================================");
        // Scenario 7: All conditions are false, expect branch_or_not to be false
        jal = 0;
        #10;
        $display("Scenario 7: All conditions are false, expect branch_or_not to be false");
        $display("Scenario 7: branch_or_not = %b (Expect 0)", branch_or_not);
        $display("========================================================================");

        $finish; // Finish simulation
    end
endmodule
