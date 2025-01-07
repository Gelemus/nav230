report 51183 "Payroll Posting Buffer"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Payroll Posting Buffer.rdl';

    dataset
    {
        dataitem("Payroll Posting Buffer"; "Payroll Posting Buffer")
        {
            DataItemTableView = SORTING("Buffer No");
            RequestFilterFields = "Payroll Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Payroll_Posting_Buffer__Buffer_No_; "Buffer No")
            {
            }
            column(Payroll_Posting_Buffer__Account_Type_; "Account Type")
            {
            }
            column(Payroll_Posting_Buffer__Account_No_; "Account No")
            {
            }
            column(Payroll_Posting_Buffer__Payroll_Code_; "Payroll Code")
            {
            }
            column(Payroll_Posting_Buffer__ED_Code_; "ED Code")
            {
            }
            column(Payroll_Posting_Buffer_Amount; Amount)
            {
            }
            column(Payroll_Posting_Buffer__Currency_Code_; "Currency Code")
            {
            }
            column(Payroll_Posting_Buffer__Currency_Factor_; "Currency Factor")
            {
            }
            column(Payroll_Posting_Buffer__Amount__LCY__; "Amount (LCY)")
            {
            }
            column(Payroll_Posting_Buffer__Amount__LCY___Control1102754008; "Amount (LCY)")
            {
            }
            column(Payroll_Posting_Buffer__Employee_No_; "Payroll Posting Buffer"."Employee No.")
            {
            }
            column(Payroll_Posting_BufferCaption; Payroll_Posting_BufferCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payroll_Posting_Buffer__Buffer_No_Caption; FieldCaption("Buffer No"))
            {
            }
            column(Payroll_Posting_Buffer__Account_Type_Caption; FieldCaption("Account Type"))
            {
            }
            column(Payroll_Posting_Buffer__Account_No_Caption; FieldCaption("Account No"))
            {
            }
            column(Payroll_Posting_Buffer__Payroll_Code_Caption; FieldCaption("Payroll Code"))
            {
            }
            column(Payroll_Posting_Buffer__ED_Code_Caption; FieldCaption("ED Code"))
            {
            }
            column(Payroll_Posting_Buffer_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Payroll_Posting_Buffer__Currency_Code_Caption; FieldCaption("Currency Code"))
            {
            }
            column(Payroll_Posting_Buffer__Currency_Factor_Caption; FieldCaption("Currency Factor"))
            {
            }
            column(Payroll_Posting_Buffer__Amount__LCY__Caption; FieldCaption("Amount (LCY)"))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(GLName; GLName)
            {
            }
            dataitem("Payroll Dimension"; "Payroll Dimension")
            {
                DataItemLink = "Entry No" = FIELD("Buffer No");
                DataItemTableView = SORTING("Table ID", "Payroll ID", "Employee No", "Entry No", "ED Code", "Dimension Code", "Payroll Code") ORDER(Ascending) WHERE("Table ID" = FILTER(52021893));
                column(Payroll_Dimension__Dimension_Code_; "Dimension Code")
                {
                }
                column(Payroll_Dimension__Dimension_Value_Code_; "Dimension Value Code")
                {
                }
                column(Payroll_Dimension_Table_ID; "Table ID")
                {
                }
                column(Payroll_Dimension_Payroll_ID; "Payroll ID")
                {
                }
                column(Payroll_Dimension_Employee_No; "Employee No")
                {
                }
                column(Payroll_Dimension_Entry_No; "Entry No")
                {
                }
                column(Payroll_Dimension_ED_Code; "ED Code")
                {
                }
                column(Payroll_Dimension_Payroll_Code; "Payroll Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                GLName := '';
                if GL.Get("Payroll Posting Buffer"."Account No") then GLName := GL.Name;
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Payroll_Posting_BufferCaptionLbl: Label 'Payroll Posting Buffer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        GLName: Text[50];
        GL: Record "G/L Account";
}

