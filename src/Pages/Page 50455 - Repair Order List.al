page 50455 "Repair Order List"
{
    CardPageID = "Repair Order Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Open),
                            "Document Type" = CONST("Repair Order"),
                            "Repair Order" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = true;
                    NotBlank = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Supplier No"; Rec."Supplier No")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                }
                field("Supplier Address"; Rec."Supplier Address")
                {
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                }
                field("Job No"; Rec."Job No")
                {
                }
                field("Motor Vehicle/Motor Cycle"; Rec."Motor Vehicle/Motor Cycle")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Repair Order" := true;
        Rec."Document Type" := Rec."Document Type"::"Repair Order";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Repair Order" := true;
        Rec."Document Type" := Rec."Document Type"::"Repair Order";
    end;

    trigger OnOpenPage()
    begin
        ///filter for form
        //SETFILTER("Trip Planned End Date",'>=%1',TODAY);
        Rec.SetFilter("Request ID", UserId);
    end;
}

