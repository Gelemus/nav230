page 50720 "Driver List"
{
    CardPageID = "Staff List Card";
    PageType = List;
    SourceTable = Employee;
    SourceTableView = WHERE(Driver = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                }
                field(Driver; Rec.Driver)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Driver Allocation Status"; Rec."Driver Allocation Status")
                {
                }
                field("Driving Licence No."; Rec."Driving Licence No.")
                {
                }
                field("Class of Driving License"; Rec."Class of Driving License")
                {
                }
            }
        }
    }

    actions
    {
    }
}

