page 50176 "HR Job Applicant Results"
{
    PageType = List;
    SourceTable = "HR Job Applicant Results";
    SourceTableView = SORTING(Total)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Applicant No"; Rec."Job Applicant No")
                {
                }
                field(Surname; Rec.Surname)
                {
                }
                field(Firstname; Rec.Firstname)
                {
                }
                field(Middlename; Rec.Middlename)
                {
                }
                field("EV 1"; Rec."EV 1")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 2"; Rec."EV 2")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 3"; Rec."EV 3")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 4"; Rec."EV 4")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 5"; Rec."EV 5")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 6"; Rec."EV 6")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 7"; Rec."EV 7")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 8"; Rec."EV 8")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 9"; Rec."EV 9")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field("EV 10"; Rec."EV 10")
                {

                    trigger OnValidate()
                    begin
                        Rec.TestField(Closed, false);
                    end;
                }
                field(Total; Rec.Total)
                {
                }
                field(Position; Rec.Position)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Rank Interviewees")
            {
                Caption = 'Rank Interviewees';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    EmployeeRecruitment.RankInterviewees(Rec."Job Requistion No", Rec."Job No");
                end;
            }
            action("Print Final Score Sheet")
            {
                Caption = 'Print Final Score Sheet';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    JobApplicantResults.Reset;
                    JobApplicantResults.SetRange("Job Requistion No", Rec."Job Requistion No");
                    if JobApplicantResults.FindFirst then
                        REPORT.Run(REPORT::"HR Interview Results Report", true, true, JobApplicantResults);
                end;
            }
            action("Calculate Totals")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    EmployeeRecruitment.CalculateResultsTotals(Rec."Job Requistion No", Rec."Job No");
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    trigger OnOpenPage()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    var
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        JobApplicantResults: Record "HR Job Applicant Results";
}

