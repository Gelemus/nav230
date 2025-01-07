page 50271 "HR Medical Sch. Beneficiaries"
{
    PageType = ListPart;
    SourceTable = "HR Medical Scheme Members";
    SourceTableView = WHERE("Cover Option" = FILTER(Dependant));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Principal No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Principal Name';
                    Editable = false;
                }
                field("Dependant Name"; Rec."Dependant Name")
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
                field(Age; Rec.Age)
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
        Rec."Cover Option" := Rec."Cover Option"::Dependant
    end;
}

