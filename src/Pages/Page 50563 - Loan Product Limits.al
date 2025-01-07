page 50563 "Loan Product Limits"
{
    PageType = List;
    SourceTable = "Loan Product Grades";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Grade"; Rec."Job Grade")
                {
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Duplicate in All Job Grades")
            {
                Caption = 'Duplicate in All Job Grades';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Text0001) = false then exit;
                    Rec.TestField("Job Grade");
                    Rec.TestField("Max. Loan Amount");
                    AllocatedAmount := Rec."Max. Loan Amount";
                    LoanProductCode := Rec."Loan Product";

                    LoanProductGrades.Reset;
                    LoanProductGrades.SetRange("Loan Product", Rec."Loan Product");
                    if LoanProductGrades.FindSet then
                        LoanProductGrades.DeleteAll;

                    JobGrades.Reset;
                    JobGrades.SetRange(JobGrades.Option, JobGrades.Option::"Job Grade");
                    if JobGrades.FindSet then begin
                        repeat
                            LoanProductGrades.Init;
                            LoanProductGrades."Loan Product" := LoanProductCode;
                            LoanProductGrades."Job Grade" := JobGrades.Code;
                            LoanProductGrades."Max. Loan Amount" := AllocatedAmount;
                            LoanProductGrades.Insert;
                        until JobGrades.Next = 0;
                    end
                end;
            }
        }
    }

    var
        Text0001: Label 'Duplicate same amount in all Grades?';
        LoanProductGrades: Record "Loan Product Grades";
        AllocatedAmount: Decimal;
        JobGrades: Record "HR Job Lookup Value";
        LoanProductCode: Code[50];
}

