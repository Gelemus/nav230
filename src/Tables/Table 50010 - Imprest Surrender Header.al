table 50010 "Imprest Surrender Header"
{
    Caption = 'Imprest Surrender Header';

    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2;"Document Type";Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender,Petty Cash Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender","Petty Cash Surrender";
        }
        field(3;"Document Date";Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(4;"Posting Date";Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(5;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);

                "Employee Name":='';
                if Employee.Get("Employee No.") then begin
                  "Employee Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
                  "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                  "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(6;"Employee Name";Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(7;"Imprest No.";Code[20])
        {
            Caption = 'Imprest No.';
            TableRelation = IF ("Document Type"=CONST("Imprest Surrender")) "Imprest Header"."No." WHERE ("Employee No."=FIELD("Employee No."),
                                                                                                          Posted=CONST(true),
                                                                                                          Reversed=CONST(false),
                                                                                                          "Surrender status"=FILTER("Not Surrendered"),
                                                                                                          Type=FILTER(Imprest))
                                                                                                          ELSE IF ("Document Type"=FILTER("Petty Cash Surrender")) "Imprest Header"."No." WHERE ("Employee No."=FIELD("Employee No."),
                                                                                                                                                                                                 Posted=CONST(true),
                                                                                                                                                                                                 Reversed=CONST(false),
                                                                                                                                                                                                 "Surrender status"=FILTER("Not Surrendered"),
                                                                                                                                                                                                 Type=FILTER("Petty Cash"));

            trigger OnValidate()
            begin

                //TestStatusOpen(TRUE);

                TestField("Employee No.");
                //Reset Imprest Surrender
                ImprestSurrenderLine.Reset;
                ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.","No.");
                if ImprestSurrenderLine.FindSet then begin
                  ImprestSurrenderLine.DeleteAll;
                end;

                "Imprest Date":=0D;
                "Global Dimension 1 Code":='';
                "Global Dimension 2 Code":='';
                "Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code":='';
                "Shortcut Dimension 5 Code":='';
                "Shortcut Dimension 6 Code":='';
                "Shortcut Dimension 7 Code":='';
                "Shortcut Dimension 8 Code":='';
                "Responsibility Center":='';
                //End Reset Imprest Surrender

                Commit;

                if "Imprest No." <> '' then begin
                if ImprestHeader.Get("Imprest No.") then begin
                  "Imprest Date":=ImprestHeader."Posting Date";
                  "Currency Code":=ImprestHeader."Currency Code";
                  "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
                  "Responsibility Center":=ImprestHeader."Responsibility Center";

                  ImprestLine.Reset;
                  ImprestLine.SetRange(ImprestLine."Document No.",ImprestHeader."No.");
                  ImprestLine.SetFilter(ImprestLine."Gross Amount",'>%1',0);
                  if ImprestLine.FindSet then begin
                    repeat
                      ImprestSurrenderLine.Reset;
                      ImprestSurrenderLine."Line No.":=0;
                      ImprestSurrenderLine."Document No.":="No.";
                      ImprestSurrenderLine."Document Type":="Document Type";//ImprestSurrenderLine."Document Type"::"Imprest Surrender";
                      ImprestSurrenderLine."Imprest Code":=ImprestLine."Imprest Code";
                      ImprestSurrenderLine."Imprest Code Description":=ImprestLine."Imprest Code Description";
                      ImprestSurrenderLine."Account Type":=ImprestLine."Account Type";
                      ImprestSurrenderLine."Account No.":=ImprestLine."Account No.";
                      ImprestSurrenderLine."Account Name":=ImprestLine."Account Name";
                      ImprestSurrenderLine."Posting Group":=ImprestLine."Posting Group";
                      ImprestSurrenderLine.Description:=ImprestLine.Description;
                      ImprestSurrenderLine."Currency Code":=ImprestLine."Currency Code";
                      ImprestSurrenderLine."Gross Amount":=ImprestLine."Gross Amount";
                      ImprestSurrenderLine."Gross Amount(LCY)":=ImprestLine."Gross Amount(LCY)";
                      ImprestSurrenderLine."Actual Spent":=ImprestLine."Net Amount";
                      ImprestSurrenderLine."Actual Spent(LCY)":=ImprestLine."Net Amount";
                      ImprestSurrenderLine."Paid Amount":=ImprestLine."Net Amount";
                      ImprestSurrenderLine."Tax Amount":=ImprestLine."Tax Amount";
                      ImprestSurrenderLine."Global Dimension 1 Code":=ImprestLine."Global Dimension 1 Code";
                      ImprestSurrenderLine."Global Dimension 2 Code":=ImprestLine."Global Dimension 2 Code";
                      ImprestSurrenderLine."Shortcut Dimension 3 Code":=ImprestLine."Shortcut Dimension 3 Code";
                      ImprestSurrenderLine."Shortcut Dimension 4 Code":=ImprestLine."Shortcut Dimension 4 Code";
                      ImprestSurrenderLine."Shortcut Dimension 5 Code":=ImprestLine."Shortcut Dimension 5 Code";
                      ImprestSurrenderLine."Shortcut Dimension 6 Code":=ImprestLine."Shortcut Dimension 6 Code";
                      ImprestSurrenderLine."Shortcut Dimension 7 Code":=ImprestLine."Shortcut Dimension 7 Code";
                      ImprestSurrenderLine."Shortcut Dimension 8 Code":=ImprestLine."Shortcut Dimension 8 Code";
                      ImprestSurrenderLine."Responsibility Center":=ImprestLine."Responsibility Center";
                      ImprestSurrenderLine."FA Depreciation Book":=ImprestLine."FA Depreciation Book";
                      ImprestSurrenderLine.Insert;
                    until ImprestLine.Next=0;
                  end;
                end;
                end;

                Validate("Employee No.");
            end;
        }
        field(8;"Imprest Date";Date)
        {
            Caption = 'Imprest Date';
        }
        field(15;"On Behalf Of";Text[100])
        {
            Caption = 'On Behalf Of';
        }
        field(16;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                TestField("Imprest No.");
                TestField("Posting Date");
            end;
        }
        field(17;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(18;Amount;Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Paid Amount" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Amount';
            FieldClass = FlowField;
        }
        field(19;"Amount(LCY)";Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Gross Amount(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Amount(LCY)';
            FieldClass = FlowField;
        }
        field(20;"Actual Spent";Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Actual Spent" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Actual Spent';
            FieldClass = FlowField;
        }
        field(21;"Actual Spent(LCY)";Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Actual Spent(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Actual Spent(LCY)';
            FieldClass = FlowField;
        }
        field(22;"Cash Receipt Amount";Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Cash Receipt" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Cash Receipt Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23;"Cash Receipt Amount(LCY)";Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Cash Receipt(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Cash Receipt Amount(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;Difference;Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line".Difference WHERE ("Document No."=FIELD("No.")));
            Caption = 'Difference';
            FieldClass = FlowField;
        }
        field(25;"Difference(LCY)";Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Line"."Difference(LCY)" WHERE ("Document No."=FIELD("No.")));
            Caption = 'Difference(LCY)';
            FieldClass = FlowField;
        }
        field(49;Description;Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestStatusOpen(true);

                Description:=UpperCase(Description);
            end;
        }
        field(50;"Global Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
                //Delete the previous dimensions
                "Global Dimension 2 Code":='';
                "Shortcut Dimension 3 Code":='';
                "Shortcut Dimension 4 Code":='';
                "Shortcut Dimension 5 Code":='';
                "Shortcut Dimension 6 Code":='';
                "Shortcut Dimension 7 Code":='';
                "Shortcut Dimension 8 Code":='';
                ImprestSurrenderLine.Reset;
                ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.","No.");
                if ImprestSurrenderLine.FindSet then begin
                  repeat
                    ImprestSurrenderLine."Global Dimension 2 Code":='';
                    ImprestSurrenderLine."Shortcut Dimension 3 Code":='';
                    ImprestSurrenderLine."Shortcut Dimension 4 Code":='';
                    ImprestSurrenderLine."Shortcut Dimension 5 Code":='';
                    ImprestSurrenderLine."Shortcut Dimension 6 Code":='';
                    ImprestSurrenderLine."Shortcut Dimension 7 Code":='';
                    ImprestSurrenderLine."Shortcut Dimension 8 Code":='';
                    ImprestSurrenderLine.Modify;
                  until ImprestSurrenderLine.Next=0;
                end;
                //End delete the previous dimensions

                ImprestSurrenderLine.Reset;
                ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.","No.");
                if ImprestSurrenderLine.FindSet then begin
                  repeat
                    ImprestSurrenderLine."Global Dimension 1 Code":="Global Dimension 1 Code";
                    ImprestSurrenderLine.Modify;
                  until ImprestSurrenderLine.Next=0;
                end;
            end;
        }
        field(51;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                //TestStatusOpen(TRUE);
            end;
        }
        field(52;"Shortcut Dimension 3 Code";Code[50])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(53;"Shortcut Dimension 4 Code";Code[50])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(54;"Shortcut Dimension 5 Code";Code[50])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(55;"Shortcut Dimension 6 Code";Code[50])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(56;"Shortcut Dimension 7 Code";Code[50])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(57;"Shortcut Dimension 8 Code";Code[50])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            begin
                TestStatusOpen(true);
            end;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Posted,Reversed,Cancelled,Approved';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Posted,Reversed,Cancelled,Approved;

            trigger OnValidate()
            begin
                ImprestSurrenderLine.Reset;
                ImprestSurrenderLine.SetRange(ImprestSurrenderLine."Document No.","No.");
                if ImprestSurrenderLine.FindSet then begin
                  repeat
                    ImprestSurrenderLine.Status:=Status;
                    ImprestSurrenderLine.Modify;
                  until ImprestSurrenderLine.Next=0;
                end;
            end;
        }
        field(71;Posted;Boolean)
        {
            Caption = 'Posted';
            Editable = true;
        }
        field(72;"Posted By";Code[50])
        {
            Caption = 'Posted By';
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(73;"Date Posted";Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(74;"Time Posted";Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(75;Reversed;Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(76;"Reversed By";Code[50])
        {
            Caption = 'Reversed By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77;"Reversal Date";Date)
        {
            Caption = 'Reversal Date';
            Editable = false;
        }
        field(78;"Reversal Time";Time)
        {
            Caption = 'Reversal Time';
            Editable = false;
        }
        field(80;"Reversal Posting Date";Date)
        {
        }
        field(99;"User ID";Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID","User ID");
                if UserSetup.FindFirst then begin
                  UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                  //UserSetup.TESTFIELD(UserSetup."Shortcut Dimension 3 Code");
                  "Global Dimension 1 Code":=UserSetup."Global Dimension 1 Code";
                  "Global Dimension 2 Code":=UserSetup."Global Dimension 2 Code";
                  "Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
                  "Shortcut Dimension 4 Code":=UserSetup."Shortcut Dimension 4 Code";
                  "Shortcut Dimension 5 Code":=UserSetup."Shortcut Dimension 5 Code";
                  "Shortcut Dimension 6 Code":=UserSetup."Shortcut Dimension 6 Code";
                  "Shortcut Dimension 7 Code":=UserSetup."Shortcut Dimension 7 Code";
                  "Shortcut Dimension 8 Code":=UserSetup."Shortcut Dimension 8 Code";
                  "Employee No.":= UserSetup."No.";
                  "Employee Name" := UserSetup."Full Name";
                  Validate("Employee No.");
                end;
            end;
        }
        field(100;"No. Series";Code[20])
        {
            Caption = 'No. Series';
        }
        field(101;"No. Printed";Integer)
        {
            Caption = 'No. Printed';
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
        }
        field(106;"Document Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(112;"Cancelled By";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(113;"Time Cancelled";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(114;"Date Cancelled";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(115;"Reason for Cancellation";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50227;"Project No";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;

            trigger OnValidate()
            begin
                if JobRec.Get("Project No") then
                begin
                  "Project Name" := JobRec.Description;
                end;
            end;
        }
        field(50228;"Project Name";Text[30])
        {
            DataClassification = ToBeClassified;
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

    trigger OnDelete()
    begin
        //TESTFIELD(Status,Status::Open);
        ImprestSurrenderLine.Reset;
        ImprestSurrenderLine.SetRange("Document No.","No.");
        if ImprestSurrenderLine.FindSet then
          ImprestSurrenderLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          FundsSetup.Get;
          if "Document Type"="Document Type"::"Imprest Surrender" then
          begin
          FundsSetup.TestField(FundsSetup."Imprest Surrender Nos.");
          NoSeriesMgt.InitSeries(FundsSetup."Imprest Surrender Nos.",xRec."No. Series",0D,"No.","No. Series");
          "Document Type":="Document Type"::"Imprest Surrender";

          end else  if "Document Type"="Document Type"::"Petty Cash Surrender" then
          begin
            FundsSetup.TestField(FundsSetup."Petty Cash Surrender Nos");
           NoSeriesMgt.InitSeries(FundsSetup."Petty Cash Surrender Nos",xRec."No. Series",0D,"No.","No. Series");
           "Document Type":="Document Type"::"Petty Cash Surrender";

          end;



        end;
        "Document Date":=Today;
        "User ID":=UserId;
        Validate("User ID");
    end;

    var
        FundsSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLine: Record "Imprest Surrender Line";
        CurrExchRate: Record "Currency Exchange Rate";
        OnlyDeleteOpenDocument: Label 'You can only delete an Open Payment Document. The current status is %1';
        UserSetup: Record Employee;
        JobRec: Record Job;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestSurrenderHeader.Get("No.");
        if AllowApproverEdit then begin
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange(ApprovalEntry."Document No.",ImprestSurrenderHeader."No.");
          ApprovalEntry.SetRange(ApprovalEntry.Status,ApprovalEntry.Status::Open);
          ApprovalEntry.SetRange(ApprovalEntry."Approver ID",UserId);
          if not ApprovalEntry.FindFirst then begin
            ImprestSurrenderHeader.TestField(Status,ImprestSurrenderHeader.Status::Open);
          end;
        end else begin
          ImprestSurrenderHeader.TestField(Status,ImprestSurrenderHeader.Status::Open);
        end;
    end;
}

