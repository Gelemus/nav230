page 50348 "Commitee Members Subform"
{
    PageType = ListPart;
    SourceTable = "Commitee Members";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Chair; Rec.Chair)
                {
                }
                field(Secretary; Rec.Secretary)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        headerrec.Reset;
        if headerrec.Get(Rec."Appointment No") then begin
            if headerrec.Status <> headerrec.Status::Open then begin
                Error('You cannot only Delete Open Entries!');
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        headerrec.Reset;
        if headerrec.Get(Rec."Appointment No") then begin
            if headerrec.Status <> headerrec.Status::Open then begin
                Error('You cannot only Modify Open Entries!');
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        headerrec.Reset;
        if headerrec.Get(Rec."Appointment No") then begin
            if headerrec.Status <> headerrec.Status::Open then begin
                Error('You cannot only add to Open Entries!');
            end;
        end;
    end;

    var
        headerrec: Record "Tender Commitee Appointment";
}

