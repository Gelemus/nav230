tableextension 60201 tableextension60201 extends Vendor
{
    fields
    {
        field(50001; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Normal,Projects';
            OptionMembers = ,Normal,Projects;
        }
        field(50002; PIN; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vendor Budget Gl"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(52137023; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
            TableRelation = "Bank Code"."Bank Code";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                end;

            end;
        }
        field(52137024; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
            Editable = false;
        }
        field(52137025; "Bank Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
            TableRelation = "Bank Branch"."Bank Branch Code" WHERE("Bank Code" = FIELD("Bank Code"));

            trigger OnValidate()
            begin
                "Bank Branch Name" := '';
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Bank Branch Code", "Bank Branch Code");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Bank Branch Name");
                    "Bank Branch Name" := BankBranches."Bank Branch Name";
                end;

            end;
        }
        field(52137026; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
            Editable = false;
        }
        field(52137027; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        field(52137028; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        field(52137029; "MPESA/Paybill Account No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        field(52137030; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
            Editable = false;
        }
        field(52137031; "Vendor Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
            Editable = false;
        }
        field(52137032; "VAT Registered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        field(52137033; "VAT Registration Nos."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        field(52137034; "Date of Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        field(52137035; "Incorporation Certificate No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = '//Sysre NextGen Addon(Vendor details)';
        }
        //         field(52137036;AGPO;Option)
        //         {
        //             DataClassification = ToBeClassified;
        //             OptionCaption = 'N/A

        // ';
        //             OptionMembers = """N/A

        // ,PWD";
        //         }
        field(52137037; Building; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137038; "County Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = County.Code;

            trigger OnValidate()
            begin
                "County Name" := '';

                if Counties.Get("County Code") then
                    "County Name" := Counties.Name;
            end;
        }
        field(52137039; "County Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52137040; Street; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137041; "Supplier Category Code"; Code[20])
        {
            Caption = 'Supplier Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";

            trigger OnValidate()
            var
                ItemAttributeManagement: Codeunit "Item Attribute Management";
            begin
                //ItemAttributeManagement.InheritAttributesFromItemCategory(Rec,"Item Category Code",xRec."Item Category Code");
            end;
        }
        field(52137042; Contacts; Code[30])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
            TableRelation = Contact;

            trigger OnValidate()
            begin
                CompanyPhonebook.Reset;
                CompanyPhonebook.SetRange(CompanyPhonebook."No.", Contacts);
                if CompanyPhonebook.FindFirst then begin
                    "Home Page" := CompanyPhonebook."Home Page";
                    "Phone No." := CompanyPhonebook."Phone No.";
                    "E-Mail" := CompanyPhonebook."E-Mail";
                end;
            end;
        }
        field(52137043; "Vendor Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(52137044; "Vendor Email"; Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(52137045; "Vendor Home Page"; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromContact(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedVendOnDocs(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedVendOnJnls(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewInvoice(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewCreditMemo(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CreateAndShowNewPurchaseOrder(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "VendBlockedErrorMessage(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "VendPrivacyBlockedErrorMessage(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "GetPrivacyBlockedGenericErrorText(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "CalcOverDueBalance(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvoicedPrepmtAmountLCY(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetTotalAmountLCY(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendorNo(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "GetVendorNoOpenCard(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OpenVendorLedgerEntries(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetInsertFromTemplate(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "SetAddress(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCurrencyId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentTermsId(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeIsContactUpdateNeeded(PROCEDURE 50)".


    var
        "//Custom Code": Integer;
        BankCodes: Record "Bank Code";
        BankBranches: Record "Bank Branch";
        Counties: Record County;
        ProcurementUploadDocuments: Record "Procurement Upload Documents";
        ProcurementUploadDocuments2: Record "Procurement Upload Documents";
        VendorPostingGroup: Record "Vendor Posting Group";
        VendorDocs: Record "Vendor Required Documents";
        CompanyPhonebook: Record Contact;
}

