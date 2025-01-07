page 50685 "Board Member Card"
{
    DeleteAllowed = true;
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
                field(Title; Rec.Title)
                {
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
                field("Full Name"; Rec."Full Name")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the Gender';
                }
                field("Employee Grade"; Rec."Employee Grade")
                {
                }
                field(Age; Rec.Age)
                {
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
                field(Position; Rec.Position)
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
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
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                }
                field("Employment Years of Service"; Rec."Employement Years of Service")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the  Employee Status.';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    Visible = CauseOfInactivityVisible;
                }
                field("Calculation Scheme"; Rec."Calculation Scheme")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the  User ID that created the Employee Card.';
                }
            }
            group("Important Numbers")
            {
                field("National ID"; Rec."National ID")
                {
                }
                field("Huduma No."; Rec."Huduma No.")
                {
                }
                field("Passport No.-d"; Rec."Passport No.-d")
                {
                    ToolTip = 'Specifies the Passport No.';
                }
                field(PIN; Rec.PIN)
                {
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                }
                field(Sanlam; Rec.Sanlam)
                {
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
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
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
                field(Liberty; Rec.Liberty)
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
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control4; "Employee Signature")
            {
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
            action("Page Employee Ledger Entries")
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
                Caption = 'Notify ICT for Account creation';
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

    trigger OnAfterGetCurrRecord()
    var
        "`": Integer;
    begin
        //Calculate Leave Balance
        Clear(AnnualLeaveBalance);
        LeaveTypes.Reset;
        LeaveTypes.SetRange("Annual Leave", true);
        if LeaveTypes.FindFirst then
            AnnualLeaveCode := LeaveTypes.Code;

        LeavePeriods.Reset;
        LeavePeriods.SetRange(Closed, true);
        if LeavePeriods.FindFirst then
            LeaveYear := LeavePeriods."Leave Year";

        CurrentYear := Date2DMY(Today, 3);
        LeaveLedgerEntries.Reset;
        LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Employee No.", Rec."No.");
        LeaveLedgerEntries.SetRange(LeaveLedgerEntries."Leave Type", AnnualLeaveCode);
        LeaveLedgerEntries.SetRange("Leave Year", LeaveYear);
        LeaveLedgerEntries.CalcSums(LeaveLedgerEntries.Days);
        AnnualLeaveBalance := LeaveLedgerEntries.Days;

        //Calculate Age
        /*HRSetup.GET;
        IF "Employment Date" <> 0D THEN
         "Employement Years of Service":=Dates.DetermineAge_Years("Employment Date",TODAY);
        IF "Birth Date" <> 0D THEN
         Age := Dates.DetermineAge_Years("Birth Date",TODAY);
        "Retirement Date" := CALCDATE(HRSetup."Retirement Age","Birth Date");
        */

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
        LeaveLedgerEntries: Record "HR Leave Ledger Entries";
        LeaveTypes: Record "HR Leave Types";
        LeavePeriods: Record "HR Leave Periods";
        LeaveYear: Integer;
        AnnualLeaveCode: Code[20];
        EmployeeManagement: Codeunit "HR Employee Management";
        HRSetup: Record "Human Resources Setup";
}

