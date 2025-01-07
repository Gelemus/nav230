table 50323 "Evaluation Criteria"
{

    fields
    {
        field(1;"Code";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Max Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Particulars;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Tender No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Header";
        }
        field(5;"Created By";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Updated By";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8;Status;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Date Updated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;Section;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Evaluation Category";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mandatory,Supplier Availability,Business Profile Ownership,Financial Capability,Experience: (Evidence of at least 3 fulfilled Orders in the last 2 years,Reliability: Recommendations within the last 2 year,Supply Capacity,Eligibility & Disclosure of litigation history';
            OptionMembers = " ",Mandatory,"Supplier Availability","Business Profile Ownership","Financial Capability","Experience: (Evidence of at least 3 fulfilled Orders in the last 2 years","Reliability: Recommendations within the last 2 year","Supply Capacity","Eligibility & Disclosure of litigation history";
        }
        field(13;Eligibility;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Open,Reserved for Special group';
            OptionMembers = " ",Open,"Reserved for Special group";
        }
        field(14;"Document Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration of Supplier,Open Tender,Request for Proposal';
            OptionMembers = " ","Registration of Supplier","Open Tender","Request for Proposal";
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

