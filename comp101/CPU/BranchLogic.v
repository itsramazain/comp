module BranchLogic (
    input wire brancheq,
    input wire branchnotequal,
    input wire brachlessthat,
    input wire branchgreaterthanorequal,
    input wire branchlessthanorequal,
    input wire jal,
    input wire zero,
    input wire less,
    output wire branch_or_not
);

assign branch_or_not = 
    (brancheq & zero) || 
    (branchnotequal & ~zero) || 
    (brachlessthat & less) || 
    (branchgreaterthanorequal & (zero & ~less)) || 
    (branchlessthanorequal & (zero & less)) || 
    (jal);

endmodule