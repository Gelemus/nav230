tableextension 60383 tableextension60383 extends "Employee Qualification" 
{
    fields
    {
        modify(Type)
        {
            OptionCaption = ' ,Internal,External,Previous Position,Self Sponsored,Company Sponsored';

            //Unsupported feature: Property Modification (OptionString) on "Type(Field 6)".

        }

        //Unsupported feature: Code Modification on ""Qualification Code"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Qualification.Get("Qualification Code");
            Description := Qualification.Description;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            QualificationRec.Get("Qualification Code");
            Qualification := QualificationRec.Description;
            */
        //end;
        field(14;Award;Text[150])
        {
            DataClassification = ToBeClassified;
            Description = '//';
        }
        field(15;"Award Date";Date)
        {
            DataClassification = ToBeClassified;
            Description = '//';
        }
        field(16;Verified;Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//';
            Editable = false;
        }
        field(17;"Year of Graduation";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18;Qualification;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Document Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',qualification,Kpi';
            OptionMembers = ,qualification,Kpi;
        }
        field(20;"Performance Target";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21;Unit;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22;"Maximum Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23;Apprasee;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24;Appraiser;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1;"Document Type")
        {
        }
    }

    var
        QualificationRec: Record Qualification;
}

