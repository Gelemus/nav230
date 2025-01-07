report 50198 "New Purchase Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/New Purchase Order Report.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(Timesent; Timesent)
            {
            }
            column(ReferenceNo_PurchaseHeader; "Purchase Header"."Reference No")
            {
            }
            column(PreparedByName; PreparedByName)
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Purchase Header"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Purchase Header"."Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Purchase Header"."Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Purchase Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Purchase Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(SupplierNoteCaption_; SupplierNoteCaption)
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
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header"."Currency Code")
            {
            }
            column(Amount_PurchaseHeader; "Purchase Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Purchase Header"."Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; PurchLines."Line Discount Amount")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NoPrinted; "Purchase Header"."No. Printed")
            {
            }
            column(LPOText; LPOText)
            {
            }
            column(CampusName; CampusName)
            {
            }
            column(LNo; LNo)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Purchase Line"."Line Amount")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Description_PurchaseLine2; "Purchase Line"."Description 2")
                {
                }
                column(Remarks_PurchaseLine; "Purchase Line".Remarks)
                {
                }
                column(UnitofMeasure_PurchaseLine; PurchLines."Unit of Measure Code")
                {
                }
                column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                {
                }
                column(VatAmount_; VatAmount)
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Purchase Line"."Line Discount Amount")
                {
                }
                column(VAT; "Purchase Line"."VAT %")
                {
                }
                column(LocationCode; "Purchase Line"."Location Code")
                {
                }
                column(VATAMOUNT2; "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount)
                {
                }
                column(UnitofMeasureCode_PurchaseLine; "Purchase Line"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LNo := LNo + 1;
                    VatAmount := 0;
                    VATPostingSetupRec.Reset;
                    VATPostingSetupRec.SetRange("VAT Prod. Posting Group", "Purchase Line"."VAT Prod. Posting Group");
                    if VATPostingSetupRec.FindSet then begin
                        VatAmount := (VATPostingSetupRec."VAT % 2" * "Purchase Line"."Amount Including VAT") / 100;
                    end;
                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");
                DataItemTableView = WHERE(Status = FILTER(Approved));
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
                column(ApproveByCaption_; ApproveByCaption)
                {
                }
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(PreparedByName_; PreparedByName)
                {
                }
                column(PreparedByCaption; PreparedByCaption)
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(UserSetupCopy_Signature; UserSetupCopy.Signature)
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
                dataitem(Employee2; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Sender ID");
                    column(EmployeeSignature_Employee2; Employee2."Employee Signature")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;

                    ApproveByCaption := '';
                    ShowPreparedBy := false;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedByCaption := 'Prepared By: ';//+' '+"Approval Entry"."Sender ID";
                                                             //get sender name
                        EmployeeRec.Reset;
                        EmployeeRec.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRec.FindFirst then
                            PreparedByName := EmployeeRec.FullName;
                        //Get Sender Signature
                        UserSetupCopy.Get("Approval Entry"."Sender ID");
                        UserSetupCopy.CalcFields(Signature);

                        ApproveByCaption := 'Checked By:';
                    end
                    else if i = 2 then begin
                        ApproveByCaption := 'Approved By:';
                    end
                    else if i = 3 then
                        ApproveByCaption := 'Approved By:';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Purchase Header"."Shortcut Dimension 1 Code");
                if DimVal.FindFirst then
                    CampusName := DimVal.Name;
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Purchase Header"."Shortcut Dimension 2 Code");
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


                PreparedByName := '';
                /*
                ApprovalEntryRec.RESET;
                ApprovalEntryRec.SETRANGE(ApprovalEntryRec."Document No.","Purchase Header"."No.");
                ApprovalEntryRec.SETRANGE(ApprovalEntryRec.Status,ApprovalEntryRec.Status::Approved);
                IF ApprovalEntryRec.FINDFIRST THEN
                BEGIN
                  Employee.RESET;
                  Employee.SETRANGE("User ID",ApprovalEntryRec."Sender ID");
                  IF Employee.FINDSET THEN
                  BEGIN
                    PreparedByName := Employee."Full Name";
                  END;
                  Timesent := ApprovalEntryRec."Date-Time Sent for Approval";
                END;
                */

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
        SupplierNoteCaption: Label 'Suppliers are warned that this order is INVALID unless availability of funds is confirmed here below by the accountant I/C, VBC';
        VATPostingSetupRec: Record "VAT Posting Setup";
        VatAmount: Decimal;
        i: Integer;
        ApproveByCaption: Text;
        PreparedByName: Text;
        EmployeeRec: Record Employee;
        ApprovalEntryRec: Record "Approval Entry";
        Timesent: DateTime;
        PreparedByCaption: Text;
        ShowPreparedBy: Boolean;
        UserSetupCopy: Record "User Setup";
}

