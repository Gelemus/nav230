table 50129 "HR Leave Carryover"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;
        }
        field(2;"Document Date";Date)
        {
            Editable = false;
        }
        field(3;"Posting Date";Date)
        {
        }
        field(4;"Employee No.";Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                "Employee Name":='';
                if Employee.Get("Employee No.") then begin
                  "Employee Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
                end;
            end;
        }
        field(5;"Employee Name";Text[150])
        {
            Editable = false;
        }
        field(6;"Leave Type";Code[50])
        {
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            begin
                LeaveType.Reset;
                LeaveType.SetRange(LeaveType.Code,"Leave Type");
                if LeaveType.FindFirst then begin
                  "Maximum Carryover Days":=LeaveType."Max Carry Forward Days";
                  CalcFields("Leave Balance");
                  if "Leave Balance">"Maximum Carryover Days" then
                  "Days to CarryOver":=LeaveType."Max Carry Forward Days";
                  if "Leave Balance"<"Maximum Carryover Days" then
                  "Days to CarryOver":="Leave Balance";
                end;
            end;
        }
        field(7;"Maximum Carryover Days";Decimal)
        {
            Editable = false;
        }
        field(8;"From Leave Period";Code[20])
        {
            Editable = false;
            TableRelation = "HR Leave Periods".Code;
        }
        field(9;"Leave Balance";Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries".Days WHERE ("Employee No."=FIELD("Employee No."),
                                                                    "Leave Type"=FIELD("Leave Type")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"To Leave Period";Code[20])
        {
            Editable = false;
            TableRelation = "HR Leave Periods".Code;
        }
        field(11;"Days Applied";Integer)
        {
            Editable = false;
        }
        field(12;"Days Approved";Integer)
        {
            Editable = false;
        }
        field(49;"Reason for Carryover";Text[250])
        {
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(52;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(53;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(54;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(55;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(56;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(57;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard));
        }
        field(58;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(70;Status;Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted;
        }
        field(71;Posted;Boolean)
        {
            Editable = false;
        }
        field(72;"Posted By";Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73;"Date Posted";Date)
        {
            Editable = false;
        }
        field(74;"Time Posted";Time)
        {
            Editable = false;
        }
        field(99;"User ID";Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100;"No. Series";Code[20])
        {
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
        }
        field(103;"Days to CarryOver";Decimal)
        {

            trigger OnValidate()
            begin
                if "Reasons For Difference in Days"='' then begin
                if "Days to CarryOver"<>"Maximum Carryover Days" then
                  Error(ErrorLeave);
                end;
            end;
        }
        field(104;"Reasons For Difference in Days";Text[150])
        {
        }
        field(105;"Leave Period";Code[20])
        {
            TableRelation = "HR Leave Periods".Code;
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
          HRSetup.TestField(HRSetup."Leave Carryover Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Leave Carryover Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;
        "Document Date":=Today;
        "User ID":=UserId;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        LeaveType: Record "HR Leave Types";
        ErrorLeave: Label 'Kindly first input the Reasons why the employee should be reimbursed the number of days set different from the reccomended number';
}
