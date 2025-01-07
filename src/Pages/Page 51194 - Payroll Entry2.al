page 51194 "Payroll Entry2"
{
    PageType = ListPart;
    Permissions = TableData "Payroll Header" = rimd,
                  TableData "Payroll Entry" = rimd,
                  TableData "Special Payments" = rimd;
    PopulateAllFields = true;
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
                    Editable = "Payroll IDEditable";
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = "Employee No.Editable";
                    TableRelation = "Payroll Header"."Employee no.";

                    trigger OnValidate()
                    begin
                        EmployeeNoOnAfterValidate;
                    end;
                }
                field("ED Code"; Rec."ED Code")
                {
                    Editable = "ED CodeEditable";
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
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
                field(Amount; Rec.Amount)
                {
                    Editable = AmountEditable;
                }
                field(Interest; Rec.Interest)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Debt"; Rec."Remaining Debt")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Paid; Rec.Paid)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Loan ID"; Rec."Loan ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Loan Entry No"; Rec."Loan Entry No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Copy to next"; Rec."Copy to next")
                {
                    Editable = "Copy to nextEditable";
                }
                field("Reset Amount"; Rec."Reset Amount")
                {
                    Editable = "Reset AmountEditable";
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

    trigger OnDeleteRecord(): Boolean
    begin
        if (Rec."Payroll ID" <> '') and (Rec."Employee No." <> '') then begin
            Header.Get(Rec."Payroll ID", Rec."Employee No.");
            if Header.Calculated = true then begin
                Header.Calculated := false;
                Header.Modify;
            end
        end;
    end;

    trigger OnInit()
    begin
        "Employee No.Editable" := true;
        "Payroll IDEditable" := true;
        "Reset AmountEditable" := true;
        "Copy to nextEditable" := true;
        AmountEditable := true;
        RateEditable := true;
        QuantityEditable := true;
        "ED CodeEditable" := true;
        DateEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if (Rec."Payroll ID" <> '') and (Rec."Employee No." <> '') then begin
            Header.Get(Rec."Payroll ID", Rec."Employee No.");
            if Header.Calculated = true then begin
                Header.Calculated := false;
                Header.Modify;
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if (Rec."Payroll ID" <> '') and (Rec."Employee No." <> '') then begin
            Header.Get(Rec."Payroll ID", Rec."Employee No.");
            if Header.Calculated = true then begin
                Header.Calculated := false;
                Header.Modify;
            end
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Entrys.Find('+') then MaxEntry := Entrys."Entry No.";
        MaxEntry := MaxEntry + 1;
        Rec."Entry No." := MaxEntry;
        Rec."Payroll ID" := Entrys."Payroll ID";
        Rec.Date := Today;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if Entrys.Find('+') then
            MaxEntry := Entrys."Entry No."
        else
            MaxEntry := 0;

        Rec.SetCurrentKey("Payroll ID", "Employee No.", "ED Code");
        gsSegmentPayrollData;
    end;

    var
        Header: Record "Payroll Header";
        Entrys: Record "Payroll Entry";
        MaxEntry: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
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
        [InDataSet]
        "Payroll IDEditable": Boolean;
        [InDataSet]
        "Employee No.Editable": Boolean;

    local procedure EmployeeNoOnAfterValidate()
    begin
        if Rec."ED Code" <> '' then Rec.Validate("ED Code");
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
            "Payroll IDEditable" := true;
            "Employee No.Editable" := true;
        end else begin
            DateEditable := false;
            "ED CodeEditable" := false;
            QuantityEditable := true;
            RateEditable := true;
            AmountEditable := true;
            "Copy to nextEditable" := false;
            "Reset AmountEditable" := false;
            "Payroll IDEditable" := false;
            "Employee No.Editable" := false;
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

