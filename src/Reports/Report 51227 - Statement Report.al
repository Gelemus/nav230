report 51227 "Statement Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Statement Report.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            DataItemTableView = SORTING("Bank Account No.", "Statement No.") ORDER(Ascending);
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(Bank_Account_Nos; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(Statement_Nos; "Bank Account Statement"."Statement No.")
            {
            }
            column(Statement_Ending_Balance; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(Statement_Date; "Bank Account Statement"."Statement Date")
            {
            }
            column(Balance_Last_Statement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Statement No." = FIELD("Statement No."), "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.") ORDER(Ascending);
                column(Bank_Account_No; "Bank Account Statement Line"."Bank Account No.")
                {
                }
                column(Statement_No; "Bank Account Statement Line"."Statement No.")
                {
                }
                column(Statement_Line_No; "Bank Account Statement Line"."Statement Line No.")
                {
                }
                column(Document_No; "Bank Account Statement Line"."Document No.")
                {
                }
                column(Transaction_Date; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(Description; "Bank Account Statement Line".Description)
                {
                }
                column(Statement_Amount; "Bank Account Statement Line"."Statement Amount")
                {
                }
                column(Difference; "Bank Account Statement Line".Difference)
                {
                }
                column(Applied_Amount; "Bank Account Statement Line"."Applied Amount")
                {
                }
                column(Type; "Bank Account Statement Line".Type)
                {
                }
                column(Applied_Entries; "Bank Account Statement Line"."Applied Entries")
                {
                }
                column(WithholdingVATAmount_PaymentHeader; "Bank Account Statement Line"."Value Date")
                {
                }
                column(WithHoldingTaxAmount_PaymentHeader; "Bank Account Statement Line"."Check No.")
                {
                }
                column(WithHoldingTaxAmount; "Bank Account Statement Line"."Transaction ID")
                {
                }
                column(TotalDiff; TotalDiff + "Bank Account Statement Line".Difference)
                {
                }
                column(TotalBalance; TotalBalance + "Bank Account Statement Line"."Statement Amount")
                {
                }
                column(Balance; Balance + "Bank Account Statement Line"."Statement Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*IF Vendor.GET("Account No.") THEN BEGIN
                      PayeeAddress:=Vendor.Address;
                      PayeeBankName:=Vendor."Bank Account Name";
                    END;
                    IF PostedInvoice.GET("Applies-to Doc. No.") THEN BEGIN
                      InvoiceNo:=PostedInvoice."Vendor Invoice No.";
                      InvoiceDate:=PostedInvoice."Posting Date";
                    END;
                    
                    
                    IF "Withholding Tax Code"<>'' THEN BEGIN
                      IF FundsTaxCodes.GET("Withholding Tax Code") THEN
                        "WHT%":=FORMAT(FundsTaxCodes.Percentage);
                    END;
                    
                    
                    IF "Withholding VAT Code"<>'' THEN BEGIN
                       IF FundsTaxCodes.GET("Withholding Tax Code") THEN
                        "WHTVAT%":=(FundsTaxCodes.Percentage);
                    END;
                    
                    
                    PaymentHeader.RESET;
                    PaymentHeader.SETRANGE(PaymentHeader."No.","Payment Line"."Document No.");
                    IF PaymentHeader.FINDFIRST THEN BEGIN
                      DocNo:="Payment Line"."Account No.";
                      IF PaymentHeader."Loan No."<>'' THEN
                        DocNo:=PaymentHeader."Loan No." ;
                      END;
                    */
                    CalcBalance("Bank Account Statement Line"."Statement Line No.");

                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*TotalAmount:=0;
                CALCFIELDS("Total Amount","Net Amount","WithHolding Tax Amount");
                TotalAmount:="Net Amount";
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText,("Net Amount"),"Currency Code");
                
                IF Bank.GET("Bank Account No.") THEN BEGIN
                  BankName:=Bank.Name;
                  BankAccountNo:=Bank."Bank Account No.";
                END;
                
                
                IF "Payment Header"."Payment Mode"="Payment Header"."Payment Mode"::Cheque THEN BEGIN
                  PayMode:=PayMode::"Cheque No.";
                  ChequeNo:="Payment Header"."Cheque No.";
                END ELSE BEGIN
                  PayMode:=PayMode::"Refference No.";
                  ChequeNo:="Payment Header"."Reference No.";
                END;
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

    trigger OnInitReport()
    begin
        /*BalanceEnable := TRUE;
        TotalBalanceEnable := TRUE;
        TotalDiffEnable := TRUE;
        */

    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        CompanyInfo: Record "Company Information";
        Bank: Record "Bank Account";
        BankAccountNo: Code[20];
        BankName: Text[100];
        PayeeAddress: Text[100];
        InvoiceDate: Date;
        InvoiceNo: Code[50];
        TotalAmount: Decimal;
        PurchaseInvoice: Record "Purch. Inv. Header";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        Vendor: Record Vendor;
        PostedInvoice: Record "Purch. Inv. Header";
        "WHT%": Text;
        FundsTaxCodes: Record "Funds Tax Code";
        "WHTVAT%": Integer;
        PaymentLine: Record "Payment Line";
        PayeeBankName: Text;
        DocNo: Code[30];
        PaymentHeader: Record "Payment Header";
        ChequeNo: Code[100];
        PayMode: Option "Cheque No.","Refference No.";
        TotalDiff: Decimal;
        TotalBalance: Decimal;
        Balance: Decimal;
        [InDataSet]
        TotalDiffEnable: Boolean;
        [InDataSet]
        TotalBalanceEnable: Boolean;
        [InDataSet]
        BalanceEnable: Boolean;

    local procedure CalcBalance(BankAccStmtLineNo: Integer)
    var
        BankAccStmt: Record "Bank Account Statement";
        TempBankAccStmtLine: Record "Bank Account Statement Line";
    begin
        if BankAccStmt.Get(TempBankAccStmtLine."Bank Account No.", TempBankAccStmtLine."Statement No.") then;

        TempBankAccStmtLine.Copy(TempBankAccStmtLine);

        TotalDiff := -TempBankAccStmtLine.Difference;
        if TempBankAccStmtLine.CalcSums(TempBankAccStmtLine.Difference) then begin
            TotalDiff := TotalDiff + TempBankAccStmtLine.Difference;
            TotalDiffEnable := true;
        end else
            TotalDiffEnable := false;

        TotalBalance := BankAccStmt."Balance Last Statement" - TempBankAccStmtLine."Statement Amount";
        if TempBankAccStmtLine.CalcSums(TempBankAccStmtLine."Statement Amount") then begin
            TotalBalance := TotalBalance + TempBankAccStmtLine."Statement Amount";
            TotalBalanceEnable := true;
        end else
            TotalBalanceEnable := false;

        Balance := BankAccStmt."Balance Last Statement" - TempBankAccStmtLine."Statement Amount";
        TempBankAccStmtLine.SetRange(TempBankAccStmtLine."Statement Line No.", 0, BankAccStmtLineNo);
        if TempBankAccStmtLine.CalcSums(TempBankAccStmtLine."Statement Amount") then begin
            Balance := Balance + TempBankAccStmtLine."Statement Amount";
            BalanceEnable := true;
        end else
            BalanceEnable := false;
    end;
}

