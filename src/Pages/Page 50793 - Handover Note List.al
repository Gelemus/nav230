page 50793 "Handover Note List"
{
    CardPageID = "Handover Notes Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE("Document Type" = FILTER("Handover Notes"),
                            Status = FILTER(<> Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::"Handover Notes";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Handover Notes";
    end;
}

