page 50822 "Leave Balances List"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Employee Leave Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(Names; Names)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(Section; Rec.Section)
                {
                }
                field("Leave Type"; Rec."Leave Type")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                }
                field("Current Period"; Rec."Current Period")
                {
                    Visible = false;
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
        Employee.SetRange("No.", Rec."Employee No.");
        if Employee.FindSet then begin
            Names := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
        end;
    end;

    trigger OnOpenPage()
    begin
        //CALCFIELDS(Department,Section);
        Employee1.Reset;
        Employee1.SetRange("User ID", UserId);
        if Employee1.FindSet then
            Rec.SetRange(Department, Employee1."Global Dimension 1 Code");
    end;

    var
        Employee: Record Employee;
        Names: Text;
        Employee1: Record Employee;
}

