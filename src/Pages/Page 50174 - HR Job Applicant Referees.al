page 50174 "HR Job Applicant Referees"
{
    Caption = 'Job Applicant Referees';
    PageType = List;
    SourceTable = "HR Applicant Referee Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Surname; Rec.Surname)
                {
                }
                field(Firstname; Rec.Firstname)
                {
                }
                field(Middlename; Rec.Middlename)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Personal E-Mail Address"; Rec."Personal E-Mail Address")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Applicant E-mail"; Rec."Applicant E-mail")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field("Referee Category"; Rec."Referee Category")
                {
                }
            }
        }
    }

    actions
    {
    }
}

