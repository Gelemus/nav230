page 50355 "Appointment List"
{
    CardPageID = "Commitee Creation Card";
    Editable = false;
    PageType = List;
    SourceTable = "Tender Commitee Appointment";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                }
                field("Committee ID"; Rec."Committee ID")
                {
                }
                field("Committee Name"; Rec."Committee Name")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Appointment No"; Rec."Appointment No")
                {
                }
                field("No. Series"; Rec."No. Series")
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
        //    group(ActionGroup)
        //     {
        //         action("Commitee ")
        //         {
        //             RunObject = Page Page51511515;
        //         }
        //     }
    }
}

