table 50082 "Employee Loan Products"
{

    fields
    {
        field(1;"Code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Product Description";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Product Category";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan';
            OptionMembers = " ",Loan;
        }
        field(4;"Product Account Identifier";Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Minimum Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Maximum Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Appraisal Fee(%)";Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            MinValue = 0;
        }
        field(9;"Recovery Priority";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Loan Fees-Penalty-Interest-Principal,Loan Fees-Interest-Penalty-Principal,Loan Fees-Principal-Interest-Penalty';
            OptionMembers = ,"Loan Fees-Penalty-Interest-Principal","Loan Fees-Interest-Penalty-Principal","Loan Fees-Principal-Interest-Penalty";
        }
        field(10;"Repayment Method";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amortised,Reducing Balance,Straight Line';
            OptionMembers = Amortised,"Reducing Balance","Straight Line";
        }
        field(11;"Repayment Frequency";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Monthly,Quarterly,Annually';
            OptionMembers = " ",Daily,Monthly,Quarterly,Annually;
        }
        field(12;"Repayment Period";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"No. of Installments";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Principal Moratorium Period";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Check Employee Age";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
        }
        field(20;"Interest Calculation Method";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',No Interest,Reducing Balance,Flat Rate';
            OptionMembers = ,"No Interest","Reducing Balance","Flat Rate";
        }
        field(21;"Interest Calculation Frequency";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Weekly,Monthly,Quaterly';
            OptionMembers = " ",Daily,Weekly,Monthly,Quaterly;
        }
        field(23;"Interest Rate(%)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24;"Interest Margin Lower Limit(%)";Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
        }
        field(25;"Interest Margin Upper Limit(%)";Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
        }
        field(26;"Interest Moratorium Period";DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"Penalty Calculation Method";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No Penalty,Principal in Arrears,Principal in Arrears+Interest in Arrears,Principal in Arrears+Interest in Arrears+Penalty in Arrears';
            OptionMembers = "No Penalty","Principal in Arrears","Principal in Arrears+Interest in Arrears","Principal in Arrears+Interest in Arrears+Penalty in Arrears";
        }
        field(31;"Penalty Calculation Frequency";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Weekly,Monthly,Quaterly';
            OptionMembers = " ",Daily,Weekly,Monthly,Quaterly;
        }
        field(32;"Penalty Rate(%)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67;"Created By";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(68;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69;"Time Created";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(71;"Approval Statement";Text[100])
        {
            Caption = 'Approval Statement';
            DataClassification = ToBeClassified;
        }
        field(72;"Approved By";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(73;"Date Approved";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74;"Time Approved";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(100;"Disbursement Payment Code";Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Code"."Transaction Code" WHERE ("Transaction Type"=CONST(Payment));

            trigger OnValidate()
            begin
                "Disbursement Account No.":='';
                FundsTransactionCode.Reset;
                if FundsTransactionCode.Get("Disbursement Payment Code") then begin
                  "Disbursement Account No.":=FundsTransactionCode."Account No.";
                  Validate("Disbursement Account No.");
                end;
            end;
        }
        field(101;"Disbursement Account No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "G/L Account"."No.";
        }
        field(102;"Disbursement Account Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(105;"Principal Receivable PG";Code[20])
        {
            Caption = 'Principal Receivable Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;

            trigger OnValidate()
            begin
                "Principal Receivable Account":='';

                CustomerPostingGroup.Reset;
                if CustomerPostingGroup.Get("Principal Receivable PG") then begin
                  "Principal Receivable Account":=CustomerPostingGroup."Receivables Account";
                end;
            end;
        }
        field(106;"Principal Receivable Account";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "G/L Account"."No." WHERE ("Income/Balance"=CONST("Balance Sheet"));
        }
        field(110;"Interest Receivable PG";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;

            trigger OnValidate()
            begin
                "Interest Receivable Account":='';

                CustomerPostingGroup.Reset;
                if CustomerPostingGroup.Get("Interest Receivable PG") then begin
                  "Interest Receivable Account":=CustomerPostingGroup."Receivables Account";
                end;
            end;
        }
        field(111;"Interest Receivable Account";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "G/L Account"."No." WHERE ("Income/Balance"=CONST("Balance Sheet"));
        }
        field(112;"Interest Income Account";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE ("Income/Balance"=CONST("Income Statement"));
        }
        field(113;"Interest Accrual Account";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." WHERE ("Income/Balance"=CONST("Income Statement"));
        }
        field(200;"Multiple of Basic Salary";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(201;"Multiplier of";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Basic Salary,Total Cash Pay';
            OptionMembers = " ","Basic Salary","Total Cash Pay";
        }
        field(205;"Reapplication Period";DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(300;"Account No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
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
        "Created By":=UserId;
        "Date Created":=Today;
        "Time Created":=Time;
    end;

    var
        FundsTransactionCode: Record "Funds Transaction Code";
        CustomerPostingGroup: Record "Customer Posting Group";
        EmployeePostingGroup: Record "Employee Posting Group";
        PPeriod: Integer;
}

