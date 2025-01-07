report 50026 "Fixed Deposit Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Fixed Deposit Certificate.rdl';

    dataset
    {
        dataitem("FD Processing"; "FD Processing")
        {
            column(DocumentNo_FDProcessing; "Document No.")
            {
            }
            column(BOSAAccountNo_FDProcessing; "BOSA Account No")
            {
            }
            column(Name_FDProcessing; Name)
            {
            }
            column(AccountType_FDProcessing; "Account Type")
            {
            }
            column(DestinationAccount_FDProcessing; "FD Account")
            {
            }
            column(SavingsAccountNo_FDProcessing; "Savings Account No.")
            {
            }
            column(IDNo_FDProcessing; "ID No.")
            {
            }
            column(MobilePhoneNo_FDProcessing; "Mobile Phone No")
            {
            }
            column(UserID_FDProcessing; "User ID")
            {
            }
            column(DatePosted_FDProcessing; "Date Posted")
            {
            }
            column(AmounttoTransfer_FDProcessing; "FD Amount")
            {
            }
            column(Interestrate_FDProcessing; "Interest rate")
            {
            }
            column(ExpectedMaturityDate_FDProcessing; "Expected Maturity Date")
            {
            }
            column(ExpectedInterestOnTermDep_FDProcessing; "Expected Interest On Term Dep")
            {
            }
            column(FixedDuration_FDProcessing; "Fixed Duration")
            {
            }
            column(FixedDepositStartDate_FDProcessing; "Fixed Deposit Start Date")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CAddress2; CompanyInfo."Address 2")
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(cemail; CompanyInfo."E-Mail")
            {
            }
            column(CPhoneNum; CompanyInfo."Phone No.")
            {
            }
            column(website; CompanyInfo."Home Page")
            {
            }
            column(custidno; idno)
            {
            }
            column(addressno; pox)
            {
            }
            column(postalcode; code)
            {
            }
            column(NAMEP; PNAME)
            {
            }
            column(Date; Date)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Date := Today;
                // cust.RESET;
                // cust.SETRANGE(cust."No.","Property Allocation Header"."Customer No");
                // IF cust.FIND ('-') THEN BEGIN
                //   idno:=cust."ID Number";
                //   pox:=cust.Address;
                //   code:=cust."Post Code";
                //   END;
                //   PRO.RESET;
                //   PRO.SETRANGE(PRO."Project No.","Property Allocation Header"."Project Code");
                //   IF PRO.FIND('-') THEN BEGIN
                //     PNAME:=PRO."Project Name";
                //     END;
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
        CompanyInfo: Record "Company Information";
        cust: Record Customer;
        idno: Code[10];
        pox: Code[10];
        "code": Code[10];
        PRO: Record "Fixed Asset";
        PNAME: Text;
        Date: Date;
}

