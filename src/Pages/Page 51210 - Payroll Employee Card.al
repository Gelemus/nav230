page 51210 "Payroll Employee Card"
{
    Caption = 'Employee Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update;
                    end;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Importance = Promoted;
                }
                field("First Name"; Rec."First Name")
                {
                    Importance = Promoted;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Caption = 'Second Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Postal Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Physical Address';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Importance = Promoted;
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    Editable = false;
                }
                field("Calculation Scheme"; Rec."Calculation Scheme")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Importance = Promoted;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    Importance = Promoted;
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Importance = Promoted;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; Rec."Employment Date")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                }
                field("Termination Date"; Rec."Termination Date")
                {

                    trigger OnValidate()
                    begin
                        Rec.GetDurations;
                    end;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; Rec."Birth Date")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Rec.GetDurations;
                    end;
                }
                field(Age; Rec.Age)
                {
                }
                field(Service; Rec.Service)
                {
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                Visible = true;
                field("Posting Group"; Rec."Posting Group")
                {
                    Editable = true;
                }
                field(PIN; Rec.PIN)
                {
                    ShowMandatory = true;
                }
                field("National ID"; Rec."National ID")
                {
                    ShowMandatory = true;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ShowMandatory = true;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ShowMandatory = true;
                }
                field("Membership No."; Rec."Membership No.")
                {
                    Caption = 'Sacco Membership No.';
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ShowMandatory = true;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ShowMandatory = true;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ShowMandatory = true;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    Editable = false;
                }
                field("No of Days"; Rec."No of Days")
                {
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                }
                field("Fixed Pay"; Rec."Fixed Pay")
                {
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("&Alternative Addresses")
                {
                    Caption = '&Alternative Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Relatives")
                {
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                separator(Separator23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                }
                separator(Separator61)
                {
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        Rec.DisplayMap;
                    end;
                }
                action("Convert To General")
                {
                    Caption = 'Convert To Temporary';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        EmployeeRec: Record Employee;
                        EmployeeCopy: Record Employee;
                    begin
                        EmployeeRec.Copy(Rec);
                        EmployeeCopy.Init;
                        EmployeeCopy.Copy(Rec);
                        EmployeeCopy."No." := Rec."No." + 'c';
                        EmployeeCopy."Payroll Code" := 'TEMPORARY';
                        EmployeeCopy."Calculation Scheme" := 'TEMPORARY';
                        EmployeeCopy."Posting Group" := 'TEMPORARY';
                        EmployeeCopy."Imprest Posting Group" := 'TEMPORARY';
                        EmployeeCopy."Employee Posting Group" := 'TEMPORARY';
                        EmployeeCopy.Insert;
                        Message('Successfully Converted to %1 ', EmployeeCopy."No.");

                        Rec.Status := Rec.Status::Inactive;
                        Rec."Inactive Date" := Today;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        MapPointVisible := true;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        gsSegmentPayrollData;

        if not MapMgt.TestSetup then
            MapPointVisible := false;

        if Rec."Payroll Code" = 'TEMPORARY' then
            ShowConvert := true
        else
            ShowConvert := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        /*IF "Phone No." = ''
        THEN
        ERROR('Please insert a value into the Phone No. field');//Mesh
        IF "Employment Date" = 0D
        THEN
        ERROR('Please insert a value into the Employment Date field');//Mesh
        
        IF "NSSF No." = ''
        THEN
        ERROR('Please insert a value into the NSSF No field');//Mesh
        
        IF "NHIF No." = ''
        THEN
        ERROR('Please insert a value into the NHIF No. field');//Mesh
        
        IF "National ID" = ''
        THEN
        ERROR('Please insert a value into the National ID field');//Mesh
        
        IF PIN = ''
        THEN
        ERROR('Please insert a value into the KRA PIN No field');//Mesh
        
        IF "Mode of Payment" = ''
        THEN
        ERROR('Please insert a value into the Mode of Payment field');*///Mesh

    end;

    var
        [InDataSet]
        MapPointVisible: Boolean;
        ShowConvert: Boolean;

    local procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);
    end;
}

