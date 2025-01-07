page 50190 "HR Employee Relatives"
{
    Caption = 'HR Employee Family Details';
    PageType = List;
    SourceTable = "HR Employee Relative";
    SourceTableView = WHERE(Type = CONST(Relative));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Relative Code"; Rec."Relative Code")
                {
                    Caption = 'Relationship Type';
                    ToolTip = 'Specifies the Relative Code.';
                }
                field(Firstname; Rec.Firstname)
                {
                    ToolTip = 'Specifies the  Firstname.';
                }
                field(Middlename; Rec.Middlename)
                {
                    ToolTip = 'Specifies the Middlename.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the Surname.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the  Date of Birth.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the Age';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Relative;
    end;
}

