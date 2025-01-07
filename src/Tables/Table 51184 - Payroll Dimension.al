table 51184 "Payroll Dimension"
{
    Permissions = TableData "Payroll Header"=rm;

    fields
    {
        field(1;"Table ID";Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" WHERE ("Object Type"=CONST(Table));
        }
        field(2;"Payroll ID";Code[10])
        {
            NotBlank = true;
            TableRelation = Periods."Period ID";
        }
        field(3;"Employee No";Code[20])
        {
            TableRelation = Employee;
            ValidateTableRelation = false;
        }
        field(4;"Entry No";Integer)
        {
        }
        field(5;"ED Code";Code[20])
        {
            TableRelation = "ED Definitions";

            trigger OnLookup()
            var
                EDCodeRec: Record "ED Definitions";
                Employee: Record Employee;
                CalcSchemes: Record "Calculation Scheme";
            begin
            end;

            trigger OnValidate()
            var
                EDCodeRec: Record "ED Definitions";
                Employee: Record Employee;
                CalcSchemes: Record "Calculation Scheme";
                lvPayrollHdr: Record "Payroll Header";
                lvRoundDirection: Text[1];
            begin
            end;
        }
        field(6;"Dimension Code";Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                //Block Change of dimensions for system created lines as the change will be overwritten by
                //calculate payroll function
                if "ED Code" <> '' then begin
                  gvEDDefinition.Get("ED Code");
                  if gvEDDefinition."System Created" then
                    Error('Manual assignment of dimensions to system created EDs is not allowed.');
                end;
                //block end

                if not DimMgt.CheckDim("Dimension Code") then Error(DimMgt.GetDimErr);
            end;
        }
        field(7;"Dimension Value Code";Code[20])
        {
            Caption = 'Dimension Value Code';
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FIELD("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") then Error(DimMgt.GetDimErr);
            end;
        }
        field(8;"Payroll Code";Code[10])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = Payroll;
        }
    }

    keys
    {
        key(Key1;"Table ID","Payroll ID","Employee No","Entry No","ED Code","Dimension Code","Payroll Code")
        {
        }
        key(Key2;"Table ID","Payroll ID","Employee No","Entry No","ED Code","Dimension Code","Dimension Value Code","Payroll Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*//Block deletione of dimensions for system created lines as the change will be overwritten by
        //calculate payroll function
        IF "ED Code" <> '' THEN BEGIN
          gvEDDefinition.GET("ED Code");
          IF gvEDDefinition."System Created" THEN
            ERROR('Deletion of dimensions assigned to system created EDs is not allowed.');
        END;
        //block end
        
        IF "Table ID" IN [DATABASE::"Payroll Header", DATABASE::"Payroll Entry"] THEN BEGIN
          gvPayrollHdr.GET("Payroll ID", "Employee No");
          gvPayrollHdr.Calculated := FALSE;
          gvPayrollHdr.MODIFY
        END;
        */

    end;

    trigger OnInsert()
    begin
        TestField("Dimension Value Code");

        if "Table ID" in [DATABASE::"Payroll Header", DATABASE::"Payroll Entry"] then begin
          gvPayrollHdr.Get("Payroll ID", "Employee No");
          gvPayrollHdr.Calculated := false;
          gvPayrollHdr.Modify
        end;
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: Label 'You can not rename a %1.';
        Text001: Label 'You have changed a dimension.\\';
        Text002: Label 'Do you want to update the lines?';
        Text003: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        DimMgt: Codeunit DimensionManagement;
        gvEDDefinition: Record "ED Definitions";
        gvPayrollHdr: Record "Payroll Header";
}

