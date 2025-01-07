table 50203 "User Support Incidences"
{

    fields
    {
        field(1;"Incident Reference";Code[60])
        {

            trigger OnValidate()
            begin
                if "Incident Reference" <> xRec."Incident Reference" then begin
                  SalesSetup.Get;
                 //  NoSeriesMgt.TestManual(SalesSetup."User Support Inc Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Incident Description";Text[250])
        {
        }
        field(3;"Incident Date";Date)
        {
        }
        field(4;"Incident Status";Option)
        {
            OptionCaption = ',Unresolved,Resolved,Sent to HR Manager,Sent to HOD,Sent Direcor CS,Sent to CEO';
            OptionMembers = ,Unresolved,Resolved,"Sent to HR Manager","Sent to HOD","Sent Direcor CS","Sent to CEO";
        }
        field(5;"No. Series";Code[60])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6;"Action taken";Text[250])
        {
        }
        field(7;"Action Date";Date)
        {
        }
        field(8;"User Id";Code[50])
        {
        }
        field(9;"System Support Email Address";Text[80])
        {
        }
        field(10;"User email Address";Text[80])
        {
        }
        field(11;Type;Option)
        {
            OptionMembers = ICT,ADM,REGISTRY,"KEYS";
        }
        field(12;"File No";Code[30])
        {
        }
        field(13;"Incident Time";Time)
        {
        }
        field(14;"Action Time";Time)
        {
        }
        field(15;"Employee No";Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if emp.Get("Employee No") then
                  begin
                  "Employee Name":=emp.FullName;
                   "Job Title":=emp."Job Title";
                    Department:=emp."Global Dimension 2 Code";

                    end;
            end;
        }
        field(16;"Employee Name";Text[100])
        {
        }
        field(17;Sent;Boolean)
        {
        }
        field(18;"User Informed?";Boolean)
        {
        }
        field(19;"Work place Controller";Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin

                emp.Get("Work place Controller");
                  "Work place Controller Name":=emp."First Name"+' '+emp."Last Name";
            end;
        }
        field(20;"Work place Controller Name";Text[100])
        {
        }
        field(21;"Incidence Location";Code[50])
        {
        }
        field(22;"Incidence Location Name";Text[100])
        {
        }
        field(23;"Incidence Outcome";Option)
        {
            OptionCaption = '  ,Dangerous,Serious bodily injury,Work caused illness,Serious electrical incident,Dangerous electrical event,MajorAccident under the OSHA Act';
            OptionMembers = "  ",Dangerous,"Serious bodily injury","Work caused illness","Serious electrical incident","Dangerous electrical event","MajorAccident under the OSHA Act";
        }
        field(24;"Incident Outcome";Option)
        {
            OptionCaption = '  ,Yes,No';
            OptionMembers = "  ",Yes,No;
        }
        field(25;"Remarks HR";Text[250])
        {
        }
        field(26;Category;Option)
        {
            OptionCaption = ' ,Incident,Maintenance,Grievance';
            OptionMembers = " ",Incident,Maintenance,Grievance;
        }
        field(27;"Grievance Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Individual,Collective';
            OptionMembers = Individual,Collective;
        }
        field(28;"Job Title";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Supervisor Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30;Department;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31;Subject;Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                if PAGE.RunModal(0,AreasofGrieavanceRec) = ACTION::LookupOK then
                  begin
                    Subject:=AreasofGrieavanceRec."Grievance Description";
                  end;
            end;
        }
        field(32;"Date of Issue First Raised";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33;"Steps taken";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(34;Outcome;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(35;Comments;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(36;"Grievance About Management";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37;"Grievance About HR Manager";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38;"Car No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39;"No. of Persons Injured";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40;"Abstract Obtained";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41;"No. of fatalities";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42;"Recommended Measures";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(43;Station;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44;Occurrence;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45;"Guard Name";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(46;Shift;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Day Shift"," Night Shift";
        }
    }

    keys
    {
        key(Key1;"Incident Reference")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        
        
        if Category=Category::Incident then begin
          HRSetup.Get;
        //  HRSetup.TESTFIELD(HRSetup."HR HOD");
          NoSeriesMgt.InitSeries(HRSetup."Incident Reference Nos",xRec."No. Series",0D,"Incident Reference","No. Series");
        end;
        /*
        IF Category=Category::Maintenance THEN BEGIN
          HRSetup.GET;
          HRSetup.TESTFIELD(HRSetup."Maintenance Req Nos");
          NoSeriesMgt.InitSeries(HRSetup."Maintenance Req Nos",xRec."No. Series",0D,"Incident Reference","No. Series");
          "Incident Time":=TIME;
        END;
        */
        if Category=Category::Grievance then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Grievance Nos");
          NoSeriesMgt.InitSeries(HRSetup."Grievance Nos",xRec."No. Series",0D,"Incident Reference","No. Series");
          "Incident Date":=Today;
        end;
        
        
        
        
        
        CompanyInformation.Get;
        //"System Support Email Address":=CompanyInformation."HR Support Email";
        "User Id":=UserId;
        /*
        IF Users.GET(USERID) THEN
        BEGIN
          //employee name and no and dept
          "Employee No":=Users."Employee No";
          IF emp.GET(Users."Employee No") THEN
            BEGIN
            "Employee Name":=emp."First Name"+' '+emp."Middle Name"+' '+emp."Last Name";
            "Job Title":=emp."Job Title";
            Department:=emp."Global Dimension 2 Code";
            END;
          "User email Address":=Users."E-Mail";
        
          //get supervisor name
        //  IF emp.GET(Users."Immediate Supervisor") THEN
        //    "Supervisor Name":=emp."Last Name"+' '+emp."First Name";
        END;
        */

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CommentLine: Record "Comment Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CompanyInformation: Record "Company Information";
        Users: Record "User Setup";
        emp: Record Employee;
        HRSetup: Record "Human Resources Setup";
        AreasofGrieavanceRec: Record "Areas of Grieavance";
        UserSetupRec: Record "User Setup";
}

