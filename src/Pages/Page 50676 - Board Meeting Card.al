page 50676 "Board Meeting Card"
{
    DeleteAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Board Meeting";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Nature of the Meeting"; Rec."Nature of the Meeting")
                {
                }
                field("Venue/Location"; Rec."Venue/Location")
                {
                }
                field("Convened By"; Rec."Convened By")
                {
                }
                field("Convened By Email"; Rec."Convened By Email")
                {
                }
                field("Meeting Group Code"; Rec."Meeting Group Code")
                {
                }
                field("Meeting Group"; Rec."Meeting Group")
                {
                    Editable = false;
                }
                field("Meeting Papers"; Rec."Meeting Papers")
                {
                }
                field("Conference Venue"; Rec."Conference Venue")
                {
                }
                field("Parking Arrangement"; Rec."Parking Arrangement")
                {
                }
                field("Access Requirement"; Rec."Access Requirement")
                {
                }
                field("Meeting Link"; Rec."Meeting Link")
                {
                }
                field("Meeting UserID"; Rec."Meeting UserID")
                {
                }
                field("Meeting Pass Code"; Rec."Meeting Pass Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Published; Rec.Published)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control21; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Meeting Agenda")
            {
                Caption = 'Meeting Agenda';
                Image = AgreementQuote;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meeting Agenda";
                RunPageLink = "Meeting No" = FIELD(No);

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                end;
            }
            action("Meeting Attendance")
            {
                Caption = 'Meeting Attendance';
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meeting Attendance";
                RunPageLink = "Meeting No" = FIELD(No);

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                end;
            }
            action("Meeting Comments")
            {
                Caption = 'Meeting Comments';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meeting Comments";
                RunPageLink = "Meeting No" = FIELD(No);

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                end;
            }
            action("Meeting Documents")
            {
                Caption = 'Meeting Documents';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Board Attachment List";
                RunPageLink = "Meeting No" = FIELD(No);

                trigger OnAction()
                var
                    lvEmployee: Record Employee;
                begin
                end;
            }
            action("Import Attachment")
            {
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    //FileManagement.UploadFile_BoardMeeting(Rec);
                end;
            }
            action(AttachedDoc)
            {
                ApplicationArea = Suite;
                Caption = 'View  Attached Document';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';
                Visible = false;

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                    PortalSetup: Record "Portal Setup";
                begin
                    //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                    PortalSetup.Get;
                    //HYPERLINK(PortalSetup."Server File Path"+"Document Name");
                end;
            }
            action("Publish Meeting")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Publish Meeting';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Send Notification email to Employees';

                // trigger OnAction()
                // var
                //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     Filename: Text;
                //     Filepath: Text;
                // begin
                //     Rec.TestField(Published,false);
                //     if Confirm('Do you want to Publish this Meeting? Board committee Members will be Emailed.') then begin
                //       Rec.Published := true;
                //      Rec. Status := Rec.Status::Upcoming;

                //     CommitteMembers.Reset;
                //     CommitteMembers.SetRange(Code,Rec."Meeting Group Code");
                //     ProgressWindow.Open('Sending...');
                //     if CommitteMembers.FindFirst then begin
                //       repeat
                //         Employee.Reset;
                //        if Employee.Get(CommitteMembers."Member No") then begin
                //           SMTP.Get;
                //           Subject := 'Board Meeting';
                //           //SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",Employee."Company E-Mail",Subject,'',TRUE);
                //          // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",
                //           //'kcarditor@yahoo.com',
                //          // 'jimwanyoike@gmail.com',
                //          // 'jmusya.m@gmail.com',
                //                       //Employee."Company E-Mail",
                //                     //  Subject,'',true);
                //           //SMTPMail.AddCC('jimwanyoike@gmail.com');
                //           SMTPMail.AppendBody('Dear'+' '+Employee."First Name"+',');
                //           SMTPMail.AppendBody('<br><br>');
                //           Body:='There will be a meeting i.e. ' + Rec.Title + '  on '+ Format(Rec."Start Date")+' Time '+Format(Rec."Start Time")
                //           +'.<br> Kindly Avail yourself';
                //           SMTPMail.AppendBody(Body);
                //           SMTPMail.AppendBody('<br><br>');
                //           SMTPMail.AppendBody('Regards,');
                //           SMTPMail.AppendBody('<br><br>');
                //           SMTPMail.AppendBody('Convened by ' + Rec."Convened By" +'.');
                //           SMTPMail.AppendBody('<br><br>');
                //           SMTPMail.AppendBody('<br><br>');
                //           SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');

                //           //SMTPMail.Send;
                //           if  not SMTPMail.TrySend then
                //             Error(SMTPMail.GetLastSendMailErrorText);
                //           end;
                //     until CommitteMembers.Next = 0;
                //           ProgressWindow.Close;
                //       Message('Emails Sent Successfully');
                //   end

                /*SalaryIncrementLines.RESET;
                SalaryIncrementLines.SETRANGE("Increment Code",Code);
                SalaryIncrementLines.SETRANGE("Employee No",'3094');
                ProgressWindow.OPEN('Sending...');
                IF SalaryIncrementLines.FINDFIRST THEN BEGIN
                  REPEAT
                    Employee.RESET;
                    IF Employee.GET(SalaryIncrementLines."Employee No") THEN BEGIN
                      Periods.RESET;
                      Periods.SETRANGE("Period ID","Start Period");
                      Periods.FINDFIRST;

                      //ProgressWindow.UPDATE(1,Employee."No."+':'+Employee.FullName);
                      SMTP.GET;
                      Subject := 'HR Salary Notification';
                      //SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",Employee."Company E-Mail",Subject,'',TRUE);
                      SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",
                      //'kcarditor@yahoo.com',
                      //'jimwanyoike@gmail.com',
                                  Employee."Company E-Mail",
                                  Subject,'',TRUE);
                       SMTPMail.AddBCC('payrol@nakuruwater.co.ke');
                      //SMTPMail.AddCC('jimwanyoike@gmail.com');
                      SMTPMail.AppendBody('Dear'+' '+Employee."First Name"+',');
                      SMTPMail.AppendBody('<br><br>');
                      Body:='Please Find Attached Salary Increment Letter.';
                      SMTPMail.AppendBody(Body);
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('Regards,');
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('HR & Administration Department');
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');
                      //SMTPMail.AddAttachment(Filepath,Filename);
                     {
                     SMTPMail.AppendBody('<br><br>');
                      Body:='We are pleased to inform you of Management''s decision to review your '+SalaryIncrementLines."Ed Definition"
                            +' by '+FORMAT(100 * (SalaryIncrementLines."Increment Value"/SalaryIncrementLines."Current Amount"))+ '% with effect from ' +Periods.Description
                            +'. Henceforth, your new '+SalaryIncrementLines."Ed Definition"+' shall be '+FORMAT(SalaryIncrementLines."Proposed Amount")+'.';
                      SMTPMail.AppendBody(Body);
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('All your other terms & conditions remain unchanged.,');
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('Yours Faithfully,');
                      SMTPMail.AppendBody('<br><br>');
                      SMTPMail.AppendBody('J.N Gachathi<br> Managing Director');}

                      //SMTPMail.Send;
                      IF  NOT SMTPMail.TrySend THEN
                        MESSAGE(SMTPMail.GetLastSendMailErrorText);
                     // ProgressWindow.UPDATE(1,Employee."No."+':'+Employee.FullName);
                    END;
                  UNTIL SalaryIncrementLines.NEXT = 0;
                  ProgressWindow.CLOSE;
                  MESSAGE('Emails Sent Successfully');
                END;*/
                //end;

                // end;
            }
            action("Close Meeting")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Meeting';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Filename: Text;
                    Filepath: Text;
                begin
                    Rec.TestField(Published, false);
                    if Confirm('Do you want to Close this Meeting?.') then begin
                        Rec.Status := Rec.Status::Completed;
                        /*SalaryIncrementLines.RESET;
                        SalaryIncrementLines.SETRANGE("Increment Code",Code);
                        SalaryIncrementLines.SETRANGE("Employee No",'3094');
                        ProgressWindow.OPEN('Sending...');
                        IF SalaryIncrementLines.FINDFIRST THEN BEGIN
                          REPEAT
                            Employee.RESET;
                            IF Employee.GET(SalaryIncrementLines."Employee No") THEN BEGIN
                              Periods.RESET;
                              Periods.SETRANGE("Period ID","Start Period");
                              Periods.FINDFIRST;

                              //ProgressWindow.UPDATE(1,Employee."No."+':'+Employee.FullName);
                              SMTP.GET;
                              Subject := 'HR Salary Notification';
                              //SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",Employee."Company E-Mail",Subject,'',TRUE);
                              SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",
                              //'kcarditor@yahoo.com',
                              //'jimwanyoike@gmail.com',
                                          Employee."Company E-Mail",
                                          Subject,'',TRUE);
                               SMTPMail.AddBCC('payrol@nakuruwater.co.ke');
                              //SMTPMail.AddCC('jimwanyoike@gmail.com');
                              SMTPMail.AppendBody('Dear'+' '+Employee."First Name"+',');
                              SMTPMail.AppendBody('<br><br>');
                              Body:='Please Find Attached Salary Increment Letter.';
                              SMTPMail.AppendBody(Body);
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('Regards,');
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('HR & Administration Department');
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');
                              //SMTPMail.AddAttachment(Filepath,Filename);
                             {
                             SMTPMail.AppendBody('<br><br>');
                              Body:='We are pleased to inform you of Management''s decision to review your '+SalaryIncrementLines."Ed Definition"
                                    +' by '+FORMAT(100 * (SalaryIncrementLines."Increment Value"/SalaryIncrementLines."Current Amount"))+ '% with effect from ' +Periods.Description
                                    +'. Henceforth, your new '+SalaryIncrementLines."Ed Definition"+' shall be '+FORMAT(SalaryIncrementLines."Proposed Amount")+'.';
                              SMTPMail.AppendBody(Body);
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('All your other terms & conditions remain unchanged.,');
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('Yours Faithfully,');
                              SMTPMail.AppendBody('<br><br>');
                              SMTPMail.AppendBody('J.N Gachathi<br> Managing Director');}

                              //SMTPMail.Send;
                              IF  NOT SMTPMail.TrySend THEN
                                MESSAGE(SMTPMail.GetLastSendMailErrorText);
                             // ProgressWindow.UPDATE(1,Employee."No."+':'+Employee.FullName);
                            END;
                          UNTIL SalaryIncrementLines.NEXT = 0;
                          ProgressWindow.CLOSE;
                          MESSAGE('Emails Sent Successfully');
                        END;*/
                    end;

                end;
            }
            action("UnPublish Meeting")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'UnPublish Meeting';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Send Notification email to Employees';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Filename: Text;
                    Filepath: Text;
                begin
                    Rec.TestField(Published, true);
                    if Confirm('Do you want to UnPublish this Meeting?') then begin
                        Rec.Published := false;
                        Rec.Status := Rec.Status::Pending;
                    end;
                end;
            }
            action("Cancel Meeting")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Meeting';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Send Notification email to Employees';
                Visible = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Filename: Text;
                    Filepath: Text;
                begin
                    Rec.TestField(Published, true);
                    if Confirm('Do you want to Cancel this Meeting? Board committee Members will be Emailed.') then begin
                        Rec.Published := false;
                        Rec.Status := Rec.Status::Cancelled;
                    end;
                end;
            }
        }
    }

    var
        FileManagement: Codeunit "File Management Upload";
        CommitteMembers: Record "Board Commitee";
        ProgressWindow: Dialog;
        Employee: Record Employee;
        // SMTP: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        Subject: Text;
        Body: Text;
        SeePublished: Boolean;
}

