xmlport 50044 "Import Bank Statement"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Bank Acc. Reconciliation Line";"Bank Acc. Reconciliation Line")
            {
                AutoReplace = true;
                AutoUpdate = false;
                XmlName = 'StatementImport';
                fieldelement(DocumentNo;"Bank Acc. Reconciliation Line"."Document No.")
                {
                    MaxOccurs = Unbounded;
                }
                fieldelement(TransDate;"Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                fieldelement(Description;"Bank Acc. Reconciliation Line".Description)
                {
                    MaxOccurs = Unbounded;
                }
                fieldelement(StatementAmount;"Bank Acc. Reconciliation Line"."Statement Amount")
                {
                    FieldValidate = yes;
                    MaxOccurs = Unbounded;
                }

                trigger OnBeforeInsertRecord()
                begin
                    lineno+=1;
                    "Bank Acc. Reconciliation Line"."Statement Line No.":=lineno;
                    "Bank Acc. Reconciliation Line"."Statement Type":="Bank Acc. Reconciliation Line"."Statement Type"::"Bank Reconciliation";
                    "Bank Acc. Reconciliation Line"."Bank Account No.":=Bankacc;
                    "Bank Acc. Reconciliation Line"."Statement No.":=statementNo;
                end;
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
        Message('Entries successful uploaded');
    end;

    trigger OnPreXmlPort()
    begin
        BankAccReconciliationLine.Reset;
        BankAccReconciliationLine.SetRange("Bank Account No.",Bankacc);
        BankAccReconciliationLine.SetRange("Statement No.",statementNo);
        if BankAccReconciliationLine.FindLast then
          lineno:=BankAccReconciliationLine."Statement Line No."
        else
          lineno:=0
    end;

    var
        lineno: Integer;
        Bankacc: Code[20];
        statementNo: Code[20];
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";

    procedure SetstatementDetails(pstatementNo: Code[20];pBankAcc: Code[20])
    begin
        statementNo:=pstatementNo;
        Bankacc:=pBankAcc;
    end;
}

