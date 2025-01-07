page 50083 "Requisition Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Requisitions";
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique document number for the purchase requisition';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the date when the purchase requisition was created';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date when the user expects to receive the items on the purchase requisition';
                }
                field(Budget; Rec.Budget)
                {
                    ShowMandatory = true;
                }
                field(Supplimentary; Rec.Supplimentary)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency used for the amounts on the purchase requisition';
                    Visible = false;
                }
                field("Reference Document No."; Rec."Reference Document No.")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Project No"; Rec."Project No")
                {
                }
                field(Voted; Rec.Voted)
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Area Manager"; Rec."Area Manager")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Template; Rec.Template)
                {
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description for the purchase requisition';
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the approval status for the purchase requisition';
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the user who created the purchase requisition';
                }
            }
            part("Purchase Requisition Line"; "Requisition Line")
            {
                Caption = 'Purchase Requisition Line';
                SubPageLink = "Document No." = FIELD("No.");
                ToolTip = 'Purchase Requisition Line';
            }
            part("Approval Entries."; "Approval Enttries I")
            {
                Caption = 'Approval Entries';
                SubPageLink = "Document No." = FIELD("No.");
                Editable = false;
                //ToolTip = 'Purchase Requisition Line';
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control29; Links)
            {
                Visible = false;
            }
            systempart(Control26; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)

        {
            // action(OnRun)
            // {
            //     trigger OnAction()
            //     var
            //         NyeriInter: Codeunit "Nyeri Intergration WS";
            //         Project: Record "Job";
            //     begin
            //         Codeunit.Run(22, Project);
            //     end;

            // }
            action(ReOpen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';
                Visible = false;

                trigger OnAction()
                begin
                    /*TESTFIELD("User ID",USERID);
                    IF CONFIRM(Txt_003,FALSE,"No.") THEN BEGIN
                      ProcurementApprovalWorkflow.ReOpenPurchaseRequisitionHeader(Rec);
                      ApprovalsMgmt.OnCancelPurchaseRequisitionApprovalRequest(Rec);
                      WorkflowWebhookMgt.FindAndCancel(RECORDID);
                    END;*/

                end;
            }
            action("Cancel ")
            {
                Caption = 'Cancel';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel Document';
                Visible = false;

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then begin
                        Rec.TestField("Reason for Cancellation");
                        if Confirm('Are you sure you want to cancel?', true) then begin
                            Rec."Cancelled By" := UserId;
                            Rec."Date Cancelled" := Today;
                            Rec."Time Cancelled" := Time;
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                            Message('Cancelled Successfully');
                        end;
                    end;
                end;
            }
            action("Create PO")
            {
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to create a purchase order from this requisition?') then
                        ProcurementManagement.CreatePurchaseOrder(Rec);
                end;
            }
            action("Create Imprest Requisition")
            {
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    UserSetup.Get(rec."User ID");
                    if not UserSetup."Allow Multiple Imprest Request" then begin
                        //check for two unprocessed Imprest
                        // B.V 03.08.2023
                        ImprestHeader.Reset;
                        ImprestHeader.SetRange(ImprestHeader."User ID", rec."User ID");
                        ImprestHeader.SetRange(Type, ImprestHeader.Type::Imprest);
                        if ImprestHeader.FindLast then begin
                            if ImprestHeader."Surrender status" = ImprestHeader."Surrender status"::"Not Surrendered" then
                                Error('Imprest Request No. %1 yet to be surrendered', ImprestHeader."No.");
                            //ImprestNotSurrendered := true;
                        end;
                    end else begin
                        ImprestHeader.Reset;
                        ImprestHeader.SetRange(ImprestHeader."User ID", rec."User ID");
                        ImprestHeader.SetRange(Status, ImprestHeader.Status::Posted);
                        ImprestHeader.SetRange(Surrendered, false);

                        if FundsSetup."Maximum Imprest Requests" < ImprestHeader.Count then
                            Error('You have exceeded the limit %1  of unsurrendered requests ', FundsSetup."Maximum Imprest Requests");

                    end;
                    if DIALOG.Confirm('Are you sure you want to create an Imprest Requisition from Purchase Requisition No  %1', true, Rec."No.") then begin
                        PurchaseRequisitionHeader.Reset;
                        PurchaseRequisitionHeader.SetRange("No.", Rec."No.");
                        if PurchaseRequisitionHeader.FindSet then begin
                            FundsSetup.Reset;
                            FundsSetup.Get;

                            ImprestRec.Init;
                            ImprestRec."No." := NoSeriesMgt.GetNextNo(FundsSetup."Imprest Nos.", 0D, true);
                            ImprestRec."No. Series" := FundsSetup."Imprest Nos.";
                            ImprestRec."Document Type" := ImprestRec."Document Type"::Imprest;
                            ImprestRec."Posting Date" := Today;
                            ImprestRec."Date From" := Today;
                            ImprestRec."Date To" := Today;
                            ImprestRec."User ID" := PurchaseRequisitionHeader."User ID";
                            ImprestRec."Document Date" := Today;
                            ImprestRec.Type := ImprestRec.Type::Imprest;


                            EmployeeRec.Reset;
                            EmployeeRec.SetRange(EmployeeRec."User ID", PurchaseRequisitionHeader."User ID");
                            if EmployeeRec.FindSet then begin
                                ImprestRec."Employee No." := EmployeeRec."No.";
                                ImprestRec."Employee Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                                ImprestRec."Employee Posting Group" := EmployeeRec."Imprest Posting Group";
                                ImprestRec.position := EmployeeRec.Position;
                                ImprestRec."Position Title" := EmployeeRec."Position Title";
                                ImprestRec."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                                ImprestRec."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                                ImprestRec."Phone No." := EmployeeRec."Phone No.";
                                ImprestRec."HR Job Grade" := EmployeeRec."Employee Grade";
                                ImprestRec."User ID" := PurchaseRequisitionHeader."User ID";//EmployeeRec."User ID";
                                ImprestRec."Low Value" := true;
                            end;
                            ImprestRec.Description := PurchaseRequisitionHeader.Description;
                            ImprestRec."Purchase Requisition No" := Rec."No.";
                            if ImprestRec.Insert(true) then begin
                                ImprestRec."User ID" := PurchaseRequisitionHeader."User ID";
                                ImprestRec."Employee No." := PurchaseRequisitionHeader."Employee No.";
                                ImprestRec.Validate("Employee No.");
                                ImprestRec.Modify();
                            end;

                            //lines
                            PurchaseReqline.Reset;
                            PurchaseReqline.SetRange("Document No.", PurchaseRequisitionHeader."No.");
                            if PurchaseReqline.FindSet then begin
                                repeat
                                    ImprestLines.Init;
                                    ImprestLines."Document No." := ImprestRec."No.";
                                    ImprestLines."Line No." := PurchaseReqline."Line No.";
                                    ImprestLines."Document Type" := ImprestLines."Document Type"::Imprest;
                                    ImprestLines."Imprest Code" := 'CASH SALES';
                                    ImprestLines."Imprest Code Description" := 'Items bought via imprest';//PurchaseReqline.Name;
                                                                                                          //justo added to fetch the budget gl for items 06/02/2024
                                    if PurchaseReqline."Requisition Type" = PurchaseReqline."Requisition Type"::Item then begin
                                        ImprestLines."Account Type" := ImprestLines."Account Type"::Item;
                                        Items.Reset;
                                        if Items.Get(PurchaseReqline."No.") then
                                            ImprestLines."Item Budget Gl" := Items."Item G/L Budget Account";
                                        //ImprestLines."Item Budget Gl":=Items."Item G/L Budget Account";
                                    end else//end
                                        ImprestLines."Account Type" := ImprestLines."Account Type"::"G/L Account";
                                    ImprestLines."Account No." := PurchaseReqline."No.";
                                    ImprestLines."Account Name" := PurchaseReqline.Name;
                                    ImprestLines.Description := PurchaseReqline.Description;
                                    ImprestLines."Posting Date" := Today;
                                    ImprestLines."Net Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines.Quantity := PurchaseReqline.Quantity;
                                    ImprestLines."Unit Amount" := PurchaseReqline."Unit Cost";
                                    ImprestLines."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                    ImprestLines."Employee No" := PurchaseRequisitionHeader."Employee No.";
                                    ImprestLines."Gross Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines."Gross Amount(LCY)" := PurchaseReqline."Total Cost(LCY)";
                                    if ImprestLines.Insert(true) then begin
                                        ImprestLines."Employee No" := Rec."Employee No.";
                                        ImprestLines."Employee Name" := Rec."Employee Name";
                                        ImprestLines.Modify();
                                    end;
                                until PurchaseReqline.Next = 0;
                            end;
                            //update the requisition to closed
                            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Closed;
                            PurchaseRequisitionHeader.Modify;

                            Message('Imprest Requisition %1 created successfully', ImprestRec."No.");
                            ImprestRec1.Reset;
                            ImprestRec1.SetRange("No.", ImprestRec."No.");
                            PAGE.Run(50023, ImprestRec1);
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action("Create Petty Cash Requisition")
            {
                Image = CreateReminders;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if DIALOG.Confirm('Are you sure you want to create a Petty Cash Requisition from Purchase Requisition No  %1', true, Rec."No.") then begin
                        PurchaseRequisitionHeader.Reset;
                        PurchaseRequisitionHeader.SetRange("No.", Rec."No.");
                        if PurchaseRequisitionHeader.FindSet then begin
                            FundsSetup.Reset;
                            FundsSetup.Get;

                            ImprestRec.Init;
                            ImprestRec."No." := NoSeriesMgt.GetNextNo(FundsSetup."Petty Cash Nos", 0D, true);
                            ImprestRec."No. Series" := FundsSetup."Petty Cash Nos";
                            ImprestRec."Document Type" := ImprestRec."Document Type"::"Petty Cash";
                            ImprestRec."Posting Date" := Today;
                            ImprestRec."Date From" := Today;
                            ImprestRec."Date To" := Today;
                            ImprestRec."User ID" := UserId;
                            ImprestRec."Document Date" := Today;
                            ImprestRec.Type := ImprestRec.Type::"Petty Cash";

                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", UserId);
                            if EmployeeRec.FindSet then begin
                                ImprestRec."Employee No." := EmployeeRec."No.";
                                ImprestRec."Employee Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                                ImprestRec."Employee Posting Group" := EmployeeRec."Imprest Posting Group";
                                ImprestRec.position := EmployeeRec.Position;
                                ImprestRec."Position Title" := EmployeeRec."Position Title";
                                ImprestRec."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                                ImprestRec."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                                ImprestRec."Phone No." := EmployeeRec."Phone No.";
                                ImprestRec."HR Job Grade" := EmployeeRec."Employee Grade";
                                ImprestRec."Low Value" := true;
                            end;
                            ImprestRec.Description := PurchaseRequisitionHeader.Description;
                            ImprestRec."Purchase Requisition No" := PurchaseRequisitionHeader."No.";
                            if ImprestRec.Insert(true) then begin
                                ImprestRec."User ID" := PurchaseRequisitionHeader."User ID";
                                ImprestRec."Employee No." := PurchaseRequisitionHeader."Employee No.";
                                ImprestRec.Validate("Employee No.");
                                ImprestRec.Modify();
                            end;

                            //lines
                            PurchaseReqline.Reset;
                            PurchaseReqline.SetRange("Document No.", PurchaseRequisitionHeader."No.");
                            if PurchaseReqline.FindSet then begin
                                repeat
                                    ImprestLines.Init;
                                    ImprestLines."Document No." := ImprestRec."No.";
                                    ImprestLines."Line No." := PurchaseReqline."Line No.";
                                    ImprestLines."Document Type" := ImprestLines."Document Type"::Imprest;
                                    ImprestLines."Imprest Code" := PurchaseReqline."Requisition Code";
                                    ImprestLines."Imprest Code Description" := PurchaseReqline.Name;
                                    ImprestLines."Account Type" := ImprestLines."Account Type"::"G/L Account";
                                    ImprestLines."Account No." := PurchaseReqline."No.";
                                    ImprestLines."Account Name" := PurchaseReqline.Name;
                                    ImprestLines.Description := PurchaseReqline.Description;
                                    ImprestLines."Posting Date" := Today;
                                    ImprestLines."Net Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines.Quantity := PurchaseReqline.Quantity;
                                    ImprestLines."Unit Amount" := PurchaseReqline."Unit Cost";
                                    ImprestLines."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                    ImprestLines."Employee No" := PurchaseRequisitionHeader."Employee No.";
                                    ImprestLines."Gross Amount" := PurchaseReqline."Total Cost";
                                    ImprestLines."Gross Amount(LCY)" := PurchaseReqline."Total Cost(LCY)";
                                    if ImprestLines.Insert(true) then begin
                                        ImprestLines."Employee No" := Rec."Employee No.";
                                        ImprestLines."Employee Name" := Rec."Employee Name";
                                        ImprestLines.Modify();

                                    end;
                                until PurchaseReqline.Next = 0;
                            end;
                            //update the requisition to closed
                            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Closed;
                            PurchaseRequisitionHeader.Modify;

                            Message('Petty Cash Requisition %1 created successfully', ImprestRec."No.");
                            ImprestRec1.Reset;
                            ImprestRec1.SetRange("No.", ImprestRec."No.");
                            PAGE.Run(50130, ImprestRec1);
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action("Create Purchase Requisition")
            {
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    if DIALOG.Confirm('Are you sure you want to create an Purchase Requisition from Requisition No  %1', true, Rec."No.") then begin

                        PurchaseRequisitionHeader.Reset;
                        PurchaseRequisitionHeader.SetRange("No.", Rec."No.");
                        if PurchaseRequisitionHeader.FindSet then begin
                            PurchasesPayablesSetup.Reset;
                            PurchasesPayablesSetup.Get;

                            PurchaseReqRec.Init;
                            PurchaseReqRec."No." := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Requisition Nos.", 0D, true);
                            PurchaseReqRec."No. Series" := PurchasesPayablesSetup."Requisition Nos.";
                            PurchaseReqRec."Document Date" := Today;
                            PurchaseReqRec."User ID" := UserId;
                            PurchaseReqRec."Requested Receipt Date" := Today;
                            PurchaseReqRec."Purchase Requisition" := true;
                            PurchaseReqRec.Budget := PurchaseRequisitionHeader.Budget;
                            PurchaseReqRec.Description := PurchaseRequisitionHeader.Description;
                            PurchaseReqRec."Reference Document No." := PurchaseRequisitionHeader."No.";
                            PurchaseReqRec."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                            PurchaseReqRec."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                            PurchaseReqRec.Status := PurchaseRequisitionHeader.Status::Open;
                            PurchaseReqRec.Amount := PurchaseRequisitionHeader.Amount;
                            PurchaseReqRec."Amount(LCY)" := PurchaseRequisitionHeader."Amount(LCY)";
                            PurchaseReqRec.Insert(true);

                            //lines
                            PurchaseReqline.Reset;
                            PurchaseReqline.SetRange("Document No.", PurchaseRequisitionHeader."No.");
                            if PurchaseReqline.FindSet then begin
                                repeat
                                    PurchLine.Init;
                                    PurchLine."Document No." := PurchaseReqRec."No.";
                                    PurchLine."Line No." := PurchaseReqline."Line No.";
                                    PurchLine.Type := PurchaseReqline.Type;
                                    PurchLine.Validate(Type);
                                    PurchLine."No." := PurchaseReqline."No.";
                                    PurchLine.Validate("No.");
                                    PurchLine.Quantity := PurchaseReqline.Quantity;
                                    PurchLine.Validate(Quantity);
                                    PurchLine.Description := PurchaseReqline.Description;
                                    PurchLine.Validate(Description);
                                    PurchLine."Document Date" := Today;
                                    PurchLine.Name := PurchaseReqline.Name;
                                    PurchLine.Validate(Name);
                                    PurchLine."Requisition Type" := PurchaseReqline."Requisition Type";
                                    PurchLine."Unit of Measure" := PurchaseReqline."Unit of Measure";
                                    PurchLine.Budget := PurchaseReqline.Budget;
                                    PurchLine."Total Cost" := PurchaseReqline."Total Cost";

                                    PurchLine."Unit Cost" := PurchaseReqline."Unit Cost";
                                    PurchLine."Global Dimension 1 Code" := PurchaseRequisitionHeader."Global Dimension 1 Code";
                                    PurchLine."Global Dimension 2 Code" := PurchaseRequisitionHeader."Global Dimension 2 Code";
                                    PurchLine."Total Cost" := PurchaseReqline."Total Cost";
                                    PurchLine."Total Cost(LCY)" := PurchaseReqline."Total Cost(LCY)";
                                    PurchLine.Insert(true);
                                until PurchaseReqline.Next = 0;
                            end;

                            PurchaseReqline.Reset;
                            PurchaseReqline.SetRange("Document No.", PurchaseReqRec."No.");
                            if PurchaseReqline.FindSet then begin
                                repeat

                                until PurchaseReqline.Next = 0;
                            end;
                            //update the requisition to closed
                            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Closed;
                            PurchaseRequisitionHeader.Modify;

                            Message('Purchase Requisition No. %1 created successfully', PurchaseReqRec."No.");
                            PurchaseReqRec1.Reset;
                            PurchaseReqRec1.SetRange("No.", PurchaseReqRec."No.");
                            PAGE.Run(50411, PurchaseReqRec1);
                            CurrPage.Close();
                            //change Nos
                            //      PurchasesPayablesSetup.GET();
                            //      PurchaseRequisitionHeader.no := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Requisition Nos.",TODAY,TRUE);
                            //      PurchaseRequisitionHeader."No. Series" := PurchasesPayablesSetup."Requisition Nos.";
                            //      PurchaseRequisitionHeader.MODIFY;
                        end;
                    end;
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
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
                    RunPageLink = "Document No." = FIELD("No.");
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesDocumentPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Requisition Header","No.");
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Description = 'NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Enabled = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.CalcFields(Amount, "Amount(LCY)");
                        Rec.TestField(Amount);
                        Rec.TestField("Amount(LCY)");
                        Rec.TestField(Description);
                        //ProcurementManagement.CheckPurchaseRequisitionMandatoryFields(Rec);
                        //Commitment.CheckBudgetPurchaseRequisition(Rec); //to be unncommended later justo 01/02/2024
                        //Message(Text004);
                        // if ApprovalsMgmt.CheckPurchaseRequisitionApprovalsWorkflowEnabled(Rec) then
                        CustomApprovals.OnSendPurchaseRequisitionForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    begin
                        //Commitment.CancelBudgetCommitmentPurchaseRequisition(Rec); //to be uncommended later justo 01/02/2024
                        // ApprovalsMgmt.OnCancelPurchaseRequisitionApprovalRequest(Rec);

                        CustomApprovals.OnCancelPurchaseRequisitionApprovalRequest(Rec);
                        // WorkflowWebhookMgt.FindAndCancel(RecordId);

                        //CanCancelApprovalForRecord OR CanCancelApprovalForFlow
                    end;
                }

                group("Budgetting")
                {
                    Caption = 'Budget Committment';


                    action(CommittingBudget)
                    {
                        Caption = 'Commit Budget';
                        Promoted = true;
                        Visible = true;
                        PromotedCategory = Process;
                        Image = CostBudget;
                        trigger OnAction()
                        begin
                            IF UserSetup.GET(USERID) THEN BEGIN
                                IF NOT UserSetup.CommitBudget THEN
                                    Error(Text010);
                                if Confirm('Are you sure you want to Commit/Vote this document') then
                                    Commitment.CommitBudgetPurchaseRequisition(Rec);
                                Message(Text009);
                            end;
                        end;
                    }
                    action("Cancel Budget Commitment")
                    {
                        Image = CancelAllLines;
                        Promoted = true;
                        Caption = 'Decommit/Unvote Budget';
                        PromotedIsBig = true;
                        Visible = true;

                        trigger OnAction()
                        begin
                            if not Confirm(Text005, true) then
                                Error(Text006);
                            Commitment.CancelBudgetCommitmentPurchaseRequisition(Rec);
                            Message('Decommited successfully');
                        end;
                    }
                    action("Budget Committment Lines")
                    {
                        Image = BinJournal;
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedIsBig = true;
                        RunObject = Page "Budget Committment Lines";
                        RunPageLink = "Document No." = FIELD("No.");
                    }
                    action("Cancel Transaction")
                    {

                        trigger OnAction()
                        begin
                            if Rec.Status = Rec.Status::Open then
                                Rec.Status := Rec.Status::Cancelled;
                        end;
                    }
                    action("Check Budget Availability")
                    {
                        Image = Balance;
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedIsBig = true;
                        Visible = false;

                        trigger OnAction()
                        begin
                            /*BudgetarySetup.GET;
                            IF NOT BudgetarySetup.Mandatory THEN
                               EXIT;

                            IF Status=Status::Approved THEN
                              ERROR(Text001);

                            IF CheckIfSomeLinesCommitted("No.")  THEN BEGIN
                             IF NOT CONFIRM(Text002,TRUE) THEN
                               ERROR(Text003);
                              BudgetCommitment.RESET;
                              BudgetCommitment.SETRANGE(BudgetCommitment."Document No.","No.");
                              IF BudgetCommitment.FINDSET THEN
                              BudgetCommitment.DELETEALL;
                            END;
                            */
                            Commitment.DecommitBudgetPurchaseReq(Rec);
                            Message(Text004);

                        end;

                    }
                    group("Report")
                    {
                        Caption = 'Report';
                        action("Print Requisition")
                        {
                            Caption = 'Print Requisition';
                            Image = Print;
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            ToolTip = 'Prepare to print the document. A report request window where you can specify what to include on the print-out.';

                            trigger OnAction()
                            begin
                                PurchaseRequisitionHeader.Reset;
                                PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."No.", Rec."No.");
                                if PurchaseRequisitionHeader.FindFirst then begin
                                    REPORT.RunModal(REPORT::"Requisition Report", true, false, PurchaseRequisitionHeader);
                                end;
                            end;
                        }
                    }
                    group(IncomingDocument)
                    {
                        Caption = 'Incoming Document';
                        Image = Documents;
                        action(AttachedDoc)
                        {
                            ApplicationArea = Suite;
                            Caption = 'View  Attached Document';
                            Image = ViewOrder;
                            Promoted = true;
                            PromotedCategory = Process;
                            ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                            trigger OnAction()
                            var
                                IncomingDocument: Record "Incoming Document";
                                PortalSetup: Record "Portal Setup";
                            begin
                                //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                                PortalSetup.Get;
                                HyperLink(PortalSetup."Server File Path" + Rec."Document Name");
                            end;
                        }
                        action(IncomingDocCard)
                        {
                            ApplicationArea = Suite;
                            Caption = 'View Incoming Document';
                            Enabled = HasIncomingDocument;
                            Image = ViewOrder;
                            ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                            trigger OnAction()
                            var
                                IncomingDocument: Record "Incoming Document";
                            begin
                                IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                            end;
                        }
                        action(SelectIncomingDoc)
                        {
                            AccessByPermission = TableData "Incoming Document" = R;
                            ApplicationArea = Suite;
                            Caption = 'Select Incoming Document';
                            Image = SelectLineToApply;
                            ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                            trigger OnAction()
                            var
                                IncomingDocument: Record "Incoming Document";
                            begin
                                Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                            end;
                        }
                        action(IncomingDocAttachFile)
                        {
                            ApplicationArea = Suite;
                            Caption = 'Create Incoming Document from File';
                            Ellipsis = true;
                            Enabled = CreateIncomingDocumentEnabled;
                            Image = Attach;
                            ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                            trigger OnAction()
                            var
                                IncomingDocumentAttachment: Record "Incoming Document Attachment";
                            begin
                                IncomingDocumentAttachment.NewAttachmentFromPurchaseRequisitionDocument(Rec);
                            end;
                        }
                        action(RemoveIncomingDoc)
                        {
                            ApplicationArea = Suite;
                            Caption = 'Remove Incoming Document';
                            Enabled = HasIncomingDocument;
                            Image = RemoveLine;
                            ToolTip = 'Remove any incoming document records and file attachments.';

                            trigger OnAction()
                            var
                                IncomingDocument: Record "Incoming Document";
                            begin
                                if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                                    IncomingDocument.RemoveLinkToRelatedRecord;
                                Rec."Incoming Document Entry No." := 0;
                                Rec.Modify(true);
                            end;
                        }
                    }
                    group(Approval)
                    {
                        Caption = 'Approval';
                        action(Approve)
                        {
                            ApplicationArea = Suite;
                            Caption = 'Approve';
                            Image = Approve;
                            Promoted = true;
                            PromotedCategory = Category4;
                            PromotedIsBig = true;
                            ToolTip = 'Approve the requested changes.';
                            Visible = OpenApprovalEntriesExistForCurrUser;

                            trigger OnAction()
                            var
                                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            begin
                                ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                            end;
                        }
                        action(Reject)
                        {
                            ApplicationArea = Suite;
                            Caption = 'Reject';
                            Image = Reject;
                            Promoted = true;
                            PromotedCategory = Category4;
                            PromotedIsBig = true;
                            ToolTip = 'Reject the requested changes.';
                            Visible = OpenApprovalEntriesExistForCurrUser;

                            trigger OnAction()
                            var
                                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                            end;
                        }
                    }
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*PurchaseRequisitionHeader.RESET;
        PurchaseRequisitionHeader.SETRANGE("User ID",USERID);
        PurchaseRequisitionHeader.SETRANGE(Status,PurchaseRequisitionHeader.Status::Open);
        IF PurchaseRequisitionHeader.FINDFIRST THEN BEGIN
          ERROR(Txt_002);
        END;
        */

    end;

    var
        Txt_002: Label 'There is an open purchase requisition under your name, use it before you create a new one';
        Txt_003: Label 'Reopen Purchase Requisition No.:%1. All approval requests for this document will be cancelled. Continue?';
        Text001: Label 'This document has already been released. This functionality is available for open documents only';
        Text002: Label 'Some or All the Lines Are already Committed do you want to continue';
        Text003: Label 'Budget Availability Check and Commitment Aborted';
        Text004: Label 'Budget Availability Checking Complete';
        Text005: Label 'Are you sure you want to Cancel All Commitments Done for this document';
        Text006: Label 'Budget Availability Check and Commitment Aborted';
        Text007: Label 'Commitments Cancelled Successfully for Doc. No %1';
        Text008: Label 'Check Budget Availability Before Sending for Approval.';
        Text009: Label 'Budget Committed Succesffuly';
        Text010: Label 'Oops!You do not have permissions to Commit/Uncommit Budget  Kindly Request Permission from the ICT';
        Error0001: Label 'Document is under Approval Process, Cancel Approval instead!';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomApprovals: Codeunit "Custom Workflow Mgmt";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementApprovalWorkflow: Codeunit "Procurement Approval Manager";
        PurchaseRequisitionHeader: Record "Purchase Requisitions";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Payment,Receipt,Imprest,"Imprest Surrender","Funds Refund","Purchase Requisition";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        ShowWorkflowStatus: Boolean;
        IsEditable: Boolean;
        BudgetarySetup: Record "Budget Control Setup";
        BudgetCommitment: Record "Budget Committment";
        Commitment: Codeunit "Procurement Management";
        SomeLinesCommitted: Boolean;
        PurchLine: Record "Purchase Requisition Line";
        PurchaseReqRec: Record "Purchase Requisitions";
        PurchaseReqLines: Record "Purchase Requisition Line";
        PurchaseReqline: Record "Purchase Requisition Line";
        EmployeeRec: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FundsSetup: Record "Funds General Setup";
        PurchaseReqRec1: Record "Purchase Requisitions";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ImprestRec: Record "Imprest Header";
        ImprestHeader: Record "Imprest Header";
        ImprestLines: Record "Imprest Line";
        ImprestRec1: Record "Imprest Header";
        IncomingDocumentAttachment: Record "Incoming Document Attachment";
        Items: Record Item;
        UserSetup: Record "User Setup";


    procedure CheckIfSomeLinesCommitted(PurchReqNo: Code[20]) SomeLinesCommitted: Boolean
    begin
        SomeLinesCommitted := false;
        PurchLine.Reset;
        PurchLine.SetRange("Document No.", PurchReqNo);
        if PurchLine.FindSet then begin
            repeat
                if PurchLine.Committed = true then
                    SomeLinesCommitted := true;
            until PurchLine.Next = 0;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}

