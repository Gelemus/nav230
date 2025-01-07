page 50335 "File Movement Card"
{
    PageType = Card;
    SourceTable = "File Movement Detail";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("File Movement Code"; Rec."File Movement Code")
                {
                }
                field("File Code"; Rec."File Code")
                {
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                }
                field("File Issue date"; Rec."File Issue date")
                {
                    Editable = false;
                }
                field("File Issue Time"; Rec."File Issue Time")
                {
                    Editable = false;
                }
                field("Date Due at Registry"; Rec."Date Due at Registry")
                {
                    Editable = false;
                }
                field("Officer issued file"; Rec."Officer issued file")
                {
                    Editable = false;
                }
                field("Officer Name"; Rec."Officer Name")
                {
                    Editable = false;
                }
                field("Date Returned To Registry"; Rec."Date Returned To Registry")
                {
                }
                field("Receiving Officer"; Rec."Receiving Officer")
                {
                    Editable = false;
                }
                field("Receiver Name"; Rec."Receiver Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Registry Comments"; Rec."Registry Comments")
                {
                }
                field("Folio No."; Rec."Folio No.")
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
                    Editable = false;
                }
                field(Volume; Rec.Volume)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Complete Return")
            {
                Caption = 'Complete Return';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm(Text001 + Rec."File Code") = true then begin
                        Rec."Returned?" := true;
                        Rec.Modify;
                        //Change available at the registry status
                        Message('File Returned');
                        FileDetails1Copy.Reset;
                        FileDetails1Copy.SetRange("File Code", Rec."File Code");
                        if FileDetails1Copy.FindLast then begin
                            FileDetails1Copy.Status := FileDetails1Copy.Status::Available;
                            FileDetails1Copy.Modify;
                        end;
                        CurrPage.Close;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Receiving Officer" := UserId;
        if UserSetupCopy.Get(UserId) then
            if Emp.Get(UserSetupCopy."Employee No") then
                Rec."Receiver Name" := Emp."Last Name" + ' ' + Emp."First Name";
    end;

    var
        Text001: Label 'Are you sure you want to effect the return of this file ';
        FileDetails1Copy: Record "File Detail";
        UserSetupCopy: Record "User Setup";
        Emp: Record Employee;
}

