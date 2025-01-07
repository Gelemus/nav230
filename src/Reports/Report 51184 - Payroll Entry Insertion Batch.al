report 51184 "Payroll Entry Insertion Batch"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee;Employee)
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                gvPayrollHdr.Get(gvPeriodID, "No."); //Ensure payroll header exists

                //Check that ED is not already inserted
                gvPayrollEntry.SetCurrentKey("Payroll ID", "Employee No.", "ED Code");
                gvPayrollEntry.SetRange("Payroll ID", gvPeriodID);
                gvPayrollEntry.SetRange("Employee No.", "No.");
                gvPayrollEntry.SetRange("ED Code", gvEDCode);
                if gvPayrollEntry.FindFirst then CurrReport.Skip;

                gvPayrollEntry.Reset;
                gvPayrollEntry.Init;
                gvLastEntryNo += 10;
                gvPayrollEntry."Entry No." := gvLastEntryNo;
                gvPayrollEntry."Payroll ID" := gvPeriodID;
                gvPayrollEntry."Employee No." := "No.";
                gvPayrollEntry.Validate("ED Code", gvEDCode);
                gvPayrollEntry.Date := gvPeriod."Start Date";
                gvPayrollEntry.Insert(true);
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("No.", gvEmpNos);
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                gvPayrollEntry.SetRange("ED Code", gvEDCode);
                if gvPayrollEntry.FindLast then gvLastEntryNo := gvPayrollEntry."Entry No.";

                gvPeriod.SetRange("Period ID", gvPeriodID);
                gvPeriod.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                gvPeriod.FindFirst;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(gvPeriodID;gvPeriodID)
                    {
                        Caption = 'Insert Into Period';
                        TableRelation = Periods."Period ID" WHERE (Status=CONST(Open));
                    }
                    field(gvEmpNos;gvEmpNos)
                    {
                        Caption = 'For Employees';
                        TableRelation = Employee."No." WHERE (Status=CONST(Active));
                    }
                    field(gvEDCode;gvEDCode)
                    {
                        Caption = 'ED Code';
                        TableRelation = "ED Definitions"."ED Code" WHERE ("System Created"=CONST(false));
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
        if (gvPeriodID = '') or (gvEmpNos = '') or (gvEDCode = '') then
          Error('All options on the request form must be filled in.')
    end;

    var
        gvPeriodID: Code[10];
        gvEmpNos: Code[20];
        gvEDCode: Code[20];
        gvPayrollEntry: Record "Payroll Entry";
        gvPayrollHdr: Record "Payroll Header";
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvLastEntryNo: Integer;
        gvPeriod: Record Periods;

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

