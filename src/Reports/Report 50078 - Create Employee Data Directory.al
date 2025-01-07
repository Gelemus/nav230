report 50078 "Create Employee Data Directory"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee;Employee)
        {

            trigger OnAfterGetRecord()
            begin
                ProgressWindow.Update(1,Employee."No.");
                //EmployeeManagement.CreateEmployeeDirectory(Employee."No.");
            end;

            trigger OnPostDataItem()
            begin
                //ProgressWindow.CLOSE;
                //MESSAGE('Émployee Directories created successfully');
            end;

            trigger OnPreDataItem()
            begin
                ProgressWindow.Open('Creating Directory for Employee No. #1#######');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProgressWindow: Dialog;
}

