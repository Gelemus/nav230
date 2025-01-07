report 50257 "Document Track Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Document Track Report.rdl';

    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            DataItemTableView = SORTING("Sender ID") ORDER(Ascending);
            RequestFilterFields = "Document No.", "Sender ID", "Approver ID", Status;
            column(Name; CompanyInfo.Name)
            {
            }
            column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
            {
            }
            column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
            {
            }
            column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
            {
            }
            column(Status_ApprovalEntry; "Approval Entry".Status)
            {
            }
            column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
            {
            }
            column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
            {
            }
            column(LastModifiedByUserID_ApprovalEntry; "Approval Entry"."Last Modified By User ID")
            {
            }
            column(Comment_ApprovalEntry; "Approval Entry".Comment)
            {
            }
            column(DocumentType_ApprovalEntry; "Approval Entry"."Document Type")
            {
            }
            column(Amount_ApprovalEntry; "Approval Entry".Amount)
            {
            }
            column(PendingApprovals_ApprovalEntry; "Approval Entry"."Pending Approvals")
            {
            }
            column(DelegationDateFormula_ApprovalEntry; "Approval Entry"."Delegation Date Formula")
            {
            }
            column(NumberofApprovedRequests_ApprovalEntry; "Approval Entry"."Number of Approved Requests")
            {
            }
            column(NumberofRejectedRequests_ApprovalEntry; "Approval Entry"."Number of Rejected Requests")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(picture)//
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
        CompanyInfo: Record "Company Information";
}

