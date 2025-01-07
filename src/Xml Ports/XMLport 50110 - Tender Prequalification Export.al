xmlport 50110 "Tender Prequalification Export"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(TenderPrequalificationRoot)
        {
            tableelement("Tender Prequalification";"Tender Prequalification")
            {
                XmlName = 'TenderPrequalificationHeader';
                fieldelement(No;"Tender Prequalification".No)
                {
                }
                fieldelement(PrequalificationCreatedDate;"Tender Prequalification"."Prequalification Created Date")
                {
                }
                fieldelement(PrequalificationUpdatedDate;"Tender Prequalification"."Prequalification Updated Date")
                {
                }
                fieldelement(CreatedBy;"Tender Prequalification"."Created By")
                {
                }
                fieldelement(UpdatedBy;"Tender Prequalification"."Updated By")
                {
                }
                fieldelement(Status;"Tender Prequalification".Status)
                {
                }
                fieldelement(Description;"Tender Prequalification".Description)
                {
                }
                fieldelement(CatId;"Tender Prequalification"."Cat Id")
                {
                }
                fieldelement(FpId;"Tender Prequalification"."Fp Id")
                {
                }
                fieldelement(ClosingDate;"Tender Prequalification"."Closing Date")
                {
                }
                fieldelement(OpeningDate;"Tender Prequalification"."Opening Date")
                {
                }
                fieldelement(ApprovalStatus;"Tender Prequalification"."Approval Status")
                {
                }
                fieldelement(AwardDate;"Tender Prequalification"."Award Date")
                {
                }
                fieldelement(AdvertisementDate;"Tender Prequalification"."Advertisement Date")
                {
                }
                fieldelement(Code;"Tender Prequalification".Code)
                {
                }
                fieldelement(Type;"Tender Prequalification".Type)
                {
                }
                fieldelement(SpecialGroup;"Tender Prequalification"."Special Group")
                {
                }
                fieldelement(SpecialCondition;"Tender Prequalification"."Special Condition")
                {
                }
                fieldelement(TenderNo;"Tender Prequalification"."Tender No")
                {
                }
                fieldelement(SupplyType;"Tender Prequalification"."Supply Type")
                {
                }
                fieldelement(ClosingTime;"Tender Prequalification"."Closing Time")
                {
                }
                fieldelement(OpeningTime;"Tender Prequalification"."Opening Time")
                {
                }
                fieldelement(SubmissionFrom;"Tender Prequalification"."Submission From")
                {
                }
                fieldelement(SubmissionTo;"Tender Prequalification"."Submission To")
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
}

