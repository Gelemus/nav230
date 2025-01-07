report 50020 "Vote Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Vote Book.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting));
            column(AccNo; "G/L Account"."No.")
            {
            }
            column(AccName; "G/L Account".Name)
            {
            }
            column(IncomeBalance; "G/L Account"."Income/Balance")
            {
            }
            column(DebitAmt; "G/L Account"."Debit Amount")
            {
            }
            column(CreditAmt; "G/L Account"."Credit Amount")
            {
            }
            column(BDAmt; "G/L Account"."Budgeted Debit Amount")
            {
            }
            column(CDAmt; "G/L Account"."Budgeted Credit Amount")
            {
            }
            column(AccBalance; "G/L Account".Balance)
            {
            }
            column(BudgetedAmt; "G/L Account"."Budgeted Amount")
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(ActualExpenditure; ActualExpenditure)
            {
            }
            column(TotalCommitment; TotalCommitment)
            {
            }
            column(BudgetedAmount; BudgetedAmount)
            {
            }
            column(TotalCommAct; TotalCommAct)
            {
            }
            column(Balance; Balance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(BudgetedAmount);
                Clear(TotalCommitment);
                Clear(ActualExpenditure);
                Clear(TotalCommAct);
                Clear(Balance);

                BudgetEntry.Reset;
                BudgetEntry.SetRange(BudgetEntry."Budget Name", BudgetCode);
                BudgetEntry.SetRange(BudgetEntry."G/L Account No.", "G/L Account"."No.");
                if BudgetEntry.FindFirst then begin
                    BudgetedAmount := BudgetEntry.Amount;
                end;

                Committments.Reset;
                Committments.SetRange(Committments.Budget, BudgetCode);
                Committments.SetRange(Committments."G/L Account No.", "G/L Account"."No.");
                if Committments.FindSet then begin
                    repeat
                        TotalCommitment := TotalCommitment + Committments.Amount;
                    until Committments.Next = 0;
                end;


                BudgetControl.Get();
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."G/L Account No.", "G/L Account"."No.");
                GLEntry.SetRange("Posting Date", BudgetControl."Current Budget Start Date", BudgetControl."Current Budget End Date");
                if GLEntry.FindSet then begin
                    repeat
                        ActualExpenditure := ActualExpenditure + GLEntry.Amount;
                    until GLEntry.Next = 0;
                end;


                TotalCommAct := TotalCommitment + ActualExpenditure;

                if TotalCommAct >= 0 then
                    Balance := BudgetedAmount - TotalCommAct
                else if TotalCommAct < 0 then
                    Balance := BudgetedAmount + TotalCommAct;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get;
                CompInf.CalcFields(CompInf.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BudgetCode; BudgetCode)
                {
                    TableRelation = "G/L Budget Name".Name;
                }
            }
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
        //GLFilter := "G/L Account".GETFILTERS;
        //PeriodText := "G/L Account".GETFILTER("Date Filter");
    end;

    var
        Committments: Record "Budget Committment";
        BudgetName: Code[7];
        Spend: Decimal;
        BudgetBalance: Decimal;
        PostingDateFilter: Date;
        AmtCommitted: Decimal;
        BudgetEntry: Record "G/L Budget Entry";
        CompInf: Record "Company Information";
        GLFilter: Text;
        PeriodText: Text[30];
        BudgetCode: Code[80];
        ActualExpenditure: Decimal;
        TotalCommitment: Decimal;
        BudgetedAmount: Decimal;
        Balance: Decimal;
        GLEntry: Record "G/L Entry";
        TotalCommAct: Decimal;
        BudgetControl: Record "Budget Control Setup";
}

