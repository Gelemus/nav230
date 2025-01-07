report 50031 "Tenant to Customer"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Tenant to Customer.rdl';

    dataset
    {
        dataitem("File Types"; "File Types")
        {

            trigger OnAfterGetRecord()
            begin
                /*"Tenant Application"."Customer Posting Group":='tenant';
                "Tenant Application".Status:="Tenant Application".Status::Approved;
                "Tenant Application".VALIDATE("Tenant Application".Property);
                "Tenant Application".MODIFY;
                */


                /*
                Setups.GET;
                
                
                CustomerTenanant.INIT;
                AccountCode:=NoSeriesMgt.GetNextNo(Setups."Customer Nos.",0D,TRUE);
                CustomerTenanant."No.":='TNT-'+Table50260.Property+'-'+AccountCode;
                CustomerTenanant."Application No.":=Table50260."Application No.";
                CustomerTenanant."Old Account No.":=Table50260."Old Account No.";
                CustomerTenanant.Name:=COPYSTR(Table50260.Name,1,50);
                CustomerTenanant.Address:=Table50260.Address;
                CustomerTenanant."Phone No.":=Table50260."Phone No.";
                CustomerTenanant."E-Mail":=Table50260."E-Mail";
                CustomerTenanant."Customer Posting Group":=Table50260."Customer Posting Group";
                IF CustomerTenanant.INSERT THEN BEGIN
                  TenantApplication2.RESET;
                  TenantApplication2.SETRANGE(TenantApplication2."Application No.",CustomerTenanant."Application No.");
                  IF TenantApplication2.FINDFIRST THEN BEGIN
                    TenantApplication2."Tenant Account No.":=CustomerTenanant."No.";
                    TenantApplication2.MODIFY;
                  END;
                END;
                */

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
        CustomerTenanant: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setups: Record "Sales & Receivables Setup";
        AccountCode: Code[20];
}

