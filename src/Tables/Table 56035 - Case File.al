table 56035 "Case File"
{

    fields
    {
        field(1;"Case ID";Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Case ID"<> xRec."Case ID" then begin
                NoSetup.Get;
                NoSeriesMgt.TestManual(NoSetup."Case Nos");
                "No. Series" := '';
                end;
            end;
        }
        field(2;"Court Case no";Code[20])
        {
        }
        field(3;"Case Title";Text[50])
        {
        }
        field(4;"Case Brief";BLOB)
        {
            SubType = UserDefined;
        }
        field(5;"Document Date";Date)
        {
        }
        field(6;"Accused Name";Text[60])
        {
        }
        field(7;"Accused Address";Text[60])
        {
        }
        field(8;"Accused Phone No";Code[20])
        {
        }
        field(9;"Complainant Name";Text[60])
        {
        }
        field(10;"Complainant Address";Text[60])
        {
        }
        field(11;"Complainant Phone No";Code[20])
        {
        }
        field(12;"Court Station";Code[10])
        {
            TableRelation = "Station set-ups".Code;
        }
        field(13;"Main Investigator";Code[10])
        {
            TableRelation = "Case Investigator"."Employee No" WHERE ("Case No"=FIELD("Case ID"));

            trigger OnValidate()
            begin
                CaseInvestigator.Reset;
                CaseInvestigator.SetRange("Case No","Case ID");
                CaseInvestigator.SetRange("Employee No","Main Investigator");
                if CaseInvestigator.Find('-')then
                begin
                    "Main Investigator Name" := CaseInvestigator."Employee Name";
                end;
            end;
        }
        field(14;"Date Created";Date)
        {
            Editable = false;
        }
        field(15;"Time Created";Date)
        {
            Editable = false;
        }
        field(16;"Created By";Code[50])
        {
            Editable = false;
        }
        field(17;Status;Option)
        {
            OptionCaption = 'Ongoing,Closed,Withdrawn';
            OptionMembers = Ongoing,Closed,Withdrawn;
        }
        field(18;"Case Types";Code[30])
        {
            TableRelation = "Case Set-Ups".Code;
        }
        field(19;"Court Rank";Code[10])
        {
            TableRelation = "Courts Structures".Code;
        }
        field(20;"Exhibit No";Code[10])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                if Exhibit.Get("Exhibit No") then begin
                  "Serial No":=Exhibit."Serial Nos.";
                  //"Case ID":=Exhibit.
                  end;
            end;
        }
        field(21;"Serial No";Code[20])
        {
        }
        field(22;"Case No";Code[20])
        {
        }
        field(23;"Date Removed";Date)
        {
        }
        field(24;"Date brought back";Date)
        {
        }
        field(25;"Final Disposal Date";Date)
        {
        }
        field(26;"Exhibit Details";Text[30])
        {
        }
        field(27;"Current Case File Location";Code[10])
        {
            TableRelation = "Case Schedule";
        }
        field(28;"No. Series";Code[20])
        {
        }
        field(29;"Year of the Case";Text[30])
        {
            TableRelation = "Case Year Setups".Code;
        }
        field(30;"Nature of Offence";Text[60])
        {
        }
        field(31;"Case Outcome";Option)
        {
            OptionCaption = ',Won,Lost';
            OptionMembers = ,Won,Lost;
        }
        field(32;"Decretal Amount";Decimal)
        {
        }
        field(33;"Awarded Amount";Decimal)
        {
        }
        field(34;"Payment Status";Option)
        {
            OptionCaption = ',Partially Paid,Fully Paid';
            OptionMembers = ,"Partially Paid","Fully Paid";
        }
        field(35;"Payment Amount";Decimal)
        {

            trigger OnValidate()
            begin
                "Outstanding Amount":="Awarded Amount"-"Payment Amount";
            end;
        }
        field(36;"Outstanding Amount";Decimal)
        {
            Editable = false;
        }
        field(37;"Exhibit Disposed";Boolean)
        {
        }
        field(38;"Main Investigator Name";Text[250])
        {
        }
        field(39;"Arresting Officer No";Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Arresting Officer No") then
                begin
                  "Arresting Officer Name" := Employee."First Name" +' '+ Employee."Middle Name" +' '+ Employee."Last Name";
                end;
            end;
        }
        field(40;"Arresting Officer Name";Text[250])
        {
        }
        field(41;"Nature of cause of action";Text[250])
        {
        }
        field(42;"Interim Orders";Text[250])
        {
        }
        field(43;Judge;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(44;Parties;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(45;Advocates;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(46;Citation;Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Case ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Case ID"= '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Case Nos");
          NoSeriesMgt.InitSeries(NoSetup."Case Nos",xRec."No. Series",0D,"Case ID","No. Series");
        end;

        "Date Created":=Today;
        "Created By":=UserId;
        "Time Created":="Time Created";
        "Document Date":=Today;
    end;

    var
        NoSetup: Record "Accreditation/Arbitratio Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Exhibit: Record Item;
        Employee: Record Employee;
        CaseInvestigator: Record "Case Investigator";
}

