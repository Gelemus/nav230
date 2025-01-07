pageextension 60329 pageextension60329 extends "Employee Card"
{
    layout
    {


        //Unsupported feature: Property Modification (ImplicitType) on ""Job Title"(Control 12)".

        modify(Initials)
        {
            Visible = true;
            ApplicationArea = All;
        }
        addafter("Last Name")
        {
            field(Balance; Rec.Balance)
            {
            }
            field(Position; Rec.Position)
            {
            }
        }
        addafter("Privacy Blocked")
        {
            field("Employee Name"; Rec."Employee Name")
            {
            }
        }
        addafter("Privacy Blocked")
        {

            field("UserID"; Rec."User ID")
            {
            }
        }
        addafter("UserID")
        {
            field("Imprest Posting Group"; Rec."Imprest Posting Group")
            {
                ApplicationArea = All;

            }
            field("Board Members"; Rec."Board Members")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        addfirst("Address & Contact")
        {
            field("National ID"; Rec."National ID")
            {
            }
            field("Huduma No."; Rec."Huduma No.")
            {
                Visible = false;
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
            field("Driving Licence No."; Rec."Driving Licence No.")
            {
                ToolTip = 'Specifies the  Driving Licence No.';
            }
        }
        addafter("Employment Date")
        {
            field(Driver; Rec.Driver)
            {
            }
        }
        addafter(Control3)
        {
            part(Control57; "Employee Signature")
            {
                SubPageLink = "No." = FIELD("No.");
            }
        }
        moveafter("Company E-Mail"; "Privacy Blocked")


    }
}

