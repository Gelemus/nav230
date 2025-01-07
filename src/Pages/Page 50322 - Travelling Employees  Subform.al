page 50322 "Travelling Employees  Subform"
{
    PageType = ListPart;
    SourceTable = "Travelling Employee";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    NotBlank = true;
                }
            }
        }
    }

    actions
    {
    }
}

