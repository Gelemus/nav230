page 52237 "Approved Projects"
{
    CardPageID = "Project Request Card -Approved";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Released),
                            "Document Type" = CONST("Project Request"));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Request No."; Rec."Request No.")
                {
                    Visible = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Project Cost"; Rec."Project Cost")
                {
                }
                field("Project Status"; Rec."Project Status")
                {
                }
                field("P.Nature of Request"; Rec."P.Nature of Request")
                {
                    Caption = 'Nature of Request';
                }
                field("P.Request Reason"; Rec."P.Request Reason")
                {
                    Caption = 'Request Reason';
                }
                field("Defects Liability Period"; Rec."Defects Liability Period")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
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

