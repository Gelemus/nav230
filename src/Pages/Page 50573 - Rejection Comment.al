page 50573 "Rejection Comment"
{
    PageType = CardPart;

    layout
    {
        area(content)
        {
            field(RejectionReason;RejectionReason)
            {
                Caption = 'Comment';
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if RejectionReason='' then
        Error('Comment must not be empty');
    end;

    var
        RejectionReason: Text;
}

