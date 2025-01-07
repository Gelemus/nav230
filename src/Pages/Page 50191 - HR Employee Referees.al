page 50191 "HR Employee Referees"
{
    Caption = 'HR Employee Referees';
    PageType = List;
    SourceTable = "HR Employee Referee Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field(Surname; Rec.Surname)
                {
                }
                field(Firstname; Rec.Firstname)
                {
                }
                field(Middlename; Rec.Middlename)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Personal E-Mail Address"; Rec."Personal E-Mail Address")
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("City/Town"; Rec."City/Town")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field("Referee Category"; Rec."Referee Category")
                {
                }
                field(Verified; Rec.Verified)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Verify Referee")
            {
                Caption = 'Verify Employee''s Referee';
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Txt082) = false then exit;
                    Rec.Verified := true;
                    Rec.Modify;
                    Message(Txt083);
                end;
            }
        }
    }

    var
        Txt082: Label 'Are you sure the Referee has been verified?';
        Txt083: Label 'Referee has been verified';
}

