page 52240 "Feasiblity Study - Submitted"
{
    CardPageID = "Feasibility Study Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Transport Request";
    SourceTableView = WHERE(Status = CONST(Open),
                            "Document Type" = CONST("Feasibility Study"),
                            "Study Submited" = CONST(true));

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
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Proposed Offtake Pressure"; Rec."Proposed Offtake Pressure")
                {
                }
                field("Length of Proposed Line"; Rec."Length of Proposed Line")
                {
                }
                field("Elevation At Required Points"; Rec."Elevation At Required Points")
                {
                }
                field("Description Of Housing"; Rec."Description Of Housing")
                {
                }
                field("Verification Date"; Rec."Verification Date")
                {
                }
                field("Data Collection Date"; Rec."Data Collection Date")
                {
                }
                field("Data Collected By"; Rec."Data Collected By")
                {
                }
                field("Design Submitted by"; Rec."Design Submitted by")
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

