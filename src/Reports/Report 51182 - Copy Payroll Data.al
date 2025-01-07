report 51182 "Copy Payroll Data"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Cause of Absence";"Cause of Absence")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                grCauseofAbsence.SetRange("Payroll Code", gvCopyToPayroll);
                grCauseofAbsence.SetFilter(Code, '*%1*', gvCopyToPayroll);

                if not grCauseofAbsence.Find('-') then begin
                  grCauseofAbsence.Copy("Cause of Absence");
                  grCauseofAbsence.Code := CopyStr(Code + gvCopyToPayroll, 1, 10);
                  grCauseofAbsence."Payroll Code" := gvCopyToPayroll;
                  if not grCauseofAbsence.Insert then; //skip silently
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvCauseofAbsence then CurrReport.Break;
            end;
        }
        dataitem("Coinage Analysis Setup";"Coinage Analysis Setup")
        {
            DataItemTableView = SORTING(Line);

            trigger OnAfterGetRecord()
            begin
                gvLineNo += 10;
                grCoinageAnalysisSetup.Copy("Coinage Analysis Setup");
                grCoinageAnalysisSetup."Payroll Code" := gvCopyToPayroll;
                grCoinageAnalysisSetup.Line := gvLineNo;
                if not grCoinageAnalysisSetup.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvCoinageAnalysisSetup then CurrReport.Break;

                if grCoinageAnalysisSetup.Find('+') then
                  gvLineNo := grCoinageAnalysisSetup.Line
                else
                  gvLineNo := 0;
            end;
        }
        dataitem("Calculation Header";"Calculation Header")
        {
            DataItemTableView = SORTING("Scheme ID");

            trigger OnAfterGetRecord()
            begin
                grCalculationHeader.SetRange("Payroll Code", gvCopyToPayroll);
                grCalculationHeader.SetFilter("Scheme ID", '*%1*', gvCopyToPayroll);

                if not grCalculationHeader.Find('-') then begin
                  grCalculationHeader.Copy("Calculation Header");
                  grCalculationHeader."Scheme ID" := CopyStr("Scheme ID" + gvCopyToPayroll, 1, 20);
                  grCalculationHeader."Payroll Code" := gvCopyToPayroll;
                  if not grCalculationHeader.Insert then; //skip silently
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvCalculationHeader then CurrReport.Break;
            end;
        }
        dataitem("Calculation Scheme";"Calculation Scheme")
        {
            DataItemTableView = SORTING("Line No.","Scheme ID");

            trigger OnAfterGetRecord()
            begin
                gvLineNo += 10;

                grCalculationScheme.Copy("Calculation Scheme");
                grCalculationScheme."Scheme ID" := CopyStr("Scheme ID" + gvCopyToPayroll, 1, 20);
                grCalculationScheme."Payroll Code" := gvCopyToPayroll;
                grCalculationScheme."Line No." := gvLineNo;
                if not grCalculationScheme.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvCalculationScheme then CurrReport.Break;

                gvLineNo := 0;
            end;
        }
        dataitem(Periods;Periods)
        {
            DataItemTableView = SORTING("Period ID","Period Month","Period Year","Payroll Code");

            trigger OnAfterGetRecord()
            begin
                grPeriods.Copy(Periods);
                grPeriods."Payroll Code" := gvCopyToPayroll;
                if not grPeriods.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvPeriods then CurrReport.Break;
            end;
        }
        dataitem("Employee Posting Groups";"Employee Posting Groups")
        {
            DataItemTableView = SORTING("Posting Group");

            trigger OnAfterGetRecord()
            begin
                grEmployeePostingGroups.Copy("Employee Posting Groups");
                grEmployeePostingGroups."Posting Group" := CopyStr("Posting Group" + gvCopyToPayroll, 1, 20);
                grEmployeePostingGroups."Payroll Code" := gvCopyToPayroll;
                if not grEmployeePostingGroups.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvEmployeePostingGroups then CurrReport.Break;
            end;
        }
        dataitem(EDPostingGroup;"ED Posting Group")
        {
            DataItemTableView = SORTING("ED Posting Group Code");

            trigger OnAfterGetRecord()
            begin
                grEDPostingGroup.Copy(EDPostingGroup);
                grEDPostingGroup."ED Posting Group Code" := CopyStr("ED Posting Group Code" + gvCopyToPayroll, 1, 20);
                grEDPostingGroup."Payroll Code" := gvCopyToPayroll;
                if not grEDPostingGroup.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvEDPostingGroup then CurrReport.Break;
            end;
        }
        dataitem("Payroll Posting Setup";"Payroll Posting Setup")
        {
            DataItemTableView = SORTING("Posting Group","ED Posting Group");

            trigger OnAfterGetRecord()
            begin
                grPayrollPostingSetup.Copy("Payroll Posting Setup");
                grPayrollPostingSetup."Posting Group" := CopyStr("Posting Group" + gvCopyToPayroll, 1, 20);
                grPayrollPostingSetup."ED Posting Group" := CopyStr("ED Posting Group" + gvCopyToPayroll, 1, 20);
                grPayrollPostingSetup."Payroll Code" := gvCopyToPayroll;
                if not grPayrollPostingSetup.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvPayrollPostingSetup then CurrReport.Break;
            end;
        }
        dataitem("Payroll Setups";"Payroll Setups")
        {
            DataItemTableView = SORTING("Payroll Code");

            trigger OnAfterGetRecord()
            begin
                grPayrollSetup.Copy("Payroll Setups");
                grPayrollSetup."Payroll Code" := gvCopyToPayroll;
                if not grPayrollSetup.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvPayrollSetup then CurrReport.Break;
            end;
        }
        dataitem("Salary Scale";"Salary Scale")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                grSalaryScale.Copy("Salary Scale");
                grSalaryScale.Code := CopyStr(Code + gvCopyToPayroll, 1, 20);
                grSalaryScale."Payroll Code" := gvCopyToPayroll;
                if not grSalaryScale.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvSalaryScale then CurrReport.Break;
            end;
        }
        dataitem("Salary Scale Step";"Salary Scale Step")
        {
            DataItemTableView = SORTING(Code,Scale);

            trigger OnAfterGetRecord()
            begin
                grSalaryScaleStep.Copy("Salary Scale Step");
                grSalaryScaleStep.Code := CopyStr(Code + gvCopyToPayroll, 1, 20);
                grSalaryScaleStep.Scale := CopyStr(Scale + gvCopyToPayroll, 1, 20);
                grSalaryScaleStep."Payroll Code" := gvCopyToPayroll;
                if not grSalaryScaleStep.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvSalaryScaleStep then CurrReport.Break;
            end;
        }
        dataitem("Loan Types";"Loan Types")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                grLoanTypes.Copy("Loan Types");
                grLoanTypes.Code := CopyStr(Code + gvCopyToPayroll, 1, 20);
                grLoanTypes."Payroll Code" := gvCopyToPayroll;
                if not grLoanTypes.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvLoanTypes then CurrReport.Break;
            end;
        }
        dataitem("Payslip Group";"Payslip Group")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                grPayslipGroup.Copy("Payslip Group");
                grPayslipGroup.Code := CopyStr(Code + gvCopyToPayroll, 1, 20);
                grPayslipGroup."Payroll Code" := gvCopyToPayroll;
                if not grPayslipGroup.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvPayslipGroup then CurrReport.Break;
            end;
        }
        dataitem("Payslip Lines";"Payslip Lines")
        {
            DataItemTableView = SORTING("Line No.","Payslip Group");

            trigger OnAfterGetRecord()
            begin
                gvLineNo += 10;

                grPayslipLines.Copy("Payslip Lines");
                grPayslipLines."Payslip Group" := CopyStr("Payslip Group" + gvCopyToPayroll, 1, 20);
                grPayslipLines."Line No." := gvLineNo;
                grPayslipLines."Payroll Code" := gvCopyToPayroll;
                if not grPayslipLines.Insert then; //skip silently
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvCopyFromPayroll);
                if not gvPayslipLines then CurrReport.Break;

                gvLineNo := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(gvCopyFromPayroll;gvCopyFromPayroll)
                    {
                        Caption = 'Copy From Payroll';
                        TableRelation = Payroll;
                    }
                    field(gvCopyToPayroll;gvCopyToPayroll)
                    {
                        Caption = 'Copy to Payroll';
                        TableRelation = Payroll;
                    }
                    group(Copy)
                    {
                        Caption = 'Copy';
                    }
                    field(gvCauseofAbsence;gvCauseofAbsence)
                    {
                        Caption = 'Cause of Absence';
                    }
                    field(gvCoinageAnalysisSetup;gvCoinageAnalysisSetup)
                    {
                        Caption = 'Coinage Analysis setup';
                    }
                    field(gvCalculationHeader;gvCalculationHeader)
                    {
                        Caption = 'Calculation header';
                    }
                    field(gvCalculationScheme;gvCalculationScheme)
                    {
                        Caption = 'Calculation Scheme';
                    }
                    field(gvPeriods;gvPeriods)
                    {
                        Caption = 'Periods';
                    }
                    field(gvPayrollPostingSetup;gvPayrollPostingSetup)
                    {
                        Caption = 'Payroll Posting Setup';
                    }
                    field(gvEmployeePostingGroups;gvEmployeePostingGroups)
                    {
                        Caption = 'Employee Posting Groups';
                    }
                    field(gvEDPostingGroup;gvEDPostingGroup)
                    {
                        Caption = 'Ed Posting Group';
                    }
                    field(gvPayrollSetup;gvPayrollSetup)
                    {
                        Caption = 'Payroll Setup';
                    }
                    field(gvSalaryScale;gvSalaryScale)
                    {
                        Caption = 'Salary Scale';
                    }
                    field(gvSalaryScaleStep;gvSalaryScaleStep)
                    {
                        Caption = 'Salary Scale Step';
                    }
                    field(gvLoanTypes;gvLoanTypes)
                    {
                        Caption = 'Loan Types';
                    }
                    field(gvPayslipGroup;gvPayslipGroup)
                    {
                        Caption = 'Payslip Group';
                    }
                    field(gvPayslipLines;gvPayslipLines)
                    {
                        Caption = 'Payslip Lines';
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
        if Confirm('This function copies payroll data from one payroll to another within one Navision company.\'  +
          'Existing records will not be replaced or updated. Proceed anyway?', false) = false then CurrReport.Quit;

        if gvCopyFromPayroll = gvCopyToPayroll then Error('Source and destination payrolls can not be the same!');
        if (gvCopyFromPayroll = '') or (gvCopyToPayroll = '') then Error('Source and destination payrolls can not be blank!');
    end;

    var
        gvCopyFromPayroll: Code[10];
        gvCopyToPayroll: Code[10];
        gvCauseofAbsence: Boolean;
        gvCoinageAnalysisSetup: Boolean;
        gvCalculationHeader: Boolean;
        gvCalculationScheme: Boolean;
        gvPeriods: Boolean;
        gvEmployeePostingGroups: Boolean;
        gvEDPostingGroup: Boolean;
        gvPayrollPostingSetup: Boolean;
        gvPayrollSetup: Boolean;
        gvSalaryScale: Boolean;
        gvSalaryScaleStep: Boolean;
        gvLoanTypes: Boolean;
        gvPayslipGroup: Boolean;
        gvPayslipLines: Boolean;
        grCauseofAbsence: Record "Cause of Absence";
        grCoinageAnalysisSetup: Record "Coinage Analysis Setup";
        grCalculationHeader: Record "Calculation Header";
        grCalculationScheme: Record "Calculation Scheme";
        grPeriods: Record Periods;
        grEmployeePostingGroups: Record "Employee Posting Groups";
        grEDPostingGroup: Record "ED Posting Group";
        grPayrollPostingSetup: Record "Payroll Posting Setup";
        grPayrollSetup: Record "Payroll Setups";
        grSalaryScale: Record "Salary Scale";
        grSalaryScaleStep: Record "Salary Scale Step";
        grLoanTypes: Record "Loan Types";
        grPayslipGroup: Record "Payslip Group";
        grPayslipLines: Record "Payslip Lines";
        gvLineNo: BigInteger;
}

