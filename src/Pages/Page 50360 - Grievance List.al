page 50360 "Grievance List"
{
    CardPageID = "Grievance Card";
    PageType = List;
    SourceTable = "User Support Incidences";
    SourceTableView = WHERE(Category = CONST(Grievance));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'Grievance Reference';
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'Grievance Description';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Grievance Date';
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
                    Caption = 'Grievance Status';
                }
                field("Work place Controller"; Rec."Work place Controller")
                {
                }
                field("Work place Controller Name"; Rec."Work place Controller Name")
                {
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

