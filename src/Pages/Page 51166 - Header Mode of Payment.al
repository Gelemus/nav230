page 51166 "Header Mode of Payment"
{
    PageType = List;
    SourceTable = "Payroll Header";

    layout
    {
        area(content)
        {
            repeater(Control1102754000)
            {
                ShowCaption = false;
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                }
            }
        }
    }

    actions
    {
    }
}

