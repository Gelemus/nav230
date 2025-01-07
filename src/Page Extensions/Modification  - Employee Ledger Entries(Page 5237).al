pageextension 60342 pageextension60342 extends "Employee Ledger Entries"
{
    layout
    {
        addafter("Employee No.")
        {
            field(Names; Names)
            {
            }
        }
        // addafter("Entry No.")
        // {
        //     field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
        //     {
        //     }
        // }
    }

    var
        Names: Text;
        EmployeeRec: Record Employee;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
    /*
    EmployeeRec.Reset;
    EmployeeRec.SetRange(EmployeeRec."No.","Employee No.");
    if EmployeeRec.FindSet then begin
      Names:=EmployeeRec."Full Name";
    end;
    */
    //end;
}

