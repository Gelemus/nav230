table 51121 "Document Emailing Users"
{
    Permissions = TableData "G/L Entry" = rimd;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            NotBlank = true;

            trigger OnLookup()
            begin
                //LoginMgt.LookupUserID("User ID"); musya.
            end;

            trigger OnValidate()
            begin
                // LoginMgt.ValidateUserID("User ID"); musya
            end;
        }
        field(2; "Customer Statement Due Not."; Boolean)
        {
        }
        field(3; "Sales Invoice Due Notification"; Boolean)
        {
        }
        field(4; "Service Invoice Due Notif."; Boolean)
        {
        }
        field(5; "Remit. Advice Due Notif."; Boolean)
        {
        }
        field(6; "Payments Advice Due Notif."; Boolean)
        {
        }
        field(7; "EFT Remit. Due Notif."; Boolean)
        {
        }
        field(8; "Reminder Due Notification"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LoginMgt: Codeunit "User Management";
}

