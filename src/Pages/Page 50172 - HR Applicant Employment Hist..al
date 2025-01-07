page 50172 "HR Applicant Employment Hist."
{
    PageType = List;
    SourceTable = "HR Applicant Employment Hist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Application No."; Rec."Job Application No.")
                {
                    Visible = false;
                }
                field("Employer Name/Organization"; Rec."Employer Name/Organization")
                {
                }
                field("Address of the Organization"; Rec."Address of the Organization")
                {
                    Visible = false;
                }
                field("Job Designation/Position Held"; Rec."Job Designation/Position Held")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("Days/Years of service"; Rec."Days/Years of service")
                {
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                }
                field(Benefits; Rec.Benefits)
                {
                }
            }
        }
    }

    actions
    {
    }
}

