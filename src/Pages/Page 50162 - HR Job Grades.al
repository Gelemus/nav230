page 50162 "HR Job Grades"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Job Lookup Value";
    SourceTableView = SORTING(Option, Code)
                      ORDER(Descending)
                      WHERE(Option = CONST("Job Grade"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Option; Rec.Option)
                {
                    Editable = false;
                    ToolTip = 'Specifies the folowing options Qualification, Requirement, Responsibility, Job grade.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the code for a specific Job Grade.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description fot the specific Job code.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Action7)
            {
                Caption = 'Job Grade Levels';
                Image = LedgerBook;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Grade Levels";
                RunPageLink = "Job Grade" = FIELD(Code);
            }
            action("Job Grade Allowances")
            {
                Caption = 'Job Grade Allowances';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Grade Allowances";
                RunPageLink = "Job Grade" = FIELD(Code);
                Visible = false;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Option := Rec.Option::"Job Grade";
    end;
}

