page 51147 "Document E-mail Log"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Document E-Mail Log";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                }
                field("E-mailed To"; Rec."E-mailed To")
                {
                }
                field("File Extension"; Rec."File Extension")
                {
                    Editable = false;
                }
                field("E-Mail DateTime"; Rec."E-Mail DateTime")
                {
                }
                field(Document; Rec.Document)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
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
                action("Open Attachment..")
                {
                    Caption = 'Open Attachment..';

                    trigger OnAction()
                    var
                        lvFileName: Text[250];
                    begin
                        //  lvFileName:= TemporaryPath + '\' + Rec."Document No" + '.' + Rec."File Extension";
                        // if Exists(lvFileName) then FILE.Erase(lvFileName);
                        // ExportAttachment(lvFileName);
                        HyperLink(lvFileName);
                    end;
                }
                action("Export Attachment...")
                {
                    Caption = 'Export Attachment...';

                    trigger OnAction()
                    begin
                        // ExportAttachment('')
                    end;
                }
                separator(Separator1102754027)
                {
                }
                action("Resend Via E-mail")
                {
                    Caption = 'Resend Via E-mail';

                    trigger OnAction()
                    var
                        lvFileName: Text[250];
                        lvSenderName: Text[50];
                        lvSenderEmail: Text[80];
                        lvrecipient: Text[30];
                    begin
                        UserSetup.Get(UserId);

                        Rec.CalcFields(Document);
                        if not Rec.Document.HasValue then exit;
                        gvDocumentSetup.Get(Rec."Document Type");
                        gvDocumentSetup.TestField("Email Subject");
                        gvDocumentSetup.TestField("Email Body");

                        //Pick the relevant Sender Name and Address
                        if gvDocumentSetup."Sender Name" <> '' then
                            lvSenderName := gvDocumentSetup."Sender Name"
                        else begin
                            lvSenderName := UserId;
                        end;

                        if gvDocumentSetup."Sender Email" <> '' then
                            lvSenderEmail := gvDocumentSetup."Sender Email"
                        else begin
                            UserSetup.TestField("E-Mail");
                            lvSenderEmail := UserSetup."E-Mail";
                        end;

                        //wtm 20110512
                        lvrecipient := Rec."E-mailed To";
                        //wtm
                        // SMTPMail.CreateMessage(lvSenderName, lvSenderEmail, lvrecipient,
                        //                       gvDocumentSetup."Email Subject", gvDocumentSetup."Email Body", false);

                        // if gvDocumentSetup."Email Footer Line 1" <> '' then SMTPMail.AppendBody(' ' + gvDocumentSetup."Email Footer Line 1");
                        // if gvDocumentSetup."Email Footer Line 2" <> '' then SMTPMail.AppendBody(', ' + gvDocumentSetup."Email Footer Line 2");
                        // if gvDocumentSetup."Email Footer Line 3" <> '' then SMTPMail.AppendBody(', ' + gvDocumentSetup."Email Footer Line 3");
                        // if gvDocumentSetup."Email Footer Line 4" <> '' then SMTPMail.AppendBody(', ' + gvDocumentSetup."Email Footer Line 4");
                        // if gvDocumentSetup."Email Footer Line 5" <> '' then SMTPMail.AppendBody(', ' + gvDocumentSetup."Email Footer Line 5");

                        // lvFileName:= TemporaryPath + '\' + "Document No" + '.' + "File Extension";
                        // if Exists(lvFileName) then Erase(lvFileName);
                        // ExportAttachment(lvFileName);
                        // SMTPMail.AddAttachment(lvFileName,"Document No");

                        // SMTPMail.Send();
                        // FILE.Erase(lvFileName); // Erase the temporary file


                        Message('Attachment on log entry %1 successfully resent to %2', Rec."Entry No", Rec."E-mailed To");
                    end;
                }
            }
        }
    }

    var
        DocumentLog: Record "Document Generation Log";
        // SMTPMail: Codeunit "SMTP Mail";
        Mail: Codeunit Mail;
        UserSetup: Record "User Setup";
        DocumentEmailLog: Record "Document E-Mail Log";
        gvDocumentSetup: Record "Document E-Mailing Setup";
        AttachmentManagement: Codeunit AttachmentManagement;
}

