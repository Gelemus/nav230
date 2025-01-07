report 50113 "Cases Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Cases Register.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            RequestFilterFields = "Code";
            column(OpinionsComments_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(ValueofClaim_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CaseCategory_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(Parties_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(LegalFees_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CaseStatus_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CaseNo_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CaseTitle_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CourtType_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CourtName_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            column(Description_CaseManagementHeader; "Payment Terms".Code)
            {
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

