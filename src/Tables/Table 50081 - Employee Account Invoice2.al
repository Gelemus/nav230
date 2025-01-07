table 50081 "Employee Account Invoice2"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Document Type";Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Invoice';
            OptionMembers = Invoice;
        }
        field(3;"Document Date";Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;"Posting Date";Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(5;"Customer No.";Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Customer Name":='';

                Customer.Reset;
                if Customer.Get("Customer No.") then begin
                  "Customer Name":=Customer.Name;
                end;
            end;
        }
        field(6;"Customer Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"Loan Account No.";Code[20])
        {
            Caption = 'Loan Account No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*"Account Name":='';
                
                LoanAccount.RESET;
                IF LoanAccount.GET("Account No.") THEN BEGIN
                  "Account Name":=LoanAccount.Address;
                  GetLoanAccountArrears("Customer No.",LoanAccount."No.");
                  GetLoanAccountCurrentAmounts("Customer No.",LoanAccount."No.");
                END;*/

            end;
        }
        field(11;"Loan Account Name";Text[50])
        {
            Caption = 'Loan Account Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Currency.Code;
        }
        field(13;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
        }
        field(30;"Principal Arrears";Decimal)
        {
            Caption = 'Principal Arrears';
            Editable = false;
        }
        field(31;"Principal Arrears(LCY)";Decimal)
        {
            Caption = 'Principal Arrears(LCY)';
            Editable = false;
        }
        field(32;"Interest Arrears";Decimal)
        {
            Caption = 'Interest Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33;"Interest Arrears(LCY)";Decimal)
        {
            Caption = 'Interest Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34;"Penalty Interest Arrears";Decimal)
        {
            Caption = 'Penalty Interest Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35;"Penalty Interest Arrears(LCY)";Decimal)
        {
            Caption = 'Penalty Interest Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36;"Loan Fee Arrears";Decimal)
        {
            Caption = 'Loan Fee Arrears';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37;"Loan Fee Arrears(LCY)";Decimal)
        {
            Caption = 'Loan Fee Arrears(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38;"Principal Amount";Decimal)
        {
            Caption = 'Principal Amount';
            Editable = false;
        }
        field(39;"Principal Amount(LCY)";Decimal)
        {
            Caption = 'Principal Amount(LCY)';
            Editable = false;
        }
        field(40;"Interest Amount";Decimal)
        {
            Caption = 'Interest Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41;"Interest Amount(LCY)";Decimal)
        {
            Caption = 'Interest Amount(LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48;"Total Amount";Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
        }
        field(49;"Total Amount(LCY)";Decimal)
        {
            Caption = 'Total Amount(LCY)';
            Editable = false;
        }
        field(50;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(51;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(52;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(53;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(54;"Shortcut Dimension 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(55;"Shortcut Dimension 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(56;"Shortcut Dimension 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(57;"Shortcut Dimension 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                          "Dimension Value Type"=CONST(Standard),
                                                          Blocked=CONST(false));
        }
        field(58;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Acc. Statement Linevb"."Bank Account No.";
        }
        field(60;Description;Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(65;"Created By";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(66;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(67;"Time Created";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70;Status;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted,Reversed';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Reversed;
        }
        field(71;Posted;Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72;"Posted By";Code[50])
        {
            Caption = 'Posted By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(73;"Date Posted";Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74;"Time Posted";Time)
        {
            Caption = 'Time Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75;Reversed;Boolean)
        {
            Caption = 'Reversed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(76;"Reversed By";Code[50])
        {
            Caption = 'Reversed By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(77;"Date Reversed";Date)
        {
            Caption = 'Reversal Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(78;"Time Reversed";Time)
        {
            Caption = 'Reversal Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(79;"Reversal Document No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80;"Reversal Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(99;"User ID";Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(100;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(101;"No. Printed";Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(102;"Incoming Document Entry No.";Integer)
        {
            Caption = 'Incoming Document Entry No.';
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

    trigger OnInsert()
    begin
        /*IF "No." = '' THEN BEGIN
          InvestmentGeneralSetup.GET;
          InvestmentGeneralSetup.TESTFIELD(InvestmentGeneralSetup."Loan Customer Invoice Nos.");
          "NoSeriesMgt.".InitSeries(InvestmentGeneralSetup."Loan Customer Invoice Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;*/
        
        "Document Date":=Today;
        "Created By":=UserId;
        "Date Created":=Today;
        "Time Created":=Time;
        "User ID":=UserId;

    end;

    var
        "NoSeriesMgt.": Codeunit NoSeriesManagement;
        Customer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";

    procedure GetLoanAccountArrears("CustomerNo.": Code[20];"LoanAccountNo.": Code[20])
    var
        PrincipalArrears: Decimal;
        "PrincipalArrears(LCY)": Decimal;
        InterestArrears: Decimal;
        "InterestArrears(LCY)": Decimal;
        PenaltyInterestArrears: Decimal;
        "PenaltyInterestArrears(LCY)": Decimal;
        LoanFeeArrears: Decimal;
        "LoanFeeArrears(LCY)": Decimal;
    begin
        /*//Get Principal Arrears
        PrincipalArrears:=0;"PrincipalArrears(LCY)":=0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.","CustomerNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Investment Account No.","LoanAccountNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Due Date",0D,CALCDATE('-1D',"Posting Date"));
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Investment Transaction Type",'%1|%2',
                                  CustLedgerEntry."Investment Transaction Type"::"Principal Receivable",
                                  CustLedgerEntry."Investment Transaction Type"::"Principal Payment");
        IF CustLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount,CustLedgerEntry."Amount (LCY)",
                                       CustLedgerEntry."Remaining Amount",CustLedgerEntry."Remaining Amt. (LCY)");
            PrincipalArrears:=PrincipalArrears+CustLedgerEntry.Amount;
            "PrincipalArrears(LCY)":="PrincipalArrears(LCY)"+CustLedgerEntry."Amount (LCY)";
          UNTIL CustLedgerEntry.NEXT=0;
        END;
        
        //Get Interest Arrears
        InterestArrears:=0;"InterestArrears(LCY)":=0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.","CustomerNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Investment Account No.","LoanAccountNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Due Date",0D,CALCDATE('-1D',"Posting Date"));
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Investment Transaction Type",'%1|%2',
                                  CustLedgerEntry."Investment Transaction Type"::"Interest Receivable",
                                  CustLedgerEntry."Investment Transaction Type"::"Interest Payment");
        IF CustLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount,CustLedgerEntry."Amount (LCY)",
                                       CustLedgerEntry."Remaining Amount",CustLedgerEntry."Remaining Amt. (LCY)");
            InterestArrears:=InterestArrears+CustLedgerEntry.Amount;
            "InterestArrears(LCY)":="InterestArrears(LCY)"+CustLedgerEntry."Amount (LCY)";
          UNTIL CustLedgerEntry.NEXT=0;
        END;
        
        //Get Penalty Interest Arrears
        PenaltyInterestArrears:=0;"PenaltyInterestArrears(LCY)":=0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.","CustomerNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Investment Account No.","LoanAccountNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Due Date",0D,CALCDATE('-1D',"Posting Date"));
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Investment Transaction Type",'%1|%2',
                                  CustLedgerEntry."Investment Transaction Type"::"Penalty Interest Receivable",
                                  CustLedgerEntry."Investment Transaction Type"::"Penalty Interest Payment");
        IF CustLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount,CustLedgerEntry."Amount (LCY)",
                                       CustLedgerEntry."Remaining Amount",CustLedgerEntry."Remaining Amt. (LCY)");
            PenaltyInterestArrears:=PenaltyInterestArrears+CustLedgerEntry.Amount;
            "PenaltyInterestArrears(LCY)":="PenaltyInterestArrears(LCY)"+CustLedgerEntry."Amount (LCY)";
          UNTIL CustLedgerEntry.NEXT=0;
        END;
        
        //Get Loan Fee Arrears
        LoanFeeArrears:=0;"LoanFeeArrears(LCY)":=0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.","CustomerNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Investment Account No.","LoanAccountNo.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Due Date",0D,CALCDATE('-1D',"Posting Date"));
        CustLedgerEntry.SETFILTER(CustLedgerEntry."Investment Transaction Type",'%1|%2',
                                  CustLedgerEntry."Investment Transaction Type"::"Loan Fee Receivable",
                                  CustLedgerEntry."Investment Transaction Type"::"Loan Fee Payment");
        IF CustLedgerEntry.FINDSET THEN BEGIN
          REPEAT
            CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount,CustLedgerEntry."Amount (LCY)",
                                       CustLedgerEntry."Remaining Amount",CustLedgerEntry."Remaining Amt. (LCY)");
            LoanFeeArrears:=LoanFeeArrears+CustLedgerEntry.Amount;
            "LoanFeeArrears(LCY)":="LoanFeeArrears(LCY)"+CustLedgerEntry."Amount (LCY)";
          UNTIL CustLedgerEntry.NEXT=0;
        END;
        
        "Principal Arrears":=PrincipalArrears;
        "Principal Arrears(LCY)":="PrincipalArrears(LCY)";
        "Interest Arrears":=InterestArrears;
        "Interest Arrears(LCY)":="InterestArrears(LCY)";
        "Loan Fee Arrears":=LoanFeeArrears;
        "Loan Fee Arrears(LCY)":="LoanFeeArrears(LCY)";
        */

    end;

    local procedure GetLoanAccountCurrentAmounts("CustomerNo.": Code[20];"LoanAccountNo.": Code[20])
    var
        PrincipalRepayment: Decimal;
        "PrincipalRepayment(LCY)": Decimal;
        InterestRepayment: Decimal;
        "InterestRepayment(LCY)": Decimal;
    begin
        /*AmortizationSchedule.RESET;
        AmortizationSchedule.SETRANGE(AmortizationSchedule."Account No.","LoanAccountNo.");
        AmortizationSchedule.SETRANGE("Repayment Date",CALCDATE('CM',"Posting Date"));
        IF AmortizationSchedule.FINDFIRST THEN BEGIN
        
        END;*/

    end;
}

