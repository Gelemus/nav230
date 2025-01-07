page 50257 "HR Approved Training Line"
{
    PageType = ListPart;
    SourceTable = "Approved Training Needs Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Official Mail"; Rec."Official Mail")
                {
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
                field("Approved By Management"; Rec."Approved By Management")
                {
                }
                field("Training Attended"; Rec."Training Attended")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

