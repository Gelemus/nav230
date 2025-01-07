page 50846 "Returnable Request Line"
{
    PageType = ListPart;
    SourceTable = "Returnable Items";


    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    TableRelation = "Returnable Items";
                }
                field("Item Description "; Rec."Item Description ")
                {

                }
                field("Base unit of Measure"; Rec."Base unit of Measure")
                {
                }
                field("Inventory "; Rec."Inventory ")
                {
                    Editable = false;
                    Visible = false;
                }

            }
        }

    }


}
