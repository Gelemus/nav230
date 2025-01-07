page 50195 "Employee Signature"
{
    Caption = 'Employee Signature';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            field("Employee Signature"; Rec."Employee Signature")
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the signature of the employee.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                    TempBlob: Codeunit "Temp Blob";
                    NVInStream: InStream;
                    Name: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField("First Name");
                    Rec.TestField("Last Name");
                    // Check if there's already a signature and prompt for confirmation if there is one
                    if Rec.Image.HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;
                    // Upload the picture file to TempBlob
                    FileName := FileManagement.BLOBImport(TempBlob, SelectPictureTxt);
                    if FileName = '' then
                        exit;
                    // Create an InStream from the TempBlob to import the image
                    TempBlob.CreateInStream(NVInStream);
                    // Import the stream into the Employee Signature field
                    Rec."Employee Signature".ImportStream(NVInStream, SelectPictureTxt, '');
                    Rec.Modify(true);
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField("First Name");
                    Rec.TestField("Last Name");

                    NameValueBuffer.DeleteAll;
                    // ExportPath := TemporaryPath + "No." + Format("Employee Signature".MediaId);
                    // "Employee Signature".ExportFile(ExportPath);
                    // FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
                    TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
                    TempNameValueBuffer.FindFirst;
                    ToFile := StrSubstNo('%1 %2 %3.jpg', Rec."No.", Rec."First Name", Rec."Last Name");
                    // Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    // if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Employee Signature");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    trigger OnOpenPage()
    begin
        // CameraAvailable := CameraProvider.IsAvailable;
        // if CameraAvailable then
        //     CameraProvider := CameraProvider.Create;
    end;

    var
        // [RunOnClient]
        // [WithEvents]
        // CameraProvider: DotNet CameraProvider;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing signature will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the signature?';
        SelectPictureTxt: Label 'Select a signature to upload';
        DeleteExportEnabled: Boolean;
        DownloadImageTxt: Label 'Download signature';

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Employee Signature".HasValue;
    end;

}
