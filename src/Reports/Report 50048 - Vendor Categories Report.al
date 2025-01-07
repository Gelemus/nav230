report 50048 "Vendor Categories Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Vendor Categories Report.rdl';

    dataset
    {
        dataitem("Supplier Category"; "Supplier Category")
        {
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            column(DocumentNumber_SupplierCategory; "Document Number")
            {
            }
            column(SupplierCategory_SupplierCategory; "Supplier Category")
            {
            }
            column(CategoryDescription_SupplierCategory; SupplierName)
            {
            }
            column(LiNo; LiNo)
            {
            }
            column(SupplierName; SupplierName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LiNo := LiNo + 1;

                Vendors.Reset;
                Vendors.SetRange("No.", "Document Number");
                if Vendors.FindFirst then
                    SupplierName := Vendors.Name;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        SupplierName: Text;
        LiNo: Integer;
        Vendors: Record Vendor;
}

