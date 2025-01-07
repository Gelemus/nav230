page 50666 "Work Ticket Card -Pending"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Work Ticket";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Ticket No"; Rec."Ticket No")
                {
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Oil Drawn (Litres)"; Rec."Oil Drawn (Litres)")
                {
                }
                field("Fuel Drawn (Litres)"; Rec."Fuel Drawn (Litres)")
                {
                }
                field("Start Speedometer Reading"; Rec."Start Speedometer Reading")
                {
                }
                field("Last Mileage Reading"; Rec."Last Mileage Reading")
                {
                    Caption = 'Return Mileage Reading';
                }
                field("Kms Covered"; Rec."Kms Covered")
                {
                }
                field("Driver No"; Rec."Driver No")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Journey Details"; Rec."Journey Details")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("Return TIme"; Rec."Return TIme")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Inspection Remarks"; Rec."Inspection Remarks")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("Ticket No");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.CheckWorticketApprovalWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendWorticketForApproval(Rec);*/

                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                        Message('Request approved successfully');

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        /*ApprovalsMgmt.OnCancelWorkticketApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RECORDID);*/

                    end;
                }
            }
            action("Print Work Ticket")
            {
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(WorkTicketRec);
                    WorkTicketRec.Reset;
                    WorkTicketRec.SetRange("Ticket No", Rec."Ticket No");
                    WorkTicket.SetTableView(WorkTicketRec);
                    WorkTicket.Run;
                end;
            }
            action(Confirm)
            {
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    MileageRegistrationRec: Record "Mileage Registration";
                begin
                    if Confirm('Are you sure you want to Confirm this Ticket?') then begin
                        //TESTFIELD("Kms Covered");
                        Rec.TestField("Inspection Remarks");
                        //TESTFIELD("Return TIme");
                        //TESTFIELD("Last Mileage Reading");
                        /*MileageRegistrationRec.INIT;
                        MileageRegistrationRec."Vehicle No.":="Vehicle No";
                        MileageRegistrationRec."Work Ticket No.":="Ticket No";
                        MileageRegistrationRec.Date:=TODAY;
                        MileageRegistrationRec."Curent Reading":="Last Mileage Reading";
                        MileageRegistrationRec."Previous Reading":="Current Mileage Reading";
                        MileageRegistrationRec."User ID":=USERID;
                        MileageRegistrationRec.INSERT;*/
                        Message('successfully closed');
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                        CurrPage.Close;
                    end;

                end;
            }
        }
    }

    var
        WorkTicketRec: Record "Work Ticket";
        WorkTicket: Report "Work Ticket";
}

