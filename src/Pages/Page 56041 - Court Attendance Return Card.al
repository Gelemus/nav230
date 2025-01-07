page 56041 "Court Attendance Return Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Document registration";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = true;
                }
                field("Registration Entry No"; Rec."Registration Entry No")
                {
                }
                field("Before Type"; Rec."Before Type")
                {
                }
                field("Before Name"; Rec."Before Name")
                {
                }
                field("Prosecutor No."; Rec."Prosecutor No.")
                {
                }
                field("Court Attendance Date"; Rec."Court Attendance Date")
                {
                }
                field("Start time"; Rec."Start time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Exhibit produced in court"; Rec."Exhibit produced in court")
                {
                }
                field("Outcome of Proceedings"; Rec."Outcome of Proceedings")
                {
                }
                field("Next Court Date"; Rec."Court Date")
                {
                }
                field("Next Cause of Action"; Rec."Next Cause of Action")
                {
                }
                field("Accused Counsel"; Rec."Accused Counsel")
                {
                }
                field("Intrested Party Counsel"; Rec."Intrested Party Counsel")
                {
                }
                field("Nature Of Application"; Rec."Nature Of Application")
                {
                }
                field("Case ID"; Rec."Case ID")
                {
                }
                field("Case Title"; Rec."Case Title")
                {
                }
                field("Court Rank"; Rec."Court Rank")
                {
                }
                field("Court Station"; Rec."Court Station")
                {
                }
                field("Accused Name"; Rec."Accused Name")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Time Created"; Rec."Time Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control20; Outlook)
            {
            }
            systempart(Control21; Links)
            {
            }
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.RegistrationType := Rec.RegistrationType::Return
    end;
}

