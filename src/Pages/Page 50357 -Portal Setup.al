namespace spaBC.spaBC;

page 50357 "Portal Setups"
{
    ApplicationArea = All;
    Caption = 'Portal Setup';
    PageType = Card;
    SourceTable = "Portal Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Local File Path"; Rec."Local File Path")
                {
                    ToolTip = 'Specifies the value of the Local File Path field.', Comment = '%';
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.', Comment = '%';
                }
                field("Server File Path"; Rec."Server File Path")
                {
                    ToolTip = 'Specifies the value of the Server File Path field.', Comment = '%';
                }
            }
        }
    }
}
