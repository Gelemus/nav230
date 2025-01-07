page 50359 "Allocated Vehicle List"
{
    CardPageID = "Vehicel Allocation Card";
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Allocated),
                            Allocated = CONST(true));

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
                    if Rec.Status = Rec.Status then
                        Rec.Status := Rec.Status::Open;
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

