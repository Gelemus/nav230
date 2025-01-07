table 50085 "Loan Application Documents"
{

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table50355.Field1;

            trigger OnValidate()
            begin
                EmployeeLoanApplications.Reset;
                EmployeeLoanApplications.SetRange(EmployeeLoanApplications."No.", "Application No.");
                if EmployeeLoanApplications.FindFirst then begin
                    "Product Code" := EmployeeLoanApplications."Loan Product Code";
                end;
            end;
        }
        field(2; "Document Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table50367.Field1 WHERE(Field1 = FIELD("Product Code"));

            trigger OnValidate()
            begin
                "Document Description" := '';
                LoanApplicationDocuments.Reset;
                LoanApplicationDocuments.SetRange(LoanApplicationDocuments."Document Code", "Document Code");
                if LoanApplicationDocuments.FindFirst then begin
                    "Document Description" := LoanApplicationDocuments."Document Description";
                end;
            end;
        }
        field(3; "Document Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Attached"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Document Verified"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document Verified" = true then begin
                    "Verified By" := UserId;
                end;
            end;
        }
        field(6; "Verified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Document Mandatory Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Application,Approval,Account Creation';
            OptionMembers = " ",Application,Approval,"Account Creation";
        }
        field(10; "Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Local File URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "SharePoint URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application No.", "Document Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeLoanApplications: Record "Employee Loan Applications";
        LoanApplicationDocuments: Record "Loan Application Documents";
}

