table 50108 "Interview Attendance Header"
{

    fields
    {
        field(10;"Interview No";Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(11;"Interview Committee code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interview Committee Dep Header"."Department Code";

            trigger OnValidate()
            begin
                "Interview Committee Name":='';
                IntCommitteeHeader.Reset;
                IntCommitteeHeader.SetRange("Department Code","Interview Committee code");
                if IntCommitteeHeader.FindFirst then
                  "Interview Committee Name":=IntCommitteeHeader."Dept Committee Name";
                  EmployeeRecruitment.LoadInterviewPanelFromCommittee(Rec);
            end;
        }
        field(12;"Interview Committee Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;"Interview Job No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;"Interview Date from";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Interview Date to";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Interview Time";Text[30])
        {
            Caption = 'Interview Start Time';
            DataClassification = ToBeClassified;
        }
        field(17;"Interview Location";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Interview Chairperson Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Reset;
                Employee.SetRange(Employee."No.","Interview Chairperson Code");
                if Employee.FindFirst then begin
                  "Interview Chairperson Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
                end;
            end;
        }
        field(19;"Interview Chairperson Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20;"Interview Purpose";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Job Requisition No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employee Requisitions"."No.";

            trigger OnValidate()
            begin
                "Interview Job No.":='';
                "Job Title":='';
                Description:='';
                EmployeeRequisition.Reset;
                EmployeeRequisition.SetRange("No.","Job Requisition No.");
                if EmployeeRequisition.FindFirst then begin
                  "Interview Job No.":=EmployeeRequisition."Job No.";
                  "Job Title":=EmployeeRequisition."Job Title";
                  Description:=EmployeeRequisition."Emp. Requisition Description";
                  EmployeeRecruitment.LoadApplicantsToInterviewPannel(EmployeeRequisition."No.",EmployeeRequisition."Job No.");
                end;
            end;
        }
        field(22;"Job Title";Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23;Description;Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24;"Committee Remarks";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(49;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50;Closed;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52;"Created by";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53;"Mandatory Docs. Required";Boolean)
        {
            Caption = 'Mandatory Documents Required';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Interview No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
          if "Interview No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Interview Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Interview Nos.",xRec."No. Series",0D,"Interview No","No. Series");
          end;
          "Created by":=UserId;
          "Document Date":=Today;
    end;

    var
        IntCommitteeHeader: Record "Interview Committee Dep Header";
        EmployeeRequisition: Record "HR Employee Requisitions";
        EmployeeJobApplications: Record "HR Job Applications";
        EmployeeRecruitment: Codeunit "HR Employee Recruitment";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
}

