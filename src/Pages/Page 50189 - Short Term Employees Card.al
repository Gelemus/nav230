page 50189 "Short Term Employees Card"
{
    PageType = Card;
    SourceTable = Employee;

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
                field("Age-d"; Rec."Age-d")
                {
                }
                field("Marital Status-d"; Rec."Marital Status-d")
                {
                    ToolTip = 'Specifies the Marital Status';
                }
                field("Person Living with Disability"; Rec."Person Living with Disability")
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Ethnic Group"; Rec."Ethnic Group")
                {
                }
                field(Religion; Rec.Religion)
                {
                }
                field("Job No.-d"; Rec."Job No.-d")
                {
                    ToolTip = 'Specifies the  Job Number.';
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Job Grade-d"; Rec."Job Grade-d")
                {
                    ToolTip = 'Specifies the  Job Grade.';
                }
                field("Supervisor Job No."; Rec."Supervisor Job No.")
                {
                }
                field("Supervisor Job Title"; Rec."Supervisor Job Title")
                {
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                }
                field("On Probation"; Rec."On Probation")
                {
                }
                field("HR Salary Notch"; Rec."HR Salary Notch")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies Global Dimension 1 Code.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Employment Years of Service"; Rec."Employement Years of Service")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the  Employee Status.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    Visible = CauseOfInactivityVisible;
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
                field("Huduma No."; Rec."Huduma No.")
                {
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
                field("County Code"; Rec."County Code")
                {
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
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                }
                field("Probation Period"; Rec."Probation Period")
                {
                }
                field("Probation End date"; Rec."Probation End date")
                {
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the  Birth date.';
                }
                field("Driving License Expiry Date"; Rec."Driving License Expiry Date")
                {
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
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                }
                field("Reason For Leaving (Other)"; Rec."Reason For Leaving (Other)")
                {
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
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
            part(Control4; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control3; "Employee Signature")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control2; Links)
            {
                Visible = false;
            }
            systempart(Control1; Notes)
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
                ToolTip = 'Specifies the  Employees Relatives.';
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
                ToolTip = 'Specifies the Employee Next of Kin.';
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
            action(" Employees Statement")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Employees Statement";

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    if Rec.FindFirst then begin
                        REPORT.RunModal(REPORT::"Employees Statement", true, false, Rec);
                    end;
                end;
            }
            separator(Separator106)
            {
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
            separator(Separator107)
            {
            }
            action("Confirm Employee")
            {
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Confirm verification of Employee Referees
                    HREmployeeRefereeDetails.Reset;
                    HREmployeeRefereeDetails.SetRange("Employee No.", Rec."No.");
                    if HREmployeeRefereeDetails.FindFirst then
                        HREmployeeRefereeDetails.TestField(HREmployeeRefereeDetails.Verified, true);

                    if Confirm(Txt_001) = false then exit;
                    Rec."On Probation" := false;
                    Rec.Modify;
                    Message(Txt_002);
                end;
            }
            action("Disciplinary Cases")
            {
                Caption = 'Disciplinary Cases';
                Image = DecreaseIndent;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "Disciplinary Case";
                RunPageLink = "Employee No" = FIELD("No.");
            }
            action("Employee Detail History")
            {
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Employee Detail Updates";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Specifies the  Employee Deatil History.';
            }
            action("Employees Statement")
            {
                Caption = 'Employees Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Employees Statement";
                ToolTip = 'Specifies the  Employees Statementy.';
            }
            action("Employee Training History")
            {
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Training Applications";
                RunPageLink = "No." = FIELD("No.");
                ToolTip = 'Specifies the  Employee Training History.';
            }
            action("Print Letter of Appointment")
            {
                Caption = 'Print Letter of Appointment';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    //  ReportSelections.Print(ReportSelections.Usage::"Letter of Appointment",Rec,0);
                end;
            }
            action("Ledger E&ntries")
            {
                ApplicationArea = BasicHR;
                Caption = 'Ledger E&ntries';
                Image = VendorLedger;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "Employee Ledger Entries";
                RunPageLink = "Employee No." = FIELD("No.");
                RunPageView = SORTING("Employee No.")
                              ORDER(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
            action("Send Mail Notification to ICT")
            {
                Caption = 'Send Mail Notification to ICT for Account creation and Supervisor';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send Mail Notification to ICT for Account creation';

                trigger OnAction()
                begin
                    EmployeeManagement.SendEmailNotificationToICT(Rec."No.");
                    //EmployeeManagement.SendEmailNotificationToSupervisor("No.","Supervisor Job No.");
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*CLEAR(AnnualLeaveBalance);
        CurrentYear:=DATE2DMY(TODAY,3);
        LeaveEntry.RESET;
        LeaveEntry.SETRANGE(LeaveEntry."Employee No.","No.");
        LeaveEntry.SETRANGE(LeaveEntry."Leave Type",'Annual');
        LeaveEntry.SETRANGE("Leave Year",CurrentYear);
        IF LeaveEntry.FINDSET THEN BEGIN
         REPEAT
           AnnualLeaveBalance:=AnnualLeaveBalance+LeaveEntry.Days;
         UNTIL LeaveEntry.NEXT=0;
        END;*/
        if Rec."Employment Date" <> 0D then
            Rec."Employement Years of Service" := Dates.DetermineAge_Years(Rec."Employment Date", Today);

    end;

    var
        AnnualLeaveBalance: Decimal;
        CurrentYear: Integer;
        CauseOfInactivityVisible: Boolean;
        Dates: Codeunit Dates;
        Employee: Record Employee;
        EmployeeNo: Code[10];
        HREmployeeRefereeDetails: Record "HR Employee Referee Details";
        Txt_001: Label 'Are you sure you want to Confirm Employee?';
        Txt_002: Label 'Employee %1 has been confirmed.';
        ReportSelections: Record "Report Selections";
        EmployeeManagement: Codeunit "HR Employee Management";
}

