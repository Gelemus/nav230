report 50608 "Update Approval Entries"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer";"Integer")
        {
            DataItemTableView = WHERE(Number=CONST(1));

            trigger OnAfterGetRecord()
            var
                HRLeaveApplicationRec: Record "HR Leave Application";
                UserSetupRec: Record "User Setup";
                SubstituteApprover: Code[20];
                UserSetupRec2: Record "User Setup";
                Employee: Record Employee;
            begin
                HRLeaveApplicationRec.Reset;
                HRLeaveApplicationRec.SetFilter(Status,'%1|%2',HRLeaveApplicationRec.Status::Released,HRLeaveApplicationRec.Status::Posted);
                HRLeaveApplicationRec.SetFilter("Leave Start Date",'<=%1',Today);
                HRLeaveApplicationRec.SetFilter("Leave End Date",'>=%1',Today);
                HRLeaveApplicationRec.SetRange("Leave Status",HRLeaveApplicationRec."Leave Status"::"On Leave");
                //HRLeaveApplicationRec.SETRANGE("No.",'LVAP000279');
                
                if HRLeaveApplicationRec.FindFirst then
                   repeat
                     SubstituteApprover := '';
                     Employee.Reset;
                     Employee.SetRange("No.",HRLeaveApplicationRec."Substitute No.");
                     Employee.SetRange(Status,Employee.Status::Active);
                       if Employee.FindFirst then begin //GET(HRLeaveApplicationRec."Substitute No.") THEN BEGIN
                           SubstituteApprover:=Employee."User ID";
                      end else begin
                       UserSetupRec.Reset;
                       if UserSetupRec.Get(HRLeaveApplicationRec."User ID") then
                         SubstituteApprover:=UserSetupRec.Substitute;
                     end;
                
                       /*UserSetupRec.RESET;
                       IF UserSetupRec.GET(HRLeaveApplicationRec."User ID") THEN
                         SubstituteApprover:=UserSetupRec.Substitute;*/
                
                      ApprovalEntryRec.Reset;
                      ApprovalEntryRec.SetFilter(Status,'%1|%2',ApprovalEntryRec.Status::Created,ApprovalEntryRec.Status::Open);
                      ApprovalEntryRec.SetFilter(ApprovalEntryRec."Due Date",'>=%1',Today);
                      ApprovalEntryRec.SetRange("Approver ID",HRLeaveApplicationRec."User ID");
                      if ApprovalEntryRec.FindFirst then
                        repeat
                          if SubstituteApprover<>'' then begin
                          ApprovalEntryRec."Approver ID":=SubstituteApprover;
                
                          ApprovalEntryRec.Modify;
                          NOOfRec+=1;
                          /*
                          AutoApprovedRec.RESET;
                          AutoApprovedRec.INIT;
                          AutoApprovedRec."Leave No" := HRLeaveApplicationRec."No.";
                          AutoApprovedRec."Approver Id" := HRLeaveApplicationRec."User ID";
                          AutoApprovedRec."Delegated To" := SubstituteApprover;
                          AutoApprovedRec."Record Id" := ApprovalEntryRec."Document No.";
                          AutoApprovedRec.INSERT;*/
                
                          end;
                    until ApprovalEntryRec.Next=0;
                 until HRLeaveApplicationRec.Next=0;

            end;

            trigger OnPreDataItem()
            var
                NoOfRecords: Integer;
            begin
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(OldApprover;OldApprover)
                {
                    Caption = 'Current Approver';
                    TableRelation = "User Setup";
                }
                field(NewApprover;NewApprover)
                {
                    Caption = 'New Approver';
                    TableRelation = "User Setup";
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

    trigger OnPostReport()
    begin
        //MESSAGE('No of records %1',NOOfRec);
    end;

    var
        ApprovalEntryRec: Record "Approval Entry";
        NOOfRec: Integer;
        OldApprover: Code[20];
        NewApprover: Code[20];
        AutoApprovedRec: Record "Auto Approved Records";
        lineNo: Integer;
}

