page 50710 "Approval Safari Notice List"
{
    CardPageID = "Safari Notice Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Released),
                            "Document Type" = CONST("Safari Notice"),
                            "Repair Order" = FILTER(false),
                            "Safari Notice" = FILTER(true));

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
                    Caption = 'Company Vehicle Allocated';
                }
                field(Taxi; Rec.Taxi)
                {
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Caption = 'No. of Employees';
                }
                field("No. of Non Employees"; Rec."No. of Non Employees")
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
        //SETFILTER("Request ID",USERID);
    end;
}

