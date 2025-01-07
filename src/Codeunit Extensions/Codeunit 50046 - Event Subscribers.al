codeunit 50046 EventSubscribers
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    procedure OnAfterLogin()
    var
        payrollSelect: Codeunit "Table Code Transferred-Payroll";

    begin
        //Message('LOGINED IN');
        if GuiAllowed then
            payrollSelect.gsSetActivePayroll();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry.Payee := GenJournalLine.Payee;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    procedure OnBeforeCode231(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    begin
        IF GenJournalLine.HideDialog THEN HideDialog := TRUE;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnBeforeCode', '', false, false)]
    // procedure OnBeforeCode241(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    // begin
    //     IF ItemJournalLine.HideDialog THEN HideDialog := TRUE;
    //     IsHandled := false;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnConditionalCardPageIDNotFound', '', false, false)]
    procedure OnConditionalCardPageIDNotFound(RecordRef: RecordRef; var CardPageID: Integer)
    var
        ImprestHeader: Record "Imprest Header";
        PaymentHeader: Record "Payment Header";

    begin
        CASE RecordRef.NUMBER OF
            DATABASE::"Imprest Header":
                begin
                    RecordRef.SETTABLE(ImprestHeader);
                    CASE ImprestHeader."Document Type" OF
                        ImprestHeader."Document Type"::Imprest:
                            CardPageID := PAGE::"Imprest Card";
                        ImprestHeader."Document Type"::"Petty Cash":
                            CardPageID := PAGE::"Petty Cash Card";
                        ImprestHeader."Document Type"::"Casuals Payment":
                            CardPageID := PAGE::"Casuals Payment Card";
                    END;
                end;
            DATABASE::"HR Leave Reimbursement":
                CardPageID := PAGE::"Leave Reimbursment Card";

            DATABASE::"HR Leave Planner Header":
                CardPageID := PAGE::"Leave Planner Card";

            DATABASE::"Payment Header":
                begin
                    //CardPageID := GetPaymentHeaderPageID(RecordRef);
                    RecordRef.SETTABLE(PaymentHeader);
                    CASE PaymentHeader."Payment Type" OF
                        PaymentHeader."Payment Type"::"Cash Payment":
                            CardPageID := PAGE::"Cash Payment Card";
                        PaymentHeader."Payment Type"::"Cheque Payment":
                            CardPageID := PAGE::"Payment Card";
                    END;
                end;

            DATABASE::Periods:
                CardPageID := PAGE::"Payroll Period Card1";

            DATABASE::"Purchase Requisitions":
                CardPageID := PAGE::"Requisition Card";
            DATABASE::"Store Requisition Header":
                CardPageID := PAGE::"Store Requisition Card";

            DATABASE::"Imprest Surrender Header":
                CardPageID := PAGE::"Imprest Surrender Card";

            DATABASE::"HR Leave Application":
                CardPageID := PAGE::"Leave Application Card";

            DATABASE::"Transport Request":
                CardPageID := PAGE::"Transport Request Card";

            DATABASE::"HR Employee Requisitions":
                CardPageID := PAGE::"Casual Requisition Card";

            DATABASE::"Journal Voucher Header":
                CardPageID := PAGE::"Journal Voucher";

            DATABASE::"Inspection Header":
                CardPageID := PAGE::"Inspection Card";

            DATABASE::"HR Training Applications":
                CardPageID := PAGE::"Training Application Card";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Management", 'OnGetDocumentTypeAndNumber', '', false, false)]
    procedure OnGetDocumentTypeAndNumber(var RecRef: RecordRef; var DocumentType: Text; var DocumentNo: Text; var IsHandled: Boolean)
    var
        FieldRef: FieldRef;
    begin
        CASE RecRef.NUMBER OF

            //FRS ADD ON>>1O2619
            //Sysre NextGen Addon
            //-----------------------------------Funds Management Documents------------------------
            //Payment Header
            DATABASE::"Payment Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Receipt Header

            DATABASE::"Receipt Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Funds Transfer Header
            DATABASE::"Funds Transfer Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Imprest Header
            DATABASE::"Imprest Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Imprest Surrender Header
            DATABASE::"Imprest Surrender Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Funds Claim Header
            DATABASE::"Funds Claim Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //---------------------------------End Funds Management Documents----------------------

            //--------------------------------Procurement Management Documents---------------------
            //Purchase Requisition
            DATABASE::"Purchase Requisitions":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Bid Analysis
            DATABASE::"Bid Analysis Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Store Requisition
            DATABASE::"Store Requisition Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //------------------------------End Procurement Management Documents--------------------
            //-----------------------------------HR Management Documents----------------------------
            //HR Job
            DATABASE::"HR Jobs":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Employee Requisition
            DATABASE::"HR Employee Requisitions":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //Journal Voucher
            DATABASE::"Journal Voucher Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(10);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Job Application
            DATABASE::"HR Job Applications":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Employee Appraisal Header
            DATABASE::"HR Employee Appraisal Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Leave Planner Header
            DATABASE::"HR Leave Planner Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Leave Application
            DATABASE::"HR Leave Application":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Leave Reimbusment
            DATABASE::"HR Leave Reimbursement":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Leave Carryover
            DATABASE::"HR Leave Carryover":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
            //HR Leave Allocation Header
            DATABASE::"HR Leave Allocation Header":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                END;
        //FRS ADD ON 102619<<
        end;
        IsHandled := true
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', false, false)]
    procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    begin
        TransShptHeader."Shipped By" := USERID;
        TransShptHeader."Date Shipped" := TODAY;
        TransShptHeader."Time Shipped" := TIME;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransRcptHeaderInsert', '', false, false)]
    procedure OnBeforeTransRcptHeaderInsert(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Received By" := USERID;
        TransferReceiptHeader."Date Received" := TODAY;
        TransferReceiptHeader."Time Received" := TIME;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"File Management",'OnBeforeUploadFileWithFilter','',false,false)]
     procedure OnBeforeUploadFileWithFilter(var ServerFileName: Text; WindowTitle: Text[50]; ClientFileName: Text; FileFilter: Text; ExtFilter: Text; var IsHandled: Boolean)
    begin
        
    end;
}
