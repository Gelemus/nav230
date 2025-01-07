page 51185 "Payslip Lines"
{
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Payslip Lines";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Payslip Group"; Rec."Payslip Group")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line Type"; Rec."Line Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("E/D Code"; Rec."E/D Code")
                {
                    Visible = "E/D CodeVisible";
                }
                field(P9; Rec.P9)
                {
                    Visible = P9Visible;
                }
                field(Negative; Rec.Negative)
                {
                }
                field("P9 Text"; Rec."P9 Text")
                {
                    Visible = "P9 TextVisible";
                }
                field("E/D Description"; Rec."E/D Description")
                {
                    Editable = false;
                    Visible = "E/D DescriptionVisible";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "E/D DescriptionVisible" := true;
        "P9 TextVisible" := true;
        P9Visible := true;
        "E/D CodeVisible" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec, BelowxRec);
    end;

    trigger OnOpenPage()
    begin
        PayslipGroupRec.Get(Rec."Payslip Group", Rec."Payroll Code");

        if PayslipGroupRec."Line Type" = 0 then begin
            "E/D CodeVisible" := true;
            P9Visible := false;
            "P9 TextVisible" := false;
            "E/D DescriptionVisible" := true;
        end else begin
            "E/D CodeVisible" := false;
            P9Visible := true;
            "P9 TextVisible" := true;
            "E/D DescriptionVisible" := false;
        end;
    end;

    var
        PayslipGroupRec: Record "Payslip Group";
        [InDataSet]
        "E/D CodeVisible": Boolean;
        [InDataSet]
        P9Visible: Boolean;
        [InDataSet]
        "P9 TextVisible": Boolean;
        [InDataSet]
        "E/D DescriptionVisible": Boolean;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);

    end;
}

