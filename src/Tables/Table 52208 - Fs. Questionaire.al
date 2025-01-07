table 52208 "Fs. Questionaire"
{
    Caption = 'Fs. Questionaire';

    fields
    {
        field(1;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Transport Request"."Request No." WHERE ("Document Type"=CONST("Feasibility Study"));
        }
        field(3;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt,Funds Transfer,Imprest,Imprest Surrender';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Surrender";
        }
        field(4;Name;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Gender;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Male,Female;
        }
        field(6;"Employment Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Unemployed,"Self Employed","Works for Government Institution","Works for Private Institution";
        }
        field(7;"Income Per Month";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Years lived in the House";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Type of House";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Permanent,Temporary';
            OptionMembers = " ",Permanent,"Temporary";
        }
        field(10;"Type of Building";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Commercial,Residental,MulidWelling';
            OptionMembers = " ",Commercial,Residental,MulidWelling;
        }
        field(11;"Have Water Source";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,yes,No';
            OptionMembers = " ",yes,No;
        }
        field(12;"Main Source of Water";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Cost of Installation";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Preffered Source of Water";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Water Quality used Perception";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"If  bad Reason";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Water Used per Day";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Currently Enough";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(19;"Days In a Week";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Hours Per Day";Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Have Storage Facilities";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(22;"Size of Storage";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23;Category;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Elevated,Underground,Service Level';
            OptionMembers = " ",Elevated,Underground,"Service Level";
        }
        field(24;"Amount You Pay";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25;"Mode of Payment";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Per Liter,Per Jelican';
            OptionMembers = " ","Per Liter","Per Jelican";
        }
        field(26;"When You Pay";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Monthly,Not Applicable';
            OptionMembers = " ",Daily,Monthly,"Not Applicable";
        }
        field(27;"Need Improvement of Source";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
        }
        field(28;"Amount You Would Pay";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Would Migrate if Improved";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(30;"Hours You Use Most Water";Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(31;"Major Use of Water";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32;"Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No.") then
                  "Employee Name":=Empl."First Name"+' '+Empl."Middle Name"+' '+Empl."Last Name";
                "Employee No." :="Employee No.";
            end;
        }
        field(33;"Employee Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No.","Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //TestStatusOpen(TRUE);
    end;

    trigger OnInsert()
    begin
        /*ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.","Document No.");
        IF ImprestHeader.FINDFIRST THEN BEGIN
          ImprestHeader.TESTFIELD("Date From");
          ImprestHeader.TESTFIELD("Date To");
          Description:=ImprestHeader.Description;
          "Document Type":="Document Type"::Imprest;
          "Posting Date":=ImprestHeader."Posting Date";
          "Currency Code":=ImprestHeader."Currency Code";
          "Currency Factor":=ImprestHeader."Currency Factor";
          "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
          "Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
          "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
          "Shortcut Dimension 5 Code":=ImprestHeader."Shortcut Dimension 5 Code";
          "Shortcut Dimension 6 Code":=ImprestHeader."Shortcut Dimension 6 Code";
          "Shortcut Dimension 7 Code":=ImprestHeader."Shortcut Dimension 7 Code";
          "Shortcut Dimension 8 Code":=ImprestHeader."Shortcut Dimension 8 Code";
          "HR Job Grade":=ImprestHeader."HR Job Grade";
          "Employee No":=ImprestHeader."Employee No.";
          Quantity:=ImprestHeader."Date To"-ImprestHeader."Date From";
          IF Quantity=0 THEN
            Quantity:=1;
        
        END;*/

    end;

    var
        FundsTransactionCodes: Record "Funds Transaction Code";
        FundsTaxCodes: Record "Funds Tax Code";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        ImprestHeader: Record "Imprest Header";
        ImprestLine: Record "Imprest Line";
        CurrExchRate: Record "Currency Exchange Rate";
        DepreciationBook: Record "FA Depreciation Book";
        AlowanceMatrix: Record "Allowance Matrix";
        CityCodes: Record "Procurement Lookup Values";
        Error001: Label 'From City must be Inserted';
        Error002: Label 'Imprest code exists for this date. Cannot be twice on the same day';
        Empl: Record Employee;

    local procedure TestStatusOpen(AllowApproverEdit: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ImprestHeader.Get("Document No.");
        if AllowApproverEdit then begin
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange(ApprovalEntry."Document No.",ImprestHeader."No.");
          ApprovalEntry.SetRange(ApprovalEntry.Status,ApprovalEntry.Status::Open);
          ApprovalEntry.SetRange(ApprovalEntry."Approver ID",UserId);
          if not ApprovalEntry.FindFirst then begin
            ImprestHeader.TestField(Status,ImprestHeader.Status::Open);
          end;
        end else begin
          ImprestHeader.TestField(Status,ImprestHeader.Status::Open);
        end;
    end;
}

