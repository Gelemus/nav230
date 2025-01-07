page 50403 "Guards On Site  List"
{
    CardPageID = "Security Incident Card";
    PageType = List;
    SourceTable = "User Support Incidences";
    SourceTableView = WHERE(Category = CONST(Incident));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'Code';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Date';
                }
                field("Guard Name"; Rec."Guard Name")
                {
                }
                field(Occurrence; Rec.Occurrence)
                {
                }
                field(Shift; Rec.Shift)
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("User email Address"; Rec."User email Address")
                {
                }
            }
        }
    }

    actions
    {
    }
}

