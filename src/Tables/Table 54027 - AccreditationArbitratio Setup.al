table 54027 "Accreditation/Arbitratio Setup"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(2;"Applicant Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3;"Complains Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4;"Case Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5;"Court Attendance Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6;"Case File Movement Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7;"Document Registration Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8;"Accreditation Application";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9;"APSD Minimum Quantity";Decimal)
        {
        }
        field(10;"APSD Default Unit Price";Decimal)
        {
        }
        field(11;"Default APSD Item";Code[20])
        {
            TableRelation = Item."No.";
        }
        field(12;"Authentication Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13;"CMO Registration Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14;"CMO Renewal Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(15;"Visitor Pass Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16;"Request For Appointment Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17;"E-arbitrator appointment Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18;"RFA Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19;"Stakeholders Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20;"RFM Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(21;"Request For Administration Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(22;"Gen. Bus Posting Group";Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(23;"Customer Posting Group";Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(24;"Default Annual Unit Of Measure";Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(25;"Default Serv. Contr. Acc. Gr";Code[20])
        {
            TableRelation = "Service Contract Account Group";
        }
        field(26;"Default Service Order Type";Code[20])
        {
            TableRelation = "Service Order Type";
        }
        field(27;"Default Contract Grp Code";Code[20])
        {
            TableRelation = "Contract Group";
        }
        field(28;"Default Service Period";DateFormula)
        {
        }
        field(29;"Default Renewal Period";DateFormula)
        {
        }
        field(30;"Accreditation Renewal Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(31;"Default Customer Posting Group";Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(32;"Default Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(33;"Deflt Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                /*IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                  IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                    VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
                    */

            end;
        }
        field(34;"Default VAT Bus. Posting Group";Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(35;"Response Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(36;"Arbitral Tribunal Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(37;"Disputant Customer Posting Grp";Code[10])
        {
            Caption = 'Disputant Customer Posting Grp';
            TableRelation = "Customer Posting Group";
        }
        field(38;"Disputant Gen. Bus. Posting Gp";Code[10])
        {
            Caption = 'Disputant Gen. Bus. Posting Gp';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                /*IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                  IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                    VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
                    */

            end;
        }
        field(39;"Disputant VAT Bus. Posting Grp";Code[10])
        {
            Caption = 'Disputant VAT Bus. Posting Grp';
            TableRelation = "VAT Business Posting Group";
        }
        field(40;"Accreditor Vendor Posting Grp";Code[10])
        {
            Caption = 'Accreditor Vendor Posting Grp';
            TableRelation = "Vendor Posting Group";
        }
        field(41;"Accred Gen. Bus. Posting Gp";Code[10])
        {
            Caption = 'Accred Gen. Bus. Posting Gp';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                /*IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                  IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                    VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
                    */

            end;
        }
        field(42;"Accred VAT Bus. Posting Grp";Code[10])
        {
            Caption = 'Accred VAT Bus. Posting Grp';
            TableRelation = "VAT Business Posting Group";
        }
        field(43;"Default Arbitration Seat";Text[30])
        {
        }
        field(44;"Default Arbitration Language";Code[20])
        {
            TableRelation = Language;
        }
        field(45;"Award Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(46;"Advance Deposit %";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

