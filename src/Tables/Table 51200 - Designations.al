table 51200 Designations
{
   // DrillDownPageID = 51306;
    //LookupPageID = 51306;

    fields
    {
        field(1;"Job ID";Code[20])
        {
            NotBlank = true;
        }
        field(2;"Job Description";Text[250])
        {
        }
        field(3;"No of Posts";Integer)
        {

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                "Vacant Positions" := "No of Posts" - "Occupied Position";
            end;
        }
        field(4;"Position Reporting to";Code[20])
        {
            TableRelation = Designations."Job ID";

            trigger OnValidate()
            begin
                /*IF "Position Reporting to"<>'' THEN BEGIN
                  PositionSupervised2.SETRANGE("Job ID", "Position Reporting to");
                  PositionSupervised2.SETRANGE("Position Supervised","Job ID");
                  IF NOT PositionSupervised2.FINDFIRST THEN BEGIN
                    PositionSupervised.INIT;
                    PositionSupervised."Job ID":= "Position Reporting to";
                    PositionSupervised."Position Supervised":= "Job ID";
                    PositionSupervised.Description:= "Job Description";
                    PositionSupervised.INSERT;
                  END;
                END;
                */

            end;
        }
        field(5;"Occupied Position";Integer)
        {
            CalcFormula = Count(Employee WHERE (Position=FIELD("Job ID"),
                                                Status=CONST(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Vacant Positions";Integer)
        {
        }
        field(7;"Score code";Code[20])
        {
            TableRelation = "Score Setup";
        }
        field(8;"Dimension 1";Code[20])
        {
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(9;"Dimension 2";Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
        }
        field(10;"Dimension 3";Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(11;"Dimension 4";Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4));
        }
        field(12;"Dimension 5";Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5));
        }
        field(13;"Dimension 6";Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6));
        }
        field(14;"Dimension 7";Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7));
        }
        field(15;"Dimension 8";Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8));
        }
        field(16;"No of Position";Integer)
        {
        }
        field(17;"Total Score";Decimal)
        {
           // CalcFormula = Sum(Table51202.Field8 WHERE (Field1=FIELD("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;Objective;Text[250])
        {
        }
        field(20;Department;Code[20])
        {

            trigger OnLookup()
            var
                HRSetup: Record "Human Resources Setup";
                DimensionValue: Record "Dimension Value";
                frmDimensionValues: Page "Dimension Values";
            begin
                HRSetup.Get;
                HRSetup.TestField("Pre-Trip Nos");

                DimensionValue.SetFilter("Dimension Code",HRSetup."Pre-Trip Nos");
                DimensionValue.SetRange(DimensionValue."Dimension Value Type",DimensionValue."Dimension Value Type"::Standard);
                DimensionValue.SetRange(Blocked,false);

                frmDimensionValues.SetRecord(DimensionValue);
                frmDimensionValues.SetTableView(DimensionValue);
                frmDimensionValues.LookupMode(true);
                if frmDimensionValues.RunModal = ACTION::LookupOK then begin
                    frmDimensionValues.GetRecord(DimensionValue);
                    Validate(Department,DimensionValue.Code);
                end;
                Clear(frmDimensionValues);
            end;
        }
        field(21;"Key Position";Boolean)
        {
        }
        field(23;Grade;Code[20])
        {
            TableRelation = "Salary Scale".Code;
        }
        field(24;"Primary Skills Category";Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(25;"2nd Skills Category";Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(26;"3nd Skills Category";Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
    }

    keys
    {
        key(Key1;"Job ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Job ID","Job Description")
        {
        }
    }
}

