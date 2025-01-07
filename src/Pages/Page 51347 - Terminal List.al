page 51347 "Terminal List"
{
    CardPageID = "Terminal Card";
    PageType = List;
    SourceTable = "Attendance Terminal";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Terminal No"; Rec."Terminal No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Domain Name"; Rec."Domain Name")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Terminal Tcp Ip"; Rec."Terminal Tcp Ip")
                {
                }
                field("Terminal Serial Number"; Rec."Terminal Serial Number")
                {
                }
                field("Terminal Device Name"; Rec."Terminal Device Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

