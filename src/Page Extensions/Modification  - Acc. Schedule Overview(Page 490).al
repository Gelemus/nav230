pageextension 60289 pageextension60289 extends "Acc. Schedule Overview"
{
    layout
    {
        addafter("Row No.")
        {
            field("G/L Account"; Rec."G/L Account")
            {
            }
        }
        addafter(Description)
        {
            field(Notes; Rec.Notes)
            {
            }
        }
    }
    actions
    {
        addafter(Print)
        {
            action("Print Revenue")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Monthly';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Print the information in the window. A print request window opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    AccSched: Report "Account Schedule";
                    DateFilter2: Text;
                    GLBudgetFilter2: Text;
                    BusUnitFilter: Text;
                    CostBudgetFilter2: Text;
                    Dim1Filter: Text;
                    Dim2Filter: Text;
                    Dim3Filter: Text;
                    Dim4Filter: Text;
                    IsHandled: Boolean;
                    CurrentSchedName: Code[10];
                    CurrentColumnName: Code[10];
                    AccSched2: Report "Account Schedule Report";
                begin
                    IsHandled := false;
                    OnBeforePrintSummary(Rec, TempFinancialReport."Financial Report Column Group", IsHandled, TempFinancialReport);
                    if IsHandled then
                        exit;
                    if TempFinancialReport.Name <> '' then
                        AccSched2.SetColumnLayoutName(TempFinancialReport.Name);
                    // AccSched2.SetFinancialReportName(TempFinancialReport.Name);
                    if TempFinancialReport."Financial Report Row Group" <> '' then
                        AccSched2.SetAccSchedName(TempFinancialReport."Financial Report Row Group");
                    if TempFinancialReport."Financial Report Column Group" <> '' then
                        AccSched2.SetColumnLayoutName(TempFinancialReport."Financial Report Column Group");
                    AccSched2.SetAccSchedName(CurrentSchedName);
                    AccSched2.SetAccSchedName(CurrentSchedName);
                    AccSched2.SetColumnLayoutName(CurrentColumnName);
                    DateFilter2 := Rec.GetFilter("Date Filter");
                    GLBudgetFilter2 := Rec.GetFilter("G/L Budget Filter");
                    CostBudgetFilter2 := Rec.GetFilter("Cost Budget Filter");
                    BusUnitFilter := Rec.GetFilter("Business Unit Filter");
                    AccSched2.SetFilters(DateFilter2, GLBudgetFilter2, CostBudgetFilter2, BusUnitFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
                    AccSched2.SetFilters(DateFilter2, GLBudgetFilter2, CostBudgetFilter2, BusUnitFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
                    AccSched2.Run;
                end;
            }
        }
        addafter(Recalculate)
        {
            action("Print Summary")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Summary';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Print the information in the window. A print request window opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    AccSched3: Report "Account Schedules Report";
                    DateFilter2: Text;
                    GLBudgetFilter2: Text;
                    BusUnitFilter: Text;
                    CostBudgetFilter2: Text;
                    Dim1Filter: Text;
                    Dim2Filter: Text;
                    Dim3Filter: Text;
                    Dim4Filter: Text;
                    CurrentSchedName: Code[10];
                    CurrentColumnName: Code[10];
                    AccSched2: Report "Account Schedule Report";
                    AccSched4: Report "Account Schedules Reports";
                    IsHandled: Boolean;
                begin
                    IsHandled := false;
                    OnBeforePrintSummary(Rec, TempFinancialReport."Financial Report Column Group", IsHandled, TempFinancialReport);
                    if IsHandled then
                        exit;
                    if TempFinancialReport.Name <> '' then
                        AccSched4.SetColumnLayoutName(TempFinancialReport.Name);
                    // AccSched2.SetFinancialReportName(TempFinancialReport.Name);
                    if TempFinancialReport."Financial Report Row Group" <> '' then
                        AccSched4.SetAccSchedName(TempFinancialReport."Financial Report Row Group");
                    if TempFinancialReport."Financial Report Column Group" <> '' then
                        AccSched4.SetColumnLayoutName(TempFinancialReport."Financial Report Column Group");
                    DateFilter2 := Rec.GetFilter("Date Filter");
                    GLBudgetFilter2 := Rec.GetFilter("G/L Budget Filter");
                    CostBudgetFilter2 := Rec.GetFilter("Cost Budget Filter");
                    BusUnitFilter := Rec.GetFilter("Business Unit Filter");
                    AccSched4.SetFilters(DateFilter2, GLBudgetFilter2, CostBudgetFilter2, BusUnitFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
                    AccSched4.SetFilters(DateFilter2, GLBudgetFilter2, CostBudgetFilter2, BusUnitFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
                    AccSched4.Run;
                end;
            }
        }
    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforePrintSummary(var AccScheduleLine: Record "Acc. Schedule Line"; ColumnLayoutName: Code[10]; var IsHandled: Boolean; var TempFinancialReport: Record "Financial Report" temporary)
    begin
    end;
}

