pageextension 60652 pageextension60652 extends "Accounting Manager Role Center" 
{
    actions
    {
        addafter("&Bank Detail Trial Balance")
        {
            action("Petty Cash Surrender Summary")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Petty Cash Surrender Summary';
                Image = "Report";
                RunObject = Report "Petty Cash Surrender Summary";
                ToolTip = 'Petty Cash Surrender Summary';
            }
        }
        addafter("Cost Accounting Analysis")
        {
            group("Monthly Reports")
            {
                Caption = 'Monthly Reports';
                action("Master Roll Report")
                {
                    Caption = 'Master Roll Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Master Roll Report";
                }
                action("Timesheet Report")
                {
                    Caption = 'Timesheet Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Generate P10 Re";
                }
                action("Company Payslip")
                {
                    Caption = 'Company Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Company Payslip";
                }
                action(Payslip)
                {
                    Caption = 'Payslip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report Payslips;
                }
                action("ED Report")
                {
                    Caption = 'ED Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "ED Report";
                }
                action("ED Totals Per Period")
                {
                    Caption = 'ED Totals Per Period';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "ED Totals Per Period";
                }
                action(" Bank Payment List")
                {
                    Caption = ' Bank Payment List';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Bank Payment List";
                }
                action("Staff Gratuity Report")
                {
                    Caption = 'Staff Gratuity Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Staff Gratuity Report";
                }
                action("Institution Based ED Report")
                {
                    Caption = 'Institution Based ED Report';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report";
                }
                action(" Institution Based ED Report Insurance")
                {
                    Caption = ' Institution Based ED Report Insurance';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Institution Based ED Report In";
                }
                action("Check Payment List")
                {
                    Caption = 'Check Payment List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Check Payment List";
                }
                action(" Cash Payment List")
                {
                    Caption = ' Cash Payment List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Cash Payment List";
                }
                action("MPESA Payment List")
                {
                    Caption = 'MPESA Payment List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "MPESA Payment List";
                }
                action("Payroll Reconciliation-Per ED")
                {
                    Caption = 'Payroll Reconciliation-Per ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-Per ED";
                }
                action(" Payroll Reconciliation-All ED")
                {
                    Caption = ' Payroll Reconciliation-All ED';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Payroll Reconciliation-All ED";
                }
                action(" Bank Payment Report")
                {
                    Caption = ' Bank Payment Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Bank Payment Report";
                }
            }
            group("Monthly Statutory Reports")
            {
                Caption = 'Monthly Statutory Reports';
                action("NSSF Report")
                {
                    Caption = 'NSSF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF Report";
                }
                action("NHIF Report")
                {
                    Caption = 'NHIF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF Report";
                }
                action("PAYE Report")
                {
                    Caption = 'PAYE Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "PAYE Report";
                }
                action("Generate P10")
                {
                    Caption = 'Generate P10';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Generate P10";
                }
                action("<Report Pension Report>")
                {
                    Caption = 'Pension Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Pension Report";
                }
            }
            group("Annual Statutory Reports")
            {
                Caption = 'Annual Statutory Reports';
                action("P9A Report")
                {
                    Caption = 'P9A Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "P9A Report";
                }
                action(P10A)
                {
                    Caption = 'P10A';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report P10A;
                }
                action(P10)
                {
                    Caption = 'P10';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report P10;
                }
                action(P10D)
                {
                    Caption = 'P10D';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report P10D;
                }
                action("NSSF YEARLY REPORT")
                {
                    Caption = 'NSSF YEARLY REPORT';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NSSF YEARLY REPORT";
                }
                action("<Report  NHIF YEARLY REPORT>")
                {
                    Caption = 'NHIF YEARLY REPORT';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "NHIF YEARLY REPORT";
                }
                action("<Report  CBS>")
                {
                    Caption = 'CBS';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report CBS;
                }
            }
        }
        addafter(VendorsBalance)
        {
            action("Purchase Requisition Codes")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Purchase Requisition Codes';
                RunObject = Page "Purchase Requisition Codes";
                ToolTip = 'Purchase Requisition Codes';
            }
        }
        addafter(Journals)
        {
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                action(" Imprest List")
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List";
                }
                action("Imprest List Status")
                {
                    Caption = 'Imprest List Status';
                    RunObject = Page "Imprest List Status";
                }
                action("Imprest Surrender List")
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                    Visible = false;
                }
                action("Petty Cash list")
                {
                    Caption = 'Petty Cash list';
                    RunObject = Page "Petty Cash list";
                }
                action("Petty Cash list Status")
                {
                    Caption = 'Petty Cash list Status';
                    RunObject = Page "Petty Cash list S";
                }
                action("Store Requisitions List")
                {
                    Caption = 'Store Requisitions List';
                    RunObject = Page "Store Requisitions List";
                }
                action("Store Requisitions List Status")
                {
                    Caption = 'Store Requisitions List Status';
                    RunObject = Page "Store Requisitions List Status";
                }
                action("Purchase Requisition List")
                {
                    Caption = 'Purchase Requisition List';
                    RunObject = Page "Requisition List";
                }
                action("Status Purchase Requisition List")
                {
                    Caption = 'Status Purchase Requisition List';
                    RunObject = Page "Purchase Requisition List S";
                }
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    RunObject = Page "Leave Applications";
                }
                action(" Leave Applications Status")
                {
                    Caption = ' Leave Applications Status';
                    RunObject = Page "Leave Applications Status";
                }
                action("Leave Reimbursements")
                {
                    Caption = 'Leave Reimbursements';
                    RunObject = Page "Leave Reimbursements";
                }
                action("HR Employee Appraisals")
                {
                    Caption = 'HR Employee Appraisals';
                    RunObject = Page "HR Employee Appraisals";
                }
                action("HR Employee Appraisals Status")
                {
                    Caption = 'HR Employee Appraisals Status';
                    RunObject = Page "HR Employee Appraisals Status";
                }
                action("Transport Request List")
                {
                    Caption = 'Transport Request List';
                    RunObject = Page "Transport Request List";
                }
                action("Vehicle Allocations List")
                {
                    Caption = 'Vehicle Allocations List';
                    RunObject = Page "Vehicle Allocations List";
                }
                action("Allocated Vehicle List")
                {
                    Caption = 'Allocated Vehicle List';
                    RunObject = Page "Allocated Vehicle List";
                }
            }
            group("Fund Management")
            {
                Caption = 'Fund Management';
                action(Action159)
                {
                    Caption = ' Imprest List';
                    RunObject = Page "Imprest List";
                }
                action("Approved Imprest List")
                {
                    Caption = 'Approved Imprest List';
                    RunObject = Page "Approved Imprest List";
                }
                action(" Pending Approval Imprest List")
                {
                    Caption = ' Pending Approval Imprest List';
                    RunObject = Page "pending Approval Imprest List";
                }
                action(Action156)
                {
                    Caption = 'Imprest Surrender List';
                    RunObject = Page "Imprest Surrender List";
                }
                action("Payment List")
                {
                    Caption = 'Payment List';
                    RunObject = Page "Payment List";
                }
                action("Pending Approval Payment List")
                {
                    Caption = 'Pending Approval Payment List';
                    RunObject = Page "Pending Approval Payment List";
                }
                action("Approved Payment List")
                {
                    Caption = 'Approved Payment List';
                    RunObject = Page "Approved Payment List";
                }
                action("Posted Payment List")
                {
                    Caption = 'Posted Payment List';
                    RunObject = Page "Posted Payment List";
                }
                action("Cash Payment List")
                {
                    Caption = 'Cash Payment List';
                    RunObject = Page "Cash Payment List";
                }
                action("Pending Cash Payment List")
                {
                    Caption = 'Pending Cash Payment List';
                    RunObject = Page "Pending Cash Payment List";
                }
                action("Approved Cash Payment List")
                {
                    Caption = 'Approved Cash Payment List';
                    RunObject = Page "Approved Cash Payment List";
                }
                action("Posted Cash Payment List")
                {
                    Caption = 'Posted Cash Payment List';
                    RunObject = Page "Posted Cash Payment List";
                }
                action("Receipt List")
                {
                    Caption = 'Receipt List';
                    RunObject = Page "Receipt List";
                }
                action("Journal Voucher List")
                {
                    Caption = 'Journal Voucher List';
                    RunObject = Page "Journal Voucher List";
                }
                action("Funds Claim List")
                {
                    Caption = 'Funds Claim List';
                    RunObject = Page "Funds Claim List";
                }
                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    RunObject = Page "Funds Transfer List";
                }
                action("Receipt Codes")
                {
                    Caption = 'Receipt Codes';
                    RunObject = Page "Receipt Codes";
                }
                action("Payment Codes")
                {
                    Caption = 'Payment Codes';
                    RunObject = Page "Payment Codes";
                }
                action("Imprest Codes")
                {
                    Caption = 'Imprest Codes';
                    RunObject = Page "Imprest Codes";
                }
                action("Funds Tax Codes")
                {
                    Caption = 'Funds Tax Codes';
                    RunObject = Page "Funds Tax Codes";
                }
                action("Budget Control Setup ")
                {
                    Caption = 'Budget Control Setup ';
                    RunObject = Page "Budget Control Setup";
                }
                action("Funds User Setup")
                {
                    Caption = 'Funds User Setup';
                    RunObject = Page "Funds User Setup";
                }
            }
        }
        addafter("Fixed Assets")
        {
            group(Approval)
            {
                Caption = 'Approval';
                Image = LotInfo;
                action("Requests to Approve")
                {
                    Caption = 'Requests to Approve';
                    RunObject = Page "Requests to Approve";
                }
                action("Approval Entries")
                {
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                }
            }
        }
        addfirst("Posted Documents")
        {
            action(Action124)
            {
                Caption = 'Posted Payment List';
                RunObject = Page "Posted Payment List";
            }
            action("Posted Receipt List")
            {
                Caption = 'Posted Receipt List';
                RunObject = Page "Posted Receipt List";
            }
            action("Posted Funds Transfer List")
            {
                Caption = 'Posted Funds Transfer List';
                RunObject = Page "Posted Funds Transfer List";
            }
            action("Posted Fund Claim List")
            {
                Caption = 'Posted Fund Claim List';
                RunObject = Page "Posted Fund Claim List";
            }
            action("Posted Imprest Surrender List")
            {
                Caption = 'Posted Imprest Surrender List';
                RunObject = Page "Posted Imprest Surrender List";
            }
            action("Journal Vouchers Posted")
            {
                Caption = 'Journal Vouchers Posted';
                RunObject = Page "Journal Vouchers Posted";
            }
        }
    }
}

