page 51145 "Document Generation Log"
{
    PageType = ListPart;
    Permissions = TableData "Document Generation Log" = rimd;
    SourceTable = "Document Generation Log";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field(Send; Rec.Send)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                }
                field(Document; Rec.Document)
                {
                    Editable = false;
                }
                field("E-mailed To"; Rec."E-mailed To")
                {
                    Caption = 'E-mail To';
                }
                field(DateTime; Rec.DateTime)
                {
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("File Extension"; Rec."File Extension")
                {
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        //
                    end;
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("E-Mailed"; Rec."E-Mailed")
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
            group(Functions)
            {
                Caption = 'Functions';
                action("Open Document")
                {
                    Caption = 'Open Document';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #52020951. Unsupported part was commented. Please check it.
                        OpenAttachment();
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'No Attachment';
        Text012: Label '\10000-105001';
        Attachement: Record Attachment;
        Text003: Label 'The file is already in use on the machine';
        Text004: Label 'Do you want to open the document';
        FileMgt: Codeunit "File Management";

    procedure OpenAttachment()
    var
        //WordManagement: Codeunit WordManagement;
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
        Tofile: Text;
    begin
        BulkEmailingExportAttachment('');
    end;

    procedure BulkEmailingExportAttachment(ExportToFile: Text[1024]): Boolean
    var
        // BLOBRef: Record TempBlob;
        RBAutoMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text[260];
        ClientFileName: Text[1024];
    begin
        ClientFileName := '';
        Rec.CalcFields(Document);
        if Rec.Document.HasValue then begin
            // BLOBRef.Blob := Document;
            if ExportToFile = '' then begin
                FileName := 'Default.' + Rec."File Extension";
                //ExportToFile := FileMgt.BLOBExport(BLOBRef,FileName,true);
            end else begin
                // If a filename is provided, the file will be treated as temp file.
                // ExportToFile := FileMgt.BLOBExport(BLOBRef,ExportToFile,false);
            end;
            exit(true);
        end else
            exit(false)
    end;
}

