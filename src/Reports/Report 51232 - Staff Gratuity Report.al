report 51232 "Staff Gratuity Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Staff Gratuity Report.rdl';



    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "Payroll Code";
            column(CompanyInfoName; CompanyInfo.name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebPage; CompanyInfo."Home Page")
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee.FullName)
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(PIN_Employee; Employee.PIN)
            {
            }
            column(Periodfilter; Periodfilter)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(Gratuityq; Gratuityq)
            {
            }
            column(TaxExmpt; TaxExmpt)
            {
            }
            column(Taxable; Taxable)
            {
            }
            column(taxedGratuity; taxedGratuity)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(TotalGratuity; TotalGratuity)
            {
            }
            column(FulName; Employee."Full Name")
            {
            }
            column(PayrollPeriod; PayrollPeriod)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PayrollSetups.Get(Employee."Payroll Code");
                PayrollSetups.TestField("Gratuity Percentage");
                PayrollSetups.TestField("Gratuity Tax Rate");
                BasicPay := 0;
                Gratuityq := 0;
                TaxExmpt := 0;
                Taxable := 0;
                taxedGratuity := 0;
                PAYE := 0;
                TotalGratuity := 0;
                //BasicPay:=Employee."Fixed Pay"

                payrolllineRec.Reset;
                payrolllineRec.SetRange("Payroll ID", PayrollPeriod);
                payrolllineRec.SetRange("Employee No.", Employee."No.");
                //payrolllineRec.SETRANGE("ED Code",PayrollSetups."Basic Pay E/D Code");
                payrolllineRec.SetRange("ED Code", PayrollSetups."Gratitude ED Code");
                if payrolllineRec.FindSet then begin
                    repeat
                        Gratuityq := payrolllineRec.Amount;
                        //Gratuityq:=ROUND((PayrollSetups."Gratuity Percentage"/100)*BasicPay,1);
                        TaxExmpt := PayrollSetups."Gratuity Tax Exempt";
                        if (Gratuityq - PayrollSetups."Gratuity Tax Exempt") > 0 then begin
                            Taxable := Gratuityq - PayrollSetups."Gratuity Tax Exempt";
                            PAYE := Round((PayrollSetups."Gratuity Tax Rate" / 100) * Taxable, 0.1);
                            taxedGratuity := Taxable - PAYE;
                            TotalGratuity := taxedGratuity + TaxExmpt;
                            //Basic
                            BasicPay := 0;
                            payrolllineRec.Reset;
                            payrolllineRec.SetRange("Payroll ID", PayrollPeriod);
                            payrolllineRec.SetRange("Employee No.", Employee."No.");
                            payrolllineRec.SetRange("ED Code", PayrollSetups."Basic Pay E/D Code");
                            if payrolllineRec.FindSet then begin
                                BasicPay := payrolllineRec.Amount;
                            end;
                        end;
                    until payrolllineRec.Next = 0;

                end else begin
                    TotalGratuity := Gratuityq;
                    if Taxable = 0 then
                        CurrReport.Skip;
                end;


                if GenerateJournalEntries then begin
                    SourceCode := 'GENERALJNL';
                    docno := Employee."No." + '- ' + Format(PayrollPeriod);
                    GLEntry.Reset;
                    GLEntry.SetRange(GLEntry."Document No.", docno);
                    GLEntry.SetRange(GLEntry.Reversed, false);
                    if GLEntry.FindFirst then
                        repeat
                            GLEntry.Delete;
                        until GLEntry.Next = 0;

                    /* BEGIN
                     ERROR(DocumentExist,docno,PaymentHeader."Bank Account No.");
                   END;
                   */

                    LineNo := LineNo + 1000;
                    //*********************************************Add Payment Header***************************************************************//

                    /*
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name":=PayrollSetups."Gratuity Journal Template";
                    GenJnlLine.VALIDATE("Journal Template Name");
                    GenJnlLine."Journal Batch Name":=PayrollSetups."Gratuity Journal Batch";
                    GenJnlLine.VALIDATE("Journal Batch Name");
                    GenJnlLine."Line No.":=LineNo;
                    GenJnlLine."Source Code":=SourceCode;

                    GenJnlLine."Posting Date":=Periods."End Date";
                    GenJnlLine."Document Type":=GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No.":=docno;
                    GenJnlLine."External Document No.":=docno;
                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No.":=PayrollSetups."Gratuity Expense GL";
                    GenJnlLine.VALIDATE("Account No.");

                    GenJnlLine.Amount:=(Gratuityq);  //Credit Amount
                    GenJnlLine.VALIDATE(Amount);
                    GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No.":='';
                    GenJnlLine.VALIDATE("Bal. Account No.");
                    GenJnlLine.Description:=UPPERCASE(COPYSTR(Employee.FullName+'-'+FORMAT(PayrollPeriod)+' Gratuity',1,100));
                    GenJnlLine.Description2:=GenJnlLine.Description;
                    GenJnlLine.VALIDATE(Description);

                    IF GenJnlLine.Amount<>0 THEN
                        GenJnlLine.INSERT;
                    LineNo:=LineNo+1000;

                    GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := PayrollSetups."Gratuity Journal Template";
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := PayrollSetups."Gratuity Journal Batch";
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := Periods."End Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := docno;
                        GenJnlLine."External Document No." := docno;
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := PayrollSetups."Gratuity Liability GL";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine.Amount := -(TotalGratuity);  //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine.Description := UPPERCASE(COPYSTR(Employee.FullName + '-' + FORMAT(PayrollPeriod) + ' Gratuity payable', 1, 100));
                        GenJnlLine.Description2 := GenJnlLine.Description;
                        GenJnlLine.VALIDATE(Description);
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;

                        LineNo := LineNo + 1000;

                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := PayrollSetups."Gratuity Journal Template";
                        GenJnlLine.VALIDATE("Journal Template Name");
                        GenJnlLine."Journal Batch Name" := PayrollSetups."Gratuity Journal Batch";
                        GenJnlLine.VALIDATE("Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := Periods."End Date";
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                        GenJnlLine."Document No." := docno;
                        GenJnlLine."External Document No." := docno;
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := PayrollSetups."GratuityTax GL";
                        GenJnlLine.VALIDATE("Account No.");
                        GenJnlLine.Amount := -(PAYE);  //Credit Amount
                        GenJnlLine.VALIDATE(Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                        GenJnlLine.Description := UPPERCASE(COPYSTR(Employee.FullName + '-' + FORMAT(PayrollPeriod) + ' Gratuity Tax', 1, 100));
                        GenJnlLine.Description2 := GenJnlLine.Description;
                        GenJnlLine.VALIDATE(Description);

                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                        COMMIT;
                    */
                end

            end;

            trigger OnPostDataItem()
            begin
                //Adjust GenJnlLine Exchange Rate Rounding Balances
                /*
                IF GenerateJournalEntries THEN
                  BEGIN
                CLEAR(GeneralJournalpage);
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name",PayrollSetups."Gratuity Journal Template");
                GenJnlLine.SETRANGE("Journal Batch Name",PayrollSetups."Gratuity Journal Batch");
                AdjustGenJnl.RUN(GenJnlLine);
                //End Adjust GenJnlLine Exchange Rate Rounding Balances
                
                
                //GeneralJournalpage.SETTABLEVIEW(GenJnlLine);
                //GeneralJournalpage.CurrentJnlBatchName:=;'GenJournalBatch
                GenJournalBatch.RESET;
                GenJournalBatch.SETRANGE("Journal Template Name",PayrollSetups."Gratuity Journal Template");
                GenJournalBatch.SETRANGE(Name,PayrollSetups."Gratuity Journal Batch");
                IF GenJournalBatch.FINDFIRST THEN
                  GenJnlManagement.TemplateSelectionFromBatch(GenJournalBatch);
                //GenJnlManagement.OpenJnlBatch(GenJournalBatch);
                {
                IF NOT Preview THEN BEGIN
                  //Post the Journal Lines
                  CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnlLine);
                  COMMIT;
                GLEntry.RESET;
                Gl
                GLEntry.SETRANGE("Document No.", PaymentHeader."No.");
                IF GLEntry.FINDFIRST THEN BEGIN
                    MESSAGE('Gratuity Posted Successfully')
                END;
                COMMIT;
            END ELSE BEGIN
                  GenJnlLine.RESET;
                  GenJnlLine.SETRANGE("Journal Template Name",PayrollSetups."Gratuity Journal Template");
                  GenJnlLine.SETRANGE("Journal Batch Name",PayrollSetups."Gratuity Journal Batch");
                  IF GenJnlLine.FINDSET THEN BEGIN
                    GenJnlPost.Preview(GenJnlLine);
                  END;
                END;
                }
                END
                */

            end;

            trigger OnPreDataItem()
            begin
                Employee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                /*IF (StartDate=0D) OR (Enddate=0D) THEN
                  ERROR('Please Input Date Filters');
                Periodfilter:=FORMAT(StartDate)+'..'+FORMAT(Enddate);
                PayrollSetups.GET(Employee."Payroll Code");
                PayrollSetups.TESTFIELD("Gratuity Percentage");
                PayrollSetups.TESTFIELD("Gratuity Tax Rate");
                */
                PayrollSetups.Get(gvAllowedPayrolls."Payroll Code");
                PayrollSetups.TestField("Gratuity Percentage");
                PayrollSetups.TestField("Gratuity Tax Rate");
                //PayrollSetups.TESTFIELD("Gratuity Journal Template");
                //PayrollSetups.TESTFIELD("Gratuity Journal Batch");
                //Delete Journal Lines if Exist
                /*
                GenJnlLine.RESET;
                GenJnlLine.SETRANGE("Journal Template Name",PayrollSetups."Gratuity Journal Template");
                GenJnlLine.SETRANGE("Journal Batch Name",PayrollSetups."Gratuity Journal Batch");
                IF GenJnlLine.FINDSET THEN BEGIN
                  GenJnlLine.DELETEALL;
                END;
                */
                //End Delete

                Periods.Reset;
                Periods.SetRange("Period ID", PayrollPeriod);
                //if Periods.FindFirst then

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Payroll Period"; PayrollPeriod)
                    {
                        TableRelation = Periods."Period ID" WHERE("Payroll Code" = CONST('CMT'));
                    }
                    field("Generate Journal Entries"; GenerateJournalEntries)
                    {
                        Visible = false;
                    }
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        gsSegmentPayrollData;
    end;

    var
        CompanyInfo: Record "Company Information";
        StartDate: Date;
        Enddate: Date;
        Periodfilter: Text;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        PayrollSetups: Record "Payroll Setups";
        BasicPay: Decimal;
        Gratuityq: Decimal;
        TaxExmpt: Decimal;
        Taxable: Decimal;
        taxedGratuity: Decimal;
        PAYE: Decimal;
        TotalGratuity: Decimal;
        GenerateJournalEntries: Boolean;
        PayrollPeriod: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";
        SourceCode: Code[20];
        GLEntry: Record "G/L Entry";
        PaymentLine2: Record "Payment Line";
        PaymentHeader2: Record "Payment Header";
        EmployeeLoanAccounts: Record "Employee Loan Accounts";
        LoanRepayment: Record "Employee Repayment Schedule";
        PaymentCodes: Record "Funds Transaction Code";
        EmployeeLoanProducts: Record "Employee Loan Products";
        docno: Code[30];
        DocumentExist: Label 'Allready posted, Document No.:%1 already exists ';
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        Preview: Boolean;
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GeneralJournalpage: Page "General Journal";
        Periods: Record Periods;
        GenJnlManagement: Codeunit GenJnlManagement;
        GenJournalBatch: Record "Gen. Journal Batch";
        payrolllineRec: Record "Payroll Lines";

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
            Error('You are not allowed access to this payroll dataset.');
    end;

}