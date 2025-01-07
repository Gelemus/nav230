codeunit 50021 "Billing Integration WS"
{

    trigger OnRun()
    begin
        //MESSAGE(PostPayment('PV0000116'));
        //MESSAGE(ReversePayment('PV0000240'));
        //MESSAGE(PostJV('JVN00023'));
        //CreateInvoiceHeader(1,'test001','C00010',102819D,102919D,'904921','','','');
        //CreateInvoiceHeader(2,'test002','C00010',102819D,102919D,'904921','','','')
        //MESSAGE(ReverseReceipt('299360'));
        //CreateDepositRefundHeader('PVDP0001',092820D,'','test','test','0001');
        /*
        PaymentHeaderRec.RESET;
        PaymentHeaderRec.SETRANGE("Is Deposit Refund", TRUE);
        PaymentHeaderRec.SETRANGE(Status, PaymentHeaderRec.Status::Open);
        //PaymentHeaderRec.SETRANGE("No.",'PV0001235');
        
        IF PaymentHeaderRec.FINDFIRST THEN BEGIN
          REPEAT
            PaymentLineRec.RESET;
            PaymentLineRec.SETRANGE("Document No.",PaymentHeaderRec."No.");
            PaymentLineRec.SETRANGE("Net Amount",0.0);
        
            IF PaymentLineRec.FINDFIRST THEN BEGIN
              REPEAT
                PaymentLineRec.DELETE;
                UNTIL PaymentLineRec.NEXT = 0;
            END;
        
        PaymentLineRec.RESET;
        PaymentLineRec.SETRANGE(Description, PaymentHeaderRec.Description);
        PaymentLineRec.SETRANGE("Account No.", '4700-000');
        PaymentLineRec.SETFILTER("Net Amount",'>%1',0.0);
        PaymentLineRec.SETRANGE("Document No.",'');
        
        IF PaymentLineRec.FINDFIRST THEN BEGIN
          REPEAT
            //PaymentLineRec."Document No." := PaymentHeaderRec."No.";
            //PaymentLineRec.MODIFY(TRUE);
        
        IF PaymentLineRecII.FINDLAST THEN
        LineNo:=PaymentLineRecII."Line No."+100
        ELSE
          LineNo:=100;
        
        PaymentLineRecII.INIT;
        PaymentLineRecII."Document No.":=PaymentHeaderRec."No.";
        PaymentLineRecII."Line No.":=LineNo;
        PaymentLineRecII."Account Type":=PaymentLineRec."Account Type";
        PaymentLineRecII."Account No.":=PaymentLineRec."Account No.";
        PaymentLineRecII.VALIDATE("Account No.");
        PaymentLineRecII.Description:=PaymentLineRec.Description;
        PaymentLineRecII."Total Amount":=PaymentLineRec."Total Amount";
        PaymentLineRecII."Document Type":=PaymentLineRec."Document Type";
        PaymentLineRecII.VALIDATE("Total Amount");
        PaymentLineRecII.INSERT
        
            UNTIL PaymentLineRec.NEXT =0;
          END
        
            UNTIL PaymentHeaderRec.NEXT = 0;
        
        MESSAGE('Done');
        END;
        */

    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesPost: Codeunit "Sales-Post";
        FundsManagement: Codeunit "Funds Management";
        "DocNo.": Code[20];
        FundsUserSetup: Record "Funds User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Receipt Posting, Contact the System Administrator';
        SalesInvoiceHeader: Record "Sales Invoice Header";
        FundsGeneralSetup: Record "Funds General Setup";
        PaymentHeaderRec: Record "Payment Header";
        PaymentLineRec: Record "Payment Line";
        LineNo: Integer;
        CustomerRec: Record Customer;
        JournalVoucherHeader: Record "Journal Voucher Header";
        JournalVoucherLines: Record "Journal Voucher Lines";
        DepositTransactionRec: Record "Deposit Transaction";
        Employee: Record Employee;
        SaleInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        lineAmount: Decimal;
        PaymentLineRecII: Record "Payment Line";
        GlAccounts: Record "G/L Account";
        ReversalEntry: Record "Reversal Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        ReversalPost: Codeunit "Reversal-Post";
        Amount: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustomerLedger: Record "Detailed Cust. Ledg. Entry";
        EmployeeII: Record Employee;
        GlEntry: Record "G/L Entry";
        GlEntryII: Record "G/L Entry";
        GlEntryIII: Record "G/L Entry";

    [Scope('Personalization')]
    procedure GetCustomerList(var CustomerExport: XMLport "Customer  Export";CustomerNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if CustomerNo<>'' then begin

          Customer.Reset;
          Customer.SetRange("No.",CustomerNo);
          if Customer.FindFirst then ;
          CustomerExport.SetTableView(Customer);
        end;
    end;

    [Scope('Personalization')]
    procedure GetGlAccountList(var GetGlAccounts: XMLport GetGlAccounts)
    var
        Customer: Record Customer;
    begin
    end;

    [Scope('Personalization')]
    procedure GetBankAccountList(var GetBankAccounts: XMLport GetBankAccounts)
    var
        Customer: Record Customer;
    begin
    end;

    [Scope('Personalization')]
    procedure CreateCustomer(CustNo: Code[20];CustName: Text;CustAddress: Text;Custcity: Code[20];CustPhoneNo: Code[20];CustomerPostingGroup: Code[20];CustEmail: Text;CustomerType: Code[20];Route: Code[20];Zone: Code[20];Region: Code[20];AccNo: Code[20]) ReturnValue: Text
    var
        Customer: Record Customer;
    begin
        Customer.Init;
        Customer.Validate("No.",CustNo);
        Customer.Validate(Name,CustName);
        Customer.Validate(Address,CustAddress);
        Customer.Validate(City,Custcity);
        Customer.Validate("Phone No.",CustPhoneNo);
        Customer.Validate("Customer Posting Group",CustomerPostingGroup);
        Customer.Validate("E-Mail",CustEmail);
        Customer."Account No.":=AccNo;
        Customer.Validate("Gen. Bus. Posting Group",'LOCAL');
        Customer.Validate("VAT Bus. Posting Group",'LOCAL');
        Customer."Application Method":=Customer."Application Method"::Manual;//:"Apply to Oldest";
        if Customer.Insert then
          ReturnValue:='200: Customer '+CustNo+' Created Successfully'
        else
          ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure CreateInvoiceHeader(DocumentType: Integer;InvoiceNo: Code[20];CustomerNo: Code[20];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        SalesHeader: Record "Sales Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        "DocNo.": Code[20];
    begin
        SalesInvoiceHeader.Reset;
        
        /*SalesInvoiceHeader.SETRANGE("Pre-Assigned No.",InvoiceNo);
        IF SalesInvoiceHeader.FINDFIRST THEN
          ERROR('400: Invoice'+InvoiceNo+' already Posted');*/
        
        
        SalesReceivablesSetup.Reset;
        SalesReceivablesSetup.Get;
        "DocNo.":=InvoiceNo;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=InvoiceNo;
        //"DocNo.":=NoSeriesMgt.GetNextNo(SalesReceivablesSetup."Invoice Nos." ,0D,TRUE);
        if "DocNo."<>'' then begin
          SalesHeader.Init;
          SalesHeader."Document Type":=DocumentType;
          SalesHeader."No.":=InvoiceNo;
          SalesHeader.Validate("Sell-to Customer No.",CustomerNo);
          CustomerRec.Reset;
          if CustomerRec.Get(CustomerNo) then
           SalesHeader."Posting Description" := CopyStr((CustomerRec."Account No." + '-' + SalesHeader."Sell-to Customer Name"),1,100);
          //SalesHeader."Shortcut Dimension 2 Code":=Zone;
          SalesHeader.Validate("Document Date",DocumentDate);
          SalesHeader.Validate("Posting Date",PostingDate);
          SalesHeader.Validate("External Document No.",ExternalDocumentNo);
          if SalesHeader.Insert then begin
            SalesHeader.Validate("Shortcut Dimension 2 Code");
            SalesHeader.Modify;
            ReturnValue:='200: Sales Header No '+"DocNo."+ ' Successfully Created';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;

    end;

    [Scope('Personalization')]
    procedure CreaterInvoiceLine(DocumentType: Integer;InvoiceNo: Code[20];ChargeCode: Code[30];LineDescription: Text;LineQty: Decimal;LineUnitPrice: Decimal;LineTotalAMountq: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20];Type: Integer) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine2.Reset;
        SalesLine2.SetRange("Document No.",InvoiceNo);
        SalesLine2.SetRange("Document Type",DocumentType);
        if SalesLine2.FindLast  then
          LineNo:=SalesLine2."Line No."+1000
        else
          LineNo:=1000;
        if InvoiceNo<>'' then begin
          SalesLine.Init;
          SalesLine.Validate("Document Type",DocumentType);
          SalesLine.Validate("Document No.",InvoiceNo);
          SalesLine."Line No.":=LineNo;
          //SalesLine.Type:=SalesLine.Type::"G/L Account";

          if Type=1 then
          SalesLine.Type:=SalesLine.Type::"G/L Account"
          else if Type = 2 then begin
            SalesLine.Type:=SalesLine.Type::Item;
           // SalesLine."Location Code" := 'BOTT.STORE';
          end;

          SalesLine.Validate("No.",ChargeCode);
          SalesLine.Validate(Quantity,LineQty);
          SalesLine.Validate("Unit Price",LineUnitPrice);

          if Type=2 then
            SalesLine."Location Code" := 'BOTT.STORE';

          if SalesLine.Insert ( true)
          then begin
            ReturnValue:='200: Sales Line Successfully Created'
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure PostInvoice(InvoiceNo: Code[20]) ReturnValue: Text
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("Pre-Assigned No.",InvoiceNo);
        /*IF SalesInvoiceHeader.FINDFIRST THEN
          ERROR('400: Invoice'+InvoiceNo+' already Posted');*/
        
        
        SalesHeader.Reset;
        SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("No.",InvoiceNo);
        if SalesHeader.FindFirst then begin
          SalesHeader.Ship:=true;
          SalesHeader.Invoice:=true;
          SalesHeader.Modify;
          Commit;
          if  SalesPost.Run(SalesHeader) then
        
            ReturnValue:='200: Sales Invoice Posted Successfully Created'
            else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end else
         ReturnValue:=('400:Sales Invoice  Does not exist');

    end;

    [Scope('Personalization')]
    procedure ModifyCustomer(CustNo: Code[20];CustName: Text;CustAddress: Text;Custcity: Code[20];CustPhoneNo: Code[20];CustomerPostingGroup: Code[20];CustEmail: Text;CustomerType: Code[20];Route: Code[20];Zone: Code[20];Region: Code[20];AccNo: Code[20]) ReturnValue: Text
    var
        Customer: Record Customer;
    begin
        Customer.Get(CustNo);
        Customer.Validate("No.",CustNo);
        Customer.Validate(Name,CustName);
        Customer.Validate(Address,CustAddress);
        Customer.Validate(City,Custcity);
        Customer.Validate("Phone No.",CustPhoneNo);
        Customer.Validate("Customer Posting Group",CustomerPostingGroup);
        Customer.Validate("E-Mail",CustEmail);
        Customer."Account No.":=AccNo;
        Customer.Validate("Gen. Bus. Posting Group",'LOCAL');
        Customer.Validate("VAT Bus. Posting Group",'LOCAL');
        Customer."Application Method":=Customer."Application Method"::"Apply to Oldest";
        if Customer.Modify then
          ReturnValue:='200: Customer '+CustNo+' Created Successfully'
        else
          ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyInvoiceHeader(DocumentType: Integer;InvoiceNo: Code[20];CustomerNo: Code[20];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        SalesHeader: Record "Sales Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        "DocNo.": Code[20];
    begin
        SalesReceivablesSetup.Reset;
        SalesReceivablesSetup.Get;
        "DocNo.":=InvoiceNo;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=InvoiceNo;
        //"DocNo.":=NoSeriesMgt.GetNextNo(SalesReceivablesSetup."Invoice Nos." ,0D,TRUE);
        if "DocNo."<>'' then begin
          SalesHeader.Get(DocumentType,InvoiceNo);
          //SalesHeader."Document Type":=SalesHeader."Document Type"::Invoice;
          SalesHeader."No.":=InvoiceNo;
          SalesHeader.Validate("Sell-to Customer No.",CustomerNo);
          SalesHeader.Validate("Document Date",DocumentDate);
          SalesHeader.Validate("Posting Date",PostingDate);
          SalesHeader.Validate("External Document No.",ExternalDocumentNo);
          if SalesHeader.Modify then begin
            ReturnValue:='200: Sales Header No '+"DocNo."+ ' Successfully Modified';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyInvoiceLine(DocumentType: Integer;InvoiceNo: Code[20];ChargeCode: Code[30];LineDescription: Text;LineQty: Decimal;LineUnitPrice: Decimal;LineTotalAMountq: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine2.Reset;
        SalesLine2.SetRange("Document No.",InvoiceNo);
        SalesLine2.SetRange("Document Type",SalesLine2."Document Type"::Invoice);
        if SalesLine2.FindLast  then
          LineNo:=SalesLine2."Line No."+1000
        else
          LineNo:=1000;
        if InvoiceNo<>'' then begin
          SalesLine.Reset;
          SalesLine.SetRange("Document No.",InvoiceNo);
          SalesLine.SetRange("Document Type",DocumentType);
          if SalesLine.FindFirst then begin

         ////SalesLine."Document Type":=SalesLine.nt Type"::Invoice"Docume;
          SalesLine."Document No.":=InvoiceNo;
          SalesLine.Type:=SalesLine.Type::"G/L Account";
          SalesLine.Validate("No.",ChargeCode);
          SalesLine.Validate(Quantity,LineQty);
          SalesLine.Validate("Unit Price",LineUnitPrice);
          if SalesLine.Insert then begin
            ReturnValue:='200: Sales Line Successfully Modified'
          end
          else ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
          end
          else ReturnValue:='400:Sales Invoice Does not exist';
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteInvoiceLines(InvoiceNo: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
    begin

        if InvoiceNo<>'' then begin
          SalesLine.Reset;
          SalesLine.SetRange("Document No.",InvoiceNo);
          SalesLine.SetRange("Document Type",SalesLine."Document Type"::Invoice);
          if SalesLine.FindFirst then begin
            if SalesLine.Delete then
            ReturnValue:='200: Sales Line Successfully deleted'
            else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure DeleteInvoice(InvoiceNo: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
        SalesHeader: Record "Sales Header";
    begin

        SalesHeader.Reset;
        SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("No.",InvoiceNo);
        if SalesHeader.FindFirst then begin

          SalesLine.Reset;
          SalesLine.SetRange("Document No.",InvoiceNo);
          SalesLine.SetRange("Document Type",SalesLine."Document Type"::Invoice);
          if SalesLine.FindFirst then
            repeat
            SalesLine.Delete ;

          until SalesLine.Next=0;
          if SalesHeader.Delete then
            ReturnValue:='200: Sales Invoice Successfully deleted'
          else
            ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end
        else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure CreateInvoiceCreditMemoHeader(CreditMemoNo: Code[20];CustomerNo: Code[20];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];Route: Code[20];Zone: Code[20];Region: Code[20];AppliesInvoiceNo: Code[20]) ReturnValue: Text
    var
        SalesHeader: Record "Sales Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        "DocNo.": Code[20];
    begin
        SalesReceivablesSetup.Reset;
        SalesReceivablesSetup.Get;
        "DocNo.":=CreditMemoNo;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=CreditMemoNo;
        //"DocNo.":=NoSeriesMgt.GetNextNo(SalesReceivablesSetup."Invoice Nos." ,0D,TRUE);
        if "DocNo."<>'' then begin
          SalesHeader.Init;
          SalesHeader."Document Type":=SalesHeader."Document Type"::"Credit Memo";
          SalesHeader."No.":=CreditMemoNo;
          SalesHeader.Validate("Sell-to Customer No.",CustomerNo);
          SalesHeader.Validate("Document Date",DocumentDate);
          SalesHeader.Validate("Posting Date",PostingDate);
          SalesHeader.Validate("External Document No.",ExternalDocumentNo);
            CustomerRec.Reset;
          if CustomerRec.Get(CustomerNo) then
          SalesHeader."Posting Description" := CopyStr((CustomerRec."Account No." + '-' + SalesHeader."Sell-to Customer Name"),1,100);

          SalesInvoiceHeader.Reset;
          SalesInvoiceHeader.SetRange("Order No.",AppliesInvoiceNo);
          if SalesInvoiceHeader.FindFirst then begin
        SalesHeader."Applies-to Doc. Type":=SalesHeader."Applies-to Doc. Type"::Invoice;
          SalesHeader."Applies-to Doc. No.":=AppliesInvoiceNo;
          end;
          if SalesHeader.Insert then begin
            ReturnValue:='200: Sales Credit Memo No '+"DocNo."+ ' Successfully Created';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure CreaterInvoiceCreditMemoLine(CreditmemoNo: Code[20];ChargeCode: Code[30];LineDescription: Text;LineQty: Decimal;LineUnitPrice: Decimal;LineTotalAMountq: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine2.Reset;
        SalesLine2.SetRange("Document No.",CreditmemoNo);
        SalesLine2.SetRange("Document Type",SalesLine2."Document Type"::"Credit Memo");
        if SalesLine2.FindLast  then
          LineNo:=SalesLine2."Line No."+1000
        else
          LineNo:=1000;
        if CreditmemoNo<>'' then begin
          SalesLine.Init;
          SalesLine."Document Type":=SalesLine."Document Type"::"Credit Memo";
          SalesLine."Document No.":=CreditmemoNo;
           SalesLine."Line No.":=LineNo;
          SalesLine.Type:=SalesLine.Type::"G/L Account";
          SalesLine.Validate("No.",ChargeCode);
          SalesLine.Validate(Quantity,LineQty);
          SalesLine.Validate("Unit Price",LineUnitPrice);
          if SalesLine.Insert then begin
            ReturnValue:='200: Sales credit memo Line Successfully Created'
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure PostInvoiceCreditMemo(CreditMemoNo: Code[20]) ReturnValue: Text
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset;
        SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::"Credit Memo");
        SalesHeader.SetRange("No.",CreditMemoNo);
        if SalesHeader.FindFirst then begin
          SalesHeader.Ship:=true;
          SalesHeader.Invoice:=true;
          SalesHeader.Modify;
          Commit;
          if  SalesPost.Run(SalesHeader) then

            ReturnValue:='200: Sales Credit Memo Posted Successfully Created'
            else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end else
         ReturnValue:=('400:Sales Credit Memo  Does not exist');
    end;

    [Scope('Personalization')]
    procedure ModifyInvoiceCreditMemoHeader(CreditmemoNo: Code[20];CustomerNo: Code[20];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        SalesHeader: Record "Sales Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        "DocNo.": Code[20];
    begin
        SalesReceivablesSetup.Reset;
        SalesReceivablesSetup.Get;
        "DocNo.":=CreditmemoNo;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=CreditmemoNo;
        //"DocNo.":=NoSeriesMgt.GetNextNo(SalesReceivablesSetup."Invoice Nos." ,0D,TRUE);
        if "DocNo."<>'' then begin
          SalesHeader.Get(SalesHeader."Document Type"::Invoice,CreditmemoNo);
          SalesHeader."Document Type":=SalesHeader."Document Type"::"Credit Memo";
          SalesHeader."No.":=CreditmemoNo;
          SalesHeader.Validate("Sell-to Customer No.",CustomerNo);
          SalesHeader.Validate("Document Date",DocumentDate);
          SalesHeader.Validate("Posting Date",PostingDate);
          SalesHeader.Validate("External Document No.",ExternalDocumentNo);
          if SalesHeader.Modify then begin
            ReturnValue:='200: Sales Credit Memo header No '+"DocNo."+ ' Successfully Modified';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyInvoiceCreditMemoLine(CreditmemoNo: Code[20];ChargeCode: Code[30];LineDescription: Text;LineQty: Decimal;LineUnitPrice: Decimal;LineTotalAMountq: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine2.Reset;
        SalesLine2.SetRange("Document No.",CreditmemoNo);
        SalesLine2.SetRange("Document Type",SalesLine2."Document Type"::"Credit Memo");
        if SalesLine2.FindLast  then
          LineNo:=SalesLine2."Line No."+1000
        else
          LineNo:=1000;
        if CreditmemoNo<>'' then begin
          SalesLine.Reset;
          SalesLine.SetRange("Document No.",CreditmemoNo);
          SalesLine.SetRange("Document Type",SalesLine2."Document Type"::"Credit Memo");
          if SalesLine.FindFirst then begin

          SalesLine."Document Type":=SalesLine."Document Type"::"Credit Memo";
          SalesLine."Document No.":=CreditmemoNo;
          SalesLine.Type:=SalesLine.Type::"G/L Account";
          SalesLine.Validate("No.",ChargeCode);
          SalesLine.Validate(Quantity,LineQty);
          SalesLine.Validate("Unit Price",LineUnitPrice);
          if SalesLine.Modify(true) then begin
            ReturnValue:='200: Sales credit Memo Successfully Modified'
          end
          else ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
          end
          else ReturnValue:='400:Sales Credit Memo Does not exist';
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteInvoiceCreditMemoLines(CreditmemoNo: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLine2.Reset;
        SalesLine2.SetRange("Document No.",CreditmemoNo);
        SalesLine2.SetRange("Document Type",SalesLine2."Document Type"::"Credit Memo");
        if SalesLine2.FindLast  then
          LineNo:=SalesLine2."Line No."+1000
        else
          LineNo:=1000;
        if CreditmemoNo<>'' then begin
          SalesLine.Reset;
          SalesLine.SetRange("Document No.",CreditmemoNo);
          SalesLine.SetRange("Document Type",SalesLine."Document Type"::"Credit Memo");
          if SalesLine.FindFirst then begin
            if SalesLine.Delete then
            ReturnValue:='200: Sales Credit memo Line Successfully Deleted'
            else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure DeleteInvoiceCreditMemo(CreditMemoNo: Code[20]) ReturnValue: Text
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        LineNo: Integer;
        SalesHeader: Record "Sales Header";
    begin

        SalesHeader.Reset;
        SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::"Credit Memo");
        SalesHeader.SetRange("No.",CreditMemoNo);
        if SalesHeader.FindFirst then begin

          SalesLine.Reset;
          SalesLine.SetRange("Document No.",CreditMemoNo);
          SalesLine.SetRange("Document Type",SalesLine."Document Type"::"Credit Memo");
          if SalesLine.FindFirst then
            repeat
            SalesLine.Delete ;

          until SalesLine.Next=0;
          if SalesHeader.Delete then
            ReturnValue:='200: Sales credit memo Line Successfully deleted'
          else
            ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end
        else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure CreateReceiptHeader(ReceiptNo: Code[20];CustomerNo: Code[20];BankAccountNo: Code[30];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];PaymentMode: Option " ",Cheque,EFT,RTGS,MPESA,Cash;ReceiptAmount: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20];Description: Text;ReceivedFrom: Text) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
        "DocNo.": Code[20];
    begin

        "DocNo.":=ReceiptNo;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=ReceiptNo;
        if "DocNo."<>'' then begin
            ReceiptHeader.Init;
          ReceiptHeader.Validate("Receipt Type",ReceiptHeader."Receipt Type"::"Normal Receipt");
          ReceiptHeader."Receipt Types":=ReceiptHeader."Receipt Types"::Bank;
            ReceiptHeader.Validate("No.",ReceiptNo);

            ReceiptHeader.Validate("Posting Date",PostingDate);
            ReceiptHeader.Validate("Document Date",DocumentDate);
            ReceiptHeader.Validate("Account No.",BankAccountNo);
            ReceiptHeader.Validate("Payment Mode",PaymentMode);
            ReceiptHeader.Validate("Reference No.",CopyStr(ExternalDocumentNo,1,19));
            ReceiptHeader.Description:= CopyStr(Description,1,48);
            ReceiptHeader."Received From":=ReceivedFrom;
           ReceiptHeader.Validate("Amount Received",ReceiptAmount);


          if ReceiptHeader.Insert(true) then begin
            ReturnValue:='200: Receipt header No '+"DocNo."+ ' Successfully Created';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure CreaterReceiptLine(ReceiptNo: Code[20];ReceiptCode: Code[30];LineDescription: Text;LineTotalAMountq: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20];CustomerNo: Code[30];pDescription: Text) ReturnValue: Text
    var
        ReceiptLine: Record "Receipt Line";
        ReceiptLine2: Record "Receipt Line";
        LineNo: Integer;
        ReceiptHeaderII: Record "Receipt Header";
    begin

        ReceiptHeaderII.Reset;
        ReceiptHeaderII.SetRange("No.",ReceiptNo);
        ReceiptHeaderII.SetRange(Posted, true);
        if ReceiptHeaderII.FindFirst then
          exit('200: Receipt Line Successfully Created');

        ReceiptLine2.Reset;
        ReceiptLine2.SetRange("Document No.",ReceiptNo);
        ReceiptLine2.SetRange("Document Type",ReceiptLine2."Document Type"::Receipt);
        if ReceiptLine2.FindLast  then
          LineNo:=ReceiptLine2."Line No."+1000
        else
          LineNo:=1000;
        if ReceiptNo<>'' then begin
          ReceiptLine.Init;
          ReceiptLine."Document Type":=ReceiptLine."Document Type"::Receipt;
          ReceiptLine."Document No.":=ReceiptNo;
          ReceiptLine."Line No.":=LineNo;
          ReceiptLine."Receipt Code":=ReceiptCode;
          ReceiptLine.Validate("Receipt Code");
          ReceiptLine.Validate("Account No.",CustomerNo);
          ReceiptLine.Description:=CopyStr(pDescription,1,99);
          ReceiptLine.Amount:=LineTotalAMountq;
          ReceiptLine.Validate(Amount);
          if ReceiptLine.Insert then begin
            ReturnValue:='200: Receipt Line Successfully Created'
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure PostReceipt(ReceiptNo: Code[20]) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange("Document Type",ReceiptHeader."Document Type"::Receipt);
        ReceiptHeader.SetRange("No.",ReceiptNo);
        if ReceiptHeader.FindFirst then begin
        
        
        
        FundsManagement.CheckReceiptMandatoryFields(ReceiptHeader,true);
        
        "DocNo.":=ReceiptNo;
        
        if FundsUserSetup.Get(UserId) then begin
          /*IF ReceiptHeader."Payment Mode" = ReceiptHeader."Payment Mode"::Cheque THEN BEGIN
            //insert to cheque buffer
            ReceiptHeader."Posted to Cheque Buffer":=TRUE;
            ReceiptHeader.MODIFY;
          END ELSE BEGIN*/
            FundsUserSetup.TestField("Receipt Journal Template");
            FundsUserSetup.TestField("Receipt Journal Batch");
            JTemplate:=FundsUserSetup."Receipt Journal Template";JBatch:=FundsUserSetup."Receipt Journal Batch";
              FundsManagement.PostReceipt(ReceiptHeader,JTemplate,JBatch,false);
        
            ReturnValue:='200:  Receipt Posted Successfully Created';
            /*
            ELSE ReturnValue:='400:'+GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        END ELSE
         ReturnValue:=('400:Sales Credit Memo  Does not exist');
         */
            Commit;
         // END;
        end else begin
          Error(UserAccountNotSetup,UserId);
        end;
        end;;

    end;

    [Scope('Personalization')]
    procedure ModifyReceiptHeader(ReceiptNO: Code[20];CustomerNo: Code[20];BankAccountNo: Code[30];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];PaymentMode: Option " ",Cheque,EFT,RTGS,MPESA,Cash;ReceiptAmount: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20];Description: Text;ReceivedFrom: Text) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        "DocNo.": Code[20];
    begin

        "DocNo.":=ReceiptNO;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=ReceiptNO;
        if ReceiptHeader.Get(ReceiptNO) then begin

          ReceiptHeader.Validate("Receipt Type",ReceiptHeader."Receipt Type"::"Normal Receipt");
            ReceiptHeader.Validate("No.",ReceiptNO);

            ReceiptHeader.Validate("Posting Date",PostingDate);
            ReceiptHeader.Validate("Account No.",BankAccountNo);
            ReceiptHeader.Validate("Payment Mode",PaymentMode);
            ReceiptHeader.Validate("Reference No.",ExternalDocumentNo);
            ReceiptHeader.Description:=Description;
            ReceiptHeader."Received From":=ReceivedFrom;
           ReceiptHeader.Validate("Amount Received",ReceiptAmount);


          if ReceiptHeader.Modify(true) then begin
            ReturnValue:='200: Receipt header No '+"DocNo."+ ' Modified Successfuly';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyReceiptLine(ReceiptNo: Code[20];ReceiptCode: Code[30];LineDescription: Text;LineQty: Decimal;LineUnitPrice: Decimal;LineTotalAMountq: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20]) ReturnValue: Text
    var
        ReceiptLine: Record "Receipt Line";
        ReceiptLine2: Record "Receipt Line";
        LineNo: Integer;
    begin

        if ReceiptNo<>'' then begin
          ReceiptLine.Reset;
          ReceiptLine.SetRange("Document No.",ReceiptNo);
          if ReceiptLine.FindFirst then begin

           ReceiptLine."Document Type":=ReceiptLine."Document Type"::Receipt;
          ReceiptLine."Document No.":=ReceiptNo;
          ReceiptLine."Line No.":=LineNo;
          ReceiptLine."Receipt Code":=ReceiptCode;
          ReceiptLine.Validate("Receipt Code");
          ReceiptLine.Description:=LineDescription;
          ReceiptLine.Amount:=LineTotalAMountq;
          ReceiptLine.Validate(Amount);


          if ReceiptLine.Modify(true) then begin
            ReturnValue:='200: Receipt Successfully Modified'
          end
          else ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
          end
          else ReturnValue:='400:Receipt Does not exist';
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteReceiptLines(ReceiptNo: Code[20]) ReturnValue: Text
    var
        ReceiptLine: Record "Receipt Line";
        ReceiptLine2: Record "Receipt Line";
        LineNo: Integer;
    begin

        if ReceiptNo<>'' then begin
          ReceiptLine.Reset;
          ReceiptLine.SetRange("Document No.",ReceiptNo);
          if ReceiptLine.FindFirst then begin
            if ReceiptLine.Delete then
            ReturnValue:='200: Receipt Line Successfully Deleted'
            else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure DeleteReceipt(ReceiptNo: Code[20]) ReturnValue: Text
    var
        ReceiptLine: Record "Receipt Line";
        ReceiptLine2: Record "Receipt Line";
        LineNo: Integer;
        ReceiptHeader: Record "Receipt Header";
    begin

        ReceiptHeader.Reset;
        ReceiptHeader.SetRange("No.",ReceiptNo);
        if ReceiptHeader.FindFirst then begin

          ReceiptLine.Reset;
          ReceiptLine.SetRange("Document No.",ReceiptNo);
          if ReceiptLine.FindFirst then
            repeat
            ReceiptLine.Delete ;

          until ReceiptLine.Next=0;
          if ReceiptHeader.Delete then
            ReturnValue:='200: Receipt Successfully deleted'
          else
            ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;

        end
        else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ReverseReceipt(ReceiptNo: Code[20]) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        ReceiptHeader.Reset;
        ReceiptHeader.SetRange("Document Type",ReceiptHeader."Document Type"::Receipt);
        ReceiptHeader.SetRange("No.",ReceiptNo);
        if ReceiptHeader.FindFirst then begin

        if ReceiptHeader.Status=ReceiptHeader.Status::Reversed then  begin
          ReturnValue:='400:This receipt has already been Reversed';
          exit
        end;

        if ReceiptHeader.Status<>ReceiptHeader.Status::Posted then begin
          ReturnValue:='400:This receipt has not been posted';
          exit
        end;

        "DocNo.":=ReceiptNo;

        if FundsUserSetup.Get(UserId) then begin

            FundsUserSetup.TestField("Receipt Journal Template");
            FundsUserSetup.TestField("Receipt Journal Batch");
            JTemplate:=FundsUserSetup."Receipt Journal Template";JBatch:=FundsUserSetup."Receipt Journal Batch";
              FundsManagement.ReverseReceipt(ReceiptHeader,JTemplate,JBatch,false);

            ReturnValue:='200:  Receipt Reversed Successfully Created';

            Commit;
         // END;
        end else begin
          Error(UserAccountNotSetup,UserId);
        end;
        end;;
    end;

    [Scope('Personalization')]
    procedure VerifyInvoiceDetails(DocumentType: Integer;InvoiceNo: Code[20];TotalAmount: Decimal;NoofInvoiceLines: Integer;PostingDate: Date): Boolean
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TotalInvamount: Decimal;
        Nooflines: Integer;
    begin
        SalesHeader.Get(DocumentType,InvoiceNo);
        if PostingDate<>SalesHeader."Posting Date" then
          exit(false);
        SalesLine.Reset;
        SalesLine.SetRange("Document No.",InvoiceNo);
        Nooflines:=SalesLine.Count;
        SalesLine.CalcSums("Amount Including VAT");
        TotalAmount := TotalAmount; //ROUND(TotalAmount,1,'>');
        TotalInvamount:=SalesLine."Amount Including VAT";
        if (TotalInvamount=TotalAmount) and (Nooflines=NoofInvoiceLines) then
          exit(true)
        else
          exit(false);
    end;

    [Scope('Personalization')]
    procedure VerifyReceiptDetails(ReceiptNo: Code[20];TotalAmount: Decimal;NoofReceiptines: Integer;PostingDate: Date): Boolean
    var
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        TotalRCTamount: Decimal;
        Nooflines: Integer;
    begin
        ReceiptHeader.Get(ReceiptNo);
        if PostingDate<>ReceiptHeader."Posting Date" then
          exit(false);
        ReceiptLine.Reset;
        ReceiptLine.SetRange("Document No.",ReceiptNo);
        Nooflines:=ReceiptLine.Count;
        ReceiptLine.CalcSums(Amount);
        TotalRCTamount:=ReceiptLine.Amount;
        if (TotalRCTamount=TotalAmount) and (Nooflines=NoofReceiptines) then
          exit(true)
        else
          exit(false);
    end;

    [Scope('Personalization')]
    procedure VerifyCreditMemoDetails(CreditMemoNo: Code[20];TotalAmount: Decimal;NoofCRLines: Integer;PostingDate: Date): Boolean
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TotalInvamount: Decimal;
        Nooflines: Integer;
    begin
        SalesHeader.Get(SalesHeader."Document Type"::"Credit Memo",CreditMemoNo);
        if PostingDate<>SalesHeader."Posting Date" then
          exit(false);
        SalesLine.Reset;
        SalesLine.SetRange("Document No.",CreditMemoNo);
        Nooflines:=SalesLine.Count;
        SalesLine.CalcSums("Amount Including VAT");
        TotalInvamount:=SalesLine."Amount Including VAT";
        if (TotalInvamount=TotalAmount) and (Nooflines=NoofCRLines) then
          exit(true)
        else
          exit(false);
    end;

    [Scope('Personalization')]
    procedure CreateDepositRefundHeader(DocumentNo: Code[20];PostingDate: Date;BankAccCode: Code[20];PayeeName: Text;Description: Text;DepositTransNo: Code[20]) ReturnValue: Text
    begin
        FundsGeneralSetup.Get();
        PaymentHeaderRec.Init;
        PaymentHeaderRec."No.":=NoSeriesMgt.GetNextNo(FundsGeneralSetup."Deposit Refunds Nos",Today,true);//NoSeriesMgt.GetNextNo(FundsGeneralSetup."Deposit Refund Nos",TODAY,TRUE);//DocumentNo;
        PaymentHeaderRec."Posting Date":=PostingDate;
        PaymentHeaderRec."Document Date" := PostingDate;
        //PaymentHeaderRec."Bank Account No.":=BankAccCode;
        PaymentHeaderRec."Bank Account No.":=FundsGeneralSetup."Deposit Refund Bank";
        PaymentHeaderRec."Payment Mode" := PaymentHeaderRec."Payment Mode"::Cash;
        PaymentHeaderRec."Payment Mode" := PaymentHeaderRec."Document Type"::Payment;
        PaymentHeaderRec.Validate("Bank Account No.");
        PaymentHeaderRec."Payee Name":=PayeeName;
        PaymentHeaderRec.Description:=Description;
        PaymentHeaderRec."Deposit Transaction No" := DepositTransNo;
        PaymentHeaderRec.Status := PaymentHeaderRec.Status::Open;
        PaymentHeaderRec."Is Deposit Refund" := true;
        PaymentHeaderRec."User ID" := 'WEBSERVICEUSER';
        if PaymentHeaderRec.Insert then
          ReturnValue:='200:'+PaymentHeaderRec."No."+' Deposit Refund Created successfully'
        else
          ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyDepositRefundHeader(RefundNo: Code[20];PostingDate: Date;BankAccCode: Code[20];PayeeName: Text;Description: Text) RefundHeaderModified: Boolean
    begin
        PaymentHeaderRec.Reset;
        PaymentHeaderRec.SetRange("No.",RefundNo);
        if PaymentHeaderRec.FindFirst then
          begin
            PaymentHeaderRec."Posting Date":=PostingDate;
            //PaymentHeaderRec."Bank Account No.":=BankAccCode;
            PaymentHeaderRec."Bank Account No.":=FundsGeneralSetup."Deposit Refund Bank";
            PaymentHeaderRec.Validate("Bank Account No.");
            PaymentHeaderRec."Payee Name":=PayeeName;
            PaymentHeaderRec.Description:=Description;
           if  PaymentHeaderRec.Modify then
             RefundHeaderModified:=true
           else
             RefundHeaderModified:=false;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateDepositRefundLine(RefundHeaderNo: Code[20];AccountType: Code[20];PayeeNo: Code[20];Description: Text;RegionCode: Code[20];DepartmentodeCode: Code[20];AmountIncVat: Decimal) ReturnValue: Text
    begin
        if PaymentLineRec.FindLast then
        LineNo:=PaymentLineRec."Line No."+10000
        else
          LineNo:=10000;

        FundsGeneralSetup.Get();
        PaymentLineRec.Init;
        PaymentLineRec."Document No.":=RefundHeaderNo;
        PaymentLineRec."Line No.":=LineNo;
        //customer and g/ account
        if AccountType=UpperCase(Format(PaymentLineRec."Account Type"::Customer)) then begin
          PaymentLineRec."Account Type":=PaymentLineRec."Account Type"::Customer;
          PaymentLineRec."Payee Type":=PaymentLineRec."Payee Type"::Customer;
          PaymentLineRec."Payee No.":=PayeeNo;
          PaymentLineRec.Validate("Payee No.");
          end;

        if AccountType=UpperCase(Format(PaymentLineRec."Account Type"::"G/L Account")) then begin
          PaymentLineRec."Account Type":=PaymentLineRec."Account Type"::"G/L Account";
          PaymentLineRec."Account No.":=FundsGeneralSetup."Deposit gl Account";
          PaymentLineRec.Validate("Account No.");
          end;


        PaymentLineRec.Description:=Description;
        PaymentLineRec."Total Amount":=Abs(AmountIncVat);
        PaymentLineRec."Document Type":=PaymentLineRec."Document Type"::Payment;
        PaymentLineRec.Validate("Total Amount");
        //PaymentLineRec."Global Dimension 1 Code":=RegionCode;
        //PaymentLineRec.VALIDATE("Global Dimension 1 Code");
        //PaymentLineRec."Global Dimension 2 Code":=DepartmentodeCode;
        //PaymentLineRec.VALIDATE("Global Dimension 2 Code");
        if PaymentLineRec.Insert then
          ReturnValue:='200: Line created successfully'
        else
          ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyDepositRefundLine(RefundHeaderNo: Code[20];LineNo: Integer;PayeeNo: Code[20];Description: Text;RegionCode: Code[20];DepartmentodeCode: Code[20];AmountIncVat: Decimal) RefundLineModified: Boolean
    var
        ReturnValue: Text;
    begin
        PaymentLineRec.Reset;
        PaymentLineRec.SetRange("Document No.",RefundHeaderNo);
        PaymentLineRec.SetRange("Line No.",LineNo);
        if PaymentLineRec.FindFirst then
          begin
            PaymentLineRec."Document No.":=RefundHeaderNo;
            PaymentLineRec."Line No.":=LineNo;

            PaymentLineRec."Payee No.":=PayeeNo;
            PaymentLineRec.Validate("Payee No.");
            PaymentLineRec.Description:=Description;
            PaymentLineRec."Total Amount":=AmountIncVat;
            PaymentLineRec.Validate("Total Amount");
            PaymentLineRec."Global Dimension 1 Code":=RegionCode;
            PaymentLineRec.Validate("Global Dimension 1 Code");
            PaymentLineRec."Global Dimension 2 Code":=DepartmentodeCode;
            PaymentLineRec.Validate("Global Dimension 2 Code");
              if PaymentLineRec.Modify then
             RefundLineModified:=true
               else
                RefundLineModified:=false
              end;
    end;

    [Scope('Personalization')]
    procedure DeleteDepositRefundLine(RefundHeaderNo: Code[20];LineNo: Integer;PayeeNo: Code[20];Description: Text;RegionCode: Code[20];DepartmentodeCode: Code[20];AmountIncVat: Decimal) RefundLineDeleted: Boolean
    var
        DeleteReturnValue: Text;
    begin
        PaymentLineRec.Reset;
        PaymentLineRec.SetRange("Document No.",RefundHeaderNo);
        PaymentLineRec.SetRange("Line No.",LineNo);
        if PaymentLineRec.Delete then
                RefundLineDeleted:=true
           else
          RefundLineDeleted:=false;

    end;

    [Scope('Personalization')]
    procedure GetDepositRefunds(var ImportExpDepRefunds: XMLport "ImportExp Dep Refunds")
    begin
        PaymentHeaderRec.Reset;
        PaymentHeaderRec.SetRange(Posted,false);
        PaymentHeaderRec.SetRange("Payment Type",PaymentHeaderRec."Payment Type"::"Deposit Transfer");
        ImportExpDepRefunds.SetTableView(PaymentHeaderRec);
    end;

    [Scope('Personalization')]
    procedure CreateJournalVHeader(DocNo: Code[30];PostingDate: Date;Description: Text;ExternalDocNo: Text) ReturnValue: Text
    begin
        JournalVoucherHeader.Init;
        JournalVoucherHeader."JV No.":=DocNo; //NoSeriesMgt.GetNextNo(FundsGeneralSetup."JV Nos.",TODAY,TRUE);
        JournalVoucherHeader."Posting Date":=PostingDate;
        JournalVoucherHeader.Description:=Description;
        JournalVoucherHeader."External Document No." := ExternalDocNo;
        JournalVoucherHeader."Document date":=Today;
        JournalVoucherHeader."User ID":=UserId;
        JournalVoucherHeader."Is Bill Adjustment" := true;
        if JournalVoucherHeader.Insert then
          ReturnValue:='200: Jv Header Created successfully'
        else
          ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyJournalVHeader("JVNo.": Code[20];PostingDate: Date;Description: Text) JVHeaderModified: Boolean
    begin
        JournalVoucherHeader.Reset;
        JournalVoucherHeader.SetRange("JV No.","JVNo.");
        if JournalVoucherHeader.FindFirst then
          begin
            JournalVoucherHeader."Posting Date":=PostingDate;
            JournalVoucherHeader.Description:=CopyStr(Description,1,99);;
           if  JournalVoucherHeader.Modify then
             JVHeaderModified:=true
           else
             JVHeaderModified:=false;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateJVLine(JVHeaderNo: Code[20];AccountType: Code[20];AccountNo: Code[20];Description: Text;Amount: Decimal;BalAccountType: Code[20];"BalAccountNo.": Code[20];ExternalDocNo: Code[20];Scheme: Code[20];Zone: Code[20];Route: Code[20]) ReturnValue: Text
    begin
        if JournalVoucherLines.FindLast then
        LineNo:=JournalVoucherLines."Line No."+10000
        else
          LineNo:=10000;

        if AccountNo = '' then
          AccountNo := '1001282';

        if "BalAccountNo." = '' then
          "BalAccountNo." := '1001282';

        JournalVoucherHeader.Reset;
        JournalVoucherHeader.Get(JVHeaderNo);

        JournalVoucherLines.Init;
        JournalVoucherLines."Document No.":=JVHeaderNo;
        JournalVoucherLines."JV No." :=JVHeaderNo;
        JournalVoucherLines."Line No.":=LineNo;
        JournalVoucherLines."External Document No." := JournalVoucherHeader."External Document No.";

        if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::"G/L Account")) then
          JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::"G/L Account";

        if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::"Bank Account")) then
          JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::"Bank Account";

        if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::Customer)) then
          JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::Customer;

          if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::Vendor)) then
          JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::Vendor;



        JournalVoucherLines."Account No.":=AccountNo;
        JournalVoucherLines.Validate("Account No.");
        JournalVoucherLines.Description:=Description;
        JournalVoucherLines.Amount:=Amount;
        JournalVoucherLines.Validate(Amount);

        if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::"G/L Account")) then
          JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::"G/L Account";

        if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::Customer)) then
        JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::Customer;

        if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::Vendor)) then
          JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::Vendor;

        if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::"Bank Account")) then
          JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::"Bank Account";


        //JournalVoucherLines."Bal. Account No.":="BalAccountNo.";
        JournalVoucherLines."Bal. Account No.":= "BalAccountNo.";//FundsGeneralSetup."Deposit gl Account";
        JournalVoucherLines.Validate("Bal. Account No.");
        //JournalVoucherLines."Shortcut Dimension 1 Code":='ADMIN FINANCE';
        //JournalVoucherLines.VALIDATE("Shortcut Dimension 1 Code");
        //JournalVoucherLines."Shortcut Dimension 2 Code":='FINANCE';
        //JournalVoucherLines.VALIDATE("Shortcut Dimension 2 Code");

        if JournalVoucherLines.Insert then
          ReturnValue:='200: Line created successfully'
        else
          ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyJVLine(JVHeaderNo: Code[20];LineNo: Integer;AccountType: Code[20];AccountNo: Code[20];Description: Text;Amount: Decimal;BalAccountType: Code[20];"BalAccountNo.": Code[20];GlobalDimension1: Code[20];GlobalDimension2: Code[20]) ReturnValue: Text
    begin
        JournalVoucherLines.Reset;
        JournalVoucherLines.SetRange("Document No.",JVHeaderNo);
        JournalVoucherLines.SetRange("Line No.",LineNo);
        if JournalVoucherLines.FindLast  then
          begin
              JournalVoucherLines."Document No.":=JVHeaderNo;
              JournalVoucherLines."Line No.":=LineNo;
              if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::"G/L Account")) then
                JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::"G/L Account";

              if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::"Bank Account")) then
                JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::"Bank Account";

              if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::Customer)) then
                JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::Customer;

                if AccountType=UpperCase(Format(JournalVoucherLines."Account Type"::Vendor)) then
                JournalVoucherLines."Account Type":=JournalVoucherLines."Account Type"::Vendor;

              JournalVoucherLines."Account No.":=AccountNo;
              JournalVoucherLines.Validate("Account No.");
              JournalVoucherLines.Description:=CopyStr(Description,1,99);;
              JournalVoucherLines.Amount:=Amount;
              JournalVoucherLines.Validate(Amount);
              if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::"G/L Account")) then
                JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::"G/L Account";

              if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::Customer)) then
              JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::Customer;

              if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::Vendor)) then
                JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::Vendor;

              if BalAccountType=UpperCase(Format(JournalVoucherLines."Bal. Account Type"::"Bank Account")) then
                JournalVoucherLines."Bal. Account Type":=JournalVoucherLines."Bal. Account Type"::"Bank Account";


              JournalVoucherLines."Bal. Account No.":="BalAccountNo.";
              JournalVoucherLines.Validate("Bal. Account No.");
              JournalVoucherLines."Shortcut Dimension 1 Code":=GlobalDimension1;
              JournalVoucherLines.Validate("Shortcut Dimension 1 Code");
              JournalVoucherLines."Shortcut Dimension 2 Code":=GlobalDimension2;
              JournalVoucherLines.Validate("Shortcut Dimension 2 Code");
              if JournalVoucherLines.Modify then
                ReturnValue:='200: Line Modified successfully'
              else
                ReturnValue:=GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteJVLine(JVHeaderNo: Code[20];LineNo: Integer) JVLineDeleted: Boolean
    var
        DeleteReturnValue: Text;
    begin
        JournalVoucherLines.Reset;
        JournalVoucherLines.SetRange("Document No.",JVHeaderNo);
        JournalVoucherLines.SetRange("Line No.",LineNo);
        if JournalVoucherLines.Delete then
                JVLineDeleted:=true
           else
          JVLineDeleted:=false;

    end;

    [Scope('Personalization')]
    procedure GetJVouchers(var ImportExpDepRefunds: XMLport "ImportExp Dep Refunds")
    begin
        JournalVoucherHeader.Reset;
        JournalVoucherHeader.SetRange(Posted,false);
        //JournalVoucherHeader.SETRANGE("Payment Type",JournalVoucherHeader."Payment Type"::"Deposit Transfer");
        ImportExpDepRefunds.SetTableView(JournalVoucherHeader);
    end;

    [Scope('Personalization')]
    procedure CreateDepositTransaction(TransID: Code[20];CustNo: Code[20]) ReturnValue: Text
    begin
        if TransID<>'' then
          begin
            DepositTransactionRec.Init;
            DepositTransactionRec."Deposit ID":=TransID;
            DepositTransactionRec."Cust. No.":=CustNo;
            DepositTransactionRec.Validate("Cust. No.");
            if DepositTransactionRec.Insert then
              ReturnValue:='200: Header created successfully '
            else
              ReturnValue:=GetLastErrorCode+' '+GetLastErrorText;
            end;
    end;

    [Scope('Personalization')]
    procedure ModifyDepositTransaction(TransID: Code[20];CustNo: Code[20]) ReturnValue: Text
    begin
        if TransID<>'' then
          begin
            DepositTransactionRec.Reset;
            DepositTransactionRec.SetRange("Deposit ID",TransID);
            if DepositTransactionRec.FindFirst then
              begin
             DepositTransactionRec."Deposit ID":=TransID;
            DepositTransactionRec."Cust. No.":=CustNo;
            DepositTransactionRec.Validate("Cust. No.");
            if DepositTransactionRec.Modify then
              ReturnValue:='Header modified successfully '
            else
              ReturnValue:=GetLastErrorCode+' '+GetLastErrorText;
             end


            end;
    end;

    [Scope('Personalization')]
    procedure DeleteDepositTransaction(TransID: Code[20]) ReturnValue: Text
    begin
        if TransID<>'' then
          begin
            DepositTransactionRec.Reset;
            DepositTransactionRec.SetRange("Deposit ID",TransID);
            if DepositTransactionRec.Delete then
              ReturnValue:='Deleted successfully'
            else
              ReturnValue:=GetLastErrorCode+' '+GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure GetEmployeeList(var EmployeeExport: XMLport "Employee Export";EmployeeNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if EmployeeNo<>'' then begin

          Employee.Reset;
          Employee.SetRange("No.",EmployeeNo);
          if Employee.FindFirst then ;
          EmployeeExport.SetTableView(Employee);

          if Employee.Count = 0 then begin
            EmployeeII.Reset;
            EmployeeII.SetRange("National ID",EmployeeNo);
            if EmployeeII.FindFirst then;
              EmployeeExport.SetTableView(EmployeeII);
          end;

        end;
        //Update 9/29/2020 jim
    end;

    [Scope('Personalization')]
    procedure CreateDepositReceiptHeader(ReceiptNo: Code[20];CustomerNo: Code[20];BankAccountNo: Code[30];PostingDate: Date;DocumentDate: Date;ExternalDocumentNo: Code[30];PaymentMode: Option " ",Cheque,EFT,RTGS,MPESA,Cash;ReceiptAmount: Decimal;Route: Code[20];Zone: Code[20];Region: Code[20];Description: Text;ReceivedFrom: Text;DepositTransNo: Code[20]) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
        "DocNo.": Code[20];
    begin

        "DocNo.":=ReceiptNo;
        if ExternalDocumentNo='' then
          ExternalDocumentNo:=ReceiptNo;

        ReceiptHeader.Reset;
        ReceiptHeader.SetRange("No.",ReceiptNo);
        if ReceiptHeader.FindFirst then
          exit('200: Receipt header No '+"DocNo."+ ' already Created');

        if "DocNo."<>'' then begin
            ReceiptHeader.Init;
          ReceiptHeader.Validate("Receipt Type",ReceiptHeader."Receipt Type"::"Normal Receipt");
          ReceiptHeader."Receipt Types":=ReceiptHeader."Receipt Types"::"G/L Account";
            ReceiptHeader.Validate("No.",ReceiptNo);

            ReceiptHeader.Validate("Posting Date",PostingDate);
            ReceiptHeader.Validate("Document Date",DocumentDate);
            ReceiptHeader."Account No." := BankAccountNo;//FundsGeneralSetup."Deposit gl Account";
            ReceiptHeader.Validate("Account No.");
            ReceiptHeader.Validate("Payment Mode",PaymentMode);
            ReceiptHeader.Validate("Reference No.",ExternalDocumentNo);
            ReceiptHeader.Description:=Description;
            ReceiptHeader."Received From":=ReceivedFrom;
            ReceiptHeader.Validate("Amount Received",ReceiptAmount);
            ReceiptHeader."Deposit Transaction No." := DepositTransNo;

          if ReceiptHeader.Insert(true) then begin
            ReturnValue:='200: Receipt header No '+"DocNo."+ ' Successfully Created';
          end
          else ReturnValue:='400:'+GetLastErrorCode+'-'+GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure DeletePaymentVoucher(PVHeaderNo: Code[20]) JVLineDeleted: Boolean
    var
        DeleteReturnValue: Text;
    begin
        PaymentHeaderRec.Reset;
        PaymentHeaderRec.SetRange("No.",PVHeaderNo);
        PaymentHeaderRec.SetRange(Status,PaymentHeaderRec.Status::Open);
        if PaymentHeaderRec.Delete then
                JVLineDeleted:=true
           else
          JVLineDeleted:=false;

    end;

    [Scope('Personalization')]
    procedure DeleteDepReceipt(RcptHeaderNo: Code[20]) JVLineDeleted: Boolean
    var
        DeleteReturnValue: Text;
        ReceiptHeaderDep: Record "Receipt Header";
    begin
        ReceiptHeaderDep.Reset;
        ReceiptHeaderDep.SetRange("No.",RcptHeaderNo);
        ReceiptHeaderDep.SetRange(Status,ReceiptHeaderDep.Status::Open);

        if ReceiptHeaderDep.Delete then
                JVLineDeleted:=true
           else
          JVLineDeleted:=false;

    end;

    [Scope('Personalization')]
    procedure PostJV(JVNo: Code[20]) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        JournalVoucherHeader.Reset;
        JournalVoucherHeader.SetRange("JV No.",JVNo);
        if JournalVoucherHeader.FindFirst then begin
          JournalVoucherHeader.Status := JournalVoucherHeader.Status::Approved;
          JournalVoucherHeader.Modify;
        
        //FundsManagement.CheckJournalVoucherMandatoryFields(JournalVoucherHeader,true);//.CheckReceiptMandatoryFields(ReceiptHeader,TRUE);
        
        "DocNo.":=JVNo;
        
        if FundsUserSetup.Get(UserId) then begin
          FundsUserSetup.TestField(FundsUserSetup."JV Template");
          FundsUserSetup.TestField(FundsUserSetup."JV Batch");
          JTemplate:=FundsUserSetup."JV Template";JBatch:=FundsUserSetup."JV Batch";
          FundsManagement.PostJournalVoucher(JournalVoucherHeader,JTemplate,JBatch,false);
            ReturnValue:='200:  Receipt Posted Successfully Created';
            /*
            ELSE ReturnValue:='400:'+GETLASTERRORCODE+'-'+GETLASTERRORTEXT;
        END ELSE
         ReturnValue:=('400:Sales Credit Memo  Does not exist');
         */
            Commit;
         // END;
        end else begin
          Error(UserAccountNotSetup,UserId);
        end;
        end;;

    end;

    [Scope('Personalization')]
    procedure VerifyPostedInvoice(DocumentType: Integer;InvoiceNo: Code[20];ExternalDocNo: Code[20];TotalAmount: Decimal;NoofInvoiceLines: Integer;PostingDate: Date;Status: Option posted,cancelled): Text
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TotalInvamount: Decimal;
        Nooflines2: Integer;
    begin
        if Status = Status::posted then begin
        SalesInvoiceHeader.Reset;
        //SalesInvoiceHeader.SETRANGE("Pre-Assigned No.",InvoiceNo);
        SalesInvoiceHeader.SetRange("External Document No.",ExternalDocNo);
        if SalesInvoiceHeader.FindFirst then begin

          if PostingDate<>SalesInvoiceHeader."Posting Date" then
          exit('400: Invoice Dates dont match');

          SaleInvoiceLine.Reset;
          SaleInvoiceLine.SetRange("Document No.",SalesInvoiceHeader."No.");
          Nooflines2:=SaleInvoiceLine.Count;
          SaleInvoiceLine.CalcSums("Amount Including VAT");
          //TotalAmount := ROUND(TotalAmount,1,'>');
          TotalInvamount:=SaleInvoiceLine."Amount Including VAT";

          if TotalInvamount<>TotalAmount then
            exit('400: Invoice Amount dont match');

          if Nooflines2<>NoofInvoiceLines then
            exit('400: Invoice Line Count dont match');

          exit('200: Invoice Verified Successfully');
        end else
          exit('400: Invoice Not Posted');
        end else begin
         SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("Pre-Assigned No.",InvoiceNo);
        SalesInvoiceHeader.SetRange("External Document No.",ExternalDocNo);
        if SalesInvoiceHeader.FindFirst then begin
          SalesCrMemo.Reset;
          SalesCrMemo.SetRange("External Document No.",InvoiceNo);
          if SalesCrMemo.FindFirst then begin

            if PostingDate<>SalesCrMemo."Posting Date" then
              exit('400: Posting Date Dont Match');

              SalesCrMemoLine.Reset;
              SalesCrMemoLine.SetRange("Document No.",SalesCrMemo."No.");
              Nooflines2:=SalesCrMemoLine.Count;
              SalesCrMemoLine.CalcSums("Amount Including VAT");
              TotalInvamount:=SalesCrMemoLine."Amount Including VAT";
              if (TotalInvamount=TotalAmount) and (Nooflines2=NoofInvoiceLines) then
                exit('400: Total Amount or No of Lines Dont Match');

              exit('200: Creditmemo Verified Successfully');

           end else
              exit('400: Credit Memo is not posted');

          end else
           exit('200: Nav Invoice Reversal Not Required Since Invoice was not Nav Posted');
        end
    end;

    [Scope('Personalization')]
    procedure VerifyPostedReceipt(ReceiptNo: Code[20];TotalAmount: Decimal;NoofReceiptines: Integer;PostingDate: Date;Status: Option posted,cancelled): Text
    var
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        TotalRCTamount: Decimal;
        Nooflines: Integer;
        bankAmount: Decimal;
    begin
        ReceiptHeader.Reset;
        if ReceiptHeader.Get(ReceiptNo) then begin

        if PostingDate<>ReceiptHeader."Posting Date" then
          exit('400: Receipt Dates dont Match');

        ReceiptLine.Reset;
        ReceiptLine.SetRange("Document No.",ReceiptNo);
        Nooflines:=ReceiptLine.Count;
        ReceiptLine.CalcSums(Amount);
        TotalRCTamount:=ReceiptLine.Amount;
        if TotalRCTamount<>TotalAmount then
          exit('400: Receipt Amount dont match');

        if Status = Status::posted then begin
          if ReceiptHeader.Status = ReceiptHeader.Status::Posted then
            exit('200: Receipt Verified Successfully')
          else
            exit('400: Receipt Is not Posted');
        end
        else begin
          BankLedgerEntries.Reset;
          BankLedgerEntries.SetRange("Document No.",ReceiptNo);
          BankLedgerEntries.CalcSums(Amount);
          bankAmount := BankLedgerEntries.Amount;

          if bankAmount = 0.0 then
            exit('200: Receipt Reversal Verified Successfully')
          else
            exit('400: Receipt Reversal was not Successful');
        end;

        end else exit('400: Receipt Does not Exist in Nav')
    end;

    [Scope('Personalization')]
    procedure GetGlAccountDetails(var GetGlAccounts: XMLport GetGlAccounts;GlNo: Code[20])
    var
        Customer: Record Customer;
    begin
        GlAccounts.Reset;
        GlAccounts.SetRange("No.",GlNo);

        if GlAccounts.FindFirst then;
        GetGlAccounts.SetTableView(GlAccounts)

    end;

    [Scope('Personalization')]
    procedure PostPayment(PVNo: Code[20];PostingDate: Date) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        PaymentHeaderRec.Reset;
        PaymentHeaderRec.SetRange("Deposit Transaction No",PVNo);
        ReturnValue:='400: Unknown Error';
        if PaymentHeaderRec.FindLast then begin
          if FundsUserSetup.Get(UserId) then begin
            PaymentHeaderRec."Global Dimension 1 Code":= '062';
            PaymentHeaderRec."Posting Date" := PostingDate;
            PaymentHeaderRec.Modify;
            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Template");
            FundsUserSetup.TestField(FundsUserSetup."Payment Journal Batch");
            JTemplate:=FundsUserSetup."Payment Journal Template";JBatch:=FundsUserSetup."Payment Journal Batch";
            if PaymentHeaderRec."Loan Disbursement Type" = PaymentHeaderRec."Loan Disbursement Type"::" " then
             FundsManagement.PostPaymentPortal(PaymentHeaderRec,JTemplate,JBatch,false);

            ReturnValue:='200: Payment Posted Successfully Created';
           end else
            Error('400: ' +UserAccountNotSetup,UserId);

        end else ReturnValue:='400: Payment Not found';
    end;

    [Scope('Personalization')]
    procedure ReversePayment(DepId: Code[20]) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        //CLEAR(ReversalEntry);
        //IF Reversed THEN
         // ReversalEntry.AlreadyReversedDocument(PaymentTxt,"No.");
         ReturnValue := '400: Error No record found';
         PaymentHeaderRec.Reset;
         PaymentHeaderRec.SetRange("Deposit Transaction No",DepId);
         PaymentHeaderRec.SetRange(Reversed,false);
         if PaymentHeaderRec.FindFirst then begin
        //Get transaction no.
        BankAccountLedgerEntry.Reset;
        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.",PaymentHeaderRec."No.");
        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed,false);
        if BankAccountLedgerEntry.FindFirst then begin
          //ReversalEntry.ReverseTransaction(BankAccountLedgerEntry."Transaction No.");
          //ReversalEntry.ReverseEntriesII(BankAccountLedgerEntry."Transaction No.",1,FALSE);
        end;

        Commit;

        //Update the document
        BankAccountLedgerEntry.Reset;
        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry."Document No.",PaymentHeaderRec."No.");
        BankAccountLedgerEntry.SetRange(BankAccountLedgerEntry.Reversed,true);
        if BankAccountLedgerEntry.FindLast then begin
          PaymentHeaderRec.Status:=PaymentHeaderRec.Status::Reversed;
          PaymentHeaderRec.Reversed:=true;
          PaymentHeaderRec."Reversal Date":=Today;
          PaymentHeaderRec."Reversal Time":=Time;
          PaymentHeaderRec."Reversed By":=UserId;
          PaymentHeaderRec.Modify;
           ReturnValue:='200: Payment Reversed Successfully';
        end;

        //ReversalPost.SetPrint(FALSE);
        //ReversalPost.RUN(ReversalEntry);

        end;
    end;

    [Scope('Personalization')]
    procedure CanceltPayment(DepId: Code[20];Reason: Text) ReturnValue: Text
    var
        ReceiptHeader: Record "Receipt Header";
    begin
        PaymentHeaderRec.Reset;
        PaymentHeaderRec.SetRange("Deposit Transaction No",DepId);
        ReturnValue:='400: Unknown Error';
        if PaymentHeaderRec.FindFirst then begin
          PaymentHeaderRec."Reason for Cancellation":=Reason;
          PaymentHeaderRec.Status := PaymentHeaderRec.Status::Cancelled;
          PaymentHeaderRec.Modify;
          ReturnValue:='200: Payment Cancelled Successfully';
        end else ReturnValue:='400: Payment Not found';
    end;

    [Scope('Personalization')]
    procedure GetGlAmountPerPeriod(GlNo: Code[20];StartDate: Date;EndDate: Date) Amount: Decimal
    begin
        GlAccounts.Reset;
        GlAccounts.SetRange("No.",GlNo);
        if GlAccounts.FindFirst then begin
        //GLAccounts.SETRANGE("Date Filter",EndDate,StartDate);
        GlAccounts.SetFilter("Date Filter",'%1..%2',StartDate,EndDate);
        GlAccounts.CalcFields("Net Change");
        Amount := Abs(GlAccounts."Net Change");
        end;
    end;

    [Scope('Personalization')]
    procedure GetCustomerBalanceAsAtDate(CustomerNo: Code[20];DateStatus: Date) Amount: Decimal
    begin
        Amount := 0.0;
        CustLedgerEntry.Reset;
        CustLedgerEntry.SetRange("Customer No.",CustomerNo);
        CustLedgerEntry.SetFilter("Posting Date",'..%1',DateStatus);
        if CustLedgerEntry.FindSet then begin
        repeat
          CustLedgerEntry.CalcFields(Amount);
          Amount := Amount + CustLedgerEntry.Amount;//CustLedgerEntry.Amount;
          until CustLedgerEntry.Next = 0;
        end else
         Amount :=0.0;
    end;

    local procedure UpdateCustomerChangeOfNameInvoice(PreviousCustomerNo: Code[20];NewCustomerNo: Code[20];InvoiceCode: Code[20];InvoiceId: Code[20]) ReturnValue: Text
    begin
        CustLedgerEntry.Reset;
        CustLedgerEntry.SetRange("Customer No.",PreviousCustomerNo);
        CustLedgerEntry.SetRange("External Document No.",InvoiceCode);

        if CustLedgerEntry.FindSet then begin
        repeat
          DetailedCustomerLedger.Reset;
          DetailedCustomerLedger.SetRange("Cust. Ledger Entry No.",CustLedgerEntry."Entry No.");
          if DetailedCustomerLedger.FindSet then begin
            repeat
              DetailedCustomerLedger."Customer No." := NewCustomerNo;
              DetailedCustomerLedger.Modify;
              until DetailedCustomerLedger.Next = 0;
            end;
          CustLedgerEntry."Customer No." := NewCustomerNo;
          CustLedgerEntry.Modify;
          ReturnValue := '200: Updated Successfully';
          until CustLedgerEntry.Next = 0;
        end else ReturnValue := '400: Transaction Not Found';
    end;

    local procedure UpdateCustomerChangeOfNameReceipt(PreviousCustomerNo: Integer;NewCustomerNo: Integer;ReceiptCode: Integer)
    begin
    end;

    local procedure UpdateInvoiceChangeOfNameInvoice(PreviousCustomerNo: Integer;NewCustomerNo: Integer;ReceiptCode: Integer)
    begin
    end;

    [Scope('Personalization')]
    procedure GetInvoiceDetailAmount(GlNo: Code[20];InvoCode: Code[20];Status: Option posted,cancelled;InvoId: Code[20]) ReturnValue: Text
    begin
        ReturnValue:='400:-';
        if  Status = Status::posted then begin

        GlEntry.Reset;
        GlEntry.SetRange("External Document No.",InvoCode);
        if GlEntry.FindFirst then
           begin
           GlEntryII.Reset;
            GlEntryII.SetRange("External Document No.",InvoCode);
            GlEntryII.SetRange("G/L Account No.",GlNo);

            if GlEntryII.FindFirst then begin
              ReturnValue := Format(Abs(GlEntry.Amount),0,1)
              end else ReturnValue := '400: Record was posted in wrong gl i.e ' +GlEntry."G/L Account No."
           end

        else ReturnValue := '400: Record Not Posted to Nav';
        end else begin
          // when cancelled
            GlEntry.Reset;
            GlEntry.SetRange("External Document No.",InvoCode);
            if GlEntry.FindFirst then begin

               GlEntryII.Reset;
               GlEntryII.SetRange("External Document No.",InvoId);
                if GlEntryII.FindFirst then begin

                   GlEntryIII.Reset;
                   GlEntryIII.SetRange("External Document No.",InvoId);
                   GlEntryIII.SetRange("G/L Account No.",GlNo);

                  if GlEntryIII.FindFirst then begin
                  ReturnValue := Format(Abs(GlEntry.Amount),0,1)
                  end else ReturnValue := '400: Credit Memo was posted in wrong gl i.e ' +GlEntryII."G/L Account No."

               end
                else ReturnValue := '400: Credit Memo is Not Posted to Nav';


               end else ReturnValue := '400: The Cancelled Invoice is not posted to Nav';
          end;
    end;

    [Scope('Personalization')]
    procedure GetReceiptDetail(var BankledgerExport: XMLport "BankledgerEntry Xml";ReceiptNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if ReceiptNo<>'' then begin

          BankLedgerEntries.Reset;
          BankLedgerEntries.SetRange("Document No.",ReceiptNo);
          if BankLedgerEntries.FindFirst then ;
          BankledgerExport.SetTableView(BankLedgerEntries);

        end;
    end;

    [Scope('Personalization')]
    procedure GetGlAccountListII(var GetGlAccounts: XMLport GetGlAccounts)
    var
        Customer: Record Customer;
    begin
    end;
}

