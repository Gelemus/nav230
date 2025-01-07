table 50225 "Resource Centre Setup"
{

    fields
    {
        field(1;"Primary Key";Code[20])
        {
        }
        field(2;"Book Requisition No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3;"Books No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4;Mails;Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5;MailMove;Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6;"File Req No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7;"File Movement Numbers";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8;"Litigation Sch. Nos.";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9;"Conveyance Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10;"Books Issue No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11;"Action Numbers";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(12;Resource;Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13;"Donations Ref. No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14;"external mails No.";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(15;"mails send";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16;"Resource centre Personell";Text[50])
        {
            TableRelation = "User Setup";
        }
        field(17;"Bench Mark No.";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(18;"Bech Mark Req. No";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(19;"Legal Advice";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20;Media;Code[20])
        {
            TableRelation = "No. Series";
        }
        field(21;"E-mail";Text[80])
        {
        }
        field(22;Files;Code[20])
        {
            TableRelation = "No. Series";
        }
        field(23;"Legal Email";Text[50])
        {
        }
        field(24;"Legal Notice Body";Text[250])
        {
        }
        field(25;"On Expiry Notice";DateFormula)
        {
        }
        field(26;"On Three Months Notice";DateFormula)
        {
        }
        field(27;"On Six Months Notice";DateFormula)
        {
        }
        field(28;"Contract Notices";Text[250])
        {
        }
        field(29;"Mail DMS Link";Text[250])
        {
        }
        field(30;"File DMS Link";Text[250])
        {
        }
        field(31;"Outgoing Mail Request Nos";Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32;"Registry Email";Text[100])
        {
        }
        field(33;"HR Department E-mail";Text[50])
        {
        }
        field(34;"Mail Notification Period(Days)";Integer)
        {
        }
        field(35;"Outgoing Mails DMS Link";Text[150])
        {
        }
        field(36;"Incoming Mails No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(37;"Oil Requistion No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(38;"Cheque Deposit No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(39;"Cheque Released No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40;"Released Letters  No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(41;"Sent Letters Nos";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(42;"Risk Management Nos";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
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

