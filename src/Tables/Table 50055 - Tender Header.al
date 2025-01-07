table 50055 "Tender Header"
{

    fields
    {
        field(10; "No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Tender Description"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Eligibility; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Reserved for Special group,Reserved for County';
            OptionMembers = Open,"Reserved for Special group","Reserved for County";
        }
        field(13; "Tender Submission (From)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Tender Submission (To)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Tender Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Tender Preparation,Tender Opening,Tender Evaluation,Closed';
            OptionMembers = "Tender Preparation","Tender Opening","Tender Evaluation",Closed;
        }
        field(20; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Tender Closing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Evaluation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Award Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Supplier Awarded"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                "Supplier Name" := '';
                if Supplier.Get("Supplier Awarded") then
                    "Supplier Name" := Supplier.Name;
            end;
        }
        field(26; "Supplier Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Purchase Requisition"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Requisitions";

            trigger OnValidate()
            begin
                PurchaseRequisition.Reset;
                PurchaseRequisition.SetRange(PurchaseRequisition."No.", "Purchase Requisition");
                if PurchaseRequisition.FindFirst then begin
                    "Purchase Req. Description" := PurchaseRequisition.Description;
                end;
            end;
        }
        field(29; "Purchase Req. Description"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Tender closed by"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Supplier Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                "Supplier Category Description" := '';



                ItemCategory.Reset;
                ItemCategory.SetRange(ItemCategory.Code, "Supplier Category");
                if ItemCategory.FindFirst then begin
                    "Supplier Category Description" := ItemCategory.Description;

                    if Eligibility = Eligibility::"Reserved for Special group" then begin
                        TenderLines.Reset;
                        TenderLines.SetRange(TenderLines."Document No.", "No.");
                        if TenderLines.FindSet then begin
                            TenderLines.DeleteAll
                        end;
                        SupplierCategory.Reset;
                        SupplierCategory.SetRange(SupplierCategory."Supplier Category", "Supplier Category");
                        if SupplierCategory.FindSet then begin
                            repeat
                                TenderLines.Init;
                                TenderLines."Document No." := "No.";
                                Vendors.Reset;
                                Vendors.SetRange(Vendors."No.", SupplierCategory."Document Number");
                                if Vendors.FindFirst then
                                    TenderLines."Supplier Name" := Vendors.Name;
                                TenderLines.Insert;
                            until SupplierCategory.Next = 0;
                        end;
                    end;
                end;
            end;
        }
        field(32; "Supplier Category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(34; "Tender Preparation Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Held By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Name of the Procuring Entity"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Tender No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Date Tender Invited"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Date Tender Opened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "No. of Tendererd Issued with"; Integer)
        {
            Caption = 'No. of Tendererd Issued with tender documents';
            DataClassification = ToBeClassified;
        }
        field(41; "No. of Bids Received"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Method of Procurement Applied"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "A brief background statement"; Text[250])
        {
            Caption = 'A brief background statement of the procurement/asset disposal proceeding from planning to tender evaluation';
            DataClassification = ToBeClassified;
        }
        field(44; "State whether due diligence wa"; Text[250])
        {
            Caption = 'State whether due diligence was conducted on the successful bidder. Give a brief statement of the outcome thereof';
            DataClassification = ToBeClassified;
        }
        field(45; "State whether the recom"; Text[250])
        {
            Caption = 'State whether the recommended price for the standard goods, services and works are within the indicative market price';
            DataClassification = ToBeClassified;
        }
        field(46; "State how evaluation criteria"; Text[250])
        {
            Caption = 'State how evaluation criteria set forth in tender document was applied and whther or not the tender evaluation commitee members adhered to the law in the bid evaluation';
            DataClassification = ToBeClassified;
        }
        field(47; "Confirm if adequate funds are"; Text[250])
        {
            Caption = 'Confirm if adequate funds are set aside for the procurement/asset';
            DataClassification = ToBeClassified;
        }
        field(48; "Give opinion whether procureme"; Text[250])
        {
            Caption = 'Give opinion whether procurement law and practice was applied in the proceeding leading to recommendation of the evaluation commitee and whether or not accounting officer may consider approval/rejection of the recommendations of the evaluation report';
            DataClassification = ToBeClassified;
        }
        field(49; "Any relevant information"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Special Condition"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Type of supply"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Supply of Goods","Provision of Services","Provisions of Works";
        }
        field(52; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration of Supplier,Open Tender,Request for Proposal';
            OptionMembers = " ","Registration of Supplier","Open Tender","Request for Proposal";
        }
        field(53; "Financial Year Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Financial Year End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55; "Financial Year"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Financial Year";

            trigger OnValidate()
            begin
                FinancialYear.Reset;
                IF FinancialYear.get("Financial Year") then
                    "Financial Year End Date" := FinancialYear."End Date";
                "Financial Year Start Date" := FinancialYear."Start Date";
                if "Document Type" = "Document Type"::"Registration of Supplier" then begin
                    "Tender Closing Date" := "Financial Year End Date";
                    "Tender Opening Date" := "Financial Year Start Date";
                    "Tender Submission (From)" := "Financial Year Start Date";
                    "Tender Submission (To)" := "Financial Year End Date";
                end;
            end;
            //end;
        }
        field(56; "Special Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Youth,Women,Persons with Disability,Youth/Women,Youth/Women/Persons with disability';
            OptionMembers = " ",Youth,Women,"Persons with Disability","Youth/Women","Youth/Women/Persons with disability";
        }
        field(57; "Tender Closing Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Tender Opening Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Tender Opening Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Tender Opening Venue"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Tender Description", Eligibility, "Purchase Requisition")
        {
        }
    }

    trigger OnInsert()
    begin
        /*IF "No." = '' THEN BEGIN
          "Purchases&PayablesSetup".GET;
          "Purchases&PayablesSetup".TESTFIELD("Purchases&PayablesSetup"."Tender Doc No.");
          NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
        END;*/

        if "No." = '' then begin
            "Purchases&PayablesSetup".Get;
            "Purchases&PayablesSetup".TestField("Prequalification Nos");
            if "Document Type" = "Document Type"::"Registration of Supplier" then begin
                NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Prequalification Nos", xRec."No. Series", 0D, "No.", "No. Series");
                //  "Document Type":="Document Type"::"Registration of Supplier";
            end
            else if "Document Type" = "Document Type"::"Open Tender" then begin
                "Purchases&PayablesSetup".TestField("Purchases&PayablesSetup"."Tender Doc No.");
                NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.", xRec."No. Series", 0D, "No.", "No. Series");

            end
            else if "Document Type" = "Document Type"::"Request for Proposal" then begin
                "Purchases&PayablesSetup".TestField("Purchases&PayablesSetup"."Request For Proposal");
                NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Request For Proposal", xRec."No. Series", 0D, "No.", "No. Series");
                // "Document Type":="Document Type"::"Open Tender";Request For Proposal
            end;
        end;

        "Document Date" := Today;
        "User ID" := UserId;
        "Held By" := UserId;

        ProcurementUploadDocuments2.Reset;
        ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2.Type, ProcurementUploadDocuments2.Type::Tender);
        ProcurementUploadDocuments2.SetRange(ProcurementUploadDocuments2."Tender Stage", ProcurementUploadDocuments2."Tender Stage"::"Tender Preparation");
        if ProcurementUploadDocuments2.FindSet then begin
            repeat
                VendorDocs.Init;
                VendorDocs.Code := "No.";
                VendorDocs."Document Code" := ProcurementUploadDocuments2."Document Code";
                VendorDocs."Document Description" := ProcurementUploadDocuments2."Document Description";
                VendorDocs."Document Attached" := false;
                VendorDocs.Insert;
            until ProcurementUploadDocuments2.Next = 0;
        end;

    end;

    var
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Supplier: Record Vendor;
        PurchaseRequisition: Record "Purchase Requisitions";
        ItemCategory: Record "Item Category";
        TenderLines: Record "Tender Lines";
        SupplierCategory: Record "Supplier Category";
        Vendors: Record Vendor;
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        VendorDocs: Record "Vendor Required Documents";
        "Prequalification Nos": Record "Purchases & Payables Setup";
        TenderHeader: Record "Tender Header";
        FinancialYear: Record "Financial Year";
}

