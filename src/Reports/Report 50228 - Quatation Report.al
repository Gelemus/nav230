report 50228 "Quatation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Quatation Report.rdl';

    dataset
    {
        dataitem("Request for Quotation Header"; "Request for Quotation Header")
        {
            RequestFilterFields = "No.";
            column(No_RequestforQuotationHeader; "Request for Quotation Header"."No.")
            {
            }
            column(DocumentDate_RequestforQuotationHeader; "Request for Quotation Header"."Document Date")
            {
            }
            column(IssueDate_RequestforQuotationHeader; "Request for Quotation Header"."Issue Date")
            {
            }
            column(ClosingDate_RequestforQuotationHeader; "Request for Quotation Header"."Closing Date")
            {
            }
            column(CurrencyCode_RequestforQuotationHeader; "Request for Quotation Header"."Currency Code")
            {
            }
            column(Time_RequestforQuotationHeader; "Request for Quotation Header".Time)
            {
            }
            column(Amount_RequestforQuotationHeader; "Request for Quotation Header".Amount)
            {
            }
            column(AmountLCY_RequestforQuotationHeader; "Request for Quotation Header"."Amount(LCY)")
            {
            }
            column(Description_RequestforQuotationHeader; "Request for Quotation Header".Description)
            {
            }
            column(EditinOutlookClient_RequestforQuotationHeader; "Request for Quotation Header"."Edit in Outlook Client")
            {
            }
            column(AGPOCertificate; "Request for Quotation Header"."AGPO Certificate")
            {
            }
            column(BusinessRegistrationCert; "Request for Quotation Header"."Business Registration Cert.")
            {
            }
            column(TaxComplianceCert; "Request for Quotation Header"."Tax Compliance Cert.")
            {
            }
            column(ConfidentialBusQuestionnaire; "Request for Quotation Header"."Confidential Bus.Questionnaire")
            {
            }
            column(Timeline_RequestforQuotationHeader; "Request for Quotation Header".Timeline)
            {
            }
            dataitem("Request for Quotation Line"; "Request for Quotation Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                PrintOnlyIfDetail = false;
                column(DocumentNo_RequestforQuotationLine; "Request for Quotation Line"."Document No.")
                {
                }
                column(No_RequestforQuotationLine; "Request for Quotation Line"."No.")
                {
                }
                column(Name_RequestforQuotationLine; "Request for Quotation Line".Name)
                {
                }
                column(Type_RequestforQuotationLine; "Request for Quotation Line".Type)
                {
                }
                column(Quantity_RequestforQuotationLine; "Request for Quotation Line".Quantity)
                {
                }
                column(UnitofMeasureCode_RequestforQuotationLine; "Request for Quotation Line"."Unit of Measure Code")
                {
                }
                column(Description_RequestforQuotationLine; "Request for Quotation Line".Description)
                {
                }
                column(Suppliers; "Request for Quotation Line"."Vendor Selected")
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo_Address; CompanyInfo.Address)
                {
                }
                column(CompanyInfo_Address2; CompanyInfo."Address 2")
                {
                }
                column(pic; CompanyInfo.Picture)
                {
                }
                column(PostCode; CompanyInfo."Post Code")
                {
                }
                column(CompanyInfo_City; CompanyInfo.City)
                {
                }
                column(CompanyInfo_Phone; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfo_Fax; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfo_Email; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfo_Web; CompanyInfo."Home Page")
                {
                }
            }
            dataitem("Specification Attributes"; "Specification Attributes")
            {
                DataItemLink = "RFQ No." = FIELD("No.");
                column(LNO; LNo)
                {
                }
                column(Specification_RFQSpecificationTable; Specification)
                {
                }
                column(Requirement_RFQSpecificationTable; Requirement)
                {
                }
                column(LineNo_RFQSpecificationTable; "Line No.")
                {
                }
                column(RFQNo_RFQSpecificationTable; "RFQ No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                end;
            }
            dataitem("Procurement Requirements"; "Procurement Requirements")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_ProcurementRequirements; "Procurement Requirements"."Document No.")
                {
                }
                column(LineNo_ProcurementRequirements; "Procurement Requirements"."Line No.")
                {
                }
                column(Description_ProcurementRequirements; "Procurement Requirements".Description)
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
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        CopyText: Text;
        PurchLines: Record "Purchase Line";
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        LPOText: Text;
        GenLedgerSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        CampusName: Text;
        DeptName: Text;
        LNo: Integer;
        Employees: Record Employee;
}

