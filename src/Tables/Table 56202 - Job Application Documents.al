table 56202 "Job Application Documents"
{
    Caption = 'Job Application Documents';
    DataClassification = ToBeClassified;
    

    fields
    {
        field(1; LineNo; Integer)
        {
            Caption = 'LineNo';
        }
        field(2; "Job Application No"; Code[50])
        {
            Caption = 'Job Application No';
        }
        field(3; "Document Description"; Text[100])
        {
            Caption = 'Document Description';
        }
        field(4; "Actual File Name"; Text[100])
        {
            Caption = 'Actual File Name';
        }
    }
    keys
    {
        key(PK; LineNo)
        {
            Clustered = true;
        }
    }
}
