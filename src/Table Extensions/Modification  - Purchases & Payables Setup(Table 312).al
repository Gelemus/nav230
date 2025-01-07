tableextension 60251 tableextension60251 extends "Purchases & Payables Setup"
{
    fields
    {
        field(52136923; "Purchase Requisition Nos."; Code[20])
        {
            Caption = 'Purchase Requisition Nos.';
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon - Specifies the Purchase Requisition No. Series';
            TableRelation = "No. Series".Code;
        }
        field(52136924; "Request for Quotation Nos."; Code[20])
        {
            Caption = 'Request for Quotation Nos.';
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon - Specifies the Request for Quotation No. Series';
            TableRelation = "No. Series".Code;
        }
        field(52136925; "Procurement Plan Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon - Specifies the Request for Quotation No. Series';
            TableRelation = "No. Series".Code;
        }
        field(52136926; "Use Procurement Plan"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon';
        }
        field(52136927; "Tender Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Sysre NextGen Addon';
            TableRelation = "No. Series".Code;
        }
        field(52136928; "User to replenish Stock"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(52136929; "Tender Evaluation No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(52136930; "Inspection Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52136931; "Requisition Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52136932; "Supplier Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52136933; "Prequalification Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52136934; "Request For Proposal"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(52136935; "Litigation Question Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "GetRecordOnce(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "JobQueueActive(PROCEDURE 1)".

}
