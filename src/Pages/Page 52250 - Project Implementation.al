page 52250 "Project Implementation"
{
    CardPageID = "Project Implementation Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"),
                            "Document Type" = CONST("Project Implementation"));

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
                field("Design Date"; Rec."Design Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Project Manager No';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Project Manager Name';
                }
                field("Implementation End Date"; Rec."Implementation End Date")
                {
                }
                field("Implementation Start Date"; Rec."Implementation Start Date")
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
        //SETFILTER("User ID",USERID);
    end;
}

