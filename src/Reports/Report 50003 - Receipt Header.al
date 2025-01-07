report 50003 "Receipt Header"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Receipt Header.rdl';

    dataset
    {
        dataitem("Receipt Header"; "Receipt Header")
        {
            column(No; "No.")
            {
            }
            column(Date; "Posting Date")
            {
            }
            column(Department; "Global Dimension 1 Code")
            {
            }
            column(CostCenter; "Global Dimension 2 Code")
            {
            }
            column(RHAmount; "Amount Received")
            {
            }
            column(RHAmountLCY; "Receipt Line".Amount)
            {
            }
            column(RHDescription; "Received From")
            {
            }
            column(RHDesc; Description)
            {
            }
            column(Payee; "On Behalf of")
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            column(CAddress2; CompanyInformation."Address 2")
            {
            }
            column(CImage; CompanyInformation.Picture)
            {
            }
            column(CFax; CompanyInformation."Fax No.")
            {
            }
            column(CTel; CompanyInformation."Phone No.")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(TotalAmountText; TotalAmountText[1])
            {
            }
            column(USERID_Control1102755012; UserId)
            {
            }
            column(Names; Names)
            {
            }
            dataitem("Receipt Line"; "Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(TType; "Receipt Line"."Receipt Code")
                {
                }
                column(Description; Description)
                {
                }
                column(Amount; Amount)
                {
                }
                column(AmountLCY; "Amount(LCY)")
                {
                }
                column(PayMode; "Receipt Line"."Document Type")
                {
                }
                column(ChequeNo; "Receipt Header"."Reference No.")
                {
                }
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "User ID" = FIELD("User ID");
                column(No_Employee; Employee."No.")
                {
                }
                column(FirstName_Employee; Employee."First Name")
                {
                }
                column(MiddleName_Employee; Employee."Middle Name")
                {
                }
                column(LastName_Employee; Employee."Last Name")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Receipt Header"."Line Amount");
                EnglishLanguageCode := 1033;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(TotalAmountText, ("Receipt Header"."Line Amount"), "Receipt Header"."Currency Code");



                HREmployees.Reset;
                HREmployees.SetRange(HREmployees."User ID", "Receipt Header"."User ID");
                if HREmployees.FindFirst then begin
                    Names := HREmployees."First Name";
                end;
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        CheckReport: Report Check;
        TotalLegalFee: Decimal;
        TotalMembershipFee: Decimal;
        TotalAmount: Decimal;
        TotalInvestment: Decimal;
        TotalAmountText: array[2] of Text[80];
        TotalInvestmentText: array[2] of Text[80];
        Percentage: Decimal;
        Interest: Decimal;
        InterestText: array[2] of Text;
        user: Record User;
        userid: Text;
        EnglishLanguageCode: Integer;
        Names: Text;
        HREmployees: Record Employee;
}

