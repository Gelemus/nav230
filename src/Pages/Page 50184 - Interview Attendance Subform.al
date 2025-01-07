page 50184 "Interview Attendance Subform"
{
    PageType = ListPart;
    SourceTable = "Interview Attendance Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview No."; Rec."Interview No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Closed; Rec.Closed)
                {
                    Visible = false;
                }
                field("Employee Email"; Rec."Employee Email")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;

    trigger OnOpenPage()
    begin
        if Rec.Closed = true then
            CurrPage.Editable(false);
    end;
}

