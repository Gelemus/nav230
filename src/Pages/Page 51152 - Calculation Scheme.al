page 51152 "Calculation Scheme"
{
    PageType = List;
    SourceTable = "Calculation Scheme";

    layout
    {
        area(content)
        {
            repeater(Control45)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                }
                field("Scheme ID"; Rec."Scheme ID")
                {
                    TableRelation = "Calculation Header"."Scheme ID";
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Visible = DescriptionVisible;
                }
            }
            group(Input)
            {
                Caption = 'Input';
                field(Control1; Rec.Input)
                {
                    ShowCaption = false;

                    trigger OnValidate()
                    begin
                        InputOnAfterValidate;
                    end;
                }
                field("Payroll Entry"; Rec."Payroll Entry")
                {
                }
                field("Caculation Line"; Rec."Caculation Line")
                {
                }
                field(Round; Rec.Round)
                {

                    trigger OnValidate()
                    begin
                        RoundOnAfterValidate;
                    end;
                }
                field("Round Precision"; Rec."Round Precision")
                {
                }
                field(Calculation; Rec.Calculation)
                {

                    trigger OnValidate()
                    begin
                        CalculationOnAfterValidate;
                    end;
                }
                field("Compute To"; Rec."Compute To")
                {
                    Caption = 'Calculate to';
                    Lookup = true;
                }
                field(Number; Rec.Number)
                {
                    Caption = 'Divide/Multiply';
                }
                field(LookUp; Rec.LookUp)
                {
                }
                field("Factor of"; Rec."Factor of")
                {
                    Caption = 'Factor of';
                }
                field(Percent; Rec.Percent)
                {
                }
                field("Payroll Lines"; Rec."Payroll Lines")
                {
                }
                field(P9A; Rec.P9A)
                {
                    Caption = 'P9A Column';
                }
            }
            group(Indicators)
            {
                Caption = 'Indicators';
                field("Total Earnings (B4 SAPP)"; Rec."Total Earnings (B4 SAPP)")
                {
                    Caption = 'Total Eearnings B4 Pension, Special Allowances and Payments';
                    ToolTip = 'Total Earnings Before Special Allowances, Special Payments and Pension i.e. Total Gross Pay (P9 Column D) less (Special Allowances + Special Payments + Pension)';
                }
                field("Chargeable Pay (B4 SAP)"; Rec."Chargeable Pay (B4 SAP)")
                {
                }
                field("Special Allowance"; Rec."Special Allowance")
                {
                    ToolTip = 'Indicates a tax free allowance to be inserted by the system from Special Allowances setup table';
                }
                field("Special Payment"; Rec."Special Payment")
                {
                }
                field("Chargeable Pay"; Rec."Chargeable Pay")
                {
                }
                field("PAYE Lookup Line"; Rec."PAYE Lookup Line")
                {
                }
                field("Annualize TAX"; Rec."Annualize TAX")
                {
                }
                field("Annualize Relief"; Rec."Annualize Relief")
                {
                }
                field(Multiline; Rec.Multiline)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Caculation LineVisible" := true;
        "Payroll EntryVisible" := true;
        "Round PrecisionVisible" := true;
        LookUpVisible := true;
        NumberVisible := true;
        PercentVisible := true;
        "Factor ofVisible" := true;
        "Compute ToVisible" := true;
        DescriptionVisible := true;
        Rec."Payroll Code" := 'GENERAL';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payroll Code" := Pcode;
        Rec.SetUpNewLine(xRec, BelowxRec);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        gsSegmentPayrollData; //skm150506
        DescriptionVisible := true;
        OnActivateForm;
    end;

    var
        [InDataSet]
        DescriptionVisible: Boolean;
        [InDataSet]
        "Compute ToVisible": Boolean;
        [InDataSet]
        "Factor ofVisible": Boolean;
        [InDataSet]
        PercentVisible: Boolean;
        [InDataSet]
        NumberVisible: Boolean;
        [InDataSet]
        LookUpVisible: Boolean;
        [InDataSet]
        "Round PrecisionVisible": Boolean;
        [InDataSet]
        "Payroll EntryVisible": Boolean;
        [InDataSet]
        "Caculation LineVisible": Boolean;
        lvActiveSession: Record "Active Session";
        Pcode: Code[20];

    procedure ShowCalcFields()
    begin

        "Compute ToVisible" := false;
        "Factor ofVisible" := false;
        PercentVisible := false;
        NumberVisible := false;
        LookUpVisible := false;

        case Rec.Calculation of
            Rec.Calculation::Add, Rec.Calculation::Substract:
                "Compute ToVisible" := true;

            Rec.Calculation::Divide, Rec.Calculation::Multiply:
                begin
                    "Compute ToVisible" := true;
                    NumberVisible := true;
                end;

            Rec.Calculation::Percent:
                begin
                    "Compute ToVisible" := true;
                    PercentVisible := true;
                end;

            Rec.Calculation::Highest, Rec.Calculation::Lowest:
                begin
                    "Compute ToVisible" := true;
                    "Factor ofVisible" := true;
                end;

            Rec.Calculation::"Look Up":
                begin
                    "Compute ToVisible" := true;
                    LookUpVisible := true;
                end;
        end;

        case Rec.Round of
            Rec.Round::Down, Rec.Round::Up, Rec.Round::Nearest:
                "Round PrecisionVisible" := true;
            else
                "Round PrecisionVisible" := false;
        end;

        case Rec.Input of
            Rec.Input::"Payroll Entry":
                begin
                    "Payroll EntryVisible" := true;
                    "Caculation LineVisible" := false;
                end;

            Rec.Input::"Calculation Line":
                begin
                    "Caculation LineVisible" := true;
                    "Payroll EntryVisible" := false;
                end;

            else begin
                "Payroll EntryVisible" := false;
                "Caculation LineVisible" := false;
            end;
        end;
    end;

    local procedure CalculationOnAfterValidate()
    begin
        ShowCalcFields;
    end;

    local procedure RoundOnAfterValidate()
    begin
        ShowCalcFields;
    end;

    local procedure InputOnAfterValidate()
    begin
        ShowCalcFields;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ShowCalcFields;
    end;

    local procedure OnActivateForm()
    begin
        ShowCalcFields;
    end;

    local procedure CalculationOnInputChange(var Text: Text[1024])
    begin
        ShowCalcFields;
    end;

    local procedure RoundOnInputChange(var Text: Text[1024])
    begin
        ShowCalcFields;
    end;

    local procedure InputOnInputChange(var Text: Text[1024])
    begin
        ShowCalcFields;
    end;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin
        /*lvSession.SETRANGE("My Session", TRUE);
        lvSession.FINDFIRST; //fire error in absence of a login
        IF lvSession."Login Type" = lvSession."Login Type"::Database THEN
          lvAllowedPayrolls.SETRANGE("User ID", USERID)
        ELSE*/

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        lvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        lvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if lvAllowedPayrolls.FindFirst then
            Rec.SetRange("Payroll Code", lvAllowedPayrolls."Payroll Code")
        else
            Error('You are not allowed access to this payroll dataset.');
        Rec.FilterGroup(100);
        Pcode := lvAllowedPayrolls."Payroll Code";

    end;
}

