page 50368 "Incident Card"
{
    PageType = Card;
    SourceTable = "User Support Incidences";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'Incident Reference';
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    Editable = false;
                }
                field(Station; Rec.Station)
                {
                }
                field(Occurrence; Rec.Occurrence)
                {
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                }
            }
            group("Incident Details")
            {
                Caption = 'Incident Details';
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Incident Date';
                }
                field("Date of Issue First Raised"; Rec."Date of Issue First Raised")
                {
                }
                field(Subject; Subject)
                {
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'Incident Description';
                    MultiLine = true;
                }
                field("Steps taken"; Rec."Steps taken")
                {
                    MultiLine = true;
                }
                field(Outcome; Rec.Outcome)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Caption = 'Incident Status';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Relevant Employees/Witnesses")
            {
                Caption = 'Relevant Employees/Witnesses';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Page Page51511721;
                // RunPageLink = Field1=FIELD("Incident Reference");
            }
            action("Report Incident")
            {
                Caption = 'Report Incident';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to report this grievance') = true then begin
                        HumanResourcesSetupRec.Get;
                        Rec.TestField("Incident Description");
                        Rec.TestField("Incident Date");
                        Rec.TestField("User Id");
                        Rec.TestField("Supervisor Name");
                        /*
                        //Get Hod's email
                        SupervisorEmail:='';
                        UserSetupCopy.RESET;
                        UserSetupCopy.SETRANGE(UserSetupCopy."Employee No","Employee No");
                        IF UserSetupCopy.FINDFIRST THEN
                           IF UserSetupRec.GET(UserSetupCopy.HOD) THEN
                             Recipients:=UserSetupRec."E-Mail";

                        //Get Hr hod email
                        IF UserSetupCopy.GET(HumanResourcesSetupRec."HR HOD") THEN
                         HRHoDEmail:=UserSetupCopy."E-Mail";
                        {
                        IF UserSetup.GET(USERID) THEN
                            IF UserSetupRec.GET(UserSetup."Immediate Supervisor") THEN
                              SupervisorEmail:=UserSetupRec."E-Mail";
                          Recipients:=SupervisorEmail;
                        }
                        CompanyInformationRec.GET;
                        //CompanyInformationRec.TESTFIELD("Administrator Email");
                        SenderAddress:=SMTPSetup.//."Administrator Email";
                        IF ("Grievance About Management"=FALSE) THEN BEGIN
                          IF SenderAddress<>'' THEN
                            BEGIN
                              SenderName:=COMPANYNAME;
                              Body:=STRSUBSTNO('Hello,<br>This is to bring to your attention %1 grievance  made by %2 for your action<br><br>Kind Regardsbr<br>');
                              Body:=STRSUBSTNO(Body,Subject,"Employee Name");
                              Subject := STRSUBSTNO('REF:Grievance');
                              SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                              SMTPSetup.AddCC(HRHoDEmail);
                              SMTPSetup.Send;
                              "Incident Status":="Incident Status"::"Sent to HOD";
                              MODIFY;
                            END;

                        END ELSE IF (("Grievance About Management"=TRUE) AND ("Grievance About HR Manager"=FALSE)) THEN
                        BEGIN
                          IF SenderAddress<>'' THEN
                            BEGIN
                            Recipients:=HRHoDEmail;
                              SenderName:=COMPANYNAME;
                              Body:=STRSUBSTNO('Hello,<br>This is to bring to your attention %1 grievance  made by %2 for your action<br><br>Kind Regardsbr<br>');
                              Body:=STRSUBSTNO(Body,Subject,"Employee Name");
                              Subject := STRSUBSTNO('REF:Grievance');
                              SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                              SMTPSetup.Send;
                              "Incident Status":="Incident Status"::"Sent to HOD";
                              MODIFY;
                            END;
                        END ELSE IF (("Grievance About Management"=TRUE) AND ("Grievance About HR Manager"=TRUE)) THEN
                        BEGIN
                          IF SenderAddress<>'' THEN
                            BEGIN
                            //get Recipient
                          HumanResourcesSetupRec.GET;
                          HumanResourcesSetupRec.TESTFIELD("Director CS");
                          IF UserSetup.GET(HumanResourcesSetupRec."Director CS") THEN
                            Recipients:=UserSetup."E-Mail";
                              SenderName:=COMPANYNAME;
                              Body:=STRSUBSTNO('Hello,<br>This is to bring to your attention %1 grievance  made by %2 for your action<br><br>Kind Regardsbr<br>');
                              Body:=STRSUBSTNO(Body,Subject,"Employee Name");
                              Subject := STRSUBSTNO('REF:Grievance');
                              SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                              SMTPSetup.Send;
                              "Incident Status":="Incident Status"::"Sent to HOD";
                              MODIFY;
                            END;
                        END;
                        END
                      ELSE
                      EXIT;
                      */
                        Rec."Incident Status" := Rec."Incident Status"::"Sent to HOD";
                        Rec.Modify;
                        CurrPage.Close;
                    end;

                end;
            }
            action("Appeal ")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*
                    userchoice:=DIALOG.STRMENU('HR Manager,Director CS, CEO',1,'Please Select who to receive the appeal:');
                    IF userchoice=1 THEN
                      BEGIN
                      HumanResourcesSetupRec.GET;
                      HumanResourcesSetupRec.TESTFIELD("HR HOD");
                      IF UserSetup.GET(HumanResourcesSetupRec."HR HOD") THEN
                        Recipients:=UserSetup."E-Mail";
                      CompanyInformationRec.GET;
                    
                      CompanyInformationRec.TESTFIELD("Administrator Email");
                      SenderAddress:=CompanyInformationRec."Administrator Email";
                      IF SenderAddress<>'' THEN
                        BEGIN
                          SenderName:=COMPANYNAME;
                          Body:=STRSUBSTNO('Hello,<br>This is to bring to your attention an appeal made by %1 regarding grievance %2 for your action<br><br>Kind Regardsbr<br>');
                          Body:=STRSUBSTNO(Body,"Employee Name", Subject);
                          Subject := STRSUBSTNO('REF:Grievance');
                          SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                          SMTPSetup.Send;
                          //Update the status
                        "Incident Status":="Incident Status"::"Sent to HR Manager";
                        MODIFY;
                    
                        END;
                      END ELSE IF userchoice=2 THEN
                        BEGIN
                          HumanResourcesSetupRec.GET;
                          HumanResourcesSetupRec.TESTFIELD("Director CS");
                          IF UserSetup.GET(HumanResourcesSetupRec."Director CS") THEN
                            Recipients:=UserSetup."E-Mail";
                    
                          CompanyInformationRec.GET;
                          CompanyInformationRec.TESTFIELD("Administrator Email");
                          SenderAddress:=CompanyInformationRec."Administrator Email";
                          IF SenderAddress<>'' THEN
                            BEGIN
                              SenderName:=COMPANYNAME;
                              Body:=STRSUBSTNO('Hello,<br>This is to bring to your attention an appeal made by %1 regarding grievance %2 for your action<br><br>Kind Regardsbr<br>');
                              Body:=STRSUBSTNO(Body,"Employee Name", Subject);
                              Subject := STRSUBSTNO('REF:Grievance');
                              SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                              SMTPSetup.Send;
                    
                             //Update the status
                            "Incident Status":="Incident Status"::"Sent Direcor CS";
                             MODIFY;
                    
                            END;
                        END
                        ELSE IF userchoice=3 THEN
                          BEGIN
                          HumanResourcesSetupRec.GET;
                            HumanResourcesSetupRec.TESTFIELD(CEO);
                            IF UserSetup.GET(HumanResourcesSetupRec.CEO) THEN
                              Recipients:=UserSetup."E-Mail";
                    
                            CompanyInformationRec.GET;
                            CompanyInformationRec.TESTFIELD("Administrator Email");
                            SenderAddress:=CompanyInformationRec."Administrator Email";
                            IF SenderAddress<>'' THEN
                              BEGIN
                                SenderName:=COMPANYNAME;
                                Body:=STRSUBSTNO('Hello,<br>This is to bring to your attention an appeal made by %1 regarding grievance %2 for your action<br><br>Kind Regardsbr<br>');
                                Body:=STRSUBSTNO(Body,"Employee Name", Subject);
                                Subject := STRSUBSTNO('REF:Grievance');
                                SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                                SMTPSetup.Send;
                               //Update the status
                                  "Incident Status":="Incident Status"::"Sent to CEO";
                                   MODIFY;
                              END;
                         END
                      ELSE
                      EXIT;
                      */

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Category := Rec.Category::Incident;
        //"Incident Status":="Incident Status"::Unresolved;
    end;

    var
        CompanyInformationRec: Record "Company Information";
        // SMTPSetup: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        SenderAddress: Text[80];
        Recipients: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        HumanResourcesSetupRec: Record "Human Resources Setup";
        userchoice: Integer;
        UserSetupCopy: Record "User Setup";
        UserSetupRec: Record "User Setup";
        SupervisorEmail: Text;
        HRHoDEmail: Text;
}

