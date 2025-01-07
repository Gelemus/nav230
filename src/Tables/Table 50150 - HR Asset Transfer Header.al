table 50150 "HR Asset Transfer Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {
        }
        field(2;"Document Date";Date)
        {
        }
        field(3;"Date Requested";Date)
        {
        }
        field(4;"Transfer Reason";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Canceled';
            OptionMembers = Open,"Pending Approval",Approved,Canceled;
        }
        field(11;"Transfer Effected";Boolean)
        {
        }
        field(12;"Date Transfered";Date)
        {
        }
        field(13;"Transfered By";Code[50])
        {
        }
        field(14;"Time Posted";Time)
        {
        }
        field(15;"User ID";Code[50])
        {
            Editable = false;
        }
        field(16;"Responsibility Center";Code[50])
        {
        }
        field(30;"No. Series";Code[20])
        {
        }
        field(31;"Activity Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Asset Transfer,Asset Surrender,Maintenance';
            OptionMembers = " ","Asset Transfer","Asset Surrender",Maintenance;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Asset Transfer No.");
          NoSeriesMgt.InitSeries(HRSetup."Asset Transfer No.",xRec."No. Series",0D,"No.","No. Series");
        end;

          "Date Requested":=Today;
          "Document Date":=Today;
          "User ID":=UserId;
    end;

    var
        FASetup: Record "FA Setup";
        Employees: Record Employee;
        FA: Record "Fixed Asset";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimensionValue: Record "Dimension Value";
        HRSetup: Record "Human Resources Setup";
}

