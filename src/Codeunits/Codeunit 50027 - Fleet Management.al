codeunit 50027 "Fleet Management"
{

    trigger OnRun()
    begin
    end;

    procedure CalculateReturnDate(StartDate: Date;DaysApplied: Integer) ReturnDate: Date
    var
        ReturnDateFormula: DateFormula;
    begin
        ReturnDate:=0D;
        if Evaluate(ReturnDateFormula,Format(DaysApplied)+'D') then
          ReturnDate:=CalcDate(ReturnDateFormula,StartDate);
    end;
}

