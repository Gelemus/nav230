report 50610 Quotation
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Quotation.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo."Address 2")
            {
            }
            column(PostalCode; CompanyInfo."Post Code")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(DocumentType_SalesHeader; "Sales Header"."Document Type")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(OrderDate_SalesHeader; "Sales Header"."Order Date")
            {
            }
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
            {
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
            }
            column(PostingDescription_SalesHeader; "Sales Header"."Posting Description")
            {
            }
            column(SalespersonCode_SalesHeader; "Sales Header"."Salesperson Code")
            {
            }
            column(OrderClass_SalesHeader; "Sales Header"."Order Class")
            {
            }
            column(Comment_SalesHeader; "Sales Header".Comment)
            {
            }
            column(NoPrinted_SalesHeader; "Sales Header"."No. Printed")
            {
            }
            column(OnHold_SalesHeader; "Sales Header"."On Hold")
            {
            }
            column(AppliestoDocType_SalesHeader; "Sales Header"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_SalesHeader; "Sales Header"."Applies-to Doc. No.")
            {
            }
            column(BalAccountNo_SalesHeader; "Sales Header"."Bal. Account No.")
            {
            }
            column(RecalculateInvoiceDisc_SalesHeader; "Sales Header"."Recalculate Invoice Disc.")
            {
            }
            column(Ship_SalesHeader; "Sales Header".Ship)
            {
            }
            column(Invoice_SalesHeader; "Sales Header".Invoice)
            {
            }
            column(PrintPostedDocuments_SalesHeader; "Sales Header"."Print Posted Documents")
            {
            }
            column(Amount_SalesHeader; "Sales Header".Amount)
            {
            }
            column(AmountIncludingVAT_SalesHeader; "Sales Header"."Amount Including VAT")
            {
            }
            column(ShippingNo_SalesHeader; "Sales Header"."Shipping No.")
            {
            }
            column(PostingNo_SalesHeader; "Sales Header"."Posting No.")
            {
            }
            column(LastShippingNo_SalesHeader; "Sales Header"."Last Shipping No.")
            {
            }
            column(LastPostingNo_SalesHeader; "Sales Header"."Last Posting No.")
            {
            }
            column(PrepaymentNo_SalesHeader; "Sales Header"."Prepayment No.")
            {
            }
            column(LastPrepaymentNo_SalesHeader; "Sales Header"."Last Prepayment No.")
            {
            }
            column(PrepmtCrMemoNo_SalesHeader; "Sales Header"."Prepmt. Cr. Memo No.")
            {
            }
            column(LastPrepmtCrMemoNo_SalesHeader; "Sales Header"."Last Prepmt. Cr. Memo No.")
            {
            }
            column(VATRegistrationNo_SalesHeader; "Sales Header"."VAT Registration No.")
            {
            }
            column(CombineShipments_SalesHeader; "Sales Header"."Combine Shipments")
            {
            }
            column(InvoiceDiscountValue_SalesHeader; "Sales Header"."Invoice Discount Value")
            {
            }
            column(SendICDocument_SalesHeader; "Sales Header"."Send IC Document")
            {
            }
            column(ICStatus_SalesHeader; "Sales Header"."IC Status")
            {
            }
            column(SelltoICPartnerCode_SalesHeader; "Sales Header"."Sell-to IC Partner Code")
            {
            }
            column(BilltoICPartnerCode_SalesHeader; "Sales Header"."Bill-to IC Partner Code")
            {
            }
            column(DirectDebitMandateID_SalesHeader; "Sales Header"."Direct Debit Mandate ID")
            {
            }
            column(InvoiceDiscountAmount_SalesHeader; "Sales Header"."Invoice Discount Amount")
            {
            }
            column(NoofArchivedVersions_SalesHeader; "Sales Header"."No. of Archived Versions")
            {
            }
            column(DocNoOccurrence_SalesHeader; "Sales Header"."Doc. No. Occurrence")
            {
            }
            column(CampaignNo_SalesHeader; "Sales Header"."Campaign No.")
            {
            }
            column(SelltoCustomerTemplateCode_SalesHeader; "Sales Header"."Sell-to Customer Templ. Code")
            {
            }
            column(SelltoContactNo_SalesHeader; "Sales Header"."Sell-to Contact No.")
            {
            }
            column(BilltoContactNo_SalesHeader; "Sales Header"."Bill-to Contact No.")
            {
            }
            column(BilltoCustomerTemplateCode_SalesHeader; "Sales Header"."Sell-to Customer Templ. Code")
            {
            }
            column(OpportunityNo_SalesHeader; "Sales Header"."Opportunity No.")
            {
            }
            column(ResponsibilityCenter_SalesHeader; "Sales Header"."Responsibility Center")
            {
            }
            column(AssignedUserID_SalesHeader; "Sales Header"."Assigned User ID")
            {
            }
            column(ShortcutDimension2Code_SalesHeader; ZoneDetail)
            {
            }
            column(Template_SalesHeader; "Sales Header".Template)
            {
            }
            column(AccountNo_SalesHeader; "Sales Header"."Account No.")
            {
            }
            column(ConnectionNo_SalesHeader; "Sales Header"."Connection No.")
            {
            }
            column(ChainageNo_SalesHeader; "Sales Header"."Chainage No")
            {
            }
            column(ExistingConnections_SalesHeader; "Sales Header"."Existing Connections")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(DocumentType_SalesLine; "Sales Line"."Document Type")
                {
                }
                column(SelltoCustomerNo_SalesLine; "Sales Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(Type_SalesLine; "Sales Line".Type)
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(LocationCode_SalesLine; "Sales Line"."Location Code")
                {
                }
                column(PostingGroup_SalesLine; "Sales Line"."Posting Group")
                {
                }
                column(ShipmentDate_SalesLine; "Sales Line"."Shipment Date")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Description2_SalesLine; "Sales Line"."Description 2")
                {
                }
                column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(OutstandingQuantity_SalesLine; "Sales Line"."Outstanding Quantity")
                {
                }
                column(QtytoInvoice_SalesLine; "Sales Line"."Qty. to Invoice")
                {
                }
                column(QtytoShip_SalesLine; "Sales Line"."Qty. to Ship")
                {
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }
                column(UnitCostLCY_SalesLine; "Sales Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_SalesLine; "Sales Line"."VAT %")
                {
                }
                column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesLine; "Sales Line"."Line Discount Amount")
                {
                }
                column(Amount_SalesLine; "Sales Line".Amount)
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Line"."Amount Including VAT")
                {
                }
                column(AllowInvoiceDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_SalesLine; "Sales Line"."Gross Weight")
                {
                }
                column(NetWeight_SalesLine; "Sales Line"."Net Weight")
                {
                }
                column(UnitsperParcel_SalesLine; "Sales Line"."Units per Parcel")
                {
                }
                column(UnitVolume_SalesLine; "Sales Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_SalesLine; "Sales Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_SalesLine; "Sales Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_SalesLine; "Sales Line"."Shortcut Dimension 2 Code")
                {
                }
                column(CustomerPriceGroup_SalesLine; "Sales Line"."Customer Price Group")
                {
                }
                column(JobNo_SalesLine; "Sales Line"."Job No.")
                {
                }
                column(WorkTypeCode_SalesLine; "Sales Line"."Work Type Code")
                {
                }
                column(RecalculateInvoiceDisc_SalesLine; "Sales Line"."Recalculate Invoice Disc.")
                {
                }
                column(OutstandingAmount_SalesLine; "Sales Line"."Outstanding Amount")
                {
                }
                column(QtyShippedNotInvoiced_SalesLine; "Sales Line"."Qty. Shipped Not Invoiced")
                {
                }
                column(ShippedNotInvoiced_SalesLine; "Sales Line"."Shipped Not Invoiced")
                {
                }
                column(QuantityShipped_SalesLine; "Sales Line"."Quantity Shipped")
                {
                }
                column(QuantityInvoiced_SalesLine; "Sales Line"."Quantity Invoiced")
                {
                }
                column(ShipmentNo_SalesLine; "Sales Line"."Shipment No.")
                {
                }
                column(ShipmentLineNo_SalesLine; "Sales Line"."Shipment Line No.")
                {
                }
                column(Profit_SalesLine; "Sales Line"."Profit %")
                {
                }
                column(BilltoCustomerNo_SalesLine; "Sales Line"."Bill-to Customer No.")
                {
                }
                column(InvDiscountAmount_SalesLine; "Sales Line"."Inv. Discount Amount")
                {
                }
                column(PurchaseOrderNo_SalesLine; "Sales Line"."Purchase Order No.")
                {
                }
                column(PurchOrderLineNo_SalesLine; "Sales Line"."Purch. Order Line No.")
                {
                }
                column(DropShipment_SalesLine; "Sales Line"."Drop Shipment")
                {
                }
                column(GenBusPostingGroup_SalesLine; "Sales Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_SalesLine; "Sales Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_SalesLine; "Sales Line"."VAT Calculation Type")
                {
                }
                column(TransactionType_SalesLine; "Sales Line"."Transaction Type")
                {
                }
                column(TransportMethod_SalesLine; "Sales Line"."Transport Method")
                {
                }
                column(AttachedtoLineNo_SalesLine; "Sales Line"."Attached to Line No.")
                {
                }
                column(ExitPoint_SalesLine; "Sales Line"."Exit Point")
                {
                }
                column(Area_SalesLine; "Sales Line".Area)
                {
                }
                column(TransactionSpecification_SalesLine; "Sales Line"."Transaction Specification")
                {
                }
                column(TaxCategory_SalesLine; "Sales Line"."Tax Category")
                {
                }
                column(TaxAreaCode_SalesLine; "Sales Line"."Tax Area Code")
                {
                }
                column(TaxLiable_SalesLine; "Sales Line"."Tax Liable")
                {
                }
                column(TaxGroupCode_SalesLine; "Sales Line"."Tax Group Code")
                {
                }
                column(VATClauseCode_SalesLine; "Sales Line"."VAT Clause Code")
                {
                }
                column(VATBusPostingGroup_SalesLine; "Sales Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_SalesLine; "Sales Line"."VAT Prod. Posting Group")
                {
                }
                column(CurrencyCode_SalesLine; "Sales Line"."Currency Code")
                {
                }
                column(OutstandingAmountLCY_SalesLine; "Sales Line"."Outstanding Amount (LCY)")
                {
                }
                column(ShippedNotInvoicedLCY_SalesLine; "Sales Line"."Shipped Not Invoiced (LCY)")
                {
                }
                column(ShippedNotInvLCYNoVAT_SalesLine; "Sales Line"."Shipped Not Inv. (LCY) No VAT")
                {
                }
                column(ReservedQuantity_SalesLine; "Sales Line"."Reserved Quantity")
                {
                }
                column(Reserve_SalesLine; "Sales Line".Reserve)
                {
                }
                column(BlanketOrderNo_SalesLine; "Sales Line"."Blanket Order No.")
                {
                }
                column(BlanketOrderLineNo_SalesLine; "Sales Line"."Blanket Order Line No.")
                {
                }
                column(VATBaseAmount_SalesLine; "Sales Line"."VAT Base Amount")
                {
                }
                column(UnitCost_SalesLine; "Sales Line"."Unit Cost")
                {
                }
                column(SystemCreatedEntry_SalesLine; "Sales Line"."System-Created Entry")
                {
                }
                column(LineAmount_SalesLine; "Sales Line"."Line Amount")
                {
                }
                column(VATDifference_SalesLine; "Sales Line"."VAT Difference")
                {
                }
                column(InvDiscAmounttoInvoice_SalesLine; "Sales Line"."Inv. Disc. Amount to Invoice")
                {
                }
                column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                {
                }
                column(ICPartnerRefType_SalesLine; "Sales Line"."IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_SalesLine; "Sales Line"."IC Partner Reference")
                {
                }
                column(Prepayment_SalesLine; "Sales Line"."Prepayment %")
                {
                }
                column(PrepmtLineAmount_SalesLine; "Sales Line"."Prepmt. Line Amount")
                {
                }
                column(PrepmtAmtInv_SalesLine; "Sales Line"."Prepmt. Amt. Inv.")
                {
                }
                column(PrepmtAmtInclVAT_SalesLine; "Sales Line"."Prepmt. Amt. Incl. VAT")
                {
                }
                column(PrepaymentAmount_SalesLine; "Sales Line"."Prepayment Amount")
                {
                }
                column(PrepmtVATBaseAmt_SalesLine; "Sales Line"."Prepmt. VAT Base Amt.")
                {
                }
                column(PrepaymentVAT_SalesLine; "Sales Line"."Prepayment VAT %")
                {
                }
                column(PrepmtVATCalcType_SalesLine; "Sales Line"."Prepmt. VAT Calc. Type")
                {
                }
                column(PrepaymentVATIdentifier_SalesLine; "Sales Line"."Prepayment VAT Identifier")
                {
                }
                column(PrepaymentTaxAreaCode_SalesLine; "Sales Line"."Prepayment Tax Area Code")
                {
                }
                column(PrepaymentTaxLiable_SalesLine; "Sales Line"."Prepayment Tax Liable")
                {
                }
                column(PrepaymentTaxGroupCode_SalesLine; "Sales Line"."Prepayment Tax Group Code")
                {
                }
                column(PrepmtAmttoDeduct_SalesLine; "Sales Line"."Prepmt Amt to Deduct")
                {
                }
                column(PrepmtAmtDeducted_SalesLine; "Sales Line"."Prepmt Amt Deducted")
                {
                }
                column(PrepaymentLine_SalesLine; "Sales Line"."Prepayment Line")
                {
                }
                column(PrepmtAmountInvInclVAT_SalesLine; "Sales Line"."Prepmt. Amount Inv. Incl. VAT")
                {
                }
                column(PrepmtAmountInvLCY_SalesLine; "Sales Line"."Prepmt. Amount Inv. (LCY)")
                {
                }
                column(ICPartnerCode_SalesLine; "Sales Line"."IC Partner Code")
                {
                }
                column(PrepmtVATAmountInvLCY_SalesLine; "Sales Line"."Prepmt. VAT Amount Inv. (LCY)")
                {
                }
                column(PrepaymentVATDifference_SalesLine; "Sales Line"."Prepayment VAT Difference")
                {
                }
                column(PrepmtVATDifftoDeduct_SalesLine; "Sales Line"."Prepmt VAT Diff. to Deduct")
                {
                }
                column(PrepmtVATDiffDeducted_SalesLine; "Sales Line"."Prepmt VAT Diff. Deducted")
                {
                }
                column(PmtDiscountAmount_SalesLine; "Sales Line"."Pmt. Discount Amount")
                {
                }
                column(LineDiscountCalculation_SalesLine; "Sales Line"."Line Discount Calculation")
                {
                }
                column(DimensionSetID_SalesLine; "Sales Line"."Dimension Set ID")
                {
                }
                column(QtytoAssembletoOrder_SalesLine; "Sales Line"."Qty. to Assemble to Order")
                {
                }
                column(QtytoAsmtoOrderBase_SalesLine; "Sales Line"."Qty. to Asm. to Order (Base)")
                {
                }
                column(ATOWhseOutstandingQty_SalesLine; "Sales Line"."ATO Whse. Outstanding Qty.")
                {
                }
                column(ATOWhseOutstdQtyBase_SalesLine; "Sales Line"."ATO Whse. Outstd. Qty. (Base)")
                {
                }
                column(JobTaskNo_SalesLine; "Sales Line"."Job Task No.")
                {
                }
                column(JobContractEntryNo_SalesLine; "Sales Line"."Job Contract Entry No.")
                {
                }
                column(PostingDate_SalesLine; "Sales Line"."Posting Date")
                {
                }
                column(DeferralCode_SalesLine; "Sales Line"."Deferral Code")
                {
                }
                column(ReturnsDeferralStartDate_SalesLine; "Sales Line"."Returns Deferral Start Date")
                {
                }
                column(VariantCode_SalesLine; "Sales Line"."Variant Code")
                {
                }
                column(BinCode_SalesLine; "Sales Line"."Bin Code")
                {
                }
                column(QtyperUnitofMeasure_SalesLine; "Sales Line"."Qty. per Unit of Measure")
                {
                }
                column(Planned_SalesLine; "Sales Line".Planned)
                {
                }
                column(UnitofMeasureCode_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);

                DimensionValues.Reset;
                DimensionValues.SetRange(Code, "Sales Header"."Shortcut Dimension 2 Code");
                if DimensionValues.FindSet then begin
                    ZoneDetail := DimensionValues.Name;
                end;
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
        CompanyInfo: Record "Company Information";
        ZoneDetail: Code[100];
        DimensionValues: Record "Dimension Value";
}

