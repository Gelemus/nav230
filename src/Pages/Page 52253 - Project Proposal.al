page 52253 "Project Proposal"
{
    CardPageID = "Project Proposal Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"),
                            "Document Type" = CONST(Proposal));

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
                    Caption = 'Created by';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = ' Employee Name';
                }
                field("Proposal Document Name"; Rec."Proposal Document Name")
                {
                }
                field("Design Description"; Rec."Design Description")
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

