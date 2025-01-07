report 50132 "Lease Review Batch"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Terms";"Payment Terms")
        {

            trigger OnAfterGetRecord()
            begin
                /*LeaseLines.RESET;
                LeaseLines.SETRANGE("Lease No.",Table50261."No.");
                LeaseLines.SETFILTER("Monthly Amount",'>%1',0);
                IF LeaseLines.FINDSET THEN BEGIN
                  REPEAT
                    PropertyLeaseReview.RESET;
                    PropertyLeaseReview.SETRANGE("Document No.",Table50261."No.");
                    PropertyLeaseReview.SETRANGE("Charge Code",LeaseLines."Charge Code");
                    PropertyLeaseReview.SETFILTER("Monthly Amount",'>%1',0);
                    IF PropertyLeaseReview.FINDSET THEN BEGIN
                      REPEAT
                        IF (WORKDATE >= PropertyLeaseReview."Start Period") AND (WORKDATE <= PropertyLeaseReview."End Period") THEN BEGIN
                          LeaseLines."Monthly Amount":=PropertyLeaseReview."Monthly Amount";
                          LeaseLines.VALIDATE("Monthly Amount");
                          LeaseLines."Last Review Date":=PropertyLeaseReview."Start Period";
                          IF LeaseLines.MODIFY THEN BEGIN
                            Table50261."Last Review Date":=PropertyLeaseReview."Start Period";
                            Table50261.MODIFY;
                          END;
                        END;
                      UNTIL PropertyLeaseReview.NEXT=0;
                    END;
                  UNTIL LeaseLines.NEXT=0;
                END;*/

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

    var
        FilePath: Label 'E:\Dynamics NAV\Data\Lease Reports\';
        FileName: Text[250];
        CurrentDate: Date;
        //SMTPMail: Codeunit "SMTP Mail";
        SenderName: Label 'Dynamics NAV';
        SenderAddress: Label 'nav@enke.co.ke';
        Subject: Label 'Leases Expiring This Month';
}

