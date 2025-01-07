page 50341 "Received File Request List"
{
    CardPageID = "Received File Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "File Request";
    SourceTableView = WHERE("Send Status" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Request No"; Rec."Request No")
                {
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Issue)
            {
                Caption = 'Issue Tools';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("File Issued", false);
                    ResourceCentreSetupRec.Get;
                    FileBatchRequests1Copy.Reset;
                    FileBatchRequests1Copy.SetRange("Request No", Rec."Request No");
                    FileBatchRequests1Copy.SetRange("Issued?", false);
                    if FileBatchRequests1Copy.FindFirst then
                        repeat
                            FileDetails.Reset;
                            FileDetails.SetRange(FileDetails."File Code", FileBatchRequests1Copy."File No.");
                            FileDetails.SetRange(FileDetails.Volume, FileBatchRequests1Copy.Volume);
                            if FileDetails.Find('+') then begin
                                if FileDetails.Status = FileDetails.Status::"Not Available" then begin
                                    Error('This File is not Available in Registry');
                                end else begin
                                    fileMovementRec.Init;
                                    fileMovementRec."File Movement Code" := NoSeriesMgt.GetNextNo(ResourceCentreSetupRec."File Movement Numbers", Today, true);
                                    fileMovementRec."File Code" := FileBatchRequests1Copy."File No.";
                                    fileMovementRec."Receiver Name" := Rec."Employee Name";
                                    fileMovementRec."Request No" := Rec."Request No";
                                    fileMovementRec."File Name" := FileBatchRequests1Copy."File Name";
                                    fileMovementRec.Volume := FileBatchRequests1Copy.Volume;
                                    fileMovementRec."Folio No." := FileBatchRequests1Copy."Folio No.";
                                    fileMovementRec."Officer issued file" := Rec."Employee No";
                                    fileMovementRec."Officer Name" := Rec."Employee Name";
                                    fileMovementRec."File Issue date" := Today;
                                    fileMovementRec."File Issue Time" := Time;
                                    fileMovementRec."Issued?" := true;
                                    fileMovementRec.Insert;

                                end;

                            end;
                            FileBatchRequests1Copy."Issued?" := true;
                            FileBatchRequests1Copy.Modify;
                        until FileBatchRequests1Copy.Next = 0;
                    if FileBatchRequests1Copy."Issued?" then
                        Message('Issued successfully');
                end;
            }
            action("Notify ")
            {
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //Send Notification\
                    if Confirm('Are you sure you want to send availability notification to ' + Rec."Employee No" + '?') = true then begin
                        CompanyInfor.Get;
                        //Get sender Address

                        SenderName := 'NAVISION RMIS';
                        //  SenderAddress := SMTPMailSetupRec."User ID";//.emCompanyInfor."Administrator Email";
                        if SenderAddress <> '' then begin
                            Subject := StrSubstNo('REF: File Availability Notification');
                            Body := StrSubstNo('Hi,<br><br> Please note that %1 is available for collection. Kindly check with the registry. <br><br> Kind regards,<br><br>');
                            Body := StrSubstNo(Body, Rec."File Name");
                            //Get Recepient
                            UserSetup.SetRange("Employee No", Rec."Employee No");
                            if UserSetup.FindFirst then
                                Recipients := UserSetup."E-Mail";
                            // SMTPSetup.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true); //1..
                            // SMTPSetup.Send;
                        end
                        else
                            Error('The sender address is empty');
                    end;
                    CurrPage.Close;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CompInfo.Get;
        //"System Support Email Address":=CompInfo."Registry Email";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CompInfo.Get;
        //"System Support Email Address":=CompInfo."Registry Email";
    end;

    trigger OnOpenPage()
    begin
        //Filter not issued requests
    end;

    var
        Mail: Codeunit Mail;
        CompInfo: Record "Company Information";
        FileReq: Text[250];
        Text1: Label 'is being requested by:';
        Text19055830: Label 'Files Requested';
        fileMoveNo: Code[20];
        fileMovementRec: Record "File Movement Detail";
        FileBatchRequests1Copy: Record "File Batch Request";
        //  SMTPSetup: Codeunit "SMTP Mail";
        SenderAddress: Text[80];
        Recipients: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        CompanyInfor: Record "Company Information";
        UserSetup: Record "User Setup";
        //   SMTPMailSetupRec: Record "SMTP Mail Setup";
        ResourceCentreSetupRec: Record "Resource Centre Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FileDetails: Record "File Detail";
}

