report 50032 "DUMMY CORRECTION"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/DUMMY CORRECTION.rdl';

    dataset
    {
        dataitem("Post Code"; "Post Code")
        {

            trigger OnAfterGetRecord()
            begin
                "Post Code"."Country/Region Code" := 'kenya';
                "Post Code".County := '';
                "Post Code".Modify;
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
}

