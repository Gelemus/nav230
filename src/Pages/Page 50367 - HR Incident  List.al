page 50367 "HR Incident  List"
{
    CardPageID = "Incident Card";
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
                    Caption = 'Incident Reference';
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'Incident Description';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Incident';
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("User email Address"; Rec."User email Address")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Caption = 'Incident Status';
                }
                field("Action taken"; Rec."Action taken")
                {
                }
                field("Action Date"; Rec."Action Date")
                {
                }
                field("System Support Email Address"; Rec."System Support Email Address")
                {
                }
                field("Remarks HR"; Rec."Remarks HR")
                {
                }
            }
        }
    }

    actions
    {
    }
}

