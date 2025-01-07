page 50065 "FD Transfer Term Amount Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "FD Processing";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Editable;
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("FD Account"; Rec."FD Account")
                {
                }
                field("FD Account Name"; Rec."FD Account Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group("Term Deposit Details")
            {
                Caption = 'Term Deposit Details';
                Editable = Editable;
                Visible = true;
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    Editable = false;
                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    Visible = false;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                }
                field("Untranfered Interest"; Rec."Untranfered Interest")
                {
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                }
                field("FD Amount"; Rec."FD Amount")
                {
                }
                field("Last Interest Earned Date"; Rec."Last Interest Earned Date")
                {
                    Editable = false;
                }
                field("Expected Interest On Term Dep"; Rec."Expected Interest On Term Dep")
                {
                    Editable = false;
                }
                field("On Term Deposit Maturity"; Rec."On Term Deposit Maturity")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Approval)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := DocumentType::FixedDeposits;
                    //ApprovalEntries.Setfilters(DATABASE::Table70000, DocumentType, Rec."Document No.");
                    ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Text001: Label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //TESTFIELD("Global Dimension 1 Code");
                    //TESTFIELD("Global Dimension 2 Code");
                    Rec.TestField("FD Account");
                    Rec.TestField("FD Amount");

                    //IF ApprovalsMgmt.CheckFixedDepositWorkflowEnabled(Rec) THEN
                    // ApprovalsMgmt.OnSendFixedDepositForApproval(Rec);
                    Rec.Status := Rec.Status::Approved;
                    Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Active;
                    Rec.Modify;
                    Message('Succefully Approved!');
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error(Text0001)
                    else
                        //IF ApprovalsMgmt.CheckFixedDepositWorkflowEnabled(Rec) THEN
                        ; // ApprovalsMgmt.OnCancelFixedDepositApprovalRequest(Rec);
                end;
            }
        }
        area(processing)
        {
            action("Calculate Interest")
            {
                Caption = 'Calculate Interest';
                Promoted = true;
                RunObject = Report "Generate Interest-Fixed New1.";

                trigger OnAction()
                begin
                    /*AccountTypes.RESET;
                    AccountTypes.SETRANGE(AccountTypes.Code,"Account Type");
                    IF AccountTypes.FIND('-') THEN  BEGIN
                    
                    IF Vend.GET("Savings Account No.") THEN BEGIN
                      */


                    /*
                    IF CONFIRM('Are you sure you want to effect the transfer from the Current account',FALSE) = FALSE THEN
                    EXIT;
                    
                    BATCH_TEMPLATE:='PURCHASES';
                    BATCH_NAME:='TERM';
                    DOCUMENT_NO:="Document No.";
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'TERM');
                    IF GenJournalLine.FIND('-') THEN
                    GenJournalLine.DELETEALL;
                    
                    IF Vend.GET("Savings Account No.") THEN BEGIN
                    Vend.CALCFIELDS(Vend.Balance);
                    IF Vend.Balance<"FD Amount" THEN
                     ERROR('You do not have sufficient funds in your current account to effect the transfer');
                    
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,"On Term Deposit Maturity",
                    GenJournalLine."Account Type"::"Bank Account","Savings Account No.",TODAY,"FD Amount"*-1,'FOSA',"Document No.",
                    'Transfered to FD','');
                    
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,"On Term Deposit Maturity",
                    GenJournalLine."Account Type"::"Bank Account","FD Account",TODAY,"FD Amount" ,'FOSA',"Document No.",
                    'Transfered From SAVINGS','');
                    END;
                    //END;
                    
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                    GenJournalLine.SETRANGE("Journal Batch Name",'TERM');
                    IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                    END;
                    Posted:=TRUE;
                    "Date Posted":=TODAY;
                    "FDR Deposit Status Type":="FDR Deposit Status Type"::Running;
                    "Fixed Deposit Status":="Fixed Deposit Status"::Active;
                    "Fixed Deposit Start Date":=TODAY;
                    VALIDATE("Fixed Deposit Start Date");
                    MODIFY;
                    
                    {ObjFDProcessing.RESET;
                    IF ObjFDProcessing.FIND('-') THEN
                     REPORT.RUN(51516711,FALSE,FALSE,ObjFDProcessing);
                     }
                     */

                end;
            }
            action("Activate FD")
            {
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Activate the FD term?', false) = false then
                        exit;

                    Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Active;
                    Rec.Modify;
                    Message('Fixed Deosit Activated Succesfully');
                end;
            }
            action("Interest Buffer Lines")
            {
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Interest Buffer FD";
                RunPageLink = "Document No." = FIELD("Document No.");
            }
            action("Fixed Deposit Bids")
            {
                Image = Aging;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Fixed Deposit Bids";
                RunPageLink = "Document No" = FIELD("Document No.");
            }
            action("FD Bid Analysis Report")
            {
                Caption = 'FD Bid Analysis Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    FDProcessing.Reset;
                    FDProcessing.SetRange(FDProcessing."Document No.", Rec."Document No.");
                    if FDProcessing.FindFirst then begin
                        REPORT.RunModal(REPORT::"FD Bid Analysis", true, false, FDProcessing);
                    end;
                end;
            }
            action("Recall Fixed Deposit")
            {
                Image = Migration;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm(Txt060) = false then exit;

                    FDProcessing.Reset;
                    FDProcessing.SetRange(FDProcessing."Document No.", Rec."Document No.");
                    if FDProcessing.FindFirst then begin
                        REPORT.RunModal(REPORT::"Post FD Monthly Interest", false, false, FDProcessing);
                    end;


                    Rec."Fixed Deposit Status" := Rec."Fixed Deposit Status"::Closed;
                    Rec.Modify;
                    Message(Text123);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        fnUpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        /*FDRec.RESET;
        FDRec.SETRANGE(FDRec."User ID",USERID);
        FDRec.SETRANGE(FDRec.Status,FDRec.Status::New);
        IF FDRec.COUNT > 0 THEN ERROR('Cannot create a new FD card while an unutilized one exists.');
        */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Application Date" := Today;
        Rec."User ID" := UserId;
        Rec."Global Dimension 1 Code" := 'FOSA';
        Rec."Account Type" := 'FIXED';

        fnUpdateControls();
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        PictureExists: Boolean;
        AccountTypes: Record "FD Processing";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record "Bank Account";
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        UnclearedLoan: Decimal;
        LineN: Integer;
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Funds General Setup";
        ObjFDProcessing: Record "FD Processing";
        ObjGroup: Boolean;
        undisplay: Integer;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text0001: Label 'Status must be pending Approval';
        Editable: Boolean;
        FDRec: Record "FD Processing";
        SFactory: Codeunit "Funds Management";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,FixedDeposits,CloudPesaApps,AgentApps,LoanOfficerDetails,GuarantorSub,PettyCash,PaybillChanges;
        FDProcessing: Record "FD Processing";
        Txt060: Label 'Are you sure you want to recall this Fixed deposit? Recalling the FD will  transfer the existing earned interest to income and mark this FD as closed.';
        Text123: Label 'Fixed Deposit Successfully recalled and closed.';

    local procedure fnUpdateControls()
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::"Pending Approval") then
            Editable := false
        else
            Editable := true;
    end;
}

