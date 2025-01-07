report 52351 "approval payroll"
{
    // DefaultLayout = RDLC;
    //RDLCLayout = 'src/Layouts/approval payroll.rdl';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Periods; Periods)
        {
            RequestFilterFields = "Period ID";

            trigger OnAfterGetRecord()
            begin
                Periods."Enable Payslip" := true;
                Periods.Modify;
            end;

            trigger OnPreDataItem()
            begin
                //Periods.SETRANGE("Period ID",DocumentNo);
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

    trigger OnPostReport()
    begin
        Message('Successfully Enabled');
    end;

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        DocumentNo: Code[20];

    procedure Setcode(pDocumentNo: Code[20])
    begin
        DocumentNo := pDocumentNo;
    end;
}

