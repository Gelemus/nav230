table 50243 "Bill Item"
{

    fields
    {
        field(1;"Job ID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3;"Bill Item No.";Code[20])
        {
            Caption = 'Job Task No.';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            var
                Job: Record Job;
                Cust: Record Customer;
            begin
            end;
        }
        field(4;Description;Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Start Date" := Today;
            end;
        }
        field(5;"Bill Item Type";Option)
        {
            Caption = 'Job Task Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            begin
                /*IF (xRec."Job Task Type" = "Job Task Type"::Posting) AND
                   ("Job Task Type" <> "Job Task Type"::Posting)
                THEN
                  IF JobLedgEntriesExist OR JobPlanningLinesExist THEN
                    ERROR(CannotChangeAssociatedEntriesErr,FIELDCAPTION("Job Task Type"),TABLECAPTION);
                
                IF "Job Task Type" <> "Job Task Type"::Posting THEN BEGIN
                  "Job Posting Group" := '';
                  IF "WIP-Total" = "WIP-Total"::Excluded THEN
                    "WIP-Total" := "WIP-Total"::" ";
                END;
                
                Totaling := '';
                */

            end;
        }
        field(6;"WIP-Total";Option)
        {
            Caption = 'WIP-Total';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Total,Excluded';
            OptionMembers = " ",Total,Excluded;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
                /*CASE "WIP-Total" OF
                  "WIP-Total"::Total:
                    BEGIN
                      Job.GET("Job No.");
                      "WIP Method" := Job."WIP Method";
                    END;
                  "WIP-Total"::Excluded:
                    BEGIN
                      TESTFIELD("Job Task Type","Job Task Type"::Posting);
                      "WIP Method" := ''
                    END;
                  ELSE
                    "WIP Method" := ''
                END;
                */

            end;
        }
        field(7;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24;Indentation;Integer)
        {
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(25;Remarks;Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Start Date" := Today;
            end;
        }
        field(26;Components;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Main Components, Other Components';
            OptionMembers = " ","Main Components"," Other Components";
        }
        field(27;"% of works done per bill item";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Start Date" := Today;
            end;
        }
        field(28;"Summary works done";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Site Deliveries";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1;"Job ID","Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

