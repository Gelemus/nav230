page 50340 "File Request Subform"
{
    PageType = ListPart;
    SourceTable = "File Batch Request";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("File No."; Rec."File No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin


                        FileDetails.Reset;
                        if PAGE.RunModal(50334, FileDetails) = ACTION::LookupOK then begin


                            // FileManagement.SETRANGE(FileManagement."File No.",FileDetails."File Code");
                            // FileManagement.SETRANGE(FileManagement.Volume,FileDetails.Volume);
                            // FileManagement.SETRANGE(FileManagement."File Name",FileDetails."File Description");
                            // IF FileManagement.FIND('-') THEN BEGIN
                            FileMove.Reset;
                            FileMove.SetRange(FileMove."File Code", FileDetails."File Code");
                            FileMove.SetRange(FileMove.Volume, FileDetails.Volume);
                            FileMove.SetRange(FileMove.Transfered, false);
                            FileMove.SetRange(FileMove."Returned?", false);


                            if FileMove.FindFirst then begin
                                FileHolder := FileMove."Officer Name";
                            end;

                            if FileDetails.Status = FileDetails.Status::"Not Available" then begin
                                FileMove.Reset;
                                FileMove.SetRange(FileMove."File Code", FileDetails."File Code");
                                FileMove.SetRange(FileMove.Volume, FileDetails.Volume);
                                FileMove.SetRange(FileMove.Transfered, false);
                                FileMove.SetRange(FileMove."Returned?", false);


                                if FileMove.FindFirst then begin
                                    FileHolder := FileMove."Officer Name";
                                end;


                                Error('%1%2', 'The File you have requested is not in registry.', FileHolder);
                            end else begin
                                Rec."File No." := FileDetails."File Code";
                                Rec.Volume := FileDetails.Volume;
                                Rec."File Name" := FileDetails."File Description";
                                Rec."SF No" := FileDetails."Shelf  No.";
                                Rec."Folio No." := FileDetails."Folio No.";

                                // END;

                            end;
                        end;
                    end;
                }
                field("SF No"; Rec."SF No")
                {
                    Editable = true;
                    Visible = false;
                }
                field(Volume; Rec.Volume)
                {
                    Editable = false;
                    Visible = false;
                }
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                }
                field("Issued?"; Rec."Issued?")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        FileDetails: Record "File Detail";
        FileManagement: Record "File Batch Request";
        FileMove: Record "File Movement Detail";
        FileHolder: Text[100];
}

