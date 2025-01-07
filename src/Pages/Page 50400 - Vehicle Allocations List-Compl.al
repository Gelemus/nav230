page 50400 "Vehicle Allocations List-Compl"
{
    Caption = 'Vehicle Allocations List-Completed';
    CardPageID = "Vehicel Allocation Card";
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Completed),
                            "Document Type" = CONST(" "));

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
                field("Reason for Travel"; Rec."Reason for Travel")
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
    }

    trigger OnOpenPage()
    begin
        ///filter for form
        //SETFILTER("Trip Planned End Date",'>=%1',TODAY);
    end;
}

