xmlport 50011 "HR Leave Balance Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Leave Ledger Entries";"HR Leave Ledger Entries")
            {
                XmlName = 'HRLeaveBalanceImport';
                fieldelement(A;"HR Leave Ledger Entries"."Line No.")
                {
                }
                fieldelement(B;"HR Leave Ledger Entries"."Document No.")
                {
                }
                fieldelement(C;"HR Leave Ledger Entries"."Posting Date")
                {
                }
                fieldelement(D;"HR Leave Ledger Entries"."Entry Type")
                {
                }
                fieldelement(E;"HR Leave Ledger Entries"."Employee No.")
                {
                }
                fieldelement(F;"HR Leave Ledger Entries"."Leave Type")
                {
                }
                fieldelement(G;"HR Leave Ledger Entries"."Leave Period")
                {
                }
                fieldelement(H;"HR Leave Ledger Entries".Days)
                {
                }
                fieldelement(I;"HR Leave Ledger Entries".Description)
                {
                }
            }
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

    trigger OnPostXmlPort()
    begin
        Message('Leave Balance Import completed!');
    end;
}

