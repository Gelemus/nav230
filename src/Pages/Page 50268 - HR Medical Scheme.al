page 50268 "HR Medical Scheme"
{
    CardPageID = "HR Medical Scheme Card";
    PageType = List;
    SourceTable = "HR Medical Scheme";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Medical Scheme Description"; Rec."Medical Scheme Description")
                {
                    ShowMandatory = true;
                }
                field(Provider; Rec.Provider)
                {
                    ShowMandatory = true;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

