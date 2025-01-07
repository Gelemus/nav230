xmlport 50137 "AllowanceHeader Xml"
{
    Caption = 'Tender Evaluation Criteria Export';
    UseDefaultNamespace = true;

    schema
    {
        textelement(AllowanceHeaderRoot)
        {
            tableelement("Allowance Header";"Allowance Header")
            {
                XmlName = 'AllowanceHeader';
                fieldelement(No;"Allowance Header"."No.")
                {
                }
                fieldelement(DocumentType;"Allowance Header"."Document Type")
                {
                }
                fieldelement(PostingDate;"Allowance Header"."Posting Date")
                {
                    FieldValidate = no;
                }
                fieldelement(Amount;"Allowance Header".Amount)
                {
                }
                fieldelement(DateFrom;"Allowance Header"."Date From")
                {
                }
                fieldelement(DateTo;"Allowance Header"."Date To")
                {
                }
                fieldelement(EmployeeNo;"Allowance Header"."Employee No.")
                {
                }
                fieldelement(EmployeeName;"Allowance Header"."Employee Name")
                {
                }
                fieldelement(Description;"Allowance Header".Description)
                {
                }
                fieldelement(Status;"Allowance Header".Status)
                {
                }
                fieldelement(AttachmentName;"Allowance Header"."Attachment Name")
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
}

