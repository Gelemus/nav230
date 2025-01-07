page 50323 "Vehicle Allocations List"
{
    CardPageID = "Vehicel Allocation Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Released),
                            "Document Type" = CONST(" "),
                            "Repair Order" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Request No."; Rec."Request No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Destination; Rec.Destination)
                {
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                }
                field("Travel Details"; Rec."Travel Details")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("CANCEL REQUEST")
            {
                Image = Allocate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*IF Status = Status THEN
                      Status := Status::Open;
                      */

                end;
            }
            action("ALLOCATE ")
            {
                Image = Allocate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Released then
                        Rec.Allocated := true;
                    //Status := Status::"Pending Prepayment";
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ///filter for form
        //SETFILTER("Trip Planned End Date",'>=%1',TODAY);
    end;
}

