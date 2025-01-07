report 50181 "Reverse Equity Penalty"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Reverse Equity Penalty.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            RequestFilterFields = "Code";

            trigger OnAfterGetRecord()
            begin
                /*IF Table50324."No." = '' THEN BEGIN
                 ERROR('Equity Account No. Not Specified');
                END;
                
                GLEntry.RESET;
                GLEntry.SETRANGE(GLEntry."Investment Account No.",Table50324."No.");
                IF EndDate=0D THEN BEGIN
                  GLEntry.SETRANGE(GLEntry."Posting Date",StartDate);
                END ELSE BEGIN
                  GLEntry.SETRANGE(GLEntry."Posting Date",StartDate,EndDate);
                END;
                GLEntry.SETRANGE(GLEntry."Investment Transaction Type",GLEntry."Investment Transaction Type"::"Penalty Interest Receivable");
                IF GLEntry.FINDSET THEN BEGIN
                  REPEAT
                    CLEAR(ReversalEntry);
                    IF NOT GLEntry.Reversed THEN BEGIN
                      IF GLEntry."Journal Batch Name"='' THEN
                        ReversalEntry.TestFieldError;
                      GLEntry.TESTFIELD(GLEntry."Transaction No.");
                      ReversalEntry.SetHideDialog(TRUE);
                      ReversalEntry.ReverseTransaction2(GLEntry."Transaction No.");
                    END;
                  UNTIL GLEntry.NEXT=0;
                END;*/

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if StartDate = 0D then
            Error(Text0001);
        if EndDate = 0D then
            Error(Text0002);
        if StartDate > EndDate then
            Error(Text0003, Format(StartDate), Format(EndDate));
        if EndDate >= WorkDate then
            Error(Text0004, Format(EndDate), Format(WorkDate));
    end;

    var
        GLEntry: Record "G/L Entry";
        StartDate: Date;
        EndDate: Date;
        ReversalEntry: Record "Reversal Entry";
        Text0001: Label 'Select the End date on the request page. This cannot be empty';
        Text0002: Label 'Select the End date on the request page. This cannot be empty';
        Text0003: Label 'The Start Date %1 cannot be later than the End Date %2';
        Text0004: Label 'The End Date %1 cannot be later or equals to the current workdate %2';
}

