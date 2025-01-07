pageextension 60256 pageextension60256 extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        addafter("Posting Date")
        {
            // field("External Document No."; Rec."External Document No.")
            // {
            // }
        }
        addafter(Description)
        {
            field(Payee; Rec.Payee)
            {
            }
        }
    }
    actions
    {

        addfirst(processing)
        {
            action("Transfer Line")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                    BankAccReconciliationLineCopy: Record "Bank Acc. Reconciliation Line";
                begin

                end;
                //                 BankAccReconciliationLine.RESET;
                //                 BankAccReconciliationLine.SETRANGE("Bank Account No.","Bank Account No.");
                //                 //BankAccReconciliationLine.SETRANGE("Statement No.","Statement No.");
                //                 IF BankAccReconciliationLine.FINDLAST THEN
                //   BEGIN
                //     BankAccReconciliationLineCopy.INIT;
                //                 BankAccReconciliationLineCopy."Statement Line No.":= BankAccReconciliationLine."Statement Line No."+10000;
                //                 BankAccReconciliationLineCopy."Statement No.":=BankAccReconciliationLine."Statement No.";
                //                 BankAccReconciliationLineCopy."Bank Account No.":="Bank Account No.";
                //                 BankAccReconciliationLineCopy."Transaction Date":="Posting Date";
                //                 //BankAccReconciliationLineCopy.tr
                //                 BankAccReconciliationLineCopy.Description:=Description;
                //                 BankAccReconciliationLineCopy."Statement Amount":=Amount;
                //                 BankAccReconciliationLineCopy."Document No.":="External Document No.";
                //                 BankAccReconciliationLine.Applied:=TRUE;
                //                 BankAccReconciliationLineCopy."Applied Amount":=Amount;
                //                 BankAccReconciliationLineCopy.Reconciled:=TRUE;
                //                 BankAccReconciliationLineCopy."Applied Entries":=1;
                //                 BankAccReconciliationLineCopy.Difference:=0;
                //                 BankAccReconciliationLineCopy.INSERT(TRUE);
                //     //Applied:=TRUE;
                //     //"Statement Status":="Statement Status"::Closed;
                //     //"Statement No.":=BankAccReconciliationLine."Statement No.";
                //     //"Statement Line No.":=BankAccReconciliationLineCopy."Statement Line No.";

                //         MODIFY;
                //         CurrPage.UPDATE;
                //         MESSAGE('Statement line no. %1 created successfully',BankAccReconciliationLineCopy."Statement Line No.");
                //     END
                //     ELSE
                //     BEGIN
                //      BankAccReconciliationLineCopy.INIT;
                //     BankAccReconciliationLineCopy."Statement Line No.":=10000;
                //     BankAccReconciliationLineCopy."Statement No.":=BankAccReconciliationLine."Statement No.";
                //     BankAccReconciliationLineCopy."Bank Account No.":="Bank Account No.";
                //     BankAccReconciliationLineCopy."Transaction Date":="Posting Date";
                //     //BankAccReconciliationLineCopy.tr
                //     BankAccReconciliationLineCopy.Description:=Description;
                //     BankAccReconciliationLineCopy."Statement Amount":=Amount;
                //     BankAccReconciliationLineCopy."Document No.":="External Document No.";
                //     BankAccReconciliationLineCopy.Applied:=TRUE;
                //     BankAccReconciliationLineCopy.Reconciled:=TRUE;
                //     BankAccReconciliationLineCopy."Applied Amount":=Amount;
                //     BankAccReconciliationLineCopy.Difference:=0;
                //     BankAccReconciliationLineCopy."Applied Entries":=1;
                //     BankAccReconciliationLineCopy.INSERT(TRUE);
                //     //Applied:=TRUE;
                //     //"Statement Status":="Statement Status"::Closed;
                //     //"Statement No.":=BankAccReconciliationLine."Statement No.";
                //     //"Statement Line No.":=BankAccReconciliationLineCopy."Statement Line No.";
                //     MODIFY;
                //     CurrPage.UPDATE;
                //     MESSAGE('Statement line no. %1 created successfully',BankAccReconciliationLineCopy."Statement Line No.");

                //       END;
            }
        }
    }


    //Unsupported feature: Property Modification (Attributes) on "GetSelectedRecords(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetUserInteractions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "ToggleMatchedFilter(PROCEDURE 5)".


    procedure SetFilter(StartDate: Date; EndDate: Date)
    begin
        Rec.SetRange("Posting Date", StartDate, EndDate);
        CurrPage.Update;
    end;
}

