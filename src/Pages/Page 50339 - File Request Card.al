page 50339 "File Request Card"
{
    PageType = Card;
    SourceTable = "File Request";
    SourceTableView = WHERE("Send Status" = CONST(false));

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
                    Visible = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    Editable = false;
                }
            }
            part(Control1000000006; "File Request Subform")
            {
                SubPageLink = "Request No" = FIELD("Request No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send To  Registry")
            {
                Caption = 'Send To  Registry';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Employee No");
                    Rec.TestField(Date);

                    FileBatch.Reset;
                    FileBatch.SetRange(FileBatch."Request No", Rec."Request No");

                    if FileBatch.FindLast = false then
                        Error('Please fill in the files that you are requesting!!!');


                    CompanyInfor.Get;
                    //Get sender Address
                    SenderName := Rec.User;
                    /*
                    SenderAddress:=SMTPMailSetup."User ID";//CompanyInfor."Administrator Email";
                       IF SenderAddress<>'' THEN
                        BEGIN
                        Subject := STRSUBSTNO('REF: File Request');
                         Body := STRSUBSTNO('Hi,<br><br> Please note %1 has made a request %2. Kindly  process the request <br><br> Kind regards,<br><br>');
                         SenderName:=User;
                         Body:=STRSUBSTNO(Body,SenderName,"Request No");
                         //Get Recepient
                         ResourceCentreSetup1.GET;
                         Recipients:=ResourceCentreSetup1."Registry Email";
                         IF Recipients='' THEN
                           ERROR('HR  E-mail is empty, check the Resource center setup');
                          SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE); //1..
                           SMTPSetup.Send;
                        END
                        ELSE
                     ERROR('The sender address is empty');

                 */
                    Rec."Send Status" := true;
                    Rec.Modify;
                    Message('Request Sent Successfully');
                    CurrPage.Close;

                end;
            }
            action("DMS Link")
            {
                Caption = 'DMS Link';
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ResourceCentreSetup1.Get;
                    Link := ResourceCentreSetup1."File DMS Link" + Rec."File No";
                    HyperLink(Link);
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
        Rec.Date := Today;
        Rec."Creation Time" := Time;
    end;

    trigger OnOpenPage()
    begin
        //   SETRANGE(User,USERID);
    end;

    var
        Mail: Codeunit Mail;
        CompInfo: Record "Company Information";
        FileReq: Text[250];
        Text1: Label 'is being requested by:';
        FileBatch: Record "File Batch Request";
        Text19055830: Label 'Files Requested';
        Link: Text;
        ResourceCentreSetup1: Record "Resource Centre Setup";
        // SMTPSetup: Codeunit "SMTP Mail";
        SenderAddress: Text[80];
        Recipients: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        CompanyInfor: Record "Company Information";
        UserSetup: Record "User Setup";
    // SMTPMailSetup: Record "SMTP Mail Setup";
}

