page 51346 "Attendance List"
{
    PageType = List;
    SourceTable = "Attendance Punches";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field(Names; Names)
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Visible = false;
                }
                field(Time; Time)
                {
                }
                field("Work Status"; Rec."Work Status")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Terminal No"; Rec."Terminal No")
                {
                }
                field("Terminal Name"; Rec."Terminal Name")
                {
                }
                field("Terminal Location"; Rec."Terminal Location")
                {
                }
                field("Attendance Status"; Rec."Attendance Status")
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
        Employee.Reset;
        Employee.SetRange(Employee."No.", Rec."Employee No");
        if Employee.FindSet then begin
            Names := Employee."Full Name";
        end;
    end;

    var
        Names: Text;
        Employee: Record Employee;
}

