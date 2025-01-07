pageextension 60663 pageextension60663 extends "Security Admin Role Center" 
{
    actions
    {
        addafter(Plans)
        {
            action(Employees)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Employees';
                RunObject = Page Employees;
                RunPageMode = View;
                ToolTip = 'Employees';
            }
        }
    }
}

