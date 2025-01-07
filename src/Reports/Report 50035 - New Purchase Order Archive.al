report 50035 "New Purchase Order Archive"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/New Purchase Order Archive.rdl';

    dataset
    {
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(PaytoVendorNo_PurchaseHeader; "Purchase Header Archive"."Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header Archive"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header Archive"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Purchase Header Archive"."Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header Archive"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header Archive"."Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Purchase Header Archive"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header Archive"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Purchase Header Archive"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header Archive"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header Archive"."Ship-to Address 2")
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
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header Archive"."Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header Archive"."Posting Date")
            {
            }
            column(No_PurchaseHeader; "Purchase Header Archive"."No.")
            {
            }
            column(CopyText; CopyText)
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header Archive"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header Archive"."Currency Code")
            {
            }
            column(Amount_PurchaseHeader; "Purchase Header Archive".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Purchase Header Archive"."Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; PurchLines."Line Discount Amount")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NoPrinted; "Purchase Header Archive"."No. Printed")
            {
            }
            column(LPOText; LPOText)
            {
            }
            column(DeptName; DeptName)
            {
            }
            column(CampusName; CampusName)
            {
            }
            column(LNo; LNo)
            {
            }
            dataitem("Purchase Line Archive"; "Purchase Line Archive")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(LineNo_PurchaseLine; "Purchase Line Archive"."Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line Archive"."Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line Archive"."Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line Archive".Quantity)
                {
                }
                column(No_PurchaseLine; "Purchase Line Archive"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line Archive".Description)
                {
                }
                column(Remarks_PurchaseLine; "Purchase Line Archive".Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line Archive"."Unit of Measure")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line Archive"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line Archive"."Line Discount Amount")
                {
                }
                column(VAT; "Purchase Line Archive"."VAT %")
                {
                }
                column(LocationCode; "Purchase Line Archive"."Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(EmployeeFirstName; Employee."First Name")
                    {
                    }
                    column(EmployeeMiddleName; Employee."Middle Name")
                    {
                    }
                    column(EmployeeLastName; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Employee Signature")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Purchase Header Archive"."Shortcut Dimension 1 Code");
                if DimVal.FindFirst then
                    CampusName := DimVal.Name;
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Purchase Header Archive"."Shortcut Dimension 2 Code");
                if DimVal.FindFirst then
                    DeptName := DimVal.Name;

                PurchLines.Reset;
                PurchLines.SetRange("Document Type", "Document Type");
                PurchLines.SetRange("Document No.", "No.");
                PurchLines.CalcSums("Line Discount Amount");
                CalcFields("Amount Including VAT");
                //Amount into words
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');

                if "No. Printed" = 0 then
                    LPOText := 'Suppliers copy'
                else if "No. Printed" = 1 then
                    LPOText := 'Accounts copy'
                else if "No. Printed" = 2 then
                    LPOText := 'Store copy'
                else if "No. Printed" = 3 then LPOText := 'Files copy';

                GenLedgerSetup.Get;
                if "Currency Code" = '' then "Currency Code" := GenLedgerSetup."LCY Code";
            end;

            trigger OnPostDataItem()
            begin
                /*IF CurrReport.PREVIEW=FALSE THEN
                  BEGIN
                    "No. Printed":="No. Printed" + 1;
                    MODIFY;
                END*/

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

