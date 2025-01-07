table 51188 "Payroll Exp Allocation Matrix"
{

    fields
    {
        field(1;"Employee No";Code[20])
        {
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2;"ED Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "ED Definitions";
        }
        field(4;"Dimension Code1";Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code1" <> xRec."Dimension Code1" then "Dimension Value Code1" := '';
            end;
        }
        field(5;"Dimension Value Code1";Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code1"));
        }
        field(6;"Dimension Code2";Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code2" <> xRec."Dimension Code2" then "Dimension Value Code2" := '';
            end;
        }
        field(7;"Dimension Value Code2";Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code2"));
        }
        field(8;"Dimension Code3";Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code3" <> xRec."Dimension Code3" then "Dimension Value Code3" := '';
            end;
        }
        field(9;"Dimension Value Code3";Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code3"));
        }
        field(10;"Dimension Code4";Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code4" <> xRec."Dimension Code4" then "Dimension Value Code4" := '';
            end;
        }
        field(11;"Dimension Value Code4";Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code4"));
        }
        field(12;"Dimension Code5";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code4" <> xRec."Dimension Code4" then "Dimension Value Code4" := '';
            end;
        }
        field(13;"Dimension Value Code5";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code5"));
        }
        field(14;"Dimension Code6";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code4" <> xRec."Dimension Code4" then "Dimension Value Code4" := '';
            end;
        }
        field(15;"Dimension Value Code6";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code6"));
        }
        field(16;"Dimension Code7";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code4" <> xRec."Dimension Code4" then "Dimension Value Code4" := '';
            end;
        }
        field(17;"Dimension Value Code7";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code7"));
        }
        field(18;"Dimension Code8";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if  "Dimension Code4" <> xRec."Dimension Code4" then "Dimension Value Code4" := '';
            end;
        }
        field(19;"Dimension Value Code8";Code[20])
        {
            Description = 'AAFH CCN 341/45';
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code8"));
        }
        field(25;Allocated;Decimal)
        {
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                lvAllocatedTotal: Record "Payroll Exp Allocation Matrix";
            begin
                TableTransferCode.PayrollAllocationMatrixAllocatedValidate(Rec);
            end;
        }
        field(26;"Entry No";Integer)
        {
        }
        field(27;"Posting Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
        key(Key2;"Employee No","ED Code","Dimension Code1","Dimension Value Code1","Dimension Code2","Dimension Value Code2","Dimension Code3","Dimension Value Code3")
        {
            SumIndexFields = Allocated;
        }
        key(Key3;"Employee No","ED Code","Posting Date")
        {
            SumIndexFields = Allocated;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lvPayrollExpAlloc: Record "Payroll Exp Allocation Matrix";
    begin
        //skm16/1/12 change primary key to Entry No to support 8 allocation dimensions
        TestField("Employee No");
        /*TESTFIELD("ED Code");
        TESTFIELD("Dimension Code1");
        TESTFIELD("Dimension Value Code1");  */
        if lvPayrollExpAlloc.FindLast then
          "Entry No" := lvPayrollExpAlloc."Entry No" + 1
        else
          "Entry No" := 1;
        
        //alert on unique dim combinations. With increase of dimensions to 8, which cannot fit in one primary key, not possible enforce
        //unique dimensions combinations
        if DoNotAllowDialog = false then          //cmm VSF-PAY1 020813
          Message('Please verify that each allocation entry has a unique dimension combination. It is not possible to enforce this with ' +
          'increased allocation dimensions.');

    end;

    trigger OnModify()
    begin
        //alert on unique dim combinations. With increase of dimensions to 8, which cannot fit in one primary key, not possible enforce
        //unique dimensions combinations
        Message('Please verify that each allocation entry has a unique dimension combination. It is not possible to enforce this with ' +
          'increased allocation dimensions.');
    end;

    var
        TableTransferCode: Codeunit "Table Code Transferred-Payroll";
        DoNotAllowDialog: Boolean;

    procedure SetDiallowDialog()
    begin
        DoNotAllowDialog := true;
    end;
}
