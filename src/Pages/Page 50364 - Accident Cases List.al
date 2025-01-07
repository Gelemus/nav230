page 50364 "Accident Cases List"
{
    //CardPageID = 50366;
    PageType = List;
    SourceTable = "User Support Incidences";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Accident Date';
                }
                field("Car No."; Rec."Car No.")
                {
                }
                field("No. of Persons Injured"; Rec."No. of Persons Injured")
                {
                }
                field("Abstract Obtained"; Rec."Abstract Obtained")
                {
                }
                field("Incidence Location"; Rec."Incidence Location")
                {
                    Caption = 'Accident Location';
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    Caption = 'Time';
                }
                field("No. of fatalities"; Rec."No. of fatalities")
                {
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'How accident Happen';
                    MultiLine = true;
                }
                field("Recommended Measures"; Rec."Recommended Measures")
                {
                }
                field("Remarks HR"; Rec."Remarks HR")
                {
                    Caption = 'Comments by HR/Safety Manager';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }
}

