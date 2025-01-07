codeunit 50003 "Funds Approval Manager"
{

    trigger OnRun()
    begin
    end;

    var
        ApprovalEntryRec: Record "Approval Entry";
        FundsManagement: Codeunit "Funds Management";

    procedure ReleasePaymentHeader(var "Payment Header": Record "Payment Header")
    var
        PaymentHeader: Record "Payment Header";
        ApprovalEntryRec: Record "Approval Entry";
    begin

        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", "Payment Header"."No.");
        if PaymentHeader.FindFirst then begin
            PaymentHeader.Status := PaymentHeader.Status::Approved;
            PaymentHeader.Validate(PaymentHeader.Status);
            PaymentHeader.Modify;
            //Update approval entries
            ApprovalEntryRec.Reset;
            ApprovalEntryRec.SetRange("Document Type", ApprovalEntryRec."Document Type"::Payment);
            ApprovalEntryRec.SetRange("Document No.", "Payment Header"."No.");
            ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
            if ApprovalEntryRec.FindFirst then
                repeat
                    ApprovalEntryRec.Validate(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Approved);
                    ApprovalEntryRec.Modify;

                until ApprovalEntryRec.Next = 0;


        end;
    end;

    procedure ReOpenPaymentHeader(var "Payment Header": Record "Payment Header")
    var
        PaymentHeader: Record "Payment Header";
    begin
        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", "Payment Header"."No.");
        if PaymentHeader.FindFirst then begin
            PaymentHeader.Status := PaymentHeader.Status::Open;
            // PaymentHeader.VALIDATE(PaymentHeader.Status);
            PaymentHeader.Modify;
        end;
    end;

    procedure ReleaseReceiptHeader(var "Receipt Header": Record "Receipt Header")
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange(ReceiptHeader."No.", "Receipt Header"."No.");
        if ReceiptHeader.FindFirst then begin
            ReceiptHeader.Status := ReceiptHeader.Status::Released;
            ReceiptHeader.Validate(ReceiptHeader.Status);
            ReceiptHeader.Modify;
        end;
    end;

    procedure ReOpenReceiptHeader(var "Receipt Header": Record "Receipt Header")
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange(ReceiptHeader."No.", "Receipt Header"."No.");
        if ReceiptHeader.FindFirst then begin
            ReceiptHeader.Status := ReceiptHeader.Status::Open;
            ReceiptHeader.Validate(ReceiptHeader.Status);
            ReceiptHeader.Modify;
        end;
    end;

    procedure ReleaseFundsTransferHeader(var "Funds Transfer Header": Record "Funds Transfer Header")
    var
        FundsTransferHeader: Record "Funds Transfer Header";
    begin
        FundsTransferHeader.Reset;
        FundsTransferHeader.SetRange(FundsTransferHeader."No.", "Funds Transfer Header"."No.");
        if FundsTransferHeader.FindFirst then begin
            FundsTransferHeader.Status := FundsTransferHeader.Status::Released;
            FundsTransferHeader.Validate(FundsTransferHeader.Status);
            FundsTransferHeader.Modify;
        end;
    end;

    procedure ReOpenFundsTransferHeader(var "Funds Transfer Header": Record "Funds Transfer Header")
    var
        FundsTransferHeader: Record "Funds Transfer Header";
    begin
        FundsTransferHeader.Reset;
        FundsTransferHeader.SetRange(FundsTransferHeader."No.", "Funds Transfer Header"."No.");
        if FundsTransferHeader.FindFirst then begin
            FundsTransferHeader.Status := FundsTransferHeader.Status::Open;
            FundsTransferHeader.Validate(FundsTransferHeader.Status);
            FundsTransferHeader.Modify;
        end;
    end;

    procedure ReleaseImprestHeader(var "Imprest Header": Record "Imprest Header")
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "Imprest Header"."No.");
        if ImprestHeader.FindFirst then begin
            ImprestHeader.Status := ImprestHeader.Status::Approved;
            ImprestHeader.Validate(ImprestHeader.Status);
            ImprestHeader.Modify;
            //justo commit budget when last approver is approving.
            // if ("Imprest Header"."Purchase Requisition No" = '') or ("Imprest Header"."Low Value" = false) then begin
            //     FundsManagement.commitGLBudget(ImprestHeader);
            // end else begin
            //     ApprovalEntryRec.Reset;
            //     ApprovalEntryRec.SetRange("Document No.", "Imprest Header"."No.");
            //     ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
            //     if ApprovalEntryRec.FindFirst then
            //         repeat
            //             ApprovalEntryRec.Validate(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Approved);
            //             ApprovalEntryRec.Modify;

            //         until ApprovalEntryRec.Next = 0;

            // end;
        end;
    end;

    procedure ReOpenImprestHeader(var "Imprest Header": Record "Imprest Header")
    var
        ImprestHeader: Record "Imprest Header";
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", "Imprest Header"."No.");
        if ImprestHeader.FindFirst then begin
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader.Validate(ImprestHeader.Status);
            ImprestHeader.Modify;
        end;
    end;

    procedure ReleaseImprestSurrenderHeader(var "Imprest Surrender Header": Record "Imprest Surrender Header")
    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
    begin
        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        if ImprestSurrenderHeader.FindFirst then begin
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Released;
            ImprestSurrenderHeader.Validate(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.Modify;
            //Update approval entries
            ApprovalEntryRec.Reset;
            // ApprovalEntryRec.SETRANGE("Document Type",ApprovalEntryRec."Document Type":);
            ApprovalEntryRec.SetRange("Document No.", "Imprest Surrender Header"."No.");
            ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
            if ApprovalEntryRec.FindFirst then
                repeat
                    ApprovalEntryRec.Validate(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Approved);
                    ApprovalEntryRec.Modify;

                until ApprovalEntryRec.Next = 0;
        end;
    end;

    procedure ReOpenImprestSurrenderHeader(var "Imprest Surrender Header": Record "Imprest Surrender Header")
    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
    begin
        ImprestSurrenderHeader.Reset;
        ImprestSurrenderHeader.SetRange(ImprestSurrenderHeader."No.", "Imprest Surrender Header"."No.");
        if ImprestSurrenderHeader.FindFirst then begin
            ImprestSurrenderHeader.Status := ImprestSurrenderHeader.Status::Open;
            ImprestSurrenderHeader.Validate(ImprestSurrenderHeader.Status);
            ImprestSurrenderHeader.Modify;
        end;
    end;

    procedure ReleaseFundsClaim(var "Funds Claim Header": Record "Funds Claim Header")
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        FundsClaimHeader.Reset;
        FundsClaimHeader.SetRange(FundsClaimHeader."No.", "Funds Claim Header"."No.");
        if FundsClaimHeader.FindFirst then begin
            FundsClaimHeader.Status := FundsClaimHeader.Status::Released;
            FundsClaimHeader.Validate(FundsClaimHeader.Status);
            FundsClaimHeader.Modify;
        end;
    end;

    procedure ReOpenFundsClaim(var "Funds Claim Header": Record "Funds Claim Header")
    var
        FundsClaimHeader: Record "Funds Claim Header";
    begin
        FundsClaimHeader.Reset;
        FundsClaimHeader.SetRange(FundsClaimHeader."No.", "Funds Claim Header"."No.");
        if FundsClaimHeader.FindFirst then begin
            FundsClaimHeader.Status := FundsClaimHeader.Status::Open;
            FundsClaimHeader.Validate(FundsClaimHeader.Status);
            FundsClaimHeader.Modify;
        end;
    end;

    procedure ReleaseDocumentReversal(var DocumentReversalHeader: Record "Document Reversal Header")
    var
        DocumentReversalHeaders: Record "Document Reversal Header";
    begin
        DocumentReversalHeader.Reset;
        DocumentReversalHeader.SetRange(DocumentReversalHeader."No.", DocumentReversalHeaders."No.");
        if DocumentReversalHeader.FindFirst then begin
            DocumentReversalHeader.Status := DocumentReversalHeader.Status::Approved;
            DocumentReversalHeader.Validate(DocumentReversalHeader.Status);
            DocumentReversalHeader.Modify;
        end;
    end;

    procedure ReOpenDocumentReversal(var DocumentReversalHeader: Record "Document Reversal Header")
    var
        DocumentReversalHeaders: Record "Document Reversal Header";
    begin
        DocumentReversalHeader.Reset;
        DocumentReversalHeader.SetRange(DocumentReversalHeader."No.", DocumentReversalHeaders."No.");
        if DocumentReversalHeader.FindFirst then begin
            DocumentReversalHeader.Status := DocumentReversalHeader.Status::Open;
            DocumentReversalHeader.Validate(DocumentReversalHeader.Status);
            DocumentReversalHeader.Modify;
        end;
    end;

    procedure ReleaseJournalVoucher(var "Journal Voucher": Record "Journal Voucher Header")
    var
        JournalVoucherHeader: Record "Journal Voucher Header";
    begin
        JournalVoucherHeader.Reset;
        JournalVoucherHeader.SetRange(JournalVoucherHeader."JV No.", "Journal Voucher"."JV No.");
        if JournalVoucherHeader.FindFirst then begin
            JournalVoucherHeader.Status := JournalVoucherHeader.Status::Approved;
            JournalVoucherHeader.Validate(JournalVoucherHeader.Status);
            JournalVoucherHeader.Modify;

            //commit budget
            if ("Journal Voucher"."Requires Voting" = "Journal Voucher"."Requires Voting"::Yes) and ("Journal Voucher".Voted = false) then begin
                FundsManagement.CommitjounalVoucher("Journal Voucher");
            end else begin
                //Update approval entries
                ApprovalEntryRec.Reset;
                //ApprovalEntryRec.SETRANGE("Document Type",ApprovalEntryRec."Document Type"::Payment);
                ApprovalEntryRec.SetRange("Document No.", "Journal Voucher"."JV No.");
                ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
                if ApprovalEntryRec.FindFirst then
                    repeat
                        ApprovalEntryRec.Validate(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Approved);
                        ApprovalEntryRec.Modify;

                    until ApprovalEntryRec.Next = 0;

            end;
        end;
    end;

    procedure ReOpenJournalVoucher(var "Journal Voucher": Record "Journal Voucher Header")
    var
        JournalVoucherHeader: Record "Journal Voucher Header";
    begin
        JournalVoucherHeader.Reset;
        JournalVoucherHeader.SetRange(JournalVoucherHeader."JV No.", "Journal Voucher"."JV No.");
        if JournalVoucherHeader.FindFirst then begin
            JournalVoucherHeader.Status := JournalVoucherHeader.Status::Open;
            JournalVoucherHeader.Validate(JournalVoucherHeader.Status);
            JournalVoucherHeader.Modify;
        end;
    end;

    procedure ReleaseSalaryAdvance(var SalaryAdvance: Record "Salary Advance")
    var
        SalaryAdvanceRec: Record "Salary Advance";
    begin
        SalaryAdvanceRec.Reset;
        SalaryAdvanceRec.SetRange(SalaryAdvanceRec.ID, SalaryAdvance.ID);
        if SalaryAdvanceRec.FindFirst then begin
            SalaryAdvanceRec.Status := SalaryAdvanceRec.Status::Approved;
            SalaryAdvanceRec.Validate(SalaryAdvanceRec.Status);
            SalaryAdvanceRec.Modify;
        end;
    end;

    procedure ReOpenSalaryAdvance(var SalaryAdvance: Record "Salary Advance")
    var
        SalaryAdvanceRec: Record "Salary Advance";
    begin
        SalaryAdvanceRec.Reset;
        SalaryAdvanceRec.SetRange(SalaryAdvanceRec.ID, SalaryAdvance.ID);
        if SalaryAdvanceRec.FindFirst then begin
            SalaryAdvanceRec.Status := SalaryAdvanceRec.Status::Open;
            SalaryAdvanceRec.Validate(SalaryAdvanceRec.Status);
            SalaryAdvanceRec.Modify;
        end;
    end;

    procedure ReOpenTransferAllowanceHeader(var TransferAllowanceHeader: Record "Allowance Header")
    var
        TransferAllowanceHeaderRec: Record "Allowance Header";
    begin
        TransferAllowanceHeaderRec.Reset;
        TransferAllowanceHeaderRec.SetRange(TransferAllowanceHeaderRec."No.", TransferAllowanceHeader."No.");
        if TransferAllowanceHeaderRec.FindFirst then begin
            TransferAllowanceHeaderRec.Status := TransferAllowanceHeaderRec.Status::Open;
            TransferAllowanceHeaderRec.Validate(TransferAllowanceHeaderRec.Status);
            TransferAllowanceHeaderRec.Modify;
        end;
    end;

    procedure ReleaseTransferAllowanceHeader(var TransferAllowanceHeader: Record "Allowance Header")
    var
        TransferAllowanceHeaderRec: Record "Allowance Header";
    begin
        TransferAllowanceHeaderRec.Reset;
        TransferAllowanceHeaderRec.SetRange(TransferAllowanceHeaderRec."No.", TransferAllowanceHeader."No.");
        if TransferAllowanceHeaderRec.FindFirst then begin
            TransferAllowanceHeaderRec.Status := TransferAllowanceHeaderRec.Status::Approved;
            TransferAllowanceHeaderRec.Validate(TransferAllowanceHeaderRec.Status);
            TransferAllowanceHeaderRec.Modify;
        end;
    end;

    procedure ReleasePayroll(var Periods: Record Periods)
    var
        PeriodsRec: Record Periods;
    begin
        PeriodsRec.Reset;
        PeriodsRec.SetRange(PeriodsRec."Period ID", Periods."Period ID");
        PeriodsRec.SetRange("Payroll Code", Periods."Payroll Code");
        if PeriodsRec.FindFirst then begin
            PeriodsRec."Approval Status" := PeriodsRec."Approval Status"::Approved;
            PeriodsRec.Validate(PeriodsRec."Approval Status");
            PeriodsRec.Modify;
        end;
    end;

    procedure ReOpenPayroll(var Periods: Record Periods)
    var
        PeriodsRec: Record Periods;
    begin
        PeriodsRec.Reset;
        PeriodsRec.SetRange(PeriodsRec."Period ID", Periods."Period ID");
        PeriodsRec.SetRange("Payroll Code", Periods."Payroll Code");
        if PeriodsRec.FindFirst then begin
            PeriodsRec."Approval Status" := PeriodsRec."Approval Status"::Open;
            PeriodsRec.Validate(PeriodsRec."Approval Status");
            PeriodsRec.Modify;
        end;
    end;

    procedure ReOpenAllowanceHeader(var AllowanceHeader: Record "Allowance Header")
    var
        AllowanceHeaderRec: Record "Allowance Header";
    begin
        AllowanceHeaderRec.Reset;
        AllowanceHeaderRec.SetRange(AllowanceHeaderRec."No.", AllowanceHeader."No.");
        if AllowanceHeaderRec.FindFirst then begin
            AllowanceHeaderRec.Status := AllowanceHeaderRec.Status::Open;
            AllowanceHeaderRec.Validate(AllowanceHeaderRec.Status);
            AllowanceHeaderRec.Modify;
        end;
    end;
}