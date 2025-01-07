pageextension 60269 pageextension60269 extends "Sales Quote"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Quote"(Page 41)".

    layout
    {
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Caption = 'MIT';
        }

        //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 1 Code"(Control 80)".


        //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 1 Code"(Control 80)".

        // modify("Shortcut Dimension 2 Code")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 2 Code"(Control 84)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 2 Code"(Control 84)".


        //     //Unsupported feature: Property Modification (ImplicitType) on ""Shortcut Dimension 2 Code"(Control 84)".

        //     Visible = false;
        // }
        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 80)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Shortcut Dimension 1 Code"(Control 80)".

        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 84)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Shortcut Dimension 2 Code"(Control 84)".

        addafter("Due Date")
        {
            field("Account No."; Rec."Account No.")
            {
            }
        }
        addafter("Salesperson Code")
        {
            field("Connection No."; Rec."Connection No.")
            {
                Visible = false;
            }
            field("Chainage No"; Rec."Chainage No")
            {
                Visible = false;
            }
        }
        // addafter("Shortcut Dimension 2 Code")
        // {
        //     field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
        //     {
        //     }
        //     field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
        //     {
        //         ApplicationArea = Dimensions;
        //         ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

        //         trigger OnValidate()
        //         begin
        //             CurrPage.Update
        //         end;
        //     }
        // }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
            }
            field("Point of Use"; Rec."Point of Use")
            {
            }
        }
        addafter("Assigned User ID")
        {
            field(Template; Rec.Template)
            {
            }
            field(Submitted; Rec.Submitted)
            {
                Visible = false;
            }
        }
        moveafter("Due Date"; "Salesperson Code")
        moveafter("Salesperson Code"; "Shortcut Dimension 2 Code")
        // moveafter("Existing Connections";"Shortcut Dimension 1 Code")
    }
    actions
    {


        //Unsupported feature: Code Modification on "Print(Action 69).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckSalesCheckAllLinesHaveQuantityAssigned;
        DocPrint.PrintSalesHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //CheckSalesCheckAllLinesHaveQuantityAssigned;
        //DocPrint.PrintSalesHeader(Rec);
        SalessHeader.Reset;
        SalessHeader.SetRange("No.","No.");
        if SalessHeader.FindSet then begin
          REPORT.RunModal(REPORT::Quotation,true,false,SalessHeader);
        end;
        */
        //end;
        addafter(MakeInvoice)
        {
            action(MakeStoreRequisition)
            {
                Caption = 'Make Store Requisition';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //added on 29/07/2020 to create store requisition from sales quote
                    if Rec."Requisition Created" = false then begin
                        SalessHeader.Reset;
                        SalessHeader.SetRange("No.", Rec."No.");
                        if SalessHeader.FindSet then begin
                            InventorySetup.Get();

                            StoreHeader.Init;
                            StoreHeader."No." := NoSeriesManagement.GetNextNo(InventorySetup."Stores Requisition Nos.", Today, true);
                            StoreHeader."Document Date" := Today;
                            StoreHeader."Posting Date" := Today;
                            StoreHeader."Required Date" := Today;
                            StoreHeader.Description := 'A/C No: ' + Rec."Account No." + ' ' + Rec."Sell-to Customer Name";
                            StoreHeader.Template := Rec.Template;
                            StoreHeader."No. Series" := InventorySetup."Stores Requisition Nos.";

                            employeeRec.Reset;
                            employeeRec.SetRange("User ID", UserId);
                            if employeeRec.FindSet then begin
                                StoreHeader."Global Dimension 1 Code" := employeeRec."Global Dimension 1 Code";
                                StoreHeader."Shortcut Dimension 3 Code" := employeeRec."Shortcut Dimension 3 Code";
                                StoreHeader."User ID" := UserId;
                                StoreHeader."Employee Name" := employeeRec."First Name" + ' ' + employeeRec."Middle Name" + ' ' + employeeRec."Last Name";
                                StoreHeader."Employee No." := employeeRec."No.";
                            end;
                            StoreHeader.Insert(true);

                            //lines
                            salesLine.Reset;
                            salesLine.SetRange("Document No.", SalessHeader."No.");
                            if salesLine.FindSet then begin
                                repeat
                                    StoreRequisitionLine.Init;
                                    StoreRequisitionLine."Line No." := StoreRequisitionLine."Line No." + 1;
                                    StoreRequisitionLine."Document No." := StoreHeader."No.";
                                    StoreRequisitionLine.Type := salesLine.Type::Item;
                                    StoreRequisitionLine."Item No." := salesLine."No.";
                                    StoreRequisitionLine.Validate(StoreRequisitionLine."Item No.");
                                    StoreRequisitionLine.Description := salesLine.Description;
                                    StoreRequisitionLine."Unit of Measure Code" := salesLine."Unit of Measure Code";
                                    StoreRequisitionLine."Unit Cost" := Round(salesLine."Unit Price", 1, '>');
                                    StoreRequisitionLine."Location Code" := salesLine."Location Code";
                                    StoreRequisitionLine.Validate(StoreRequisitionLine."Location Code");
                                    StoreRequisitionLine."Shortcut Dimension 3 Code" := StoreHeader."Shortcut Dimension 3 Code";
                                    StoreRequisitionLine."Global Dimension 1 Code" := StoreHeader."Global Dimension 1 Code";
                                    // StoreRequisitionLine."Unit Price" := ROUND(Items."Unit Cost",1,'>');
                                    // StoreRequisitionLine.VALIDATE(SalesLine."Unit Price");
                                    StoreRequisitionLine.Quantity := salesLine.Quantity;
                                    //StoreRequisitionLine.VALIDATE(StoreRequisitionLine.Quantity);
                                    StoreRequisitionLine."Line Amount" := StoreRequisitionLine.Quantity * StoreRequisitionLine."Unit Cost";
                                    //SalesLine.VALIDATE(SalesLine."Line Amount" );
                                    StoreRequisitionLine.Insert(true);
                                until salesLine.Next = 0;
                            end;

                            Rec."Created By" := UserId;
                            Rec."Date Created" := Today;
                            Rec."Time Created" := Time;
                            Rec."Requisition Created" := true;
                            Rec.Modify;
                            Message('The Material Requisition no %1 has been created successfully', StoreHeader."No.");
                        end;
                    end else
                        Error('The requisition already created');
                end;
            }
        }
        addafter(CancelApprovalRequest)
        {
            action(SUBMIT)
            {
                Caption = 'SUBMIT';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //updated 08/08/2020
                    if Confirm('Are you sure you want to submit %1?', false, Rec."No.") then begin
                        Rec."Submitted BY" := UserId;
                        Rec."Date Submitted" := Today;
                        Rec."Time Submitted" := Time;
                        Rec.Submitted := true;
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify
                    end;
                end;
            }
        }
    }

    var
        SalessHeader: Record "Sales Header";
        StoreRequisitionLine: Record "Store Requisition Line";
        salesLine: Record "Sales Line";
        Items: Record Item;
        StoreHeader: Record "Store Requisition Header";
        employeeRec: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeStatisticsAction(PROCEDURE 7)".

}

