page 50194 "HR Employee Next of Kin"
{
    PageType = List;
    SourceTable = "HR Employee Relative";
    SourceTableView = WHERE(Type = CONST("Next Of Kin"));

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
                field("Relationship Description"; Rec."Relationship Description")
                {
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
        Rec.Type := Rec.Type::"Next Of Kin";
    end;
}

