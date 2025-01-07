page 51161 "ED Definitions List"
{
    Editable = false;
    PageType = Card;
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

