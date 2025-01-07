codeunit 50007 "Procurement Management"
{

    trigger OnRun()
    begin
    end;

    var
        ReqLines: Record "Purchase Line";
        ItemLedgeEntries: Record "Item Ledger Entry";
        "LineNo.": Integer;
        LocationCode: Code[10];
        RHeader: Record "Purchase Header";
        Txt_001: Label 'Empty Purchase Requisition Line';
        Txt_002: Label 'Empty Request for Quotation Line';
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        RequestforQuotationVendor: Record "Request for Quotation Vendors";
        BCSetup: Record "Budget Control Setup";
        Text0001: Label 'You Have exceeded the Budget by ';
        Text0002: Label 'Do you want to Continue?';
        Text0003: Label 'There is no Budget to Check against do you wish to continue?';
        Text0004: Label 'The Documet Date %1 In The Purchase Requisition Does Not Fall Within Budget Dates %2 - %3';
        Text0005: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0006: Label 'No Budget To Check Against';
        Text0007: Label 'Item Does not Exist';
        Text0008: Label 'Ensure Fixed Asset No %1 has the Maintenance G/L Account';
        Text0009: Label 'Ensure Fixed Asset No %1 has the Acquisition G/L Account';
        Text0010: Label 'The Amount On Exceed Budget by %1 .Kindly request assistance from Finance';
        Text0011: Label 'The Amount On Purchase Requisition No %1  %2 %3  Exceeds The Budget By %4 ,Kindly request assistance from Finance';
        BudgetGL: Code[20];
        // SMTP: Record "SMTP Mail Setup";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        FASubclassRec: Record "FA Subclass";
        GLAccount: Record "G/L Account";

    procedure CheckPurchaseRequisitionMandatoryFields(PurchaseRequisition: Record "Purchase Requisitions")
    var
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
    begin
        PurchaseRequisitionHeader.TransferFields(PurchaseRequisition);
        PurchaseRequisitionHeader.TestField("Document Date");
        PurchaseRequisitionHeader.TestField(Description);
        PurchaseRequisitionHeader.TestField("Global Dimension 1 Code");

        PurchaseRequisitionLine.Reset;
        PurchaseRequisitionLine.SetRange(PurchaseRequisitionLine."Document No.", PurchaseRequisitionHeader."No.");
        if PurchaseRequisitionLine.FindSet then begin
            repeat
                PurchaseRequisitionLine.TestField("Requisition Code");
                PurchaseRequisitionLine.TestField(Quantity);
                PurchaseRequisitionLine.TestField("Global Dimension 1 Code");
                PurchaseRequisitionLine.TestField("Global Dimension 2 Code");
                PurchaseRequisitionLine.TestField("Shortcut Dimension 3 Code");
                PurchaseRequisitionLine.TestField("Shortcut Dimension 4 Code");
                PurchaseRequisitionLine.TestField("Shortcut Dimension 5 Code");
                PurchaseRequisitionLine.TestField("Shortcut Dimension 6 Code");
            until PurchaseRequisitionLine.Next = 0;
        end else begin
            Error(Txt_001);
        end;
    end;

    procedure CheckRequestforQuotationVendors()
    begin
    end;

    procedure CheckRequestforQuotationMandatoryFields(RequestforQuotation: Record "Request for Quotation Header")
    var
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        RequestforQuotationHeader.TransferFields(RequestforQuotation);
        RequestforQuotationHeader.TestField("Document Date");
        RequestforQuotationHeader.TestField(Description);

        RequestforQuotationLine.Reset;
        RequestforQuotationLine.SetRange(RequestforQuotationLine."Document No.", RequestforQuotationHeader."No.");
        if RequestforQuotationLine.FindSet then begin
            repeat
                RequestforQuotationLine.TestField("Requisition Code");
                RequestforQuotationLine.TestField("No.");
                RequestforQuotationLine.TestField(Quantity);
                RequestforQuotationLine.TestField(Description);
            //  RequestforQuotationLine.TESTFIELD("Global Dimension 1 Code");
            // RequestforQuotationLine.TESTFIELD("Global Dimension 2 Code");

            until RequestforQuotationLine.Next = 0;
        end else begin
            Error(Txt_002);
        end;
    end;

    procedure CheckBidAnalysisMandatoryFields("Bid Analysis": Record "Bid Analysis")
    var
        BidAnalysis: Record "Bid Analysis";
        BidAnalysisLine: Record "Bid Analysis Line";
    begin
    end;

    procedure SendRequestforQuotationToVendor("RFQ No.": Code[20])
    begin
        // SMTPMailSetup.Get;
        // Clear(SMTPMail);

        // RequestforQuotationVendor.Reset;
        // RequestforQuotationVendor.SetRange(RequestforQuotationVendor."RFQ Document No.","RFQ No.");
        // if RequestforQuotationVendor.FindSet then begin
        //   repeat
        //     SMTPMail.AddBCC(RequestforQuotationVendor."Vendor Email Address");
        //   until RequestforQuotationVendor.Next=0;
        // end;
        // SMTPMail.AddAttachment('','');
        // SMTPMail.TrySend();
    end;

    procedure CreatePurchaseQuoteLinesfromRFQ(PurchaseHeader: Record "Purchase Header"; "RequestforQuotationNo.": Code[20])
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        RequestforQuotationHeader: Record "Request for Quotation Header";
        RequestforQuotationLine: Record "Request for Quotation Line";
    begin
        PurchaseLine.Reset;
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet then begin
            PurchaseLine.DeleteAll;
        end;
        Commit;

        "LineNo." := 1000;
        RequestforQuotationLine.Reset;
        RequestforQuotationLine.SetRange("Document No.", "RequestforQuotationNo.");
        RequestforQuotationLine.SetRange(Status, RequestforQuotationLine.Status::Released);
        if RequestforQuotationLine.FindSet then begin
            repeat
                "LineNo." := "LineNo." + 1;
                PurchaseLine2.Init;
                PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Quote;
                PurchaseLine2.Validate("Document Type");
                PurchaseLine2."Document No." := PurchaseHeader."No.";
                PurchaseLine2.Validate("Document No.");
                PurchaseLine2."Line No." := "LineNo.";
                PurchaseLine2.Validate("Line No.");
                PurchaseHeader.TestField("Buy-from Vendor No.");
                PurchaseLine2."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                PurchaseLine2.Validate("Buy-from Vendor No.");
                PurchaseLine2.Type := RequestforQuotationLine.Type;
                PurchaseLine2.Validate(Type);
                PurchaseLine2."No." := RequestforQuotationLine."No.";
                PurchaseLine2.Validate("No.");
                PurchaseLine2."Location Code" := RequestforQuotationLine."Location Code";
                PurchaseLine2.Validate("Location Code");
                PurchaseLine2.Quantity := RequestforQuotationLine.Quantity;
                PurchaseLine2.Validate(Quantity);
                PurchaseLine2."Unit of Measure Code" := RequestforQuotationLine."Unit of Measure Code";
                PurchaseLine2.Validate("Unit of Measure Code");
                PurchaseLine2."Direct Unit Cost" := RequestforQuotationLine."Unit Cost";
                PurchaseLine2.Validate("Direct Unit Cost");
                PurchaseLine2.Remarks := RequestforQuotationLine.Description;
                PurchaseLine2."Shortcut Dimension 1 Code" := RequestforQuotationLine."Global Dimension 1 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 1 Code");
                PurchaseLine2."Shortcut Dimension 2 Code" := RequestforQuotationLine."Global Dimension 2 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 2 Code");
                PurchaseLine2."Shortcut Dimension 3 Code" := RequestforQuotationLine."Shortcut Dimension 3 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 3 Code");
                PurchaseLine2."Shortcut Dimension 4 Code" := RequestforQuotationLine."Shortcut Dimension 4 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 4 Code");
                PurchaseLine2."Shortcut Dimension 5 Code" := RequestforQuotationLine."Shortcut Dimension 5 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 5 Code");
                PurchaseLine2."Shortcut Dimension 6 Code" := RequestforQuotationLine."Shortcut Dimension 6 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 6 Code");
                PurchaseLine2."Shortcut Dimension 7 Code" := RequestforQuotationLine."Shortcut Dimension 7 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 7 Code");
                PurchaseLine2."Shortcut Dimension 8 Code" := RequestforQuotationLine."Shortcut Dimension 8 Code";
                PurchaseLine2.Validate(PurchaseLine2."Shortcut Dimension 8 Code");
                PurchaseLine2.Insert;
            until RequestforQuotationLine.Next = 0;
        end;
    end;

    procedure DecommitBudgetPurchaseReq(var PurchHeader: Record "Purchase Requisitions")
    var
        PurchLine: Record "Purchase Requisition Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") or (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, PurchHeader."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        PurchHeader.TestField(Voted, false);
        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.FindSet then begin
            repeat
                //Items
                if PurchLine.Type = PurchLine.Type::Item then begin
                    Items.Reset;
                    if not Items.Get(PurchLine."No.") then
                        Error(Text0007);
                    Items.TestField("Item G/L Budget Account");
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //Fixed Asset
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAssets.Reset;
                    FixedAssets.SetRange(FixedAssets."No.", PurchLine."No.");
                    if FixedAssets.FindFirst then begin
                        FAPostingGroup.Reset;
                        FAPostingGroup.SetRange(FAPostingGroup.Code, FixedAssets."FA Posting Group");
                        if FAPostingGroup.FindFirst then
                            if PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance then begin
                                BudgetGL := FAPostingGroup."Maintenance Expense Account";
                                if BudgetGL = '' then
                                    Error(Text0008, PurchLine."No.");
                            end else begin
                                BudgetGL := FAPostingGroup."Acquisition Cost Account";
                                if BudgetGL = '' then
                                    Error(Text0009, PurchLine."No.");
                            end;
                    end;
                end;

                //G/L Account
                if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
                    BudgetGL := PurchLine."No.";
                    if GLAccount.Get(PurchLine."No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;

                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(PurchHeader."Document Date", 2), Date2DMY(PurchHeader."Document Date", 3));
                CurrMonth := Date2DMY(PurchHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PurchHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PurchHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //check the summation of the budget
                BudgetAmount := 0;
                // ActualsAmount:=0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;
                //get the netchange/actuals
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", BudgetGL);
                GLAccount.SETFILTER("Date Filter", '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");// GLAccount.SETFILTER("Date Filter",'%1..%2',FirstDay,LastDay);
                IF GLAccount.FINDSET THEN
                    GLAccount.CALCFIELDS("Net Change");
                ActualsAmount := GLAccount."Net Change";

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010, BudgetAmount - CommitmentAmount);

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PurchLine."Total Cost(LCY)") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + PurchLine."Total Cost"))));
                    //END ELSE BEGIN

                end;
            until PurchLine.Next = 0;
            PurchHeader."Passed Budget" := true;
            PurchHeader.Modify;
        end;
    end;

    procedure CancelBudgetCommitmentPurchaseRequisition(PurchHeader: Record "Purchase Requisitions")
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        PurchLine: Record "Purchase Requisition Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        CommitmentAmount: Decimal;
    begin
        Clear(BudgetAmount);
        BudgetGL := '';
        BCSetup.Get();
        PurchHeader.TestField(Voted, true);
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange(Committed, true);
        if PurchLine.FindSet then begin
            CommitmentAmount := 0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
            Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount := Commitments.Amount;


            if PurchLine.Type = PurchLine.Type::Item then
                if Items.Get(PurchLine."No.") then
                    BudgetGL := Items."Item G/L Budget Account"
                else if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                    if FixedAsset.Get(PurchLine."No.") then
                        FAPostingGroup.Reset;
            FAPostingGroup.SetRange(Code, FixedAsset."FA Posting Group");
            if FAPostingGroup.FindFirst then
                BudgetGL := FAPostingGroup."Acquisition Cost Account"
            else if PurchLine.Type = PurchLine.Type::"G/L Account" then
                BudgetGL := PurchLine."No.";

            repeat
                BudgetAmount := PurchLine.Quantity * PurchLine."Unit Cost";
                Commitments.Reset;
                Commitments.Init;
                Commitments."Line No." := 0;
                Commitments.Date := PurchHeader."Document Date";
                Commitments."Posting Date" := Today;
                Commitments."Document Type" := Commitments."Document Type"::Requisition;
                Commitments."Document No." := PurchHeader."No.";
                Commitments.Amount := -PurchLine."Total Cost(LCY)";
                Commitments."Month Budget" := BudgetAmount;
                Commitments.Committed := false;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := Today;
                Commitments."G/L Account No." := BudgetGL;
                Commitments."Committed Time" := Time;
                Commitments.Cancelled := true;
                if GLAccount.Get(Commitments."G/L Account No.") then
                    Commitments."Gl Name" := GLAccount.Name;
                Commitments."Cancelled By" := UserId;
                Commitments."Cancelled Date" := Today;
                Commitments."Shortcut Dimension 1 Code" := PurchLine."Global Dimension 1 Code";
                Commitments."Shortcut Dimension 2 Code" := PurchLine."Global Dimension 2 Code";
                Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                Commitments.Committed := true;
                Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + PurchLine."Total Cost(LCY)");
                Commitments.Budget := BCSetup."Current Budget Code";
                if Commitments.Insert then begin
                    PurchLine.Committed := false;
                    PurchLine.Modify;
                end;
            until PurchLine.Next = 0;
            PurchHeader.Voted := false;
            PurchHeader.Modify;
        end;

    end;

    procedure CheckIfGLAccountBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked, false);
    end;

    procedure SenderTenderEvaluationEmail(TenderNo: Code[30])
    var
        TenderEvaluators: Record "Tender Evaluators";
    begin
        // SMTP.Get;
        // TenderEvaluators.Reset;
        // TenderEvaluators.SetRange(TenderEvaluators."Tender No",TenderNo);
        // TenderEvaluators.SetFilter(TenderEvaluators."E-Mail",'<>%1','');
        // if TenderEvaluators.FindSet then begin
        //   repeat
        //     SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."User ID",TenderEvaluators."E-Mail",'Tender Evaluation - '+TenderEvaluators."Tender No",'',true);
        //     SMTPMail.AppendBody('Dear'+' '+TenderEvaluators."Evaluator Name"+',');
        //     SMTPMail.AppendBody('<br><br>');
        //     SMTPMail.AppendBody('You are invited for the tender evaluation exercise for the mentioned tender as assigned.');
        //     SMTPMail.AppendBody('__________________________________________________________________________________________________<br>');
        //     SMTPMail.AppendBody('Regards.');
        //     SMTPMail.AppendBody('<br><br>');
        //     SMTPMail.AppendBody('ICDC Procurement Department');
        //     SMTPMail.AppendBody('<br><br>');
        //     SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
        //     SMTPMail.Send;
        //   until TenderEvaluators.Next=0;
        // end;
    end;

    procedure CreateEmailToApplicantOnSubmitApplication("RFQNo.": Code[20])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        CurrencyCode: Code[30];
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /*GeneralLedgerSetup.RESET;
        GeneralLedgerSetup.GET;
        
        RequestforQuotationHeader.RESET;
        RequestforQuotationHeader.GET("RFQNo.");
        
        
        
        IF RequestforQuotationHeader."Currency Code"='' THEN
          CurrencyCode:=GeneralLedgerSetup."LCY Code"
        ELSE
          CurrencyCode:=RequestforQuotationHeader."Currency Code";
        
        //EmailMessageBody.GET;
        
        EmailBody:='';
        EmailBody:='Dear '+RequestforQuotationHeader.Name+',<br><br>';
        EmailBody:=EmailBody+'Your application has successfully been submitted to ICDC. All correspondences relating to your application will be sent through your email.<br>Below are the application details:<br>';
        EmailBody:=EmailBody+'<table>';
        EmailBody:=EmailBody+'<tr><td>Application No.</td><td>'+RequestforQuotationHeader."No."+'</td></tr>';
        EmailBody:=EmailBody+'<tr><td>Application Type</td><td>'+FORMAT(RequestforQuotationHeader."Application Type")+'</td></tr>';
        EmailBody:=EmailBody+'<tr><td>Product Category</td><td>'+FORMAT(RequestforQuotationHeader."Product Category")+'</td></tr>';
        EmailBody:=EmailBody+'<tr><td>Product Name</td><td>'+InvestmentProduct."Product Description"+'</td></tr>';
        EmailBody:=EmailBody+'<tr><td>Applied Amount</td><td>'+CurrencyCode+':'+FORMAT(RequestforQuotationHeader."Applied Amount")+'</td></tr>';
        EmailBody:=EmailBody+'</table>';
        EmailBody:=EmailBody+'<br><br>';
        EmailBody:=EmailBody+'Kind Regards<br>';
        EmailBody:=EmailBody+'ICDC Marketing Department<br>';
        EmailBody:=EmailBody+'<br><br>';
        EmailBody:=EmailBody+EmailBodySeparator+'<br>';
        EmailBody:=EmailBody+EmailBodyFooter+'<br>';
        
        SMTPMail.GET;
        SenderName:='ICDC';
        SenderAddress:=SMTPMail."User ID";
        Subject:=InvestmentProduct."Product Description"+' Application.';
        Recipients:=RequestforQuotationHeader."Email Address"+';'+RequestforQuotationHeader."Contact Person E-Mail";
        RecipientsCC:=RequestforQuotationHeader."Alternative Email Address";
        RecipientsBCC:='';
        
        InsertInvestmentEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
        */

    end;

    [Scope('Personalization')]
    procedure CreatePurchaseOrder(var PurchaseRequisitions: Record "Purchase Requisitions")
    var
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderCopy: Record "Purchase Header";
        Lineno: Integer;
        PurchaseLine2: Record "Purchase Line";
        Orders: Text;
    begin
        with PurchaseRequisitions do begin
            PurchaseRequisitionLine.Reset;
            PurchaseRequisitionLine.SetRange("Document No.", "No.");
            if PurchaseRequisitionLine.FindFirst then
                repeat
                    PurchaseRequisitionLine.TestField("Vendor No");
                    PurchaseRequisitionLine.TestField("Unit Cost");
                    PurchaseRequisitionLine.TestField("No.");
                    PurchaseHeaderCopy.Reset;
                    PurchaseHeaderCopy.SetRange("Purchase Requisition", "No.");
                    PurchaseHeaderCopy.SetRange("Buy-from Vendor No.", PurchaseRequisitionLine."Vendor No");

                    if PurchaseHeaderCopy.FindFirst then begin
                        Lineno := 0;
                        PurchaseLine2.Reset;
                        PurchaseLine2.SetRange("Document No.", PurchaseHeaderCopy."No.");
                        if PurchaseLine2.FindLast then
                            Lineno := PurchaseLine2."Line No.";
                        Lineno := Lineno + 1000;
                        PurchaseLine.Init;
                        PurchaseLine."Line No." := Lineno;
                        PurchaseLine."Document No." := PurchaseHeaderCopy."No.";
                        PurchaseLine.Validate("Document Type", PurchaseHeaderCopy."Document Type");
                        PurchaseLine.Validate("Buy-from Vendor No.", "Vendor No");
                        if PurchaseRequisitionLine."Requisition Type" = PurchaseRequisitionLine."Requisition Type"::Item then
                            PurchaseLine.Type := PurchaseLine.Type::Item
                        else if PurchaseRequisitionLine."Requisition Type" = PurchaseRequisitionLine."Requisition Type"::Service then
                            PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                        else if PurchaseRequisitionLine."Requisition Type" = PurchaseRequisitionLine."Requisition Type"::"Fixed Asset" then
                            PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
                        PurchaseLine.Validate("No.", PurchaseRequisitionLine."No.");
                        PurchaseLine.Description := PurchaseRequisitionLine.Description;
                        PurchaseLine."Description 2" := PurchaseRequisitionLine.Description;
                        PurchaseLine.Validate(Quantity, PurchaseRequisitionLine.Quantity);
                        PurchaseLine."Location Code" := PurchaseRequisitionLine."Location Code";
                        PurchaseLine.Validate("Direct Unit Cost", PurchaseRequisitionLine."Unit Cost");
                        PurchaseLine.Validate("Shortcut Dimension 1 Code", PurchaseRequisitionLine."Global Dimension 1 Code");
                        PurchaseLine.Validate("Shortcut Dimension 2 Code", PurchaseRequisitionLine."Global Dimension 2 Code");
                        PurchaseLine.Insert(true);
                        PurchaseRequisitionLine."Order No." := PurchaseHeaderCopy."No.";
                        PurchaseRequisitionLine.Modify;
                    end else begin
                        PurchasesPayablesSetup.Get;
                        PurchaseHeader.Init;
                        PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.", Today, true);
                        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.Validate("Document Date", PurchaseRequisitions."Document Date");
                        PurchaseHeader.Validate("Posting Date", PurchaseRequisitions."Document Date");
                        PurchaseHeader."User ID" := UserId;
                        PurchaseHeader."Currency Code" := "Currency Code";
                        PurchaseHeader."Purchase Requisition" := "No.";
                        PurchaseHeader.Validate("Buy-from Vendor No.", PurchaseRequisitionLine."Vendor No");

                        PurchaseHeader.Insert(true);
                        Commit;
                        Lineno := 0;


                        Lineno := Lineno + 1000;
                        PurchaseLine.Init;
                        PurchaseLine."Line No." := Lineno;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
                        PurchaseLine.Validate("Buy-from Vendor No.", "Vendor No");
                        if PurchaseRequisitionLine."Requisition Type" = PurchaseRequisitionLine."Requisition Type"::Item then
                            PurchaseLine.Type := PurchaseLine.Type::Item
                        else if PurchaseRequisitionLine."Requisition Type" = PurchaseRequisitionLine."Requisition Type"::Service then
                            PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                        else if PurchaseRequisitionLine."Requisition Type" = PurchaseRequisitionLine."Requisition Type"::"Fixed Asset" then
                            PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
                        PurchaseLine.Validate("No.", PurchaseRequisitionLine."No.");
                        PurchaseLine.Description := PurchaseRequisitionLine.Description;
                        PurchaseLine."Description 2" := PurchaseRequisitionLine.Description;
                        PurchaseLine.Validate(Quantity, PurchaseRequisitionLine.Quantity);
                        PurchaseLine."Location Code" := PurchaseRequisitionLine."Location Code";
                        PurchaseLine.Validate("Direct Unit Cost", PurchaseRequisitionLine."Unit Cost");
                        PurchaseLine.Validate(Quantity, PurchaseRequisitionLine.Quantity);
                        PurchaseLine.Validate("Shortcut Dimension 1 Code", PurchaseRequisitionLine."Global Dimension 1 Code");
                        PurchaseLine.Validate("Shortcut Dimension 2 Code", PurchaseRequisitionLine."Global Dimension 2 Code");
                        PurchaseLine.Insert;
                        PurchaseRequisitionLine."Order No." := PurchaseHeader."No.";
                        PurchaseRequisitionLine.Modify;
                    end;

                until PurchaseRequisitionLine.Next = 0;
            "Order No." := PurchaseHeader."No.";
            Status := Status::Closed;

            Modify;
            PurchaseHeaderCopy.Reset;
            PurchaseHeaderCopy.SetRange("Purchase Requisition", "No.");
            if PurchaseHeaderCopy.FindFirst then
                repeat
                    Orders := Orders + ',' + PurchaseHeaderCopy."No.";
                until PurchaseHeaderCopy.Next = 0;
            Message('Purchase order %1 created succesfully', Orders);
        end;
    end;

    [Scope('Personalization')]
    procedure CreatePurchaseQuotes(var RequestforQuotationHeader: Record "Request for Quotation Header")
    var
        RequestforQuotationLine: Record "Request for Quotation Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderCopy: Record "Purchase Header";
        Lineno: Integer;
        PurchaseLine2: Record "Purchase Line";
        Orders: Text;
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
    begin
        PurchaseHeaderCopy.Reset;

        PurchaseHeaderCopy.SetRange("Document Type", PurchaseHeaderCopy."Document Type"::Quote);
        PurchaseHeaderCopy.SetRange("Request for Quotation Code", RequestforQuotationHeader."No.");
        if PurchaseHeaderCopy.FindFirst then
            Error('Quotes have already been created for this document');
        RequestforQuotationVendor.Reset;
        RequestforQuotationVendor.SetRange("RFQ Document No.", RequestforQuotationHeader."No.");
        if RequestforQuotationVendor.FindFirst then
            repeat
                Lineno := 0;
                PurchasesPayablesSetup.Get;
                PurchaseHeader.Init;
                PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Quote Nos.", Today, true);
                PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Quote);
                PurchaseHeader.Validate("Document Date", RequestforQuotationHeader."Document Date");
                PurchaseHeader.Validate("Posting Date", RequestforQuotationHeader."Document Date");
                PurchaseHeader."User ID" := UserId;
                //PurchaseHeader."Currency Code":="Currency Code";
                PurchaseHeader."Request for Quotation Code" := RequestforQuotationHeader."No.";
                PurchaseHeader.Validate("Buy-from Vendor No.", RequestforQuotationVendor."Vendor No.");
                PurchaseHeader.Insert;
                RequestforQuotationLine.Reset;
                RequestforQuotationLine.SetRange("Document No.", RequestforQuotationHeader."No.");
                if RequestforQuotationLine.FindFirst then
                    repeat
                        Lineno := Lineno + 1000;
                        PurchaseLine.Init;
                        PurchaseLine."Line No." := Lineno;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
                        PurchaseLine.Validate("Buy-from Vendor No.", RequestforQuotationVendor."Vendor No.");
                        PurchaseLine.Validate(Type, RequestforQuotationLine.Type);

                        PurchaseLine.Validate("No.", RequestforQuotationLine."No.");
                        PurchaseLine.Description := RequestforQuotationLine.Description;
                        PurchaseLine."Description 2" := RequestforQuotationLine.Description;
                        PurchaseLine.Validate(Quantity, RequestforQuotationLine.Quantity);
                        PurchaseLine."Location Code" := RequestforQuotationLine."Location Code";
                        PurchaseLine.Validate("Direct Unit Cost", 0);
                        PurchaseLine.Validate(Quantity, RequestforQuotationLine.Quantity);
                        PurchaseLine.Validate("Direct Unit Cost", 0);
                        PurchaseLine.Validate("Shortcut Dimension 1 Code", RequestforQuotationLine."Global Dimension 1 Code");
                        PurchaseLine.Validate("Shortcut Dimension 2 Code", RequestforQuotationLine."Global Dimension 2 Code");
                        PurchaseLine.Insert;
                    until RequestforQuotationLine.Next = 0;

            until RequestforQuotationVendor.Next = 0;
        Message('Purchase Quotes Created succesfully', Orders);


        /*
            IF PurchaseHeaderCopy.FINDFIRST THEN
              BEGIN
                Lineno:=0 ;
                PurchaseLine2.RESET;
                PurchaseLine2.SETRANGE("Document No.",PurchaseHeaderCopy."No.");
                IF PurchaseLine2.FINDLAST THEN
                Lineno:=PurchaseLine2."Line No.";
                Lineno:=Lineno+1000;
                PurchaseLine.INIT;
                PurchaseLine."Line No.":=Lineno;
                PurchaseLine."Document No.":=PurchaseHeaderCopy."No.";
                PurchaseLine.VALIDATE("Document Type",PurchaseHeaderCopy."Document Type");
                PurchaseLine.VALIDATE("Buy-from Vendor No.","Vendor No");
                IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Item THEN
                PurchaseLine.Type:= PurchaseLine.Type::Item
                ELSE IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Service THEN
                PurchaseLine.Type:= PurchaseLine.Type::"G/L Account"
                ELSE IF  PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::"Fixed Asset" THEN
                PurchaseLine.Type:= PurchaseLine.Type::"Fixed Asset";
                PurchaseLine.VALIDATE("No.",PurchaseRequisitionLine."No.");
                PurchaseLine.Description:=PurchaseRequisitionLine.Description;
                PurchaseLine."Description 2":=PurchaseRequisitionLine.Description;
                PurchaseLine.VALIDATE(Quantity,PurchaseRequisitionLine.Quantity);
                PurchaseLine."Location Code":=PurchaseRequisitionLine."Location Code";
                PurchaseLine.VALIDATE("Unit Amount",PurchaseRequisitionLine."Unit Cost");
                PurchaseLine.VALIDATE("Shortcut Dimension 1 Code",PurchaseRequisitionLine."Global Dimension 1 Code");
                PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",PurchaseRequisitionLine."Global Dimension 2 Code");
                PurchaseLine.INSERT;
        PurchaseRequisitionLine."Order No.":=PurchaseHeaderCopy."No.";
                PurchaseRequisitionLine.MODIFY;
            END  ELSE BEGIN
            //TESTFIELD("Order No.",'')y
            //TESTFIELD("Vendor No");
            PurchasesPayablesSetup.GET;
            PurchaseHeader.INIT;
            PurchaseHeader."No.":=NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.",TODAY,TRUE);
            PurchaseHeader.VALIDATE("Document Type",PurchaseHeader."Document Type"::Order);
            PurchaseHeader.VALIDATE("Document Date",PurchaseRequisitions."Document Date");
            PurchaseHeader.VALIDATE("Posting Date",PurchaseRequisitions."Document Date");
            PurchaseHeader."User ID":=USERID;
            PurchaseHeader."Currency Code":="Currency Code";
            PurchaseHeader."Purchase Requisition":="No.";
            PurchaseHeader.VALIDATE("Buy-from Vendor No.",PurchaseRequisitionLine."Vendor No");
        
             PurchaseHeader.INSERT;
             COMMIT;
            Lineno:=0 ;
        
        
                    Lineno:=Lineno+1000;
                PurchaseLine.INIT;
                PurchaseLine."Line No.":=Lineno;
                PurchaseLine."Document No.":=PurchaseHeader."No.";
                PurchaseLine.VALIDATE("Document Type",PurchaseHeader."Document Type");
                PurchaseLine.VALIDATE("Buy-from Vendor No.","Vendor No");
                IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Item THEN
                PurchaseLine.Type:= PurchaseLine.Type::Item
                ELSE IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Service THEN
                PurchaseLine.Type:= PurchaseLine.Type::"G/L Account"
                ELSE IF  PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::"Fixed Asset" THEN
                PurchaseLine.Type:= PurchaseLine.Type::"Fixed Asset";
                PurchaseLine.VALIDATE("No.",PurchaseRequisitionLine."No.");
                PurchaseLine.Description:=PurchaseRequisitionLine.Description;
                PurchaseLine."Description 2":=PurchaseRequisitionLine.Description;
                PurchaseLine.VALIDATE(Quantity,PurchaseRequisitionLine.Quantity);
                PurchaseLine."Location Code":=PurchaseRequisitionLine."Location Code";
                PurchaseLine.VALIDATE("Unit Amount",PurchaseRequisitionLine."Unit Cost");
                PurchaseLine.VALIDATE(Quantity,PurchaseRequisitionLine.Quantity);
                PurchaseLine.VALIDATE("Shortcut Dimension 1 Code",PurchaseRequisitionLine."Global Dimension 1 Code");
                PurchaseLine.VALIDATE("Shortcut Dimension 2 Code",PurchaseRequisitionLine."Global Dimension 2 Code");
                PurchaseLine.INSERT;
                PurchaseRequisitionLine."Order No.":=PurchaseHeader."No.";
                PurchaseRequisitionLine.MODIFY;
                END;
        
                UNTIL PurchaseRequisitionLine.NEXT=0;
           //"Order No.":=PurchaseHeader."No.";
           Status:=Status::Closed;
           MODIFY;
            PurchaseHeaderCopy.RESET;
            PurchaseHeaderCopy.SETRANGE("Purchase Requisition","No.");
            IF PurchaseHeaderCopy.FINDFIRST THEN
              REPEAT
           Orders:=Orders+','+PurchaseHeaderCopy."No.";
              UNTIL PurchaseHeaderCopy.NEXT=0;
               MESSAGE('Purchase order %1 created succesfully', Orders);
          END;
          */

    end;

    [Scope('Personalization')]
    procedure CreatePurchaseOrderRFQ(var RequestforQuotationHeader: Record "Request for Quotation Header")
    var
        RequestforQuotationLine: Record "Request for Quotation Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderCopy: Record "Purchase Header";
        Lineno: Integer;
        PurchaseLine2: Record "Purchase Line";
        Orders: Text;
        RequestforQuotationVendors: Record "Request for Quotation Vendors";
    begin
        PurchaseHeaderCopy.Reset;

        PurchaseHeaderCopy.SetRange("Document Type", PurchaseHeaderCopy."Document Type"::Order);
        PurchaseHeaderCopy.SetRange("Request for Quotation Code", RequestforQuotationHeader."No.");
        if PurchaseHeaderCopy.FindFirst then
            Error('LPOS have already been created for this document');

        Lineno := 0;
        PurchasesPayablesSetup.Get;

        RequestforQuotationLine.Reset;
        RequestforQuotationLine.SetRange("Document No.", RequestforQuotationHeader."No.");
        if RequestforQuotationLine.FindFirst then
            repeat
                RequestforQuotationLine.TestField(Quantity);
                RequestforQuotationLine.TestField("Unit Cost");
                RequestforQuotationLine.TestField("Vendor Selected");
                Lineno := Lineno + 1000;
                PurchaseHeaderCopy.SetRange("Document Type", PurchaseHeaderCopy."Document Type"::Order);
                PurchaseHeaderCopy.SetRange("Request for Quotation Code", RequestforQuotationHeader."No.");
                PurchaseHeaderCopy.SetRange("Buy-from Vendor No.", RequestforQuotationLine."Vendor Selected");
                if PurchaseHeaderCopy.FindFirst then begin
                    PurchaseLine.Init;
                    PurchaseLine."Line No." := Lineno;
                    PurchaseLine."Document No." := PurchaseHeader."No.";
                    PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.Validate("Buy-from Vendor No.", RequestforQuotationLine."Vendor Selected");
                    PurchaseLine.Validate(Type, RequestforQuotationLine.Type);

                    PurchaseLine.Validate("No.", RequestforQuotationLine."No.");
                    PurchaseLine.Description := RequestforQuotationLine.Description;
                    PurchaseLine."Description 2" := RequestforQuotationLine.Description;
                    PurchaseLine.Validate(Quantity, RequestforQuotationLine.Quantity);
                    PurchaseLine."Location Code" := RequestforQuotationLine."Location Code";
                    PurchaseLine.Validate("Direct Unit Cost", RequestforQuotationLine."Unit Cost");
                    PurchaseLine.Validate(Quantity, RequestforQuotationLine.Quantity);
                    PurchaseLine.Validate("Direct Unit Cost", RequestforQuotationLine."Unit Cost");
                    PurchaseLine.Validate("Shortcut Dimension 1 Code", RequestforQuotationLine."Global Dimension 1 Code");
                    PurchaseLine.Validate("Shortcut Dimension 2 Code", RequestforQuotationLine."Global Dimension 2 Code");
                    PurchaseLine.Insert;
                end else begin
                    PurchaseHeader.Init;
                    PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.", Today, true);
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.Validate("Document Date", RequestforQuotationHeader."Document Date");
                    PurchaseHeader.Validate("Posting Date", RequestforQuotationHeader."Document Date");
                    PurchaseHeader."User ID" := UserId;
                    //PurchaseHeader."Currency Code":="Currency Code";
                    PurchaseHeader."Request for Quotation Code" := RequestforQuotationHeader."No.";
                    PurchaseHeader.Validate("Buy-from Vendor No.", RequestforQuotationLine."Vendor Selected");
                    PurchaseHeader.Insert;
                    PurchaseLine.Init;
                    PurchaseLine."Line No." := Lineno;
                    PurchaseLine."Document No." := PurchaseHeader."No.";
                    PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.Validate("Buy-from Vendor No.", RequestforQuotationLine."Vendor Selected");
                    PurchaseLine.Validate(Type, RequestforQuotationLine.Type);

                    PurchaseLine.Validate("No.", RequestforQuotationLine."No.");
                    PurchaseLine.Description := RequestforQuotationLine.Description;
                    PurchaseLine."Description 2" := RequestforQuotationLine.Description;
                    PurchaseLine.Validate(Quantity, RequestforQuotationLine.Quantity);
                    PurchaseLine."Location Code" := RequestforQuotationLine."Location Code";
                    PurchaseLine.Validate("Direct Unit Cost", RequestforQuotationLine."Unit Cost");
                    PurchaseLine.Validate(Quantity, RequestforQuotationLine.Quantity);
                    PurchaseLine.Validate("Direct Unit Cost", RequestforQuotationLine."Unit Cost");

                    PurchaseLine.Validate("Shortcut Dimension 1 Code", RequestforQuotationLine."Global Dimension 1 Code");
                    PurchaseLine.Validate("Shortcut Dimension 2 Code", RequestforQuotationLine."Global Dimension 2 Code");
                    PurchaseLine.Insert;
                end;
                RequestforQuotationLine."Order No." := PurchaseHeader."No.";
                RequestforQuotationLine.Modify;
            until RequestforQuotationLine.Next = 0;

        RequestforQuotationHeader.Status := RequestforQuotationHeader.Status::Closed;
        RequestforQuotationHeader.Modify;
        PurchaseHeaderCopy.Reset;
        PurchaseHeaderCopy.SetRange("Request for Quotation Code", RequestforQuotationHeader."No.");
        PurchaseHeaderCopy.SetRange("Document Type", PurchaseHeaderCopy."Document Type"::Order);
        if PurchaseHeaderCopy.FindFirst then
            repeat
                Orders := Orders + ',' + PurchaseHeaderCopy."No.";
            until PurchaseHeaderCopy.Next = 0;
        Message('Purchase Orders %1 Created succesfully', Orders);
    end;

    [Scope('Personalization')]
    procedure CreateServiceOrder(var TransportRequest: Record "Transport Request")
    var
        TravellingEmployee: Record "Travelling Employee";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderCopy: Record "Purchase Header";
        Lineno: Integer;
        PurchaseLine2: Record "Purchase Line";
        Orders: Text;
    begin
        with TransportRequest do begin
            TravellingEmployee.Reset;
            TravellingEmployee.SetRange("Request No.", "Request No.");
            if TravellingEmployee.FindFirst then
                repeat
                    TransportRequest.TestField(TransportRequest."Supplier No");
                    TravellingEmployee.TestField(TravellingEmployee."Price per Unit");

                    PurchaseHeaderCopy.Reset;
                    PurchaseHeaderCopy.SetRange("Purchase Requisition", "Request No.");
                    PurchaseHeaderCopy.SetRange("Buy-from Vendor No.", TransportRequest."Supplier No");

                    if PurchaseHeaderCopy.FindFirst then begin
                        Lineno := 0;
                        PurchaseLine2.Reset;
                        PurchaseLine2.SetRange("Document No.", PurchaseHeaderCopy."No.");
                        if PurchaseLine2.FindLast then
                            Lineno := PurchaseLine2."Line No.";
                        Lineno := Lineno + 1000;
                        PurchaseLine.Init;
                        PurchaseLine."Line No." := Lineno;
                        PurchaseLine."Document No." := PurchaseHeaderCopy."No.";
                        // PurchaseLine.VALIDATE("Document Type",PurchaseHeaderCopy."Document Type");
                        PurchaseLine.Validate("Buy-from Vendor No.", "Supplier No");
                        /* IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Item THEN
                         PurchaseLine.Type:= PurchaseLine.Type::Item*/
                        //IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Service THEN
                        PurchaseLine.Type := PurchaseLine.Type::"G/L Account";
                        /* ELSE IF  PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::"Fixed Asset" THEN
                         PurchaseLine.Type:= PurchaseLine.Type::"Fixed Asset";*/
                        // PurchaseLine.VALIDATE("No.","Document No.");
                        PurchaseLine."No." := '415001';
                        PurchaseLine."VAT Prod. Posting Group" := 'NOVAT';
                        PurchaseLine."Gen. Bus. Posting Group" := 'LOCAL';
                        PurchaseLine."Gen. Prod. Posting Group" := 'GENERAL';
                        PurchaseLine.Description := TravellingEmployee.Description;
                        PurchaseLine."Description 2" := TravellingEmployee.Description;
                        PurchaseLine.Validate(Quantity, TravellingEmployee.Quantity);
                        //PurchaseLine."Location Code":=PurchaseRequisitionLine."Location Code";
                        PurchaseLine."Line Amount" := TravellingEmployee.Amount;
                        PurchaseLine.Validate("Direct Unit Cost", TravellingEmployee."Price per Unit");
                        PurchaseLine.Validate("Shortcut Dimension 1 Code", TransportRequest."Global Dimension 1 Code");
                        PurchaseLine.Validate("Shortcut Dimension 2 Code", TransportRequest."Global Dimension 2 Code");
                        PurchaseLine.Insert(true);
                        //PurchaseRequisitionLine."Order No.":=PurchaseHeaderCopy."No.";
                        TravellingEmployee.Modify;
                    end else begin
                        //TESTFIELD("Order No.",'')y
                        //TESTFIELD("Vendor No");
                        PurchasesPayablesSetup.Get;
                        PurchaseHeader.Init;
                        PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.", Today, true);
                        PurchaseHeader."Posting Description" := TransportRequest."Vehicle Name";
                        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.Validate("Document Date", TransportRequest."Posting Date");
                        PurchaseHeader.Validate("Posting Date", TransportRequest."Posting Date");
                        PurchaseHeader."User ID" := UserId;
                        // PurchaseHeader."Currency Code":="Currency Code";
                        PurchaseHeader."Purchase Requisition" := "Request No.";
                        PurchaseHeader.Validate("Buy-from Vendor No.", TransportRequest."Supplier No");

                        PurchaseHeader.Insert(true);
                        Commit;
                        Lineno := 0;


                        Lineno := Lineno + 1000;
                        PurchaseLine.Init;
                        PurchaseLine."Line No." := Lineno;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
                        PurchaseLine.Validate("Buy-from Vendor No.", TransportRequest."Supplier No");
                        /*IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Item THEN
                        PurchaseLine.Type:= PurchaseLine.Type::Item
                        ELSE IF PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::Service THEN
                        PurchaseLine.Type:= PurchaseLine.Type::"G/L Account"
                        ELSE IF  PurchaseRequisitionLine."Requisition Type"=PurchaseRequisitionLine."Requisition Type"::"Fixed Asset" THEN
                        PurchaseLine.Type:= PurchaseLine.Type::"Fixed Asset";*/
                        //PurchaseLine.VALIDATE("No.",PurchaseRequisitionLine."No.");
                        PurchaseLine.Description := TravellingEmployee.Description;
                        PurchaseLine."Description 2" := TravellingEmployee.Description;
                        PurchaseLine.Validate(Quantity, TravellingEmployee.Quantity);
                        //  PurchaseLine."Location Code":=PurchaseRequisitionLine."Location Code";
                        PurchaseLine.Validate("Direct Unit Cost", TravellingEmployee."Price per Unit");
                        PurchaseLine.Validate(Quantity, TravellingEmployee.Quantity);
                        PurchaseLine.Validate("Shortcut Dimension 1 Code", TransportRequest."Global Dimension 1 Code");
                        PurchaseLine.Validate("Shortcut Dimension 2 Code", TransportRequest."Global Dimension 2 Code");
                        PurchaseLine.Insert;
                        // PurchaseRequisitionLine."Order No.":=PurchaseHeader."No.";
                        TravellingEmployee.Modify;
                    end;

                until TravellingEmployee.Next = 0;
            //"Order No.":=PurchaseHeader."No.";
            Status := Status::Completed;

            Modify;
            PurchaseHeaderCopy.Reset;
            PurchaseHeaderCopy.SetRange("Purchase Requisition", "Request No.");
            if PurchaseHeaderCopy.FindFirst then
                repeat
                    Orders := Orders + ',' + PurchaseHeaderCopy."No.";
                until PurchaseHeaderCopy.Next = 0;
            Message('Purchase order %1 created succesfully', Orders);
        end;

    end;

    procedure CheckBudgetPurchaseOrder(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") or (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, PurchHeader."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        //get line no
        Commitments.Reset;
        if Commitments.FindLast then
            EntryNo += Commitments."Line No."
        else
            EntryNo := 1;
        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.FindSet then begin
            repeat
                //Items
                if PurchLine.Type = PurchLine.Type::Item then begin
                    Items.Reset;
                    if not Items.Get(PurchLine."No.") then
                        Error(Text0007);
                    Items.TestField("Item G/L Budget Account");
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //Fixed Asset
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAssets.Reset;
                    FixedAssets.SetRange(FixedAssets."No.", PurchLine."No.");
                    if FixedAssets.FindFirst then begin
                        //fixed asset sub class
                        FixedAssets.TestField("FA Subclass Code");
                        FASubclassRec.Get(FixedAssets."FA Subclass Code");
                        FASubclassRec.TestField("Default FA Posting Group");
                        FAPostingGroup.Reset;
                        FAPostingGroup.SetRange(FAPostingGroup.Code, FASubclassRec."Default FA Posting Group");
                        if FAPostingGroup.FindFirst then
                            if PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance then begin
                                BudgetGL := FAPostingGroup."Maintenance Expense Account";
                                if BudgetGL = '' then
                                    Error(Text0008, PurchLine."No.");
                            end else begin
                                BudgetGL := FAPostingGroup."Acquisition Cost Account";
                                if BudgetGL = '' then
                                    Error(Text0009, PurchLine."No.");
                            end;
                    end;
                end;

                //G/L Account
                if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
                    BudgetGL := PurchLine."No.";

                end;

                //check the votebook now

                FirstDay := DMY2Date(1, Date2DMY(PurchHeader."Document Date", 2), Date2DMY(PurchHeader."Document Date", 3));
                CurrMonth := Date2DMY(PurchHeader."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PurchHeader."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PurchHeader."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //Get actuals
                GLAccount.Reset;
                ;
                GLAccount.SetRange("No.", BudgetGL);
                //GLAccount.SETRANGE("Date Filter",BCSetup."Current Budget Start Date",LastDay);
                GLAccount.SetRange("Date Filter", BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                GLAccount.CalcFields("Net Change");
                ActualsAmount := GLAccount."Net Change";

                //check the summation of the budget
                BudgetAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                //Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",LastDay);
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                /*Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Global Dimension 1 Code");
                Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Global Dimension 2 Code");
                IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
                 Budget.SETRANGE(Budget."Budget Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
                IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
                 Budget.SETRANGE(Budget."Budget Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                //Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                /* Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
                 Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
                 IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
                  Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
                 IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
                  Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");*/
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PurchLine."Amount Including VAT" + ActualsAmount) > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Amount Including VAT"))));
                end else begin
                    //commit Amounts
                    EntryNo := EntryNo + 1;
                    Commitments.Init;
                    Commitments."Line No." := EntryNo;
                    Commitments.Date := Today;
                    Commitments."Posting Date" := PurchHeader."Document Date";
                    Commitments."Document Type" := Commitments."Document Type"::LPO;
                    Commitments."Document No." := PurchHeader."No.";
                    Commitments.Amount := PurchLine."Amount Including VAT";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PurchHeader."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments.Type := Commitments.Type::" ";
                    Commitments.Committed := true;
                    Commitments.Insert(true);
                    //(TRUE) THEN BEGIN
                    PurchLine.Committed := true;
                    PurchLine.Modify;
                    // END
                    // ELSE
                    // ERROR(GETLASTERRORTEXT);
                end;
            until PurchLine.Next = 0;
        end;

    end;

    procedure CancelBudgetCommitmentPurchaseOrder(PurchHeader: Record "Purchase Header")
    var
        Commitments: Record "Budget Committment";
        EntryNo: Integer;
        PurchLine: Record "Purchase Line";
        BudgetAmount: Decimal;
        Items: Record Item;
        FixedAsset: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
    begin
        Clear(BudgetAmount);
        BudgetGL := '';
        BCSetup.Get();
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange(Committed, true);
        if PurchLine.FindSet then begin
            if PurchLine.Type = PurchLine.Type::Item then
                if Items.Get(PurchLine."No.") then
                    BudgetGL := Items."Item G/L Budget Account"
                else if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAsset.Get(PurchLine."No.");
                    FixedAsset.TestField("FA Subclass Code");
                    FASubclassRec.Get(FixedAsset."FA Subclass Code");
                    FASubclassRec.TestField("Default FA Posting Group");
                    FAPostingGroup.Reset;
                    FAPostingGroup.SetRange(Code, FASubclassRec."Default FA Posting Group");
                    if FAPostingGroup.FindFirst then
                        BudgetGL := FAPostingGroup."Acquisition Cost Account"
                end
                else if PurchLine.Type = PurchLine.Type::"G/L Account" then
                    BudgetGL := PurchLine."No.";
            //Find entry no
            Commitments.Reset;
            if Commitments.FindLast then
                EntryNo += Commitments."Line No."
            else
                EntryNo := 1;
            repeat
                // BudgetAmount:=PurchLine.Quantity*PurchLine."Unit Cost";
                Commitments.Reset;
                Commitments.Init;
                Commitments."Line No." := EntryNo + 1;
                Commitments.Date := Today;
                Commitments."Posting Date" := PurchHeader."Document Date";
                Commitments."Document Type" := Commitments."Document Type"::LPO;
                Commitments."Document No." := PurchHeader."No.";
                Commitments.Amount := -PurchLine."Amount Including VAT";
                Commitments.Committed := false;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := PurchHeader."Document Date";
                Commitments."G/L Account No." := BudgetGL;
                Commitments."Committed Time" := Time;
                Commitments.Cancelled := true;
                Commitments."Cancelled By" := UserId;
                Commitments."Cancelled Date" := Today;
                Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                Commitments.Committed := true;
                Commitments.Budget := BCSetup."Current Budget Code";
                if Commitments.Insert then begin
                    PurchLine.Committed := false;
                    PurchLine.Modify;
                end;
            //ELSE
            //ERROR(GETLASTERRORTEXT);
            until PurchLine.Next = 0;
        end;
    end;

    procedure CalcBudgetAvailableAmt(Type: Option " ","G/L Account",Item,,"Fixed Asset","Charge (Item)"; "No.": Code[50]; "Document Date": Date) BudgetAmt: Decimal
    var
        Items: Record Item;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
    begin
        BCSetup.Get;
        //Items
        if Type = Type::Item then begin
            Items.Reset;
            if not Items.Get("No.") then
                Error(Text0007);
            Items.TestField("Item G/L Budget Account");
            BudgetGL := Items."Item G/L Budget Account";
        end;

        //Fixed Asset
        if Type = Type::"Fixed Asset" then begin
            FixedAssets.Reset;
            FixedAssets.SetRange(FixedAssets."No.", "No.");
            if FixedAssets.FindFirst then begin
                FixedAssets.TestField("FA Subclass Code");
                FASubclassRec.Get(FixedAssets."FA Subclass Code");
                FASubclassRec.TestField("Default FA Posting Group");
                FAPostingGroup.Reset;
                FAPostingGroup.SetRange(FAPostingGroup.Code, FASubclassRec."Default FA Posting Group");
                if FAPostingGroup.FindFirst then
                    if FAPostingGroup.FindFirst then begin
                        BudgetGL := FAPostingGroup."Acquisition Cost Account";
                        if BudgetGL = '' then
                            Error(Text0009, "No.");
                    end;
            end;
        end;

        //G/L Account
        if Type = Type::"G/L Account" then begin
            BudgetGL := "No.";

        end;

        //check the votebook now

        FirstDay := DMY2Date(1, Date2DMY("Document Date", 2), Date2DMY("Document Date", 3));
        CurrMonth := Date2DMY("Document Date", 2);
        if CurrMonth = 12 then begin
            LastDay := DMY2Date(1, 1, Date2DMY("Document Date", 3) + 1);
            LastDay := CalcDate('-1D', LastDay);
        end else begin
            CurrMonth := CurrMonth + 1;
            LastDay := DMY2Date(1, CurrMonth, Date2DMY("Document Date", 3));
            LastDay := CalcDate('-1D', LastDay);
        end;

        //Get actuals
        GLAccount.Reset;
        ;
        GLAccount.SetRange("No.", BudgetGL);
        GLAccount.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
        GLAccount.CalcFields("Net Change");
        ActualsAmount := GLAccount."Net Change";

        //check the summation of the budget
        BudgetAmount := 0;
        Budget.Reset;
        Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
        Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", LastDay);
        Budget.SetRange(Budget."G/L Account No.", BudgetGL);
        /*Budget.SETRANGE(Budget."Global Dimension 1 Code","Global Dimension 1 Code");
        Budget.SETRANGE(Budget."Global Dimension 2 Code","Global Dimension 2 Code");
        IF "Shortcut Dimension 3 Code" <> '' THEN
         Budget.SETRANGE(Budget."Budget Dimension 3 Code","Shortcut Dimension 3 Code");
        IF "Shortcut Dimension 4 Code" <> '' THEN
         Budget.SETRANGE(Budget."Budget Dimension 4 Code","Shortcut Dimension 4 Code");*/
        if Budget.FindSet then begin
            Budget.CalcSums(Amount);
            BudgetAmount := Budget.Amount;
        end;

        //get the committments
        CommitmentAmount := 0;
        Commitments.Reset;
        Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
        Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
        Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
        /*
        Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Global Dimension 1 Code");
        Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Global Dimension 2 Code");
        IF PurchLine."Shortcut Dimension 3 Code" <> '' THEN
         Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PurchLine."Shortcut Dimension 3 Code");
        IF PurchLine."Shortcut Dimension 4 Code" <> '' THEN
         Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PurchLine."Shortcut Dimension 4 Code");
         */
        Commitments.CalcSums(Commitments.Amount);
        CommitmentAmount := Commitments.Amount;

        //available budget amount
        BudgetAmt := BudgetAmount - (ActualsAmount + CommitmentAmount);
        exit(BudgetAmt);

    end;

    procedure CommitBudgetPurchaseRequisition(var PurchaseReq: Record "Purchase Requisitions")
    var
        PurchLine: Record "Purchase Requisition Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (PurchaseReq."Document Date" < BCSetup."Current Budget Start Date") or (PurchaseReq."Document Date" > BCSetup."Current Budget End Date") then begin
            Error(Text0004, PurchaseReq."Document Date",
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end;

        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        PurchaseReq.TestField(Voted, false);
        //get the lines related to the purchase requisition header
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document No.", PurchaseReq."No.");
        if PurchLine.FindSet then begin
            repeat
                //Items
                if PurchLine.Type = PurchLine.Type::Item then begin
                    Items.Reset;
                    if not Items.Get(PurchLine."No.") then
                        Error(Text0007);
                    Items.TestField("Item G/L Budget Account");
                    BudgetGL := Items."Item G/L Budget Account";
                end;

                //Fixed Asset
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                    FixedAssets.Reset;
                    FixedAssets.SetRange(FixedAssets."No.", PurchLine."No.");
                    if FixedAssets.FindFirst then begin
                        FAPostingGroup.Reset;
                        FAPostingGroup.SetRange(FAPostingGroup.Code, FixedAssets."FA Posting Group");
                        if FAPostingGroup.FindFirst then
                            if PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance then begin
                                BudgetGL := FAPostingGroup."Maintenance Expense Account";
                                if BudgetGL = '' then
                                    Error(Text0008, PurchLine."No.");
                            end else begin
                                BudgetGL := FAPostingGroup."Acquisition Cost Account";
                                if BudgetGL = '' then
                                    Error(Text0009, PurchLine."No.");
                            end;
                    end;
                end;

                //G/L Account
                if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
                    BudgetGL := PurchLine."No.";
                    if GLAccount.Get(PurchLine."No.") then
                        GLAccount.TestField(GLAccount."Budget Controlled", true);
                end;

                //check the votebook now
                FirstDay := DMY2Date(1, Date2DMY(PurchaseReq."Document Date", 2), Date2DMY(PurchaseReq."Document Date", 3));
                CurrMonth := Date2DMY(PurchaseReq."Document Date", 2);
                if CurrMonth = 12 then begin
                    LastDay := DMY2Date(1, 1, Date2DMY(PurchaseReq."Document Date", 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := DMY2Date(1, CurrMonth, Date2DMY(PurchaseReq."Document Date", 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //check the summation of the budget
                BudgetAmount := 0;
                ActualsAmount := 0;
                Budget.Reset;
                Budget.SetRange(Budget."Budget Name", BCSetup."Current Budget Code");
                Budget.SetFilter(Budget.Date, '%1..%2', BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                Budget.SetRange(Budget."G/L Account No.", BudgetGL);
                if Budget.FindSet then begin
                    Budget.CalcSums(Amount);
                    BudgetAmount := Budget.Amount;
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //check if there is any budget
                if (BudgetAmount <= 0) then
                    Error(Text0010);

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PurchLine."Total Cost(LCY)") > BudgetAmount) and (BCSetup."Allow OverExpenditure" = false) then begin
                    Error(Text0011,
                    PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + PurchLine."Total Cost"))));
                end else begin
                    //commit Amounts
                    Commitments.Init;
                    // Commitments."Line No." := 0;
                    Commitments.Date := PurchaseReq."Document Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Posting Date" := Today;
                    Commitments."Document Type" := Commitments."Document Type"::Requisition;
                    Commitments."Document No." := PurchaseReq."No.";
                    Commitments.Amount := PurchLine."Total Cost(LCY)";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments."Month Actual" := CommitmentAmount + PurchLine."Total Cost(LCY)";
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := Today;
                    if GLAccount.Get(Commitments."G/L Account No.") then
                        Commitments."Gl Name" := GLAccount.Name;
                    Commitments."Committed Time" := Time;
                    Commitments."Shortcut Dimension 1 Code" := PurchLine."Global Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := PurchLine."Global Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments."Budget Balance" := BudgetAmount - (CommitmentAmount + PurchLine."Total Cost(LCY)");
                    Commitments.Type := Commitments.Type::Vendor;
                    Commitments.Committed := true;
                    if Commitments.Insert then begin
                        PurchLine.Committed := true;
                        PurchLine.Modify;
                    end;
                end;
            until PurchLine.Next = 0;
            PurchaseReq.Voted := true;
            PurchaseReq.Modify;

        end;
    end;
}

