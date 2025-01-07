page 50350 "Inspection Header Rejected Car"
{
    PageType = Card;
    SourceTable = "Inspection Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Inspection No"; Rec."Inspection No")
                {
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
                field("Commitee Appointment No"; Rec."Commitee Appointment No")
                {
                    ApplicationArea = All;
                }
                field("Inspection Date"; Rec."Inspection Date")
                {
                    ApplicationArea = All;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Chair Employee ID"; Rec."Chair Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Chair E-mail"; Rec."Chair E-mail")
                {
                    ApplicationArea = All;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    MultiLine = true;
                }
            }
            part("Inspection Lines"; "Inspection Lines Subform")
            {
                Caption = 'Inspection Lines';
                SubPageLink = "Inspection No" = FIELD("Inspection No");
            }
            part(Control6; "Commitee Members Subform")
            {
                SubPageLink = "Appointment No" = FIELD("Inspection No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM(STRSUBSTNO('Do you want to Approve %1 the Inspection?',"Inspection No"),TRUE) THEN
                          BEGIN
                        Status :=Status::Released;
                        MESSAGE('The Inspection %1 has been Approved',"Inspection No");
                        MODIFY;
                        CurrPage.CLOSE;
                        END;
                        */

                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        TESTFIELD("Rejection Reason");

                       IF CONFIRM(STRSUBSTNO('Do you want to Reject %1 the Inspection?',"Inspection No"),TRUE) THEN
                         BEGIN

                       Status :=Status::Rejected;
                       MESSAGE('The Inspection %1 has been Rejected',"Inspection No");
                       MODIFY;
                       CurrPage.CLOSE;
                       END;
                       */

                    end;
                }
                action("View Order")
                {
                    Caption = 'View Order';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Purchase Order";
                    RunPageLink = "No." = FIELD("Order No");
                    RunPageMode = View;
                }
                action("View Inspection Certificate")
                {
                    Caption = 'View Inspection Certificate';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.Reset;
                        Rec.SetFilter("Inspection No", Rec."Inspection No");
                        REPORT.Run(50196, true, true, Rec);
                        Rec.Reset;
                    end;
                }
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
                    RunPageLink = "Document No." = FIELD("Inspection No");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund",Requisition,"Funds Transfer","HR Document";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Store Requisition Header","No.");
                    end;
                }
            }
        }
    }
}

