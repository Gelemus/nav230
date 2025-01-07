table 56048 "Internal Memos"
{

    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;RE;Text[250])
        {
        }
        field(3;"Employee UserID";Code[100])
        {
            Caption = 'UserID';
        }
        field(4;From;Text[200])
        {
        }
        field(5;"No. Series";Code[10])
        {
        }
        field(6;"To CEO";Text[250])
        {
            Caption = 'To';
        }
        field(7;Through;Text[250])
        {
        }
        field(8;"Paragraph 1";Text[250])
        {
        }
        field(9;"Paragraph 2";Text[250])
        {
        }
        field(10;"Prepared By Date";Date)
        {
        }
        field(11;"Approved By";Code[250])
        {
        }
        field(12;"CEO Approval";Code[250])
        {
        }
        field(13;"Approved By Date";Date)
        {
        }
        field(14;"CEO Approval Date";Date)
        {
        }
        field(15;Status;Option)
        {
            OptionCaption = 'Pending,Pending Approval,CEO Approval,Approved,Rejected,CEO Rejected';
            OptionMembers = Pending,"Pending Approval","CEO Approval",Approved,Rejected,"CEO Rejected";
        }
        field(16;Title;Text[250])
        {
        }
        field(17;Date;Date)
        {
        }
        field(18;"CEO Comments";Text[250])
        {
        }
        field(19;"HOD ID";Code[100])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then
        begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Visitor Pass Nos");
          NoSeriesMgt.InitSeries(NoSetup."Visitor Pass Nos",xRec."No. Series",0D,Code,"No. Series");
        end;

        Employees.Reset;
        Employees.SetFilter(Employees."User ID",UpperCase(UserId));
        if Employees.Find('-') then
        begin
          "Employee UserID":=UserId;
          From:=Employees."Job Title";
          "To CEO":='Executive Director';
          //HODID:=Employees."HOD ID";
          Date:=Today;

          Employees2.Reset;
          //Employees2.SETFILTER(Employees2."EMPL. No.",HODID);
          if Employees2.Find('-') then
          begin
            Through:=Employees2."Job Title";
          end;

        end;
    end;

    var
        NoSetup: Record "Accreditation/Arbitratio Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employees: Record Employee;
        Employees2: Record Employee;
}

