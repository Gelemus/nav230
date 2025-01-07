page 50342 "File Issue Card"
{
    PageType = Card;
    SourceTable = "File Batch Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Request No"; Rec."Request No")
                {
                }
                field("File No."; Rec."File No.")
                {
                }
                field(Volume; Rec.Volume)
                {
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                }
                field("Issued?"; Rec."Issued?")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Issue File")
            {
                Caption = 'Issue File';
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = false;

                trigger OnAction()
                var
                    FileMovementCardPg: Page "File Movement Card";
                begin

                    if Rec."Issued?" = true then
                        Error('You Have already issued this file');

                    FileDetails.Reset;
                    //MESSAGE('%1',"File No.");
                    //MESSAGE('%1',Volume);
                    FileDetails.SetRange(FileDetails."File Code", Rec."File No.");
                    FileDetails.SetRange(FileDetails.Volume, Rec.Volume);


                    if FileDetails.Find('+') then begin

                        //REPEAT
                        //MESSAGE('%1',FileDetails.Status);
                        if FileDetails.Status = FileDetails.Status::"Not Available" then begin
                            Error('This File is not Available in Registry');

                        end else begin
                            //MESSAGE('%1',Volume);
                            fileMove.Reset;
                            fileMove.SetRange(fileMove."Request No", Rec."Request No");
                            fileMove.SetRange(fileMove."File Code", Rec."File No.");
                            fileMove.SetRange(fileMove.Volume, Rec.Volume);
                            FileMovementCardPg.SetTableView(fileMove);
                            FileMovementCardPg.Run;
                        end;
                        // UNTIL FileDetails.NEXT=0;
                    end;
                end;
            }
        }
    }

    var
        FileDetails: Record "File Detail";
        fileMove: Record "File Movement Detail";
}

