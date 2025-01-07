page 51349 "Attendance Summary"
{
    PageType = List;
    SourceTable = "Attendance Summary";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Agreed Status"; Rec."Agreed Status")
                {
                }
                field(Clocked; Rec.Clocked)
                {
                }
                field("Clocked In Late"; Rec."Clocked In Late")
                {
                }
                field("Clocket Out Early"; Rec."Clocket Out Early")
                {
                }
                field("Time In String"; Rec."Time In String")
                {
                }
                field("Time out String"; Rec."Time out String")
                {
                }
            }
        }
    }

    actions
    {
    }
}

