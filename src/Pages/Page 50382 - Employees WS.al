page 50382 "Employees WS"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the  Employee Number.';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies First Name';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the Middle Name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies last Name';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the  Gender.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the Job Title';
                }
                field("Job Grade-d"; Rec."Job Grade-d")
                {
                    ToolTip = 'Specifies the  Job Grade.';
                }
                field("HR Salary Notch"; Rec."HR Salary Notch")
                {
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies Mobile Phone Number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("National ID No.-d"; Rec."National ID No.-d")
                {
                    ToolTip = 'Specifies the National ID No.';
                }
                field("PIN No.-d"; Rec."PIN No.-d")
                {
                    ToolTip = 'Specifies the  PIN No.';
                }
                field("NSSF No.-d"; Rec."NSSF No.-d")
                {
                    ToolTip = 'Specifies the  NSSF No.';
                }
                field("NHIF No.-d"; Rec."NHIF No.-d")
                {
                    ToolTip = 'Specifies the  NHIF No.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the  Employee status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the  User ID that Created the Card';
                }
                field("On Probation"; Rec."On Probation")
                {
                }
                field("Leave Group"; Rec."Leave Group")
                {
                }
                field("Imprest Balance"; Rec."Imprest Balance")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                }
                field("Probation Period"; Rec."Probation Period")
                {
                }
                field("Probation End date"; Rec."Probation End date")
                {
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                }
                field("Supervisor Job No."; Rec."Supervisor Job No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

