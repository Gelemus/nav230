report 50041 "Bid Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Bid Analysis.rdl';

    dataset
    {
        dataitem("Bid Analysis Header"; "Bid Analysis Header")
        {
            column(RFQNo; "Bid Analysis Header"."RFQ No.")
            {
            }
            column(DocumentDate; "Bid Analysis Header"."Document Date")
            {
            }
            column(RFQDate; "Bid Analysis Header"."RFQ Date")
            {
            }
            column(Description; "Bid Analysis Header".Description)
            {
            }
            column(GlobalDimension1Code; "Bid Analysis Header"."Global Dimension 1 Code")
            {
            }
            column(ReasonforSelectionofVendor; "Bid Analysis Header"."Reason for Selection of Vendor")
            {
            }
            column(UserID; "Bid Analysis Header"."User ID")
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyPhoneNo2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompanyEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            dataitem("Bid Analysis Line"; "Bid Analysis Line")
            {
                DataItemLink = "Document No." = FIELD("RFQ No.");
                column(VendorNo; "Bid Analysis Line"."Vendor No.")
                {
                }
                column(VendorName; "Bid Analysis Line"."Vendor Name")
                {
                }
                column(PurchaseQuoteNo; "Bid Analysis Line"."Purchase Quote No.")
                {
                }
                column(PurchaseQuoteDate; "Bid Analysis Line"."Purchase Quote Date")
                {
                }
                column(QuoteCurrency; "Bid Analysis Line"."Quote Currency")
                {
                }
                column(QuoteAmountExclVAT; "Bid Analysis Line"."Quote Amount Excl VAT")
                {
                }
                column(VATAmount; "Bid Analysis Line"."VAT Amount")
                {
                }
                column(QuoteAmountInclVAT; "Bid Analysis Line"."Quote Amount Incl VAT")
                {
                }
                column(MeetsSpecifications; "Bid Analysis Line"."Meets Specifications")
                {
                }
                column(Delivery_LeadTime; "Bid Analysis Line"."Delivery/Lead Time")
                {
                }
                column(PaymentTerms; "Bid Analysis Line"."Payment Terms")
                {
                }
                column(Remarks; "Bid Analysis Line".Remarks)
                {
                }
                column(TenderAwardedTo; TenderAwardedTo)
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("RFQ No.");
                DataItemTableView = WHERE(Status = CONST(Approved), Document_Type = CONST('Bid Analysis'));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(DateApproved; "Approval Entry"."Last Date-Time Modified")
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FullName; Employee."Full Name")
                    {
                    }
                    column(Signature; Employee."Employee Signature")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Employee.CalcFields(Employee."Employee Signature");
                    end;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        TenderAwardedTo: Text;
}

