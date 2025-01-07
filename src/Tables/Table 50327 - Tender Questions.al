table 50327 "Tender Questions"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3;Question;Text[1050])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Status;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Description;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Parent ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Question Type";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Cat ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Quetion Type.";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '   ,Litigation History';
            OptionMembers = "    ","Litigation History";
        }
        field(10;"Questions Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '    ,Litigation History,ELIGIBILITY_LITIGATION,CAPABILITY_COMPETENCE_TO_DELIVER_G&S';
            OptionMembers = "    ","Litigation History",ELIGIBILITY_LITIGATION,"CAPABILITY_COMPETENCE_TO_DELIVER_G&S";
        }
        field(11;"Quest type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'ELIGIBILITY/LITIGATION,CAPABILITY/COMPETENCE';
            OptionMembers = "ELIGIBILITY/LITIGATION","CAPABILITY/COMPETENCE";
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

