table 56033 "Complaints Table"
{

    fields
    {
        field(1;"Complain ID";Code[30])
        {

            trigger OnValidate()
            begin
                if "Complain ID"<> xRec."Complain ID" then begin
                NoSetup.Get;
                NoSeriesMgt.TestManual(NoSetup."Complains Nos");
                "No. Series" := '';
                end;
            end;
        }
        field(2;"Complaint Type";Option)
        {
            OptionCaption = 'Individual,Company';
            OptionMembers = Individual,Company;
        }
        field(3;"Complainant Name";Text[60])
        {
        }
        field(4;"Complainant Phone No";Code[20])
        {
        }
        field(5;Category;Code[10])
        {
            TableRelation = "Complaints set-ups".Code;
        }
        field(6;Date;Date)
        {
        }
        field(7;"Investigating Officer";Code[30])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if Inv.Get("Investigating Officer") then
                  "Investigating officer  Name":=Inv."First Name"+' '+Inv."Middle Name"+' '+Inv."Last Name";
            end;
        }
        field(8;"Investigating officer  Name";Text[60])
        {
        }
        field(9;Description;Text[60])
        {
        }
        field(10;"Action";Text[60])
        {
        }
        field(11;Responsiblity;Text[60])
        {
        }
        field(12;Status;Option)
        {
            OptionCaption = 'Open,Pending,Closed';
            OptionMembers = Open,Pending,Closed;
        }
        field(13;"Expected Resolution Date";Date)
        {
        }
        field(14;"Actual Resolution Date";Date)
        {
        }
        field(15;"No. Series";Code[20])
        {
        }
        field(16;"Date Created";Date)
        {
            Editable = false;
        }
        field(17;"Time Created";Date)
        {
            Editable = false;
        }
        field(18;"Created By";Code[20])
        {
            Editable = false;
        }
        field(19;"Case file No";Code[20])
        {
        }
        field(20;"Case description";Text[30])
        {
            TableRelation = "Case Set-Ups".Description;
        }
    }

    keys
    {
        key(Key1;"Complain ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Complain ID" = '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Complains Nos");
          NoSeriesMgt.InitSeries(NoSetup."Complains Nos",xRec."No. Series",0D,"Complain ID","No. Series");
        end;
        Date:=Today;
        "Date Created":=Today;
        "Created By":=UserId;
        "Time Created":="Time Created";
    end;

    var
        NoSetup: Record "Accreditation/Arbitratio Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Inv: Record Employee;
}

