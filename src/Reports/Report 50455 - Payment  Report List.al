report 50455 "Payment  Report List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Payment  Report List.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = Status, "Cheque No.", "Posting Date", "Bank Account No.";
            column(DOCNAME; DOCNAME)
            {
            }
            column(Payments_Header__No__; "No.")
            {
            }
            column(PayeeName_PaymentHeader; "Payment Header"."Payee Name")
            {
            }
            column(Description_PaymentHeader; "Payment Header".Description)
            {
            }
            column(BankAccountNo_PaymentHeader; "Payment Header"."Bank Account No.")
            {
            }
            column(BankAccountName_PaymentHeader; "Payment Header"."Bank Account Name")
            {
            }
            column(Status_PaymentHeader; "Payment Header".Status)
            {
            }
            column(ChequeNo_PaymentHeader; "Payment Header"."Cheque No.")
            {
            }
            column(Invoice_Amount; "Payment Header"."Total Amount")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(PostingDate_PaymentHeader; "Payment Header"."Posting Date")
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Cheque_No__; "Reference No.")
            {
            }
            column(Payments_Header_Payee; PayeeNamesII)
            {
            }
            column(RefferenceNew; RefferenceNew)
            {
            }
            column(Payments_Header__Payments_Header__Date; "Posting Date")
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_; "Global Dimension 2 Code")
            {
            }
            column(USERID; UserId)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756010; CurrCode)
            {
            }
            column(CurrCode_Control1102756012; CurrCode)
            {
            }
            column(Approved_; 'Approved')
            {
                AutoFormatType = 1;
            }
            column(Approval_Status_____; 'Approval Status' + ':')
            {
                AutoFormatType = 1;
            }
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; UserId)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(TTotal_Control1102755034; TTotal)
            {
            }
            column(CurrCode_Control1102755035; CurrCode)
            {
            }
            column(CurrCode_Control1102755037; CurrCode)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(PAYMENT_DETAILSCaption; PAYMENT_DETAILSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
            {
            }
            column(W_TAXCaption; W_TAXCaptionLbl)
            {
            }
            column(Document_No___Caption; Document_No___CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FieldCaption("Global Dimension 2 Code"))
            {
            }
            column(R_CENTERCaption; R_CENTERCaptionLbl)
            {
            }
            column(PROJECTCaption; PROJECTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Amount_in_wordsCaption_Control1102755021; Amount_in_wordsCaption_Control1102755021Lbl)
            {
            }
            column(Printed_By_Caption_Control1102755026; Printed_By_Caption_Control1102755026Lbl)
            {
            }
            column(TotalCaption_Control1102755033; TotalCaption_Control1102755033Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(Bank; "Payment Header"."Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(BankName; "Payment Header"."Bank Account Name")
            {
                IncludeCaption = true;
            }
            column(PayMode; "Payment Header"."Payment Mode")
            {
                IncludeCaption = true;
            }
            column(PreparedBy; Approval1)
            {
            }
            column(Checked_For_Accuracy; Approval2)
            {
            }
            column(ApprovedBy; Approval3)
            {
            }
            column(ApprovedBy4; Approval4)
            {
            }
            column(EmployeeRecI_EmployeeSignature; EmployeeRecI."Employee Signature")
            {
            }
            column(EmployeeRecII_EmployeeSignature; EmployeeRecII."Employee Signature")
            {
            }
            column(EmployeeRecIII_EmployeeSignature; EmployeeRecIII."Employee Signature")
            {
            }
            column(AllowanceDoc; "Payment Header"."Bank Account No.")
            {
            }
            column(DocNo; "Payment Header"."Bank Account No.")
            {
            }
            column(PayeeType_PaymentHeader; "Payment Header"."Payee Type")
            {
            }
            column(PayeeNo_PaymentHeader; "Payment Header"."Payee No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*StrCopyText:='';
                IF "No. Printed">=1 THEN
                  BEGIN
                    StrCopyText:=DUPLICATE;
                  END;
                TTotal:=0;
                
                 DOCNAME:=CHEQUEVOUCHER;
                
                CALCFIELDS("Payment Header"."Total Amount","Payment Header"."Net Amount","Payment Header"."WithHolding Tax Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText,("Payment Header"."Net Amount"),'');
                
                
                {IF "Payment Header"."Payee Type"="Payment Header"."Payee Type"::Meeting THEN BEGIN
                  IF "Payment Header"."Board Individual Payment"=FALSE THEN BEGIN
                    PayeeNamesII:="Payment Header"."Bank Account Name";
                  END ELSE BEGIN
                    PayeeNamesII:="Payment Header"."Payee Name";
                  END;
                END;
                
                IF "Payment Header"."Payee Type"<>"Payment Header"."Payee Type"::Meeting THEN BEGIN
                      PayeeNamesII:="Payment Header"."Payee Name";
                 END;
                
                
                
                IF "Payment Header"."Payment Mode"="Payment Header"."Payment Mode"::Cheque THEN BEGIN
                  RefferenceNew:="Payment Header"."Cheque No.";
                  END ELSE BEGIN
                  RefferenceNew:="Payment Header"."Reference No.";
                  END;
                  }
                //Approval
                ApprovalEntryRec.RESET;
                ApprovalEntryRec.SETRANGE("Document No.","Payment Header"."No.");
                ApprovalEntryRec.SETRANGE(Status,ApprovalEntryRec.Status::Approved);
                IF ApprovalEntryRec.FINDFIRST THEN
                REPEAT
                IF i=0 THEN
                BEGIN
                Approval1:=ApprovalEntryRec."Sender ID";
                PreparedDate := ApprovalEntryRec."Date-Time Sent for Approval";
                END
                ELSE IF i=1 THEN
                Approval2:=ApprovalEntryRec."Approver ID"
                ELSE IF i=2 THEN
                Approval3:=ApprovalEntryRec."Approver ID"
                ELSE IF i=3 THEN
                Approval4:=ApprovalEntryRec."Approver ID";
                
                i+=1;
                
                UNTIL ApprovalEntryRec.NEXT=0;
                */

            end;

            trigger OnPreDataItem()
            begin
                /*
                LastFieldNo := FIELDNO("No.");
                CurrCode:='KES';
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        VATCaptionLbl: Label 'VAT';
        PAYMENT_DETAILSCaptionLbl: Label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        NET_AMOUNTCaptionLbl: Label 'AMOUNT';
        W_TAXCaptionLbl: Label 'W/TAX';
        Document_No___CaptionLbl: Label 'Document No. :';
        Currency_CaptionLbl: Label 'Currency:';
        Payment_To_CaptionLbl: Label 'Payment To:';
        Document_Date_CaptionLbl: Label 'Document Date:';
        Cheque_No__CaptionLbl: Label 'Cheque No.:';
        R_CENTERCaptionLbl: Label 'R.CENTER CODE';
        PROJECTCaptionLbl: Label 'PROJECT CODE';
        TotalCaptionLbl: Label 'Total';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Amount_in_wordsCaptionLbl: Label 'Amount in words';
        EmptyStringCaptionLbl: Label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: Label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: Label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: Label 'Printed By:';
        TotalCaption_Control1102755033Lbl: Label 'Total';
        Signature_CaptionLbl: Label 'Signature:';
        Date_CaptionLbl: Label 'Date:';
        Name_CaptionLbl: Label 'Name:';
        RecipientCaptionLbl: Label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: Label 'Budget';
        CreationDoc: Boolean;
        PayeeNamesII: Text;
        CHEQUEVOUCHER: Label 'PAYMENT REPORT';
        DUPLICATE: Label 'DUPLICATE';
        RefferenceNew: Code[30];
        ApprovalEntryRec: Record "Approval Entry";
        Approval1: Code[50];
        ApprovedByCaption: Text;
        Approval1Date: Date;
        Approval2: Code[50];
        Approval2Date: Date;
        Approval3: Code[50];
        Approval3Date: Date;
        Approval4: Code[50];
        Approval4Date: Date;
        Approval5: Code[50];
        Approval5Date: Date;
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedBy: Text;
        PreparedByCaption: Text;
        EmployeeRecI: Record Employee;
        EmployeeRecII: Record Employee;
        EmployeeRecIII: Record Employee;
        EmployeeRecIV: Record Employee;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
}

