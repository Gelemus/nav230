pageextension 60330 pageextension60330 extends "Employee List"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on ""Job Title"(Control 12)".


        //Unsupported feature: Property Deletion (Visible) on "FullName(Control 17)".

        addafter("Last Name")
        {
            field("Payroll Code"; Rec."Payroll Code")
            {
            }
        }
    }
}

