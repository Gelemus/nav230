page 50252 "Training Needs App. Line"
{
    PageType = ListPart;
    SourceTable = "HR Training Needs Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Visible = false;
                }
                field("Development Needs"; Rec."Development Needs")
                {
                }
                field("Intervention Required"; Rec."Intervention Required")
                {
                }
                field(Objectives; Rec.Objectives)
                {
                }
                field("Proposed Training Provider"; Rec."Proposed Training Provider")
                {
                    //OptionCaption = ' ,Quater 1,Quater 2,Quater 3,Quater 4';
                }
                field("Training Location & Venue"; Rec."Training Location & Venue")
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field("Proposed Period"; Rec."Proposed Period")
                {
                }
                field("Training Scheduled Date"; Rec."Training Scheduled Date")
                {
                }
                field("Training Scheduled Date To"; Rec."Training Scheduled Date To")
                {
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = true;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

