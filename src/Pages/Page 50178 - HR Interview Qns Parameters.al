page 50178 "HR Interview Qns Parameters"
{
    PageType = List;
    SourceTable = "Interview Qns Parameters";

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
                field("Evaluator No."; Rec."Evaluator No.")
                {
                }
                field(Closed; Rec.Closed)
                {
                    Visible = false;
                }
                field("Preliminary Qns"; Rec."Preliminary Qns")
                {
                }
                field("Technical Qns"; Rec."Technical Qns")
                {
                }
                field("Behavioural Qns"; Rec."Behavioural Qns")
                {
                }
                field("Closing Qns"; Rec."Closing Qns")
                {
                }
                field(Total; Rec.Total)
                {
                }
            }
        }
    }

    actions
    {
    }
}

