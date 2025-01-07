report 51180 "Generate Duplicate Payslip"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Periods;Periods)
        {
            DataItemTableView = SORTING("Start Date") ORDER(Ascending) WHERE(Status=FILTER(Open|Posted));
            RequestFilterFields = "Period ID";
            dataitem(Employee;Employee)
            {
                DataItemTableView = SORTING("No.") ORDER(Ascending);
                RequestFilterFields = "No.","Membership No.";
                dataitem("Payslip Group";"Payslip Group")
                {
                    DataItemTableView = SORTING(Code);
                    dataitem("Payslip Lines";"Payslip Lines")
                    {
                        DataItemLink = "Payslip Group"=FIELD(Code);
                        DataItemTableView = SORTING("Line No.","Payslip Group");
                        dataitem("Payroll Lines";"Payroll Lines")
                        {
                            DataItemLink = "ED Code"=FIELD("E/D Code");
                            DataItemTableView = SORTING("Payroll ID","Employee No.") ORDER(Ascending);

                            trigger OnAfterGetRecord()
                            begin
                                EDDefRec.Get("ED Code");
                                if EDDefRec.Cumulative then begin
                                  EmployeeRec.Get(Employee."No.");
                                  EmployeeRec.SetRange("ED Code Filter", "ED Code");
                                  EmployeeRec.SetFilter("Date Filter", '%1..%2', PeriodRec."Start Date", Periods."End Date");
                                  EmployeeRec.CalcFields("Amount To Date");
                                  CumilativeDec := EmployeeRec."Amount To Date";
                                end else
                                  CumilativeDec := 0;
                                
                                case EDDefRec."Calculation Group" of
                                  EDDefRec."Calculation Group"::None://None
                                    /*IF "Payroll Lines"."ED Code"='TAXRELEIF' THEN
                                      "Payslip Lines".Amount:="Payroll Lines".Amount*-1
                                    ELSE*/
                                    "Payroll Lines".Amount := "Payroll Lines".Amount;
                                  EDDefRec."Calculation Group"::Deduction:
                                    if "Payslip Lines".Negative then
                                       "Payroll Lines".Amount := -"Payroll Lines".Amount
                                    else
                                       "Payroll Lines".Amount := "Payroll Lines".Amount;
                                end;
                                
                                TotalAmountDec := TotalAmountDec + "Payroll Lines".Amount;
                                TotalLine := false;
                                
                                // cmm 070813 from sections
                                if ("Loan Entry") and (Amount<>0) then  AddModifyTriplicateRec(Text, Amount);
                                //end cmm

                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange("Employee No.",Employee."No.");
                                SetRange("Payroll ID",Periods."Period ID");
                                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            lvPayrollLines: Record "Payroll Lines";
                            enddate: Date;
                        begin
                            if "Line Type" = "Line Type"::P9 then begin
                              case P9 of
                                P9::A: Amount := HeaderRec."A (LCY)";
                                P9::B: Amount := HeaderRec."B (LCY)";
                                P9::C: Amount := HeaderRec."C (LCY)";
                                P9::D: Amount := HeaderRec."D (LCY)";
                                P9::E1: Amount := HeaderRec."E1 (LCY)";
                                P9::E2: Amount := HeaderRec."E2 (LCY)";
                                P9::E3: Amount := HeaderRec."E3 (LCY)";
                                P9::F:  Amount := HeaderRec."F (LCY)";
                                P9::G:  Amount := HeaderRec."G (LCY)";
                                P9::H:  Amount := HeaderRec."H (LCY)";
                                P9::J:  Amount := HeaderRec."J (LCY)";
                                P9::K:  Amount := HeaderRec."K (LCY)";
                                P9::L:  Amount := HeaderRec."L (LCY)";
                                P9::M:  Amount := HeaderRec."M (LCY)";
                              end;
                              P9Amount := Amount;
                              AddModifyTriplicateRec("P9 Text", P9Amount);
                             end;

                            //Sum all Payroll lines for the same ED.
                            gvAmount :=0;
                            gvRate:=0;
                            gvCumilative :=0;
                            EDText:='';
                            gvQuantity:=0;
                            if "Payslip Lines"."Line Type" = "Payslip Lines"."Line Type"::"E/D code" then begin

                              lvPayrollLines.SetRange("Employee No.",Employee."No.");
                              lvPayrollLines.SetRange("Payroll ID",Periods."Period ID");
                              //lvPayrollLines.SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code");
                              lvPayrollLines.SetRange("Loan Entry",false);
                              lvPayrollLines.SetRange("ED Code","Payslip Lines"."E/D Code");

                              if lvPayrollLines.Find('-') then begin
                                EDText := lvPayrollLines.Text;
                                gvRate:=lvPayrollLines.Rate;

                                EDDefRec.Get("Payslip Lines"."E/D Code");

                                if EDDefRec.Cumulative then begin
                                  EmployeeRec.Get(Employee."No.");
                                  EmployeeRec.SetRange("ED Code Filter",EDDefRec."ED Code");
                                  enddate := Periods."End Date";
                                  EmployeeRec.SetFilter("Date Filter", Format(DMY2Date(1,1,1900)) + '..' + Format(enddate));
                                  EmployeeRec.CalcFields("Amount To Date (LCY)");
                                  gvCumilative  := EmployeeRec."Amount To Date (LCY)";
                                end else
                                  gvCumilative  := 0;
                              end;

                              if lvPayrollLines.Find('-') then
                                repeat
                                  gvQuantity := gvQuantity +lvPayrollLines.Quantity;
                                  gvAmount := gvAmount + lvPayrollLines.Amount;
                                until lvPayrollLines.Next=0;

                            end;

                            //cmm 070813 from sections
                            if gvAmount<>0 then AddModifyTriplicateRec(EDText, gvAmount);
                            if ("Line Type" = 0) and (Amount<>0) then AddModifyTriplicateRec("P9 Text", Amount);
                            //end cmm
                        end;

                        trigger OnPostDataItem()
                        var
                            lvPayslipGroup: Record "Payslip Group";
                        begin
                            //cmm 070813 from sections
                            TotalLine := true;
                            lvPayslipGroup.Reset;
                            lvPayslipGroup.SetRange("Payroll Code","Payslip Lines"."Payroll Code");
                            lvPayslipGroup.SetRange(Code,"Payslip Lines"."Payslip Group");
                            if (lvPayslipGroup."Include Total For Group") and (TotalAmountDec <> 0) then AddModifyTriplicateRec(TotalText, TotalAmountDec);
                            TotalLine := false;
                            //end cmm
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TotalText := 'TOTAL ' + "Heading Text";
                        TotalAmountDec := 0;

                        //cmm 070813 from sections
                        BlankLine := '-------------------------------------------------------------------------------------------------------------';
                        AddModifyTriplicateRec(BlankLine, 0);
                        AddModifyTriplicateRec("Heading Text", 0);
                        //end cmm
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    end;
                }
                dataitem("Integer";"Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;

                    trigger OnAfterGetRecord()
                    begin
                        TotalLine := true;
                        if NetPaydec > 0 then  begin
                          AddModifyTriplicateRec('--------------', 0);
                          AddModifyTriplicateRec('Net Pay ', NetPaydec);
                          AddModifyTriplicateRec(NetPayText, 0);
                          AddModifyTriplicateRec('--------------', 0);
                        end else begin
                          AddModifyTriplicateRec('--------------', 0);
                          AddModifyTriplicateRec('Over Drawn ', NetPaydec);
                          AddModifyTriplicateRec('--------------', 0);
                        end;
                        TotalLine := false;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    blnOK: Boolean;
                    Steps: Integer;
                begin
                    if HeaderRec.Get(Periods."Period ID", "No.") then begin
                      HeaderRec.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)", "Total Rounding Ded (LCY)");
                      NetPaydec := HeaderRec."Total Payable (LCY)" + HeaderRec."Total Rounding Pmts (LCY)" - (HeaderRec."Total Deduction (LCY)" +
                                   HeaderRec."Total Rounding Ded (LCY)");
                    end else
                      CurrReport.Skip;
                    
                    Window.Update(2, "No.");
                    EmploNameText := FullName;
                    
                    BankText := '';
                    AccountText := '';
                    //AA No payments into bank for AAFH
                    /*
                    IF "Bank Code" <> '' THEN BEGIN
                      EmpBank.GET("Bank Code");
                      BankText := UPPERCASE(EmpBank.Name);
                      AccountText := "Bank Account No.";
                      NetPayText := 'PAID INTO BANK';
                    END ELSE BEGIN
                    */
                      gvModeofPayment.Get(Employee."Mode of Payment");
                      BankText := Employee."Mode of Payment";
                      AccountText := '';
                      if gvModeofPayment.Description <> '' then
                        NetPayText := gvModeofPayment.Description
                      else
                        NetPayText := gvModeofPayment.Code;
                    //END;
                    
                    //cmm 070813 from Sections
                    
                      PayslipLineNoCounter := 0; //Reset individual payslip lines counter
                    
                      //choose payslip set and current payslip in set
                      if PayslipNoInSet = 2 then begin
                        PayslipNoInSet :=1;
                        LargestLineNoInSet :=0;
                        LargestSetNo := LargestSetNo + 1
                      end else
                        PayslipNoInSet := PayslipNoInSet + 1;
                    
                      //Move to first line in payslip set
                      if LargestSetNo > 1 then begin
                        TriplicatePayslipRec.Reset;
                        TriplicatePayslipRec.SetRange("Payslip Set", LargestSetNo);
                        TriplicatePayslipRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                        blnOK := TriplicatePayslipRec.Find('-');
                        blnOnFirstLineInSet := true
                      end else if PayslipNoInSet > 1 then begin
                        blnOK := TriplicatePayslipRec.Find('-');
                        blnOnFirstLineInSet := true
                      end
                    
                    //end cmm

                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MonthText := Description;
                Window.Update(1,"Period ID");
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                Window.Open('Processing\'+
                            'Period   #1#########\'+
                            'Employee #2#########');
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

    trigger OnPostReport()
    begin
        Window.Close;
    end;

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
        PayrollSetupRec.Get(gvAllowedPayrolls."Payroll Code");

        //TriplicatePayslipRec.SETRANGE("Payroll Code", gvAllowedPayrolls."Payroll Code");
        TriplicatePayslipRec.DeleteAll;
        LargestLineNoInSet := 0;
        LargestSetNo := 1;
        PayslipNoInSet := 0;

        CompanyNameText := PayrollSetupRec."Employer Name";
        PeriodRec.SetCurrentKey("Start Date");
        PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
        PeriodRec.Find('-');
    end;

    var
        blnOnFirstLineInSet: Boolean;
        TriplicatePayslipRec: Record "Duplicate-Payslip";
        PayslipLineNoCounter: Integer;
        LargestLineNoInSet: Integer;
        PayslipNoInSet: Integer;
        LargestSetNo: Integer;
        PeriodRec: Record Periods;
        EmployeeRec: Record Employee;
        PayrollSetupRec: Record "Payroll Setups";
        HeaderRec: Record "Payroll Header";
        EDDefRec: Record "ED Definitions";
        TotalText: Text[60];
        BlankLine: Text[250];
        NetPayText: Text[60];
        BankText: Text[200];
        AccountText: Text[30];
        MonthText: Text[60];
        EmploNameText: Text[100];
        CompanyNameText: Text[100];
        TotalAmountDec: Decimal;
        NetPaydec: Decimal;
        CumilativeDec: Decimal;
        Window: Dialog;
        P9Amount: Decimal;
        EmpBank: Record "Employee Bank Account";
        TotalLine: Boolean;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvModeofPayment: Record "Mode of Payment";
        gvAmount: Decimal;
        EDText: Text[100];
        gvQuantity: Decimal;
        gvCumilative: Decimal;
        gvRate: Decimal;

    procedure AddModifyTriplicateRec(parDescription: Text[250];parAmnt: Decimal)
    var
        BankRec: Record "Employee Bank Account";
    begin
        case PayslipNoInSet of
          1: begin
            PayslipLineNoCounter := PayslipLineNoCounter + 1;
            LargestLineNoInSet := LargestLineNoInSet + 1;

            TriplicatePayslipRec.Init;
            TriplicatePayslipRec.Rate1 :="Payroll Lines".Rate ;
            TriplicatePayslipRec.Qty1 :="Payroll Lines".Quantity;
            TriplicatePayslipRec.Cumm1 := CumilativeDec;
            TriplicatePayslipRec.Bal1 := 0;
            TriplicatePayslipRec."Payslip Set" := LargestSetNo;
            TriplicatePayslipRec."Line No" := PayslipLineNoCounter;
            TriplicatePayslipRec.Employee1 := Employee."No.";
            TriplicatePayslipRec."Period Name1" := Periods.Description;
            TriplicatePayslipRec.Description1 := parDescription;
            TriplicatePayslipRec.Amount1 := parAmnt;
            TriplicatePayslipRec.Period := Periods."Period ID";
            TriplicatePayslipRec.Title1 := Employee."Job Title";
            TriplicatePayslipRec.Department1 :=  Employee."Global Dimension 1 Code";
            if BankRec.Get(Employee."Bank Code") then begin
              TriplicatePayslipRec.Bank1 :=  BankRec.Name;
              TriplicatePayslipRec.Branch1 :=BankRec.Branch;
              TriplicatePayslipRec.Account1 := Employee."Bank Account No";
            end else
              TriplicatePayslipRec.Bank1 :=  BankText;

            Employee.SetFilter("ED Code Filter", PayrollSetupRec."PAYE ED Code");
            Employee.CalcFields("Membership No.");
            TriplicatePayslipRec.PIN1 := Employee.PIN;

            Employee.SetFilter("ED Code Filter", PayrollSetupRec."NHIF ED Code");
            Employee.CalcFields("Membership No.");
            TriplicatePayslipRec.NHIF1 :=  Employee.PIN;

            Employee.SetFilter("ED Code Filter", PayrollSetupRec."NSSF ED Code");
            Employee.CalcFields("Membership No.");
            TriplicatePayslipRec.NSSF1 := Employee.PIN;

            if "Payroll Lines"."Loan Entry" then begin
               TriplicatePayslipRec.Rate1 := "Payroll Lines".Repayment;
               TriplicatePayslipRec.Qty1 := "Payroll Lines".Interest;
               TriplicatePayslipRec.Cumm1:=  "Payroll Lines"."Remaining Debt";
            end;

            //Don't print amounts if its a blank line or heading
            if (parAmnt =0) or TotalLine then begin
               TriplicatePayslipRec.Rate1 := 0;
               TriplicatePayslipRec.Qty1 := 0;
               TriplicatePayslipRec.Cumm1:=   0;
               TriplicatePayslipRec.Bal1 := 0;
             end;

            TriplicatePayslipRec."Payroll Code" := gvAllowedPayrolls."Payroll Code";
            TriplicatePayslipRec.Insert;
          end;

          2: begin
            PayslipLineNoCounter := PayslipLineNoCounter +1;

            if PayslipLineNoCounter > LargestLineNoInSet then begin
               TriplicatePayslipRec.Init;
               TriplicatePayslipRec."Payslip Set" := LargestSetNo;
               TriplicatePayslipRec."Line No" := PayslipLineNoCounter;
               TriplicatePayslipRec.Period := Periods."Period ID";
            end;

            if blnOnFirstLineInSet then
               blnOnFirstLineInSet := false
            else if PayslipLineNoCounter <= LargestLineNoInSet then
               TriplicatePayslipRec.Next;
            TriplicatePayslipRec.Rate2 :="Payroll Lines".Rate ;
            TriplicatePayslipRec.Qty2 :="Payroll Lines".Quantity;
            TriplicatePayslipRec.Cumm2:=   CumilativeDec;
            TriplicatePayslipRec.Bal2 := 0;
            TriplicatePayslipRec.Employee2 := Employee."No.";
            TriplicatePayslipRec."Period Name2" := Periods.Description;
            TriplicatePayslipRec.Description2 := parDescription;
            TriplicatePayslipRec.Amount2 := parAmnt;
            TriplicatePayslipRec.Title2 := Employee."Job Title";
            TriplicatePayslipRec.Department1 :=  Employee."Global Dimension 1 Code";
            if BankRec.Get(Employee."Bank Code") then begin
              TriplicatePayslipRec.Bank2 :=  BankRec.Name;
              TriplicatePayslipRec.Branch2 :=BankRec.Branch;
              TriplicatePayslipRec.Account2 := Employee."Bank Account No";
            end else
              TriplicatePayslipRec.Bank2 :=  BankText;

            Employee.SetFilter("ED Code Filter", PayrollSetupRec."PAYE ED Code");
            Employee.CalcFields("Membership No.");
            TriplicatePayslipRec.PIN2 := Employee."Membership No.";

            Employee.SetFilter("ED Code Filter", PayrollSetupRec."NHIF ED Code");
            Employee.CalcFields("Membership No.");
            TriplicatePayslipRec.NHIF2 :=  Employee."Membership No.";

            Employee.SetFilter("ED Code Filter", PayrollSetupRec."NSSF ED Code");
            Employee.CalcFields("Membership No.");
            TriplicatePayslipRec.NSSF2 := Employee."Membership No.";

            if "Payroll Lines"."Loan Entry" then begin
               TriplicatePayslipRec.Rate2 := "Payroll Lines".Repayment;
               TriplicatePayslipRec.Qty2 := "Payroll Lines".Interest;
               TriplicatePayslipRec.Cumm2:=  "Payroll Lines"."Remaining Debt";
            end;

            //Don't print amounts if its a blank line or heading
            if (parAmnt =0) or TotalLine then
             begin
               TriplicatePayslipRec.Rate2 := 0;
               TriplicatePayslipRec.Qty2 := 0;
               TriplicatePayslipRec.Cumm2:=   0;
               TriplicatePayslipRec.Bal2 := 0;
             end;

            if PayslipLineNoCounter > LargestLineNoInSet then begin
               TriplicatePayslipRec.Insert;
               LargestLineNoInSet := LargestLineNoInSet +1;
            end else
               TriplicatePayslipRec.Modify
            end;

         end; //Case

        TotalLine := true;
    end;

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
        lvActiveSession.SetRange("Server Instance ID",ServiceInstanceId);
        lvActiveSession.SetRange("Session ID",SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
          Error('You are not allowed access to this payroll dataset.');
    end;
}

