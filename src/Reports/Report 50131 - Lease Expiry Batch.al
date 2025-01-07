report 50131 "Lease Expiry Batch"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {

            trigger OnAfterGetRecord()
            begin
                //Set the status to Expired for all Leases due for expiry
                /*IF(Table50261."Expiry Date"<TODAY) THEN BEGIN
                  Table50261.Status:=Table50261.Status::"5";
                  IF Table50261.MODIFY THEN BEGIN
                    //
                    LeaseUnits.RESET;
                    LeaseUnits.SETRANGE("Lease No.",Table50261."No.");
                    IF LeaseUnits.FINDSET THEN BEGIN
                      REPEAT
                        PropertyUnits.RESET;
                        PropertyUnits.SETRANGE("Property No.",LeaseUnits."Property No.");
                        PropertyUnits.SETRANGE("Block Code",LeaseUnits."Block Code");
                        PropertyUnits.SETRANGE("Floor Code",LeaseUnits."Floor Code");
                        PropertyUnits.SETRANGE("Unit Code",LeaseUnits."Unit Code");
                        IF PropertyUnits.FINDFIRST THEN BEGIN
                          PropertyUnits.Occupied:=FALSE;
                          PropertyUnits."Unit Status":=PropertyUnits."Unit Status"::"1";
                          PropertyUnits.MODIFY;
                        END;
                      UNTIL LeaseUnits.NEXT=0;
                    END;
                    //
                    LeaseLines.RESET;
                    LeaseLines.SETRANGE(LeaseLines."Lease No.",Table50261."No.");
                    IF LeaseLines.FINDSET THEN BEGIN
                      REPEAT
                        LeaseLines.Status:=LeaseLines.Status::"5";
                        LeaseLines.MODIFY;
                      UNTIL LeaseLines.NEXT=0;
                    END;
                  END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                //Table50261.SETRANGE(Table50261.Status,Table50261.Status::"4");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //Leases Expiring this Month
        /*CurrentDate:=TODAY;
        IF (DATE2DMY(CurrentDate,1)=1) THEN BEGIN
          FileName:=FilePath+'LeasesExpiry'+FORMAT(DATE2DMY(CurrentDate,1))+FORMAT(DATE2DMY(CurrentDate,2))+FORMAT(DATE2DMY(CurrentDate,3))+'.pdf';
          PropertyLease.RESET;
          PropertyLease.SETRANGE("Expiry Date",CALCDATE('-CM',CurrentDate),CALCDATE('CM',CurrentDate));
          IF PropertyLease.FINDSET THEN BEGIN
            REPORT.SAVEASPDF(REPORT::"Lease Report",FileName,PropertyLease);
          END;
          COMMIT;
          //Send Email
          PropertyUserSetup.RESET;
          PropertyUserSetup.SETRANGE("Receive Lease Expiry Report",TRUE);
          PropertyUserSetup.SETFILTER("Email Address",'<>%1','');
          IF PropertyUserSetup.FINDSET THEN BEGIN
            REPEAT
              SMTPMail.CreateMessage(SenderName,SenderAddress,PropertyUserSetup."Email Address",Subject,'',TRUE);
              SMTPMail.AddAttachment(FileName,'LeasesExpiry.pdf');
              SMTPMail.AppendBody('Attached is a List of all the Leases Expiring this Month<br/><hr/>');
              SMTPMail.AppendBody('<i>This is a System Generated Email. Do not Reply to this Email ID</i><br/>');
              SMTPMail.TrySend;
            UNTIL PropertyUserSetup.NEXT=0;
          END;
          //End Send Mail
        END;
        */

    end;

    var
        FilePath: Label 'E:\Dynamics NAV\Data\Lease Reports\';
        FileName: Text[250];
        CurrentDate: Date;
        //SMTPMail: Codeunit "SMTP Mail";
        SenderName: Label 'Dynamics NAV';
        SenderAddress: Label 'nav@enke.co.ke';
        Subject: Label 'Leases Expiring This Month';
}

