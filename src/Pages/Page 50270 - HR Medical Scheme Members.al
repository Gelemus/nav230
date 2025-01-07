page 50270 "HR Medical Scheme Members"
{
    PageType = ListPart;
    SourceTable = "HR Medical Scheme Members";
    SourceTableView = WHERE("Cover Option" = FILTER(Principal));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Family Size"; Rec."Family Size")
                {
                }
                field("Cover Option"; Rec."Cover Option")
                {
                    Editable = false;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Editable = false;
                }
                field(Relation; Rec.Relation)
                {
                }
                field("In Patient Benfit"; Rec."In Patient Benfit")
                {
                    Editable = false;
                }
                field("Out patient Benefit"; Rec."Out patient Benefit")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Cover Option" := Rec."Cover Option"::Principal;
    end;
}

