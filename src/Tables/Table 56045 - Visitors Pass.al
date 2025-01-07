table 56045 "Visitors Pass"
{

    fields
    {
        field(1;No;Code[20])
        {
            Editable = false;
        }
        field(2;"Document Date";Date)
        {
            Editable = false;
        }
        field(3;"Created By";Code[100])
        {
        }
        field(4;"Date Created";Date)
        {
        }
        field(5;"Time Created";Time)
        {
        }
        field(6;"Date of visit";Date)
        {
        }
        field(7;"Time of visit";Time)
        {
        }
        field(8;"Visitor Name";Text[250])
        {
        }
        field(9;"ID No";Code[50])
        {
        }
        field(10;"Mobile No.";Code[50])
        {
        }
        field(11;From;Text[250])
        {
        }
        field(12;"Officer to see No";Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Officer to see No") then
                begin
                  "Officer to see Name" := Empl."First Name" +' '+ Empl."Middle Name" +' '+ Empl."Last Name";
                end;
            end;
        }
        field(13;"Officer to see Name";Text[250])
        {
        }
        field(14;Reason;Text[250])
        {
        }
        field(15;"No. Series";Code[20])
        {
        }
        field(16;Status;Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then
        begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Visitor Pass Nos");
          NoSeriesMgt.InitSeries(NoSetup."Visitor Pass Nos",xRec."No. Series",0D,No,"No. Series");
        end;

        "Document Date" := Today;
    end;

    var
        Empl: Record Employee;
        NoSetup: Record "Accreditation/Arbitratio Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

