page 50228 "Leave Ledger Entries"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'No.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the Document Number.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the Posting Date.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the Entry Type.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the Employee Number.';
                }
                field(Names; Names)
                {
                    Caption = 'Names';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the Leave Type.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the Leave Period.';
                }
                field(Days; Rec.Days)
                {
                    ToolTip = 'Specifies the Days.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the Global Dimension 1 Code.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the User ID.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        EmployeeRec.Reset;
        EmployeeRec.SetRange(EmployeeRec."No.", Rec."Employee No.");
        if EmployeeRec.FindSet then begin
            Names := EmployeeRec."Full Name";
        end;
    end;

    var
        Names: Text;
        EmployeeRec: Record Employee;
}

