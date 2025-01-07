page 50230 "Leave Type Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the Gender.';
                }
                field(Days; Rec.Days)
                {
                    ToolTip = 'Specifies the Days.';
                }
                field("Leave Year"; Rec."Leave Year")
                {
                    Visible = false;
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                    ToolTip = 'Specifies the Annual Leave.';
                }
                field("Leave Plan Mandatory"; Rec."Leave Plan Mandatory")
                {
                    ToolTip = 'Specifies the Leave Plan.';
                }
                field("Base Calendar"; Rec."Base Calendar")
                {
                    ToolTip = 'Specifies the Leave Base Calendar.';
                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {
                    ToolTip = 'Specifies the Inclusive of Non Working Days.';
                }
            }
            group("Leave Balance")
            {
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the Balance.';
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ToolTip = 'Specifies the Max Carry Forward Days.';
                }
                field("Amount Per Day"; Rec."Amount Per Day")
                {
                    ToolTip = 'Specifies the Amount per Day.';
                }
                field("Allow Negative Days"; Rec."Allow Negative Days")
                {
                }
            }
        }
    }

    actions
    {
    }
}

