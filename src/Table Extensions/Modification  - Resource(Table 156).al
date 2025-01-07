tableextension 60126 tableextension60126 extends Resource 
{
    fields
    {
        field(50000;"Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Add for Create Resource from Employee Card.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if "Employee No." <> '' then begin
                  Clear(gvResource);
                  gvResource.SetRange(gvResource."Employee No.","Employee No.");
                  if gvResource.FindFirst then
                    Error(Text50000);
                end;
            end;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnitOfMeasureFilter(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTimeSheets(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckResourcePrivacyBlocked(PROCEDURE 6)".


    var
        gvResource: Record Resource;
        Text50000: Label 'Another Resource Card Exists the Selected Employee.';
        Text50001: Label 'Employee No. Must not be Empty in Resource No. %1';
        Text50002: Label 'Already Personal Data is there Do You want to Change';
        Text50003: Label 'Already Personal Data is there for Resource No. %1. So It is not Possible to Create Resource.';
}

