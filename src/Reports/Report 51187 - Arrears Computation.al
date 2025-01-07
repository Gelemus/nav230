report 51187 "Arrears Computation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee;Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                if Process then begin
                  PayrollEntry.Reset;
                  PayrollEntry.SetRange(PayrollEntry."ED Code",ArrearsEDCode);
                  PayrollEntry.SetRange(PayrollEntry."Payroll ID",ArrearPayM);
                  PayrollEntry.SetFilter(PayrollEntry."Employee No.","No.");
                  if not PayrollEntry.FindFirst then repeat
                    InitPayrollEntry.Reset;
                    if InitPayrollEntry.FindLast then
                      InitEntryNo := InitPayrollEntry."Entry No.";
                    PayrollEntry.Init;
                    PayrollEntry."Entry No." := InitEntryNo + 1;
                    PayrollEntry.Validate("ED Code",ArrearsEDCode);
                    PayrollEntry."Payroll ID" := ArrearPayM;
                    PayrollEntry.Validate("Employee No.","No.");
                    PayrollEntry.Validate(Quantity,NoofMonthsArr);
                    PayrollEntry."Payroll Code" := ActPayrollID;
                    PayrollLine.Reset;
                    PayrollLine.SetRange(PayrollLine."Payroll ID",BasePayM);
                    PayrollLine.SetRange(PayrollLine."Employee No.",EmpCode);
                    PayrollLine.SetRange(PayrollLine."ED Code",EDCode);
                    if PayrollLine.FindFirst then begin
                      BaseAmountCal := PayrollLine.Amount;
                    end;
                    if ArrearPercAmt = ArrearPercAmt::Percentage then begin
                      if ArrearPerc <> 0 then
                        ArrearAmountAdd := (BaseAmountCal / 100) * ArrearPerc;
                    end else if ArrearPercAmt = ArrearPercAmt::Amount then begin
                      ArrearAmountAdd := BaseAmountCal + ArrearAmt;
                    end;
                    PayrollEntry.Validate(Rate,ArrearAmountAdd);
                    PayrollEntry.Date := Today;
                    if PayrollEntry.Insert then
                      Posted := true;
                  until PayrollEntry.Next = 0 else
                    Error(Text001,"No.",ArrearPayM,ArrearsEDCode);
                end else
                  Message('Arrear Computation Process Stopped');
            end;

            trigger OnPostDataItem()
            begin
                if Posted then
                  Message('Payroll Entry Lines Updated Sucessfully');
            end;

            trigger OnPreDataItem()
            begin
                if EDCode = '' then
                  Error(Text003);
                if EmpCode = '' then
                  Error(Text005);
                if ((BasePayY = 0) or (BasePayM = '')) then
                  Error(Text006);
                if NoofMonthsArr = 0 then
                  Error(Text002);
                if ArrearPercAmt = ArrearPercAmt::Percentage then
                  if ArrearPerc = 0 then
                    Error(Text007);
                if ArrearPercAmt = ArrearPercAmt::Amount then
                  if ArrearAmt = 0 then
                    Error(Text008);
                if ((ArrearPayY = 0) or (ArrearPayM = '')) then
                  Error(Text009);
                if ArrearsEDCode = '' then
                  Error(Text010);
                Process := Confirm(Text004,true);
                SetFilter("No.",EmpCode);

                gvAllowedPayrolls.Reset;
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."User ID",UserId);
                gvAllowedPayrolls.SetRange(gvAllowedPayrolls."Last Active Payroll",true);
                if gvAllowedPayrolls.FindFirst then
                  ActPayrollID := gvAllowedPayrolls."Payroll Code";
            end;
        }
    }

    requestpage
    {
        Editable = true;
        InsertAllowed = true;

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(EmpCode;EmpCode)
                    {
                        Caption = 'Employee Filter';
                        TableRelation = Employee;
                    }
                    field(EDCode;EDCode)
                    {
                        Caption = 'Base ED Code';
                        TableRelation = "ED Definitions"."ED Code" WHERE ("System Created"=FILTER(true));
                    }
                    field(BasePayY;BasePayY)
                    {
                        Caption = 'Base Payroll Year';
                        TableRelation = Year;
                    }
                    field(BasePayM;BasePayM)
                    {
                        Caption = 'Base Payroll Month';
                    }
                    field(NoofMonthsArr;NoofMonthsArr)
                    {
                        Caption = 'No. of Months Arrear Payable';
                    }
                    field(ArrearPerc;ArrearPerc)
                    {
                        Caption = 'Arears Percentage';
                    }
                    field(ArrearAmt;ArrearAmt)
                    {
                        Caption = 'Arears Amount';
                    }
                    field(ArrearPayY;ArrearPayY)
                    {
                        Caption = 'Arrear Payroll Year';
                        TableRelation = Year;
                    }
                    field(ArrearPayM;ArrearPayM)
                    {
                        Caption = 'Arrear Payroll Month';
                    }
                    field(ArrearsEDCode;ArrearsEDCode)
                    {
                        Caption = 'Arrears ED Code';
                        TableRelation = "ED Definitions"."ED Code" WHERE ("System Created"=FILTER(false));
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                group(Functions)
                {
                    Caption = 'Functions';
                    action("TestComputation ")
                    {
                    }
                }
            }
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
    end;

    var
        EmpRec: Record Employee;
        ECDefin: Record "ED Definitions";
        PeriodsRec: Record Periods;
        PayrollEntry: Record "Payroll Entry";
        InitPayrollEntry: Record "Payroll Entry";
        PayrollLine: Record "Payroll Lines";
        EDCode: Code[20];
        ArrearPayM: Code[20];
        BasePayM: Code[20];
        ArrearsEDCode: Code[20];
        BasePayY: Integer;
        ArrearPayY: Integer;
        BaseMonthS: Integer;
        InitEntryNo: Integer;
        NoofMonthsArr: Decimal;
        ArrearPerc: Decimal;
        ArrearAmt: Decimal;
        BaseAmountCal: Decimal;
        ArrearAmountAdd: Decimal;
        ArrearPercAmt: Option Percentage,Amount;
        Text000: Label 'Arrears payable year cannot be less than Base payable Year.';
        Text001: Label 'Arrear entries already exists with Employee No := %1 , Payroll ID := %2 and ED Code := %3';
        Text002: Label 'Enter minimum 1 in No. of Months for Arrear Calculation.';
        Text003: Label 'Enter Base ED Code.';
        TestArrearComp: Report "Arrear Test Report";
        Filters: Text[100];
        EmpCode: Code[20];
        Posted: Boolean;
        Process: Boolean;
        Text004: Label 'Do you want to process arrear computation further?';
        Text005: Label 'Enter the employees no.''s for arrear computation.';
        Text006: Label 'Enter the Base Payment Year or Month upon which the computation has to be done.';
        Text007: Label 'Enter Arrear Percentage.';
        Text008: Label 'Enter Arrear Amount.';
        Text009: Label 'Enter the Arrear Payment Year or Month for which the computation has to be Processed.';
        Text010: Label 'Enter Arrear ED Code for which the Arrear Computation has to be processed.';
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        ActPayrollID: Code[20];

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID",ServiceInstanceId);
        lvActiveSession.SetRange("Session ID",SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
          Error('You are not allowed access to this payroll dataset.');
    end;
}

