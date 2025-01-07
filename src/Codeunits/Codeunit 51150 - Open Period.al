codeunit 51150 "Open Period"
{
    // Permissions = TableData TableData52021050=ri;

    trigger OnRun()
    begin
        gvPayrollUtilities.sGetActivePayroll(gvAllowedPayrolls);
        PeriodTable.SetCurrentKey("Start Date");
        PeriodTable.SetRange(Status,0);
        PeriodTable.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

        PeriodTable.Find('-');
        PeriodeText := PeriodTable.Description;
        if Confirm('Do you want to open period\%1',false,PeriodeText) then begin
          Period := PeriodTable."Period ID";
          Month := PeriodTable."Period Month";
          Year := PeriodTable."Period Year";

          PeriodTable.Reset;
          PeriodTable.SetCurrentKey("Start Date");
          PeriodTable.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
          PeriodTable.Get(Period, Month, Year, gvAllowedPayrolls."Payroll Code");
          if PeriodTable.Find('<') then begin
            PreviousPeriod := PeriodTable."Period ID";

            Window.Open('Making Payroll Header    #1######\' +
                        'Making Payroll Entries   #2######');

            MakePayrollHeader;
            MakePayrollLines;
            SetPeriodToOpen;
          end else begin
             Window.Open('Making Payroll Header... #1######\');

             MakePayrollHeader;
             SetPeriodToOpen;
          end;
          Window.Close;
        end;
    end;

    var
        Employee: Record Employee;
        PeriodTable: Record Periods;
        PeriodeText: Text[50];
        Period: Code[10];
        PreviousPeriod: Code[10];
        Window: Dialog;
        WindowCount: Integer;
        Month: Integer;
        Year: Integer;
        LineNo: Integer;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvPayrollUtilities: Codeunit "Payroll Posting";

    procedure MakePayrollHeader()
    var
        Header: Record "Payroll Header";
        lvPeriodTable: Record Periods;
    begin
        Header.LockTable(true);
        Employee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        Employee.Find('-');
        WindowCount := 0;
        lvPeriodTable.Get(Period, Month, Year, gvAllowedPayrolls."Payroll Code");
        Employee.TestField("Employment Date");
        repeat
          if (Employee.Status = Employee.Status::Active) and (Employee."Employment Date"<= lvPeriodTable."End Date") then begin
            WindowCount := WindowCount + 1;
            Window.Update(1,WindowCount);
            Header."Payroll ID" := Period;
            Header."Employee no." := Employee."No.";
            Header."Payroll Month" := Month;
            Header."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            Header."Payroll Year" := Year;
            Header.Insert(true);
          end;
        until Employee.Next = 0;
    end;

    procedure MakePayrollLines()
    var
        OldLines: Record "Payroll Entry";
        NewLines: Record "Payroll Entry";
        EDdef: Record "ED Definitions";
        lvPeriod: Record Periods;
    begin
        OldLines.LockTable(true);
        if OldLines.Find('+') then
          LineNo := OldLines."Entry No."
        else
          LineNo := 0;

        lvPeriod.Get(Period, Month, Year, gvAllowedPayrolls."Payroll Code");

        //Copy Payroll Lines without expiry date
        OldLines.SetRange("Copy to next", true);
        OldLines.SetRange("Payroll ID",PreviousPeriod);
        OldLines.SetRange("ED Expiry Date", 0D);
        OldLines.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

        if OldLines.Find('-') then begin
          WindowCount := 0;
          repeat
            EDdef.Get(OldLines."ED Code");
            if Employee.Get(OldLines."Employee No.") then
              if (Employee.Status = Employee.Status::Active) and (Employee."Employment Date"<= lvPeriod."End Date")  then begin
                WindowCount := WindowCount + 1;
                Window.Update(2,WindowCount);
                LineNo := LineNo + 1;
                NewLines.Copy(OldLines);
                NewLines."Payroll ID" := Period;
                NewLines."Entry No." := LineNo;
                //ICS March 2017
                NewLines."Staff Vendor Entry":=OldLines."Staff Vendor Entry";
                //ICS March 2017
            if EDdef."Reset Amount" = true then begin
              NewLines.Amount := 0;
              NewLines.Quantity := 0;
            end;
              NewLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
              NewLines.Insert(true);
              end;
          until OldLines.Next = 0;
        end;

        //Copy none expired payroll entries
        OldLines.SetFilter("ED Expiry Date", '>=%1', lvPeriod."Start Date");

        if OldLines.Find('-') then begin
          WindowCount := 0;
          repeat
            EDdef.Get(OldLines."ED Code");
            if Employee.Get(OldLines."Employee No.") then
              if (Employee.Status = Employee.Status::Active) and (Employee."Employment Date"<= lvPeriod."End Date") then begin
                WindowCount := WindowCount + 1;
                Window.Update(2,WindowCount);
                LineNo := LineNo + 1;
                NewLines.Copy(OldLines);
                NewLines."Payroll ID" := Period;
                NewLines."Entry No." := LineNo;
                //ICS March 2017
                NewLines."Staff Vendor Entry":=OldLines."Staff Vendor Entry";
                //ICS March 2017
            if EDdef."Reset Amount" = true then begin
              NewLines.Amount := 0;
              NewLines.Quantity := 0;
            end;
              NewLines."Payroll Code" := gvAllowedPayrolls."Payroll Code";
              NewLines.Insert(true);
              end;
          until OldLines.Next = 0;
        end;
    end;

    procedure SetPeriodToOpen()
    var
        PeriodTable: Record Periods;
    begin
        PeriodTable.Get(Period,Month,Year, gvAllowedPayrolls."Payroll Code");
        PeriodTable.Status := PeriodTable.Status::Open;
        PeriodTable."Document No" := PeriodTable."Period ID" + '-' + PeriodTable."Payroll Code";
        PeriodTable.Modify;
    end;
}

