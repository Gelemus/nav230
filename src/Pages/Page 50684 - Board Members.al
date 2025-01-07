page 50684 "Board Members"
{
    CardPageID = "Board Member Card";
    DeleteAllowed = true;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = WHERE("Board Members" = FILTER(true));

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
                field("Full Name"; Rec."Full Name")
                {
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
                field(Position; Rec.Position)
                {
                }
                field("Birth Date"; Rec."Birth Date")
                {
                }
                field("Employment Date"; Rec."Employment Date")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
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
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
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
                field(Address; Rec.Address)
                {
                }
                field("On Probation"; Rec."On Probation")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control4; "Employee Signature")
            {
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1; Links)
            {
                Visible = false;
            }
            systempart(Control2; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Employee Relative")
            {
                Caption = 'Employee Family Details';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Relatives";
                RunPageLink = "Employee No." = FIELD("No."),
                              Type = CONST(Relative);
                ToolTip = 'Specifies Employee Relative.';
            }
            action("Employee Next of Kin")
            {
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Next of Kin";
                RunPageLink = "Employee No." = FIELD("No."),
                              Type = CONST("Next Of Kin");
                ToolTip = 'Specifies Employee Next of Kin.';
            }
            action("Employee Beneficiary")
            {
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Beneficiary";
                RunPageLink = "Employee No." = FIELD("No."),
                              Type = CONST(Beneficiary);
                ToolTip = 'Specifies Employee Next of Kin.';
            }
            action("Employee Referees")
            {
                Image = ResourceGroup;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Referees";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Employee Leave Type")
            {
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "Employee Leave Type";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Specifies the Leave Type.';
            }
            action("Employee Leave Ledger")
            {
                Image = ItemLedger;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "Leave Ledger Entries";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Job Qualifications")
            {
                Caption = 'Job Qualifications';
                Image = BulletList;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Qualifications";
                RunPageLink = "Job No." = FIELD(Position);
                ToolTip = 'Specifies the Job Qualification Requirements';
            }
            action("Job Requirements")
            {
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job No." = FIELD(Position);
                ToolTip = 'Specifies the Job General Requirements';
            }
            action("Job Responsibilities")
            {
                Caption = 'Job Responsibilities';
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job No." = FIELD(Position);
                ToolTip = 'Specifies the Job Responsibilities';
            }
            action("Salary Notch")
            {
                Image = JobLedger;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "HR Job Values";
                RunPageLink = Option = CONST("Job Grade Level"),
                              Code = FIELD("HR Salary Notch");
            }
            action("Employee Qualifications")
            {
                Image = BulletList;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Employee Qualifications";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Employee Professional Bodies")
            {
                Image = PostedReceivableVoucher;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "HR Employees Prof Body";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Employee Employement Hist.")
            {
                Caption = 'Employee Employement History';
                Image = InteractionLog;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Employement Hist.";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            action("Disciplinary Cases")
            {
                Caption = 'Disciplinary Cases';
                Image = DecreaseIndent;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                RunObject = Page "Disciplinary Case";
                RunPageLink = "Employee No" = FIELD("No.");
            }
            action("Employee Detail History")
            {
                Image = History;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                RunObject = Page "Employee Detail Updates";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Specifies the  Employee Deatil History.';
            }
            action("Employee Training History")
            {
                Image = History;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                RunObject = Page "Training Applications";
                RunPageLink = "No." = FIELD("No.");
                ToolTip = 'Specifies the  Employee Training History.';
            }
        }
        area(reporting)
        {
            action("Employees Statement")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Employees Statement';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Employees Statement";
                ToolTip = 'View Job Positions in the Organization. The report also shows information about Job establishment/positions in the organization.';

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    if Rec.FindFirst then begin
                        REPORT.RunModal(REPORT::"Employees Statement", true, false, Rec);
                    end;
                end;
            }
        }
    }
}

