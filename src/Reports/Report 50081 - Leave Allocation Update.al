report 50081 "Leave Allocation Update"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(Employee;Employee)
        {

            trigger OnAfterGetRecord()
            begin
                FifteenthDay:=CalcDate('+14D',CalcDate('-CM',WorkDate));
                if FifteenthDay=WorkDate then begin
                HRLeavePeriods.Reset;
                HRLeavePeriods.SetRange(HRLeavePeriods.Closed,false);
                if HRLeavePeriods.FindFirst then begin
                 LeavePeriod:=HRLeavePeriods.Code;
                end;

                    HRLeaveTypes.Reset;
                    HRLeaveTypes.SetRange(HRLeaveTypes."Annual Leave",true);
                      if HRLeaveTypes.FindFirst then begin
                      HRLeaveLedgerEntries.Init;
                      if HRLeaveLedgerEntries.FindLast then
                      HRLeaveLedgerEntries."Line No.":=HRLeaveLedgerEntries."Line No."+1;
                      HRLeaveLedgerEntries."Document No.":=HRLeaveTypes.Code;
                      HRLeaveLedgerEntries."Posting Date":=Today;
                      HRLeaveLedgerEntries."Entry Type":=HRLeaveLedgerEntries."Entry Type"::"Positive Adjustment";
                      HRLeaveLedgerEntries."Employee No.":=Employee."No.";
                      HRLeaveLedgerEntries."Leave Type":=HRLeaveTypes.Code;
                      HRLeaveLedgerEntries."Leave Period":=LeavePeriod;
                      HRLeaveLedgerEntries.Days:=HRLeaveTypes.Days/12;
                      HRLeaveLedgerEntries."Leave Year":=HRLeavePeriods."Leave Year";
                      HRLeaveLedgerEntries."Leave Allocation":=true;
                      HRLeaveLedgerEntries.Description:='Leave allocation for the month';
                      HRLeaveLedgerEntries.Insert
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        HRLeaveTypes: Record "HR Leave Types";
        LeavePeriod: Code[30];
        HRLeavePeriods: Record "HR Leave Periods";
        HRLeaveLedgerEntries2: Record "HR Leave Ledger Entries";
        FifteenthDay: Date;
}

