page 50333 "File Movement List"
{
    CardPageID = "File Movement Card";
    Editable = false;
    PageType = List;
    SourceTable = "File Movement Detail";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("File Movement Code"; Rec."File Movement Code")
                {
                }
                field("File Issue date"; Rec."File Issue date")
                {
                }
                field("File Issue Time"; Rec."File Issue Time")
                {
                }
                field("Date Due at Registry"; Rec."Date Due at Registry")
                {
                }
                field("Officer issued file"; Rec."Officer issued file")
                {
                }
                field("File Code"; Rec."File Code")
                {
                }
                field("Action Taken"; Rec."Action Taken")
                {
                }
                field("Receiving Officer"; Rec."Receiving Officer")
                {
                }
                field("Folio No."; Rec."Folio No.")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Registry Comments"; Rec."Registry Comments")
                {
                }
                field("Officer Name"; Rec."Officer Name")
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field("Folio Name"; Rec."Folio Name")
                {
                }
                field("Receiver Name"; Rec."Receiver Name")
                {
                }
                field("Issued?"; Rec."Issued?")
                {
                }
                field("Returned?"; Rec."Returned?")
                {
                }
                field("Request No"; Rec."Request No")
                {
                }
                field(Volume; Rec.Volume)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Users: Record "User Setup";
        Emp: Record Employee;

    procedure GetfileMovement(var fieMovement: Code[20])
    var
        fileMovementRec: Record "File Movement Detail";
    begin
        fieMovement := Rec."File Movement Code";
    end;
}

