pageextension 60591 pageextension60591 extends "User Time Registers" 
{
    layout
    {
        addfirst(Control1)
        {
            field(Names;Names)
            {
                ShowCaption = false;
            }
        }
    }

    var
        Names: Text;
        Hours: Decimal;
        Employee: Record Employee;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
        /*
        Employee.Reset;
        Employee.SetRange(Employee."User ID","User ID");
        if Employee.FindSet then begin
          Names := Employee."Full Name";
          Hours := Minutes/60;
          end;
        */
    //end;
}

