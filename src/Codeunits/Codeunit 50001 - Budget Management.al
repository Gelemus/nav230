codeunit 50001 "Budget Management"
{

    trigger OnRun()
    begin
    end;

    local procedure UpdateGLBudgetEntries()
    begin
    end;

    local procedure CheckBudgetForImprest("Imprest No.": Code[20];"Imprest Line No.": Integer) BudgetAvailable: Boolean
    var
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
    begin
        BudgetAvailable:=false;
        if ImprestLine.FindFirst then begin
        end;
    end;
}

