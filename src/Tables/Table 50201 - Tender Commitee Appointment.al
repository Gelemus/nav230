table 50201 "Tender Commitee Appointment"
{
    DrillDownPageID = "Appointment List";
    LookupPageID = "Appointment List";

    fields
    {
        field(1; "Tender/Quotation No"; Code[50])
        {
            //TableRelation = Table51511393.Field1;

            trigger OnValidate()
            begin
                /*
                IF TenderRec.GET("Tender/Quotation No") THEN
                 BEGIN
                 Title:=TenderRec.Title;
                 "Process Type":=TenderRec."Process Type";
                 END;
               */

            end;
        }
        field(2; "Committee ID"; Code[20])
        {
            // TableRelation = Table51511392;

            trigger OnValidate()
            begin
                /*  IF ProcurementComittee.GET("Committee ID") THEN
                  BEGIN
                     "Committee Name":=ProcurementComittee.Description;
                     IF "Process Type"="Process Type"::RFQ THEN BEGIN
                         IF ProcurementComittee."RFQ Same Openinng_ Evaluation"=TRUE THEN BEGIN
                             "Opening_Evaluation Same":=TRUE;
                         END;
                     END;
                     IF "Process Type"="Process Type"::RFP THEN BEGIN
                         IF ProcurementComittee."RFP Same Openinng_ Evaluation"=TRUE THEN BEGIN
                             "Opening_Evaluation Same":=TRUE;
                         END;
                     END;
                     IF "Process Type"="Process Type"::Tender THEN BEGIN
                         IF ProcurementComittee."Tend Same Openinng_ Evaluation"=TRUE THEN BEGIN
                             "Opening_Evaluation Same":=TRUE;
                         END;
                     END;
                  END;*/

            end;
        }
        field(3; "Committee Name"; Text[30])
        {
        }
        field(4; "Creation Date"; Date)
        {
        }
        field(5; "User ID"; Code[70])
        {
        }
        field(6; Title; Text[250])
        {
        }
        field(7; "Appointment No"; Code[20])
        {
        }
        field(8; "No. Series"; Code[10])
        {
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
        }
        field(10; "No of Members"; Integer)
        {
            // CalcFormula = Count(Table51511406 WHERE (Field5=FIELD("Appointment No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Deadline For Report Submission"; Date)
        {
        }
        field(50001; Used; Boolean)
        {
            //CalcFormula = Exist(Table51511393 WHERE (Field50041=FIELD("Appointment No")));
            FieldClass = FlowField;
        }
        field(50002; "No of Approvers"; Integer)
        {
            FieldClass = Normal;
        }
        field(50003; "Process Type"; Option)
        {
            OptionCaption = ' ,Direct,RFQ,RFP,Tender,Low Value,Specially Permitted,EOI';
            OptionMembers = " ",Direct,RFQ,RFP,Tender,"Low Value","Specially Permitted",EOI;
        }
        field(50004; "Opening_Evaluation Same"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Appointment No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        PurchSetup.Get;
        PurchSetup.TestField(PurchSetup."Requisition Nos.");
        /// PurchSetup.TESTFIELD("Committe Creator");
        //IF PurchSetup."Committe Creator"<>USERID THEN BEGIN
        //   ERROR('Only user: '+PurchSetup."Committe Creator"+' can create Committees!');
        //END;
        NoSeriesMgt.InitSeries(PurchSetup."Requisition Nos.", xRec."No. Series", 0D, "Appointment No", "No. Series");


        "Creation Date" := Today;
        "User ID" := UserId;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        thisrec: Record "Tender Commitee Appointment";
        rfqname: Text;
        rfqname2: Text;
        usersetup: Record "User Setup";
        memberrec: Record "Commitee Members";
        // smtprec: Record "SMTP Mail Setup";
        // smtpcu: Codeunit "SMTP Mail";
        mailheader: Text;
        mailbody: Text;
        Attachmentfile: Text;
        bddialog: Dialog;
        commentline: Record "Approval Comment Line";
        commentline2: Record "Approval Comment Line";
        commentline3: Record "Approval Comment Line";
        commenterc: Text;

    procedure saveCommiteeReport(thisrecord: Record "Tender Commitee Appointment")
    begin
        /*    PurchSetup.RESET;
            PurchSetup.GET;
            PurchSetup.TESTFIELD("RFQ Documents Path");


            rfqname:=thisrecord."Appointment No";
            rfqname2:=thisrecord."Tender/Quotation No";
            rfqname:=CONVERTSTR(rfqname,'/','_');
            rfqname:=CONVERTSTR(rfqname,'\','_');

            rfqname2:=CONVERTSTR(rfqname2,'/','_');
            rfqname2:=CONVERTSTR(rfqname2,'\','_');

           CLEAR(rfqreport);
            thisrec.RESET;
            thisrec.SETFILTER("Appointment No",thisrecord."Appointment No");
            IF thisrec.FINDSET THEN BEGIN
              rfqreport.SETTABLEVIEW(thisrec);
              rfqreport.SAVEASPDF(PurchSetup."RFQ Documents Path"+(FORMAT(rfqname))+'_'+rfqname2+'.pdf');
            END;
            */

    end;

    procedure onapprovingcommitee(thisrecord: Record "Tender Commitee Appointment")
    begin
        /*  bddialog.OPEN('Sending Email to #1############',memberrec.Name);
           PurchSetup.RESET;
           PurchSetup.GET;
           PurchSetup.TESTFIELD("RFQ Documents Path");
           rfqname:=thisrecord."Appointment No";
           rfqname2:=thisrecord."Tender/Quotation No";
           rfqname:=CONVERTSTR(rfqname,'/','_');
           rfqname:=CONVERTSTR(rfqname,'\','_');

           rfqname2:=CONVERTSTR(rfqname2,'/','_');
           rfqname2:=CONVERTSTR(rfqname2,'\','_');
           saveCommiteeReport(thisrecord);
           Attachmentfile:=PurchSetup."RFQ Documents Path"+(FORMAT(rfqname))+'_'+rfqname2+'.pdf';

           memberrec.RESET;
           memberrec.SETFILTER("Appointment No",thisrecord."Appointment No");
           IF memberrec.FINDSET THEN REPEAT
                       mailheader:='EVALUATION COMMITTEE '+thisrecord."Tender/Quotation No";
                       mailbody:='Dear '+memberrec.Name+',<br><br>';
                       mailbody:=mailbody+'Please note that you have been selected as a Committee member of the Above Tender/RFQ<br><br>';
                       mailbody:=mailbody+'Please read through the attached Document<br><br>';
                       mailbody:=mailbody+'Kind Regards<br><br>';
                       mailbody:=mailbody+'<i>NAV System</i><bt><br>';
                       smtprec.RESET;
                       smtprec.GET;
                       usersetup.RESET;
                       usersetup.SETFILTER("Employee No.",memberrec."Employee No");
                       usersetup.FINDSET;
                       smtpcu.CreateMessage('ERC NAV Notifications',smtprec."User ID",usersetup."E-Mail",mailheader,mailbody,TRUE);
                       smtpcu.AddBCC('kibetbriann@gmail.com');
                       smtpcu.AddBCC('njau.muriithi@gmail.com');
                       smtpcu.AddCC(PurchSetup."Procurement Email");
                       smtpcu.AddAttachment(Attachmentfile,Attachmentfile);
                       smtpcu.Send;
                       bddialog.UPDATE(1,memberrec.Name);

           UNTIL memberrec.NEXT=0;
           bddialog.CLOSE;
rfqrec.RESET;
IF rfqrec.GET(thisrecord."Tender/Quotation No") THEN BEGIN
        committeesetup.RESET;
        committeesetup.GET(thisrecord."Committee ID");
        IF committeesetup."Evaluation Opening"=TRUE THEN BEGIN
           rfqrec."Commitee Opening":=thisrecord."Appointment No";
        END;
        IF committeesetup."Evaluation Process"=TRUE THEN BEGIN
           rfqrec."Commitee Evaluation":=thisrecord."Appointment No";
        END;
        IF thisrecord."Opening_Evaluation Same"=TRUE THEN BEGIN
           rfqrec."Commitee Evaluation":=thisrecord."Appointment No";
        END;
        rfqrec.MODIFY;
END;
*/

    end;

    procedure onResendingTocommitee(thisrecord: Record "Tender Commitee Appointment")
    begin
        /*   IF CONFIRM('Please note you are required to send to them with Comments. Will you give your Comments?') THEN  BEGIN
                      commentline.RESET;
                      commentline.SETFILTER("Entry No.",'<>%1',0);
                      IF commentline.FINDLAST THEN BEGIN
                          commentline2.INIT;
                          commentline2."Entry No.":=commentline."Entry No."+1;
                          commentline2.INSERT;
                          COMMIT;
                          PAGE.RUNMODAL(51511754,commentline2);
                          commentline3.RESET;
                          commentline3.GET(commentline."Entry No."+1);
                          commenterc:=commentline3.Comment;
                          //=======Adding the Comment on the record===============
                          commentline.RESET;
                          commentline.SETFILTER("Entry No.",'<>%1',0);
                          IF commentline.FINDLAST THEN BEGIN
                              commentline2.INIT;
                              commentline2."Entry No.":=commentline."Entry No."+1;
                              commentline2."Table ID":=51511115;
                              commentline2."Document No.":=thisrecord."Tender/Quotation No";
                              commentline2."User ID":=USERID;
                              commentline2.Comment:=commenterc;
                              rfqrec.RESET;
                              rfqrec.GET(thisrecord."Tender/Quotation No");
                              commentline2."Record ID to Approve":=rfqrec.RECORDID;
                              commentline2."Emailed?":=TRUE;
                              commentline2.Reject:=TRUE;
                              commentline2.INSERT;
                              //MESSAGE(commenterc);
                          END;
                          //======================================================
                      END;
                      bddialog.OPEN('Sending Email to #1############',memberrec.Name);
                      PurchSetup.RESET;
                      PurchSetup.GET;
                      PurchSetup.TESTFIELD("RFQ Documents Path");
                      rfqname:=thisrecord."Appointment No";
                      rfqname2:=thisrecord."Tender/Quotation No";
                      rfqname:=CONVERTSTR(rfqname,'/','_');
                      rfqname:=CONVERTSTR(rfqname,'\','_');

                      rfqname2:=CONVERTSTR(rfqname2,'/','_');
                      rfqname2:=CONVERTSTR(rfqname2,'\','_');
                      saveCommiteeReport(thisrecord);
                      Attachmentfile:=PurchSetup."RFQ Documents Path"+(FORMAT(rfqname))+'_'+rfqname2+'.pdf';

                      memberrec.RESET;
                      memberrec.SETFILTER("Appointment No",thisrecord."Appointment No");
                      IF memberrec.FINDSET THEN REPEAT
                                  mailheader:='EVALUATION COMMITTEE '+thisrecord."Tender/Quotation No";
                                  mailbody:='Dear '+memberrec.Name+',<br><br>';
                                  mailbody:=mailbody+'Please note that the Award of the above RFQ/Tender/RFP No was Rejected by the DG.<br><br>';
                                  mailbody:=mailbody+'You are required to Re-Evaluate it.<br><br>';
                                  IF commenterc<>'' THEN BEGIN
                                  mailbody:=mailbody+'Procurement Manager Comments:<br><br>';
                                  mailbody:=mailbody+'<i>'+commenterc+'</i><br><br>';
                                  END;
                                  mailbody:=mailbody+'Kind Regards<br><br>';
                                  mailbody:=mailbody+'<i>NAV System</i><bt><br>';
                                  smtprec.RESET;
                                  smtprec.GET;
                                  usersetup.RESET;
                                  usersetup.SETFILTER("Employee No.",memberrec."Employee No");
                                  usersetup.FINDSET;
                                  smtpcu.CreateMessage('ERC NAV Notifications',smtprec."User ID",usersetup."E-Mail",mailheader,mailbody,TRUE);
                                  smtpcu.AddBCC('kibetbriann@gmail.com');
                                  smtpcu.AddBCC('njau.muriithi@gmail.com');
                                  smtpcu.AddCC(PurchSetup."Procurement Email");
                                  smtpcu.AddAttachment(Attachmentfile,Attachmentfile);
                                  smtpcu.Send;
                                  bddialog.UPDATE(1,memberrec.Name);

                      UNTIL memberrec.NEXT=0;
                      bddialog.CLOSE;
                      MESSAGE('E-mail sent to the Evaluating Committee');
      END;
      */

    end;

    [Scope('Personalization')]
    procedure ReqLinesExist(): Boolean
    begin
        memberrec.Reset;
        memberrec.SetRange("Appointment No", "Appointment No");
        exit(memberrec.FindFirst);
    end;
}

