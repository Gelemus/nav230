codeunit 50080 "File Management Upload"
{

    trigger OnRun()
    begin
    end;

    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ServerPath: Text;
        ClientPath: Text;
        PortalSetup: Record "Portal Setup";

    procedure UploadFile_Imprest(ImprestHeader: Record "Imprest Header")
    begin
        ImprestHeader.TestField(Status, ImprestHeader.Status::Open);

        // ClientPath:=FileManagement.OpenFileDialog('Choose file:', '','CSV files (*.csv)|*.csv|All files (*.*)|*.*');

        FileName := FileManagement.GetFileName(ClientPath);
        FileName := 'Imprest_' + ImprestHeader."No." + '.' + FileManagement.GetExtension(FileName);

        ServerPath := 'C:\NAVERPFIILES\' + FileName;
        //FileManagement.UploadFileSilentToServerPath(ClientPath,ServerPath);
        ImprestHeader."Document Path" := ServerPath;
        ImprestHeader."Document Name" := FileName;
        ImprestHeader.Modify;
        Message('File Uploaded SuccessFully');
    end;

    procedure UploadFile_PurchaseReq(PurchaseRequisitions: Record "Purchase Requisitions")
    begin
        PortalSetup.Get;
        PortalSetup.TestField("Local File Path");
        PurchaseRequisitions.TestField("No.");

        if PurchaseRequisitions."Document Name" <> '' then
            if not Confirm('There is a Document already attached. Do you want to overwrite?') then
                exit;

        //ClientPath:=FileManagement.OpenFileDialog('Choose file:', '','CSV files (*.csv)|*.PDF|All files (*.*)|*.*');

        FileName := FileManagement.GetFileName(ClientPath);
        FileName := 'PurchaseReq_' + Format(PurchaseRequisitions."No.") + '.' + FileManagement.GetExtension(FileName);

        ServerPath := 'C:\HRDOCS\' + FileName;
        //FileManagement.UploadFileSilentToServerPath(ClientPath,ServerPath);
        PurchaseRequisitions."Document Name" := FileName;
        PurchaseRequisitions.Modify;
        Message('File Uploaded SuccessFully');
    end;

    procedure DownloadFile(DocumentPath: Text)
    begin
        if DocumentPath = '' then
            Error('There is no Document attached');
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        ServerPath := 'C:\HRDOCS\' + DocumentPath;
        //HYPERLINK(ServerPath);

        // FileName:=TemporaryPath+'\'+FileManagement.GetFileName(ServerPath);
        FileName := ServerPath;
        //Download(ServerPath,'File Download','','',FileName);
    end;

    procedure UploadFile_BoardAttachment(BoardMeetingAttachment: Record "Board Meeting Attachments")
    begin
        //ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Open);

        //ClientPath:=FileManagement.OpenFileDialog('Choose file:', '','CSV files (*.csv)|*.csv|All files (*.*)|*.*');

        FileName := FileManagement.GetFileName(ClientPath);
        FileName := 'BoardFile_' + Format(BoardMeetingAttachment."Entry No") + '.' + FileManagement.GetExtension(FileName);

        ServerPath := 'C:\NAVERPFIILES\' + FileName;
        //FileManagement.UploadFileSilentToServerPath(ClientPath,ServerPath);
        BoardMeetingAttachment.FilePath := ServerPath;
        BoardMeetingAttachment.FileName := FileName;
        BoardMeetingAttachment.Modify;
        Message('File Uploaded SuccessFully');
    end;

    procedure UploadFile_OnlineRepDocs(OnlineRepoDocument: Record "Online Repo Documents")
    begin
        //ImprestHeader.TESTFIELD(Status,ImprestHeader.Status::Open);

        //ClientPath:=FileManagement.OpenFileDialog('Choose file:', '','CSV files (*.csv)|*.csv|All files (*.*)|*.*');

        FileName := FileManagement.GetFileName(ClientPath);
        FileName := 'OnlineRepoDoc_' + Format(OnlineRepoDocument."Entry No") + '.' + FileManagement.GetExtension(FileName);

        ServerPath := 'C:\NAVERPFIILES\' + FileName;
        //FileManagement.UploadFileSilentToServerPath(ClientPath,ServerPath);
        OnlineRepoDocument.FilePath := ServerPath;
        OnlineRepoDocument."Actual File" := FileName;
        OnlineRepoDocument.Modify;
        Message('File Uploaded SuccessFully');
    end;

    procedure UploadFile_Advance(SalaryAdvance: Record "Salary Advance")
    begin
        //SalaryAdvance.TESTFIELD(Status,SalaryAdvance.Status::Open);

        //ClientPath:=FileManagement.OpenFileDialog('Choose file:', '','CSV files (*.csv)|*.csv|All files (*.*)|*.*');

        FileName := FileManagement.GetFileName(ClientPath);
        FileName := 'Advance_' + SalaryAdvance.ID + '.' + FileManagement.GetExtension(FileName);

        ServerPath := 'C:\NAVERPFIILES\' + FileName;
        //FileManagement.UploadFileSilentToServerPath(ClientPath,ServerPath);
        SalaryAdvance."File Name" := ServerPath;
        SalaryAdvance."Document Name" := FileName;
        SalaryAdvance.Modify;
        Message('File Uploaded SuccessFully');
    end;
}

