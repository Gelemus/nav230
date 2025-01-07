page 50051 "Funds Account Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control13)
            {
                ShowCaption = false;
                part(Control12;"Funds Account Activities")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Banks)
            {
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
        }
    }
}

