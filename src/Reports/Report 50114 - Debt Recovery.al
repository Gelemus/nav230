report 50114 "Debt Recovery"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Debt Recovery.rdl';

    dataset
    {
        dataitem("HR Employee Appraisal Peforman"; "HR Employee Appraisal Peforman")
        {
            // RequestFilterFields = "Appraisal No.",Field10;
            column(RecoveryNo_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(ClientNo_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(ClientName_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(LoanNo_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(LoanOustandingAmount_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(DebtRecoveryStatus_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(TypeofNotice_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(ServedNoticeDate_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(ExpiryDate_DebtRecoveryHeader; "HR Employee Appraisal Peforman"."Appraisal No.")
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            dataitem("Bill Item"; "Bill Item")
            {
                //DataItemLink = Field10=FIELD(Field10);
                column(SecurityNo_SecuritiesRegister; "Bill Item"."Job ID")
                {
                }
                column(Description_SecuritiesRegister; "Bill Item"."Bill Item Type")
                {
                }
            }
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
}

