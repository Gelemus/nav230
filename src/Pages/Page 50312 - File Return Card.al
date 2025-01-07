page 50312 "File Return Card"
{
    Caption = 'Return Issued Tools';
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "File Request";
    SourceTableView = WHERE("Send Status" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Request No"; Rec."Request No")
                {
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Receiving Officer"; Rec."Receiving Officer")
                {
                }
                field("Receiving Officer Name"; Rec."Receiving Officer Name")
                {
                    Editable = false;
                }
                field("Registry Comments"; Rec."Registry Comments")
                {
                }
            }
            field(Control1000000016; '')
            {
                CaptionClass = Text19055830;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part("Tools Request Subform"; "File Request Subform")
            {
                Caption = 'Tools Request Subform';
                SubPageLink = "Request No" = FIELD("Request No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Return)
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Registry Comments");
                    Rec.TestField("Receiving Officer");
                    Rec.TestField(Returned, false);
                    fileMovementRec.Reset;
                    fileMovementRec.SetRange("Request No", Rec."Request No");
                    if fileMovementRec.FindFirst then begin
                        fileMovementRec."Returned?" := true;
                        fileMovementRec."Receiving Officer" := UserId;
                        fileMovementRec."Registry Comments" := Rec."Registry Comments";
                        fileMovementRec."Receiving Officer" := Rec."Receiving Officer";
                        fileMovementRec."Receiver Name" := Rec."Receiving Officer Name";
                        fileMovementRec.Modify;
                        //
                        FileDetails.Reset;
                        FileDetails.SetRange("File Code", fileMovementRec."File Code");
                        if FileDetails.FindFirst then begin
                            FileDetails.Status := FileDetails.Status::Available;
                            FileDetails.Modify;
                        end;
                        //modify
                        Rec.Returned := true;

                        Rec.Modify;
                        Message('Returned succesfully');
                    end;


                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."File Issued" then
            IsIssued := true
        else
            IsIssued := false;
    end;

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
        FileDetails: Record "File Detail";
        ResourceCentreSetupRec: Record "Resource Centre Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsIssued: Boolean;
}

