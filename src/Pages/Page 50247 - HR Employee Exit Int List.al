page 50247 "HR Employee Exit Int List"
{
    CardPageID = "HR Employee Exit Interviews";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Exit Interviews";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Exit Interview No"; Rec."Exit Interview No")
                {
                }
                field("Date Of Interview"; Rec."Date Of Interview")
                {
                }
                field("Interview Done By"; Rec."Interview Done By")
                {
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                }
                field("Clearance Form Submitted"; Rec."Clearance Form Submitted")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Exit Int. Questionnare")
            {
                Caption = 'Print Exit Interview Questionnaire';
                Image = Form;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin

                    Rec.SetRange("Exit Interview No", Rec."Exit Interview No");
                    //  ReportSelections.Print(ReportSelections.Usage::"Exit Interview",Rec,0);
                end;
            }
            action("Print Departmental Clearance")
            {
                Caption = 'Print Departmental Clearance';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin

                    Rec.SetRange("Exit Interview No", Rec."Exit Interview No");
                    // ReportSelections.Print(ReportSelections.Usage::"Clearance Form",Rec,0);
                end;
            }
        }
    }

    var
        ReportSelections: Record "Report Selections";
}

