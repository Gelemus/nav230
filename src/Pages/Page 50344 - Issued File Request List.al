page 50344 "Issued File Request List"
{
    CardPageID = "File Return Card";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "File Request";
    SourceTableView = WHERE("File Issued" = CONST(true),
                            Returned = CONST(false));

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
                field("File Issued"; Rec."File Issued")
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
        //SMTPSetup: Codeunit "SMTP Mail";
        SenderAddress: Text[80];
        Recipients: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        CompanyInfor: Record "Company Information";
        UserSetup: Record "User Setup";
        //SMTPMailSetupRec: Record "SMTP Mail Setup";
        ResourceCentreSetupRec: Record "Resource Centre Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FileDetails: Record "File Detail";
}

