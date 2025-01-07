page 50201 "Inactive Employees-Other Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE("Age-d" = FILTER(<> '0'),
                            Status = FILTER(<> Active));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the  Employee No.';

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the  first Name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the middle Name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the last Name';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the Gender';
                }
                field("Marital Status-d"; Rec."Marital Status-d")
                {
                    ToolTip = 'Specifies the Marital Status';
                }
                field("Job No.-d"; Rec."Job No.-d")
                {
                    ToolTip = 'Specifies the  Job Number.';
                }
                field(Title; Rec.Title)
                {
                    Editable = false;
                    ToolTip = 'Specifies the  Job Title.';
                }
                field("Job Grade-d"; Rec."Job Grade-d")
                {
                    ToolTip = 'Specifies the  Job Grade.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies Global Dimension 1 Code.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the  Employee Status.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the  User ID that created the Employee Card.';
                }
                field(AnnualLeaveBalance; AnnualLeaveBalance)
                {
                    Caption = 'AnnuaL Leave Balance';
                }
            }
            group("Important Numbers")
            {
                field("National ID No.-d"; Rec."National ID No.-d")
                {
                    ToolTip = 'Specifies the  ID No.';
                }
                field("Passport No.-d"; Rec."Passport No.-d")
                {
                    ToolTip = 'Specifies the Passport No.';
                }
                field("PIN No.-d"; Rec."PIN No.-d")
                {
                    ToolTip = 'Specifies the Pin No.';
                }
                field("NSSF No.-d"; Rec."NSSF No.-d")
                {
                    ToolTip = 'Specifies the  NSSF No.';
                }
                field("NHIF No.-d"; Rec."NHIF No.-d")
                {
                    ToolTip = 'Specifies the NHIF No.';
                }
                field("Driving Licence No."; Rec."Driving Licence No.")
                {
                    ToolTip = 'Specifies the  Driving Licence No.';
                }
                field(Control49; '')
                {
                    ShowCaption = false;
                }
            }
            group("Contact Information")
            {
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the  Phone No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'The Mobile Phone No';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the  Address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the Address 2.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the Post Code.';
                }
                field(City; Rec.City)
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the  Country Region Code.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the County Code.';
                }
                field("County Name"; Rec."County Name")
                {
                    ToolTip = 'Specifies the County Name.';
                }
                field("SubCounty Code"; Rec."SubCounty Code")
                {
                    ToolTip = 'Specifies the  Subcounty Code.';
                }
                field("SubCounty Name"; Rec."SubCounty Name")
                {
                    ToolTip = 'Specifies the  SubCounty Name.';
                }
            }
            group("Bank Information")
            {
                field("Bank Code-d"; Rec."Bank Code-d")
                {
                    Caption = 'Bank Code';
                    ToolTip = 'Specifies the Bank code.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Bank Name.';
                }
                field("Bank Branch Code-d"; Rec."Bank Branch Code-d")
                {
                    Caption = 'Bank Branch Code';
                    ToolTip = 'Specifies the Bank Branch code.';
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    Caption = 'Bank Branch Name';
                    Editable = false;
                    ToolTip = 'Specifies Bank Branch Name.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                    ToolTip = 'Specifies the Bank Account Number.';
                }
            }
            group("Important Dates")
            {
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the  Employement Date.';
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Contract Expiry Date"; Rec."Contract Expiry Date")
                {
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the  Birth date.';
                }
                field("Driving License Expiry Date"; Rec."Driving License Expiry Date")
                {
                }
                field(Control21; '')
                {
                    ShowCaption = false;
                }
            }
            group("Leave Details")
            {
                field("Leave Group"; Rec."Leave Group")
                {
                }
                field("Leave Calendar"; Rec."Leave Calendar")
                {
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    ToolTip = 'Specifies the  leave Status.';
                }
            }
            group(Posting)
            {
                field("Imprest Posting Group"; Rec."Imprest Posting Group")
                {
                    ToolTip = 'Specifies the  leave Status.';
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                }
            }
            group(Separation)
            {
                field("Termination Date"; Rec."Termination Date")
                {
                    Caption = 'Date of Separation';
                    ToolTip = 'Specifies the termination date.';
                }
                field("Reason For Leaving"; Rec."Reason For Leaving")
                {
                }
                field("Reason For Leaving (Other)"; Rec."Reason For Leaving (Other)")
                {
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ToolTip = 'Specifies the Grounds for Term Code.';
                    Visible = false;
                }
            }
            group("Web Portal")
            {
                field("Default Portal Password"; Rec."Default Portal Password")
                {
                    ToolTip = 'Specifies the  default Portal Password.';
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    ToolTip = 'Specifies the  Portal Password.';
                }
            }
        }
        area(factboxes)
        {
            part(Control6; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control4; "Employee Signature")
            {
                ApplicationArea = BasicHR;
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
                RunPageLink = "Job No." = FIELD("Job No.-d");
                ToolTip = 'Specifies the Job Qualification Requirements';
            }
            action("Job Requirements")
            {
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job No." = FIELD("Job No.-d");
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
                RunPageLink = "Job No." = FIELD("Job No.-d");
                ToolTip = 'Specifies the Job Responsibilities';
            }
            action("Salary Notch")
            {
                Image = JobLedger;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "HR Job Values";
                RunPageLink = Option = CONST("Job Grade Level");
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
    }

    var
        AnnualLeaveBalance: Decimal;
        CurrentYear: Integer;
}

