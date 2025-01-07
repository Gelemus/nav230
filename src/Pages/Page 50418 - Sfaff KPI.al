page 50418 "Sfaff KPI"
{
    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Employee Qualification";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Performance Target"; Rec."Performance Target")
                {
                }
                field(Unit; Rec.Unit)
                {
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                }
                field(Apprasee; Rec.Apprasee)
                {
                }
                field(Appraiser; Rec.Appraiser)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Kpi;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::Kpi;
    end;

    trigger OnOpenPage()
    begin
        Rec."Document Type" := Rec."Document Type"::Kpi;
    end;
}

