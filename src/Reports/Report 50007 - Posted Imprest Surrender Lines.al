report 50007 "Posted Imprest Surrender Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Posted Imprest Surrender Lines.rdl';

    dataset
    {
        dataitem("Imprest Surrender Line"; "Imprest Surrender Line")
        {
            DataItemTableView = WHERE(Posted = CONST(true));
            RequestFilterFields = "Employee No.", "Document No.", "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(DocumentNo; "Imprest Surrender Line"."Document No.")
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(ImprestCode; "Imprest Surrender Line"."Imprest Code")
            {
            }
            column(AccountNo; "Imprest Surrender Line"."Account No.")
            {
            }
            column(AccountName; "Imprest Surrender Line"."Account Name")
            {
            }
            column(Description; "Imprest Surrender Line".Description)
            {
            }
            column(Amount; "Imprest Surrender Line"."Gross Amount")
            {
            }
            column(ActualSpent; "Imprest Surrender Line"."Actual Spent")
            {
            }
            column(Difference; "Imprest Surrender Line".Difference)
            {
            }
            column(ProjectCode; "Imprest Surrender Line"."Global Dimension 1 Code")
            {
            }
            column(CostCategory; "Imprest Surrender Line"."Global Dimension 2 Code")
            {
            }
            column(ProgramArea; "Imprest Surrender Line"."Shortcut Dimension 3 Code")
            {
            }
            column(SubProgramArea; "Imprest Surrender Line"."Shortcut Dimension 4 Code")
            {
            }
            column(CountyCode; "Imprest Surrender Line"."Shortcut Dimension 5 Code")
            {
            }
            column(SiteCode; "Imprest Surrender Line"."Shortcut Dimension 6 Code")
            {
            }
            column(EmployeeNo_ImprestSurrenderLine; "EmployeeNo.")
            {
            }
            column(EmployeeName_ImprestSurrenderLine; EmployeeName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PostingDate := 0D;
                CurrencyCode := '';
                "EmployeeNo." := '';
                EmployeeName := '';

                ImprestSurrenderHeader.Reset;
                if ImprestSurrenderHeader.Get("Imprest Surrender Line"."Document No.") then begin
                    if ImprestSurrenderHeader.Posted then begin
                        PostingDate := ImprestSurrenderHeader."Posting Date";
                        CurrencyCode := ImprestSurrenderHeader."Currency Code";
                        "EmployeeNo." := ImprestSurrenderHeader."Employee No.";
                        EmployeeName := ImprestSurrenderHeader."Employee Name";
                    end else begin
                        CurrReport.Skip;
                    end;
                end else begin
                    CurrReport.Skip;
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

    var
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        PostingDate: Date;
        CurrencyCode: Code[10];
        "EmployeeNo.": Code[20];
        EmployeeName: Text;
}

