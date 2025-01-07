page 51158 "ED Definitions"
{
    CardPageID = "ED Definition Card";
    Editable = false;
    PageType = List;
    SourceTable = "ED Definitions";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("ED Code"; Rec."ED Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Payroll Text"; Rec."Payroll Text")
                {
                    Caption = 'Payslip Text';
                }
                field(Cumulative; Rec.Cumulative)
                {
                }
                field("Rounding ED"; Rec."Rounding ED")
                {
                }
                field("Copy to next"; Rec."Copy to next")
                {
                    Caption = 'Copy to next Period';
                }
                field("Employer ED Code"; Rec."Employer ED Code")
                {
                }
                field("Reset Amount"; Rec."Reset Amount")
                {
                    Caption = 'Reset Amount';
                }
                field("System Created"; Rec."System Created")
                {
                }
                field("Sum Payroll Entries"; Rec."Sum Payroll Entries")
                {
                }
                field("Overtime ED"; Rec."Overtime ED")
                {
                    Visible = true;
                }
                field("Overtime ED Weight"; Rec."Overtime ED Weight")
                {
                    Visible = true;
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Useful in case of Negative Net Pay - 0 = Undefined, 1 = Highest, 2 = Second Highest';
                }
                field("Membership No. Name"; Rec."Membership No. Name")
                {
                }
                field("Calculation Group"; Rec."Calculation Group")
                {
                }
                field("Posting type"; Rec."Posting type")
                {

                    trigger OnValidate()
                    begin
                        PostingtypeOnAfterValidate;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("ED Posting Group"; Rec."ED Posting Group")
                {
                }
                field("Debit/Credit"; Rec."Debit/Credit")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Special Allowance"; Rec."Special Allowance")
                {
                }
                field("Special Payment"; Rec."Special Payment")
                {
                }
                field("Pension ED"; Rec."Pension ED")
                {
                }
                field("Employee Rate"; Rec."Employee Rate")
                {
                }
                field("Employer Rate"; Rec."Employer Rate")
                {
                }
                field("Institution Code"; Rec."Institution Code")
                {
                }
                field("Gratuity ED"; Rec."Gratuity ED")
                {
                }
                field("OT1 ED"; Rec."OT1 ED")
                {
                }
                field("OT2 ED"; Rec."OT2 ED")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ED)
            {
                Caption = 'ED';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(39012009),
                                  "No." = FIELD("ED Code");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Debit/CreditVisible" := true;
        "Global Dimension 2 CodeVisible" := true;
        "Global Dimension 1 CodeVisible" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        OnActivateForm;
    end;

    var
        [InDataSet]
        "ED Posting GroupVisible": Boolean;
        [InDataSet]
        "Account NoVisible": Boolean;
        [InDataSet]
        "Global Dimension 1 CodeVisible": Boolean;
        [InDataSet]
        "Global Dimension 2 CodeVisible": Boolean;
        [InDataSet]
        "Debit/CreditVisible": Boolean;

    procedure ShowFields()
    begin


        "ED Posting GroupVisible" := false;
        "Account NoVisible" := false;
        "Global Dimension 1 CodeVisible" := false;
        "Global Dimension 2 CodeVisible" := false;
        "Debit/CreditVisible" := false;

        case Rec."Posting type" of
            Rec."Posting type"::"G/L Account":
                "ED Posting GroupVisible" := true;
            Rec."Posting type"::Direct:
                begin
                    "Account NoVisible" := true;
                    "Global Dimension 1 CodeVisible" := true;
                    "Global Dimension 2 CodeVisible" := true;
                    "Debit/CreditVisible" := true;
                end;
            Rec."Posting type"::Customer:
                begin
                    "Account NoVisible" := true;
                    "Global Dimension 1 CodeVisible" := true;
                    "Global Dimension 2 CodeVisible" := true;
                    "Debit/CreditVisible" := true;
                end;
            Rec."Posting type"::Vendor:
                begin
                    "Account NoVisible" := true;
                    "Global Dimension 1 CodeVisible" := true;
                    "Global Dimension 2 CodeVisible" := true;
                    "Debit/CreditVisible" := true;
                end;
        end;
    end;

    local procedure PostingtypeOnAfterValidate()
    begin
        ShowFields;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ShowFields;
    end;

    local procedure OnActivateForm()
    begin
        ShowFields;
    end;

    local procedure PostingtypeOnInputChange(var Text: Text[1024])
    begin
        ShowFields;
    end;
}

