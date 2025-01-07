page 51160 "Payroll Entry"
{
    PageType = ListPart;
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Lines" = rimd,
                  TableData "Loan Entry" = rimd;
    PopulateAllFields = true;
    RefreshOnActivate = true;
    SourceTable = "Payroll Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Payroll ID"; Rec."Payroll ID")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Copy to next"; Rec."Copy to next")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = true;
                    Visible = true;
                }
                field("ED Code"; Rec."ED Code")
                {
                    Editable = "ED CodeEditable";
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                }
                field("ED Expiry Date"; Rec."ED Expiry Date")
                {
                }
                field(Text; Rec.Text)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = QuantityEditable;
                }
                field(Rate; Rec.Rate)
                {
                    Editable = RateEditable;
                }
                field("Rate (LCY)"; Rec."Rate (LCY)")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Visible = true;
                }
                field(Interest; Rec.Interest)
                {
                    Editable = true;
                    Visible = true;
                }
                field("Interest (LCY)"; Rec."Interest (LCY)")
                {
                    Visible = true;
                }
                field(Repayment; Rec.Repayment)
                {
                    Editable = true;
                    Visible = true;
                }
                field("Repayment (LCY)"; Rec."Repayment (LCY)")
                {
                    Visible = true;
                }
                field("Remaining Debt"; Rec."Remaining Debt")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Remaining Debt (LCY)"; Rec."Remaining Debt (LCY)")
                {
                    Visible = true;
                }
                field(Paid; Rec.Paid)
                {
                    Editable = true;
                    Visible = true;
                }
                field("Paid (LCY)"; Rec."Paid (LCY)")
                {
                    Visible = true;
                }
                field("Loan ID"; Rec."Loan ID")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Loan Entry No"; Rec."Loan Entry No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reset Amount"; Rec."Reset Amount")
                {
                }
                field("Staff Vendor Entry"; Rec."Staff Vendor Entry")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = 'Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #39012010. Unsupported part was commented. Please check it.
                        /*CurrPage.PayrollEntries.PAGE.*/
                        ShowDims;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Header.Get(Rec."Payroll ID", Rec."Employee No.");
        if Header.Calculated = true then begin
            Header.Calculated := false;
            Header.Modify;
        end;
    end;

    trigger OnInit()
    begin
        /*"Reset AmountEditable" := TRUE;
        "Copy to nextEditable" := TRUE;
        AmountEditable := TRUE;
        RateEditable := TRUE;
        QuantityEditable := TRUE;
        "ED CodeEditable" := TRUE;
        DateEditable := TRUE;*/

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        MaxEntry := MaxEntry + 1;
        Header.Get(Rec."Payroll ID", Rec."Employee No.");
        if Header.Calculated = true then begin
            Header.Calculated := false;
            Header.Modify;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Header.Get(Rec."Payroll ID", Rec."Employee No.");
        if Header.Calculated = true then begin
            Header.Calculated := false;
            Header.Modify;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Entry No." := MaxEntry + 1;
        Rec.Date := Today;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Payroll ID", "Employee No.", "ED Code");

        if Entrys.Find('+') then
            MaxEntry := Entrys."Entry No."
        else
            MaxEntry := 0;
        gsSegmentPayrollData; //skm150506
    end;

    var
        Header: Record "Payroll Header";
        Entrys: Record "Payroll Entry";
        MaxEntry: Integer;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "ED CodeEditable": Boolean;
        [InDataSet]
        QuantityEditable: Boolean;
        [InDataSet]
        RateEditable: Boolean;
        [InDataSet]
        AmountEditable: Boolean;
        [InDataSet]
        "Copy to nextEditable": Boolean;
        [InDataSet]
        "Reset AmountEditable": Boolean;

    procedure ShowDims()
    begin
        Rec.ShowDimensions;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if Editable then begin
            DateEditable := true;
            "ED CodeEditable" := true;
            QuantityEditable := true;
            RateEditable := true;
            AmountEditable := true;
            "Copy to nextEditable" := true;
            "Reset AmountEditable" := true;

        end else begin
            DateEditable := false;
            "ED CodeEditable" := false;
            QuantityEditable := true;
            RateEditable := true;
            AmountEditable := true;
            "Copy to nextEditable" := false;
            "Reset AmountEditable" := false;
        end;
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

    end;
}

