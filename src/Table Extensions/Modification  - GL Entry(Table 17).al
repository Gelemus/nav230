tableextension 60139 tableextension60139 extends "G/L Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Global Dimension 1 Code"(Field 23)".


        //Unsupported feature: Property Modification (Data type) on ""Global Dimension 2 Code"(Field 24)".


        //Unsupported feature: Property Modification (Data type) on ""External Document No."(Field 56)".

        field(50000; Payee; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50500; "Reference No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136923; Description2; Text[250])
        {
            Caption = 'Description2';
            DataClassification = ToBeClassified;
        }
        field(52136924; "Document Source"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52136925; Document_Type; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136940; "Restricted Account"; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(52137023; "Employee Transaction Type"; Option)
        {
            Caption = 'Employee Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary,Imprest,Advance';
            OptionMembers = " ",Salary,Imprest,Advance;
        }
        field(52137024; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(52137063; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(52137064; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52137123; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52137124; "Payroll Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137125; "Cheque No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52137150; "Property No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137151; "Block Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137152; "Floor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52137153; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //     field(52137180; "Shortcut Dimension 3 Code"; Code[50])
        //     {
        //         CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Code" = CONST('PROGRAM AREA'),
        //                                                                                  "Dimension Set ID" = FIELD("Dimension Set ID")));
        //         CaptionClass = '1,2,3';
        //         Caption = 'Shortcut Dimension 3 Code';
        //         FieldClass = FlowField;
        //         TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
        //                                                       "Dimension Value Type" = CONST(Standard),
        //                                                       Blocked = CONST(false));
        //     }
        //     field(52137181; "Shortcut Dimension 4 Code"; Code[50])
        //     {
        //         CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Code" = CONST('SUB PROGRAM AREA'),
        //                                                                                  "Dimension Set ID" = FIELD("Dimension Set ID")));
        //         CaptionClass = '1,2,4';
        //         Caption = 'Shortcut Dimension 4 Code';
        //         FieldClass = FlowField;
        //         TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
        //                                                       "Dimension Value Type" = CONST(Standard),
        //                                                       Blocked = CONST(false));
        //     }
        //     field(52137182; "Shortcut Dimension 5 Code"; Code[50])
        //     {
        //         CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Code" = CONST('COUNTY'),
        //                                                                                  "Dimension Set ID" = FIELD("Dimension Set ID")));
        //         CaptionClass = '1,2,5';
        //         Caption = 'Shortcut Dimension 5 Code';
        //         FieldClass = FlowField;
        //         TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
        //                                                       "Dimension Value Type" = CONST(Standard),
        //                                                       Blocked = CONST(false));
        //     }
        //     field(52137183; "Shortcut Dimension 6 Code"; Code[50])
        //     {
        //         CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Code" = CONST('SITE'),
        //                                                                                  "Dimension Set ID" = FIELD("Dimension Set ID")));
        //         CaptionClass = '1,2,6';
        //         Caption = 'Shortcut Dimension 6 Code';
        //         FieldClass = FlowField;
        //         TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
        //                                                       "Dimension Value Type" = CONST(Standard),
        //                                                       Blocked = CONST(false));
        //     }
        //     field(52137184; "Shortcut Dimension 7 Code"; Code[50])
        //     {
        //         CaptionClass = '1,2,7';
        //         Caption = 'Shortcut Dimension 7 Code';
        //         DataClassification = ToBeClassified;
        //         TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
        //                                                       "Dimension Value Type" = CONST(Standard),
        //                                                       Blocked = CONST(false));
        //     }
        //     field(52137185; "Shortcut Dimension 8 Code"; Code[50])
        //     {
        //         CaptionClass = '1,2,8';
        //         Caption = 'Shortcut Dimension 8 Code';
        //         DataClassification = ToBeClassified;
        //         TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
        //                                                       "Dimension Value Type" = CONST(Standard),
        //                                                       Blocked = CONST(false));
        //     }
        //     field(52137630; "Investment Application No."; Code[20])
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        //     field(52137650; "Investment Account No."; Code[20])
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        //     field(52137651; "Investment Transaction Type"; Option)
        //     {
        //         DataClassification = ToBeClassified;
        //         OptionCaption = ' ,Loan Disbursement,Principal Receivable,Principal Payment,Interest Receivable,Interest Payment,Penalty Interest Receivable,Penalty Interest Payment,Loan Fee Receivable,Loan Fee Payment,Equity Fair Value';
        //         OptionMembers = " ","Loan Disbursement","Principal Receivable","Principal Payment","Interest Receivable","Interest Payment","Penalty Interest Receivable","Penalty Interest Payment","Loan Fee Receivable","Loan Fee Payment","Equity Fair Value";
        //     }
        //     field(52137652; "Recovery Priority"; Integer)
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        //     field(52137660; "Equity Account No."; Code[20])
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        //     field(52137703; "Investment Product Code"; Code[20])
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        //     field(52137719; "Industry Code"; Code[20])
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        //     field(52137720; "Sector Code"; Code[20])
        //     {
        //         DataClassification = ToBeClassified;
        //     }
        // }

        //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 1)".


        //Unsupported feature: Property Modification (Attributes) on "ShowValueEntries(PROCEDURE 8)".


        //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 2)".


        //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 3)".


        //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 4)".



        //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

        //procedure CopyFromGenJnlLine();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        "Document Type" := GenJnlLine."Document Type";
        "Document No." := GenJnlLine."Document No.";
        "External Document No." := GenJnlLine."External Document No.";
        Description := GenJnlLine.Description;
        "Business Unit Code" := GenJnlLine."Business Unit Code";
        "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        #10..34
        "IC Partner Code" := GenJnlLine."IC Partner Code";

        OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        //Payee
        Payee:=GenJnlLine.Payee;
        //
        #7..37
        */
        //end;

        //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromGLEntry(PROCEDURE 5)".


        //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromVATEntry(PROCEDURE 96)".


        //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromGenJnlLine(PROCEDURE 19)".


        //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromDtldCVBuf(PROCEDURE 94)".


        //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGLEntryFromGenJnlLine(PROCEDURE 6)".


        //Unsupported feature: Property Modification (Attributes) on "CopyFromDeferralPostBuffer(PROCEDURE 46)".


        //Unsupported feature: Property Modification (Attributes) on "UpdateAccountID(PROCEDURE 1166)".

    }

}