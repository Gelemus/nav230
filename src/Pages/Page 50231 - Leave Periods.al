page 50231 "Leave Periods"
{
    PageType = List;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the Name.';
                }
                field("Leave Year"; Rec."Leave Year")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the start Date.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the End date.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Closed';
                }
                field("Enable Leave Planning"; Rec."Enable Leave Planning")
                {
                    ToolTip = 'Specifies Enabling of Leave planning';
                }
                field("Leave Planning End Date"; Rec."Leave Planning End Date")
                {
                    ToolTip = 'Specifies the Leave Planning End Date.';
                }
                field("Enable Leave Application"; Rec."Enable Leave Application")
                {
                    ToolTip = 'Specifies the enabling of Leave application.';
                }
                field("Enable Leave Carryover"; Rec."Enable Leave Carryover")
                {
                    ToolTip = 'Specifies the Enabling of Leave carryover.';
                }
                field("Leave Carryover End Date"; Rec."Leave Carryover End Date")
                {
                    ToolTip = 'Specifies the Enabling of Leave carryover End Date.';
                }
                field("Enable Leave Reimbursement"; Rec."Enable Leave Reimbursement")
                {
                    ToolTip = 'Specifies the Enabling of Leave Reimbursement.';
                }
                field("Leave Reimbursement End Date"; Rec."Leave Reimbursement End Date")
                {
                    ToolTip = 'Specifies the Enabling of Leave Reimbursment End Date.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Close Leave Period")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LeavePeriods.Reset;
                    //LeavePeriods.SETRANGE(LeavePeriods.Closed,FALSE);
                    if LeavePeriods.FindLast then begin
                        Rec.Closed := true;
                        if Rec.Modify then begin
                            HRLeaveManagement.CarryOverLeaveDays(Rec.Code);
                        end;
                    end;
                end;
            }
        }
    }

    var
        LeavePeriods: Record "HR Leave Periods";
        HRLeaveManagement: Codeunit "HR Leave Management";
        Text001: Label 'Are you sure you want to Close the Leave Period? Please note the Leave balances from the current period  will be transfered to the next Financial Period.';
}

