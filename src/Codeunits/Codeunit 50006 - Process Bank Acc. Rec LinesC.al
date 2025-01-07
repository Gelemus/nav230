codeunit 50006 "Process Bank Acc. Rec LinesC"
{
    Permissions = TableData "Data Exch."=rimd;
    TableNo = "Bank Acc. Statement Linevb";

    trigger OnRun()
    var
        PostingExch: Record "Data Exch.";
        ProcessPostingExch: Codeunit "Process Data Exch.";
        RecRef: RecordRef;
    begin
        PostingExch.Get(PostingExch."Entry No.");
        RecRef.GetTable(Rec);
        ProcessPostingExch.ProcessAllLinesColumnMapping(PostingExch,RecRef);
    end;

    var
        ProgressWindowMsg: Label 'Please wait while the operation is being completed.';

    procedure ImportBankStatement(BankAccRecon: Record "Bank Acc. Reconciliation";PostingExch: Record "Data Exch."): Boolean
    var
        BankAcc: Record "Bank Account";
        PostExchDef: Record "Data Exch. Def";
        PostExchMapping: Record "Data Exch. Mapping";
        PostExchLineDef: Record "Data Exch. Line Def";
        BankAccReconLine: Record "Bank Acc. Statement Linevb";
        ProgressWindow: Dialog;
    begin
        /*BankAcc.GET(BankAccRecon."Bank Account No.");
        BankAcc.GetDataExchDef(PostExchDef);
        
        IF NOT PostingExch.ImportToPostExch(PostExchDef)THEN
          EXIT(FALSE);
           //hazina
        ProgressWindow.OPEN(ProgressWindowMsg);
        
        CreateBankAccRecLineTemplate(BankAccReconLine,BankAccRecon,PostingExch);
        // Hazina PostExchLineDef.SETRANGE("Posting Exch. Def Code",PostExchDef.Code);
        PostExchLineDef.FINDFIRST;
        
        PostExchMapping.GET(PostExchDef.Code,PostExchLineDef.Code,DATABASE::"Bank Acc. Statement Linevb");
        
        IF PostExchMapping."Pre-Mapping Codeunit" <> 0 THEN
          CODEUNIT.RUN(PostExchMapping."Pre-Mapping Codeunit",BankAccReconLine);
        
        PostExchMapping.TESTFIELD("Mapping Codeunit");
        CODEUNIT.RUN(PostExchMapping."Mapping Codeunit",BankAccReconLine);
        
        IF PostExchMapping."Post-Mapping Codeunit" <> 0 THEN
          CODEUNIT.RUN(PostExchMapping."Post-Mapping Codeunit",BankAccReconLine);
        
        ProgressWindow.CLOSE;
        EXIT(TRUE);
        */

    end;

    local procedure CreateBankAccRecLineTemplate(var BankAccReconLine: Record "Bank Acc. Statement Linevb";BankAccRecon: Record "Bank Acc. Reconciliation";PostExch: Record "Data Exch.")
    begin
        BankAccReconLine.Init;
        BankAccReconLine."Statement Type" := BankAccRecon."Statement Type";
        BankAccReconLine."Statement No." := BankAccRecon."Statement No.";
        BankAccReconLine."Bank Account No." := BankAccRecon."Bank Account No.";
        BankAccReconLine."Posting Exch. Entry No." := PostExch."Entry No.";
    end;
}

