report 50071 "HR Jobs"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Jobs.rdl';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = Status;
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address; CI."Address 2")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(Country; CI."Country/Region Code")
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CI_TelephoneNo; CI."Telephone No.")
            {
            }
            column(CI_Email; CI."E-Mail")
            {
            }
            column(CI_Website; CI."Home Page")
            {
            }
            column(CI_Vision; Text0001)
            {
            }
            column(Lno; Lno)
            {
            }
            column(No_HRJob; "HR Jobs"."No.")
            {
            }
            column(JobTitle_HRJob; "HR Jobs"."Job Title")
            {
            }
            column(JobGrade_HRJob; "HR Jobs"."Job Grade")
            {
            }
            column(MaximumPositions_HRJob; "HR Jobs"."Maximum Positions")
            {
            }
            column(OccupiedPositions_HRJob; "HR Jobs"."Occupied Positions")
            {
            }
            column(VacantPositions_HRJob; "HR Jobs"."Vacant Positions")
            {
            }
            column(Vacant; "HR Jobs"."Maximum Positions" - "HR Jobs"."Occupied Positions")
            {
            }
            column(Levels; "HR Jobs".Levels)
            {
            }
            column(SupervisorJobNo_HRJob; "HR Jobs"."Supervisor Job No.")
            {
            }
            column(SupervisorJobTitle_HRJob; "HR Jobs"."Supervisor Job Title")
            {
            }
            column(Description_HRJob; "HR Jobs".Description)
            {
            }
            column(GlobalDimension1Code_HRJob; "HR Jobs"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRJob; "HR Jobs"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_HRJob; "HR Jobs"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_HRJob; "HR Jobs"."Shortcut Dimension 4 Code")
            {
            }
            column(ShortcutDimension5Code_HRJob; "HR Jobs"."Shortcut Dimension 5 Code")
            {
            }
            column(ShortcutDimension6Code_HRJob; "HR Jobs"."Shortcut Dimension 6 Code")
            {
            }
            column(ShortcutDimension7Code_HRJob; "HR Jobs"."Shortcut Dimension 7 Code")
            {
            }
            column(ShortcutDimension8Code_HRJob; "HR Jobs"."Shortcut Dimension 8 Code")
            {
            }
            column(ResponsibilityCenter_HRJob; "HR Jobs"."Responsibility Center")
            {
            }
            column(Status_HRJob; "HR Jobs".Status)
            {
            }
            column(UserID_HRJob; "HR Jobs"."User ID")
            {
            }
            column(NoSeries_HRJob; "HR Jobs"."No. Series")
            {
            }
            column(IncomingDocumentEntryNo_HRJob; "HR Jobs"."Incoming Document Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
                if "HR Jobs"."Maximum Positions" = 0 then
                    CurrReport.Skip;
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
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        CI: Record "Company Information";
        Lno: Integer;
        Text0001: Label '"Turning Ideas into Wealth"';
}

