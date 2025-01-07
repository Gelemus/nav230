report 50221 "Casual Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Casual Requisition.rdl';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            column(StartDate_HREmployeeRequisitions; "HR Employee Requisitions"."Start Date")
            {
            }
            column(EndDate_HREmployeeRequisitions; "HR Employee Requisitions"."End Date")
            {
            }
            column(MainDuties_HREmployeeRequisitions; "HR Employee Requisitions"."Main Duties")
            {
            }
            column(No_HREmployeeRequisitions; "HR Employee Requisitions"."No.")
            {
            }
            column(BudgetGL_HREmployeeRequisitions; "HR Employee Requisitions"."Budget GL")
            {
            }
            column(BudgetGLName_HREmployeeRequisitions; "HR Employee Requisitions"."Budget GL Name")
            {
            }
            column(GlobalDimension1Code_HREmployeeRequisitions; "HR Employee Requisitions"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HREmployeeRequisitions; "HR Employee Requisitions"."Global Dimension 2 Code")
            {
            }
            column(Section_HREmployeeRequisitions; "HR Employee Requisitions".Section)
            {
            }
            column(DocumentDate_HREmployeeRequisitions; "HR Employee Requisitions"."Document Date")
            {
            }
            column(NumberRequiredSkilled_HREmployeeRequisitions; "HR Employee Requisitions"."Number Required - Skilled")
            {
            }
            column(NumberRequiredUnskilled_HREmployeeRequisitions; "HR Employee Requisitions"."Number Required - Unskilled")
            {
            }
            column(Reasonforengagement_HREmployeeRequisitions; "HR Employee Requisitions"."Reason for engagement")
            {
            }
            column(DailyRateSkilled_HREmployeeRequisitions; "HR Employee Requisitions"."Daily Rate Skilled")
            {
            }
            column(DailyRateUnskilled_HREmployeeRequisitions; "HR Employee Requisitions"."Daily Rate Unskilled")
            {
            }
            column(EmployeeNo_HREmployeeRequisitions; "HR Employee Requisitions"."Employee No")
            {
            }
            column(EmployeeName_HREmployeeRequisitions; "HR Employee Requisitions"."Employee Name")
            {
            }
            column(CompanyInfo; CompanyInfo.Name)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(DaysforEngagementSkilled_HREmployeeRequisitions; "HR Employee Requisitions"."Days for Engagement - Skilled")
            {
            }
            column(DaysforEngagementUnkilled_HREmployeeRequisitions; "HR Employee Requisitions"."Days for Engagement - Unkilled")
            {
            }
            column(PieceWork_HREmployeeRequisitions; "HR Employee Requisitions"."Piece Work")
            {
            }
            column(NoofMetersothers_HREmployeeRequisitions; "HR Employee Requisitions"."No of Meters/others")
            {
            }
            column(Amount_HREmployeeRequisitions; "HR Employee Requisitions".Amount)
            {
            }
            column(EstimatedTotalCostofWork_HREmployeeRequisitions; "HR Employee Requisitions"."Estimated Total Cost of Work")
            {
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = FILTER(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; UserSetupRecI.Signature)
                {
                }
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
                {
                }
                column(EmployeeSignature2; TenantMedia.Content)
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Employee Signature")
                    {
                    }
                    column(JobTitle_Employee; Employee."Job Title")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: ' + EmployeeRecI."Job Title" + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";
                            //EmployeeRecI.CALCFIELDS(EmployeeRecI."Employee Signature");

                            TenantMedia.Reset;
                            if EmployeeRecI."Employee Signature".HasValue then begin
                                TenantMedia.Get(EmployeeRecI."Employee Signature".MediaId);
                                TenantMedia.CalcFields(Content);
                            end;

                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Accounts: ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Section Head:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Head of Department:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 4 then begin
                        ApprovedByCaption := 'Managing Director:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RepCheck.InitTextVariable();

                RepCheck.FormatNoText(NoText, "HR Employee Requisitions"."Number Required - Unskilled", ' ');

                AmountInWords := NoText[1];
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        NumberText: array[2] of Text[80];
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;
        TenantMedia: Record "Tenant Media";
        RepCheck: Report Check;
        NoText: array[28] of Text;
        AmountInWords: Text;
}

