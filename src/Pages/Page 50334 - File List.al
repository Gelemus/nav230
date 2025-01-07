page 50334 "File List"
{
    CardPageID = "File Card";
    Editable = true;
    PageType = List;
    SourceTable = "File Detail";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("File Code"; Rec."File Code")
                {
                    NotBlank = false;
                }
                field("File Description"; Rec."File Description")
                {
                }
                field("File Class"; Rec."File Class")
                {
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Available in Registry?';
                }
                field(FileHolder; FileHolder)
                {
                    Caption = 'Current Holder';
                }
                field("File Status"; Rec."File Status")
                {
                }
                field("Retention Period(Yrs)"; Rec."Retention Period(Yrs)")
                {
                }
                field("Disposal Action"; Rec."Disposal Action")
                {
                }
                field("Disposal Date"; Rec."Disposal Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        fileMovementRec.Reset;
        fileMovementRec.SetRange(fileMovementRec."File Code", Rec."File Code");
        fileMovementRec.SetRange(fileMovementRec.Volume, Rec.Volume);
        fileMovementRec.SetRange(fileMovementRec.Transfered, false);
        fileMovementRec.SetRange(fileMovementRec."Returned?", false);
        if fileMovementRec.Find('+') then begin
            FileHolder := fileMovementRec."Officer Name";

        end else begin
            FileHolder := 'STORES';
        end;
    end;

    var
        FileHolder: Text[100];
        fileMovementRec: Record "File Movement Detail";
}

