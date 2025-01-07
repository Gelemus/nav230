page 50193 "HR Employee Employement Hist."
{
    Caption = 'HR Employee Employement History';
    PageType = List;
    SourceTable = "HR Employee Employment Hist.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employer Name/Organization"; Rec."Employer Name/Organization")
                {
                }
                field("Address of the Organization"; Rec."Address of the Organization")
                {
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
                field("E-mail"; Rec."E-mail")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Links)
            {
            }
        }
    }

    actions
    {
    }
}

