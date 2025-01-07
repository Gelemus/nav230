page 50330 "Service interval  List"
{
    PageType = List;
    SourceTable = "Service Interval";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Service Interval Code"; Rec."Service Interval Code")
                {
                }
                field("Service Interval Description"; Rec."Service Interval Description")
                {
                }
                field("Service Interval Type"; Rec."Service Interval Type")
                {
                }
                field("Service Period"; Rec."Service Period")
                {
                }
                field("Service Mileage"; Rec."Service Mileage")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

