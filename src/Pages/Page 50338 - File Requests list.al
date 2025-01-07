page 50338 "File Requests list"
{
    CardPageID = "File Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "File Request";
    SourceTableView = SORTING(Date);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Request No"; Rec."Request No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Time; Time)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Send Status"; Rec."Send Status")
                {
                }
                field("System Support Email Address"; Rec."System Support Email Address")
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
        Rec.SetRange("Send Status", false);
    end;
}

