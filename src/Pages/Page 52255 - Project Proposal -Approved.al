page 52255 "Project Proposal -Approved"
{
    CardPageID = "Project Proposal Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = FILTER(Released),
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
                    Caption = 'Designer No';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Designer Name';
                }
                field("External Designer Name"; Rec."External Designer Name")
                {
                }
                field("Design External No"; Rec."Design External No")
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

