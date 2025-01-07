// report 51120 "Generate Payslip"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = 'src/Layouts/Generate Payslip.rdlc';
//     Permissions = TableData "Document Generation Log"=rimd,
//                   TableData "Document E-Mailing Setup"=rimd,
//                   TableData "Document E-Mail Log"=rimd,
//                   TableData "Document Report Selections"=rimd,
//                   TableData "Setup for All Email Documents"=rimd,
//                   TableData "Document Emailing Users"=rimd;

//     dataset
//     {
//         dataitem(Periods;Periods)
//         {
//             DataItemTableView = SORTING("Start Date") ORDER(Ascending) WHERE(Status=FILTER(Open|Posted));
//             column(Periods_Period_ID;"Period ID")
//             {
//             }
//             column(Periods_Period_Month;"Period Month")
//             {
//             }
//             column(Periods_Period_Year;"Period Year")
//             {
//             }
//             column(Periods_Payroll_Code;"Payroll Code")
//             {
//             }
//             dataitem(Employee;Employee)
//             {
//                 DataItemTableView = SORTING("No.");
//                 RequestFilterFields = "No.","Period Filter";
//                 column(Branch_Code_from_multiple_dim__;'Branch Code from multiple dim?')
//                 {
//                 }
//                 column(Employee__Job_Title_;"Job Title")
//                 {
//                 }
//                 column(Employee__No__;"No.")
//                 {
//                 }
//                 column(MonthText;MonthText)
//                 {
//                 }
//                 column(EmploNameText;EmploNameText)
//                 {
//                 }
//                 column(CompanyNameText;CompanyNameText)
//                 {
//                 }
//                 column(Employee_Employee__Global_Dimension_1_Code_;Employee."Global Dimension 1 Code")
//                 {
//                 }
//                 column(gvPinNo;gvPinNo)
//                 {
//                 }
//                 column(gvNhifNo;gvNhifNo)
//                 {
//                 }
//                 column(gvNssfNo;gvNssfNo)
//                 {
//                 }
//                 column(EmpBank; EmpBank)
//                 {
//                 }
//                 column(AccountNo;AccountNo)
//                 {
//                 }
//                 column(EmpBankBranch;EmpBankBranch)
//                 {
//                 }
//                 column(gvPayrollCode;gvPayrollCode)
//                 {
//                 }
//                 column(Employee_Employee__Global_Dimension_2_Code_;Employee."Global Dimension 2 Code")
//                 {
//                 }
//                 column(AmountCaption;AmountCaptionLbl)
//                 {
//                 }
//                 column(Rate__RepaymentCaption;Rate__RepaymentCaptionLbl)
//                 {
//                 }
//                 column(Quantity__InterestCaption;Quantity__InterestCaptionLbl)
//                 {
//                 }
//                 column(Branch_Caption;Branch_CaptionLbl)
//                 {
//                 }
//                 column(Employee__Job_Title_Caption;Employee__Job_Title_CaptionLbl)
//                 {
//                 }
//                 column(Employee__No__Caption;Employee__No__CaptionLbl)
//                 {
//                 }
//                 column(Payslip_for_Caption;Payslip_for_CaptionLbl)
//                 {
//                 }
//                 column(EmploNameTextCaption;EmploNameTextCaptionLbl)
//                 {
//                 }
//                 column(Employee_Employee__Global_Dimension_1_Code_Caption;FieldCaption("Global Dimension 1 Code"))
//                 {
//                 }
//                 column(Cumulative_Contribution___Total_Principal__To_DateCaption;Cumulative_Contribution___Total_Principal__To_DateCaptionLbl)
//                 {
//                 }
//                 column(Outstanding_Principal_to_DateCaption;Outstanding_Principal_to_DateCaptionLbl)
//                 {
//                 }
//                 column(gvPinNoCaption;gvPinNoCaptionLbl)
//                 {
//                 }
//                 column(gvNhifNoCaption;gvNhifNoCaptionLbl)
//                 {
//                 }
//                 column(gvNssfNoCaption;gvNssfNoCaptionLbl)
//                 {
//                 }
//                 column(Bank_Caption;Bank_CaptionLbl)
//                 {
//                 }
//                 column(Account_No_Caption;Account_No_CaptionLbl)
//                 {
//                 }
//                 column(Branch_Caption_Control1000000002;Branch_Caption_Control1000000002Lbl)
//                 {
//                 }
//                 column(Payroll_CodeCaption;Payroll_CodeCaptionLbl)
//                 {
//                 }
//                 column(Dept_CodeCaption;Dept_CodeCaptionLbl)
//                 {
//                 }
//                 dataitem("Payslip Group";"Payslip Group")
//                 {
//                     DataItemTableView = SORTING(Code);
//                     column(Payslip_Group__Heading_Text_;"Heading Text")
//                     {
//                     }
//                     column(TotalText;TotalText)
//                     {
//                     }
//                     column(TotalAmountDec;TotalAmountDec)
//                     {
//                     }
//                     column(Payslip_Group_Code;Code)
//                     {
//                     }
//                     dataitem("Payslip Lines";"Payslip Lines")
//                     {
//                         DataItemLink = "Payslip Group"=FIELD(Code);
//                         DataItemTableView = SORTING("Line No.","Payslip Group");
//                         column(Payslip_Lines__P9_Text_;"P9 Text")
//                         {
//                         }
//                         column(Payslip_Lines_Amount;Amount)
//                         {
//                         }
//                         column(Payslip_Lines_Line_No_;"Line No.")
//                         {
//                         }
//                         column(Payslip_Lines_Payslip_Group;"Payslip Group")
//                         {
//                         }
//                         column(Payslip_Lines_Payroll_Code;"Payroll Code")
//                         {
//                         }
//                         column(Payslip_Lines_E_D_Code;"E/D Code")
//                         {
//                         }
//                         dataitem("Payroll Lines";"Payroll Lines")
//                         {
//                             DataItemLink = "ED Code"=FIELD("E/D Code");
//                             DataItemTableView = SORTING("Entry No.");
//                             column(Payroll_Lines_Text;Text)
//                             {
//                             }
//                             column(Payroll_Lines__Amount__LCY__;"Amount (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines__Rate__LCY__;"Rate (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines_Quantity;Quantity)
//                             {
//                             }
//                             column(CumilativeDec;CumilativeDec)
//                             {
//                             }
//                             column(Payroll_Lines_Text_Control13;Text)
//                             {
//                             }
//                             column(Payroll_Lines__Amount__LCY___Control14;"Amount (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines__Interest__LCY__;"Interest (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines__Repayment__LCY__;"Repayment (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines__Remaining_Debt__LCY__;"Remaining Debt (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines__Paid__LCY__;"Paid (LCY)")
//                             {
//                             }
//                             column(Payroll_Lines_Entry_No_;"Entry No.")
//                             {
//                             }
//                             column(Payroll_Lines_ED_Code;"ED Code")
//                             {
//                             }

//                             trigger OnAfterGetRecord()
//                             begin

//                                 EDDefRec.Get("Payroll Lines"."ED Code");

//                                 if EDDefRec.Cumulative then begin
//                                   EmployeeRec.Get(Employee."No.");
//                                   EmployeeRec.SetRange("ED Code Filter",EDDefRec."ED Code");
//                                   EndDate := Periods."End Date";
//                                  EmployeeRec.SetFilter("Date Filter", Format(DMY2Date(1,1,1900)) + '..' + Format(EndDate));
//                                   EmployeeRec.CalcFields("Amount To Date (LCY)");
//                                   CumilativeDec := EmployeeRec."Amount To Date (LCY)";
//                                 end else
//                                   CumilativeDec := 0;

//                                 case EDDefRec."Calculation Group" of
//                                   //skm300507EDDefRec."Calculation Group"::None:
//                                   //  "Payroll Lines"."Amount (LCY)" := 0;
//                                   EDDefRec."Calculation Group"::Deduction:
//                                     begin
//                                        if "Payslip Lines".Negative then
//                                         "Payroll Lines"."Amount (LCY)" := -"Payroll Lines"."Amount (LCY)"
//                                        else
//                                          "Payroll Lines"."Amount (LCY)" := "Payroll Lines"."Amount (LCY)";
//                                     end;
//                                 end;

//                                 TotalAmountDec := TotalAmountDec + "Payroll Lines"."Amount (LCY)";
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 SetRange("Employee No.",Employee."No.");
//                                 SetRange("Payroll ID",Periods."Period ID");
//                                 SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//                             end;
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             if "Payslip Lines"."Line Type" = 1 then begin
//                               case "Payslip Lines".P9 of
//                                 "Payslip Lines".P9::A:
//                                   "Payslip Lines".Amount := HeaderRec."A (LCY)";
//                                 "Payslip Lines".P9::B:
//                                   "Payslip Lines".Amount := HeaderRec."B (LCY)";
//                                 "Payslip Lines".P9::C:
//                                   "Payslip Lines".Amount := HeaderRec."C (LCY)";
//                                 "Payslip Lines".P9::D:
//                                   "Payslip Lines".Amount := HeaderRec."D (LCY)";
//                                 "Payslip Lines".P9::E1:
//                                   "Payslip Lines".Amount := HeaderRec."E1 (LCY)";
//                                 "Payslip Lines".P9::E2:
//                                   "Payslip Lines".Amount := HeaderRec."E2 (LCY)";
//                                 "Payslip Lines".P9::E3:
//                                   "Payslip Lines".Amount := HeaderRec."E3 (LCY)";
//                                 "Payslip Lines".P9::F:
//                                   "Payslip Lines".Amount := HeaderRec."F (LCY)";
//                                 "Payslip Lines".P9::G:
//                                   "Payslip Lines".Amount := HeaderRec."G (LCY)";
//                                 "Payslip Lines".P9::H:
//                                   "Payslip Lines".Amount := HeaderRec."H (LCY)";
//                                 "Payslip Lines".P9::J:
//                                   "Payslip Lines".Amount := HeaderRec."J (LCY)";
//                                 "Payslip Lines".P9::K:
//                                   "Payslip Lines".Amount := HeaderRec."K (LCY)";
//                                 "Payslip Lines".P9::L:
//                                   "Payslip Lines".Amount := HeaderRec."L (LCY)";
//                                 "Payslip Lines".P9::M:
//                                   "Payslip Lines".Amount := HeaderRec."M (LCY)";
//                               end;
//                             end;
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//                         end;
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         TotalText := 'TOTAL ' + "Payslip Group"."Heading Text";
//                         TotalAmountDec := 0;
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//                     end;
//                 }
//                 dataitem("Integer";"Integer")
//                 {
//                     DataItemTableView = SORTING(Number);
//                     MaxIteration = 1;
//                     column(NetPayText;NetPayText)
//                     {
//                     }
//                     column(NetPaydec;NetPaydec)
//                     {
//                     }
//                     column(Integer_Number;Number)
//                     {
//                     }
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     EmpBank := '';

//                     if HeaderRec.Get(Periods."Period ID",Employee."No.") then begin
//                       HeaderRec.CalcFields("Total Payable (LCY)","Total Deduction (LCY)","Total Rounding Pmts (LCY)","Total Rounding Ded (LCY)");
//                       NetPaydec := HeaderRec."Total Payable (LCY)" +HeaderRec."Total Rounding Pmts (LCY)"- (HeaderRec."Total Deduction (LCY)" +
//                                    HeaderRec."Total Rounding Ded (LCY)");
//                     end else
//                       CurrReport.Skip;

//                     EmploNameText := Employee.FullName;

//                     Employee.TestField("Mode of Payment");
//                     gvModeofPayment.Get("Mode of Payment");
//                     if gvModeofPayment.Description <> '' then
//                       NetPayText := 'Net Pay - ' + gvModeofPayment.Description
//                     else
//                       NetPayText := 'Net Pay - By ' + gvModeofPayment.Code;

//                     if Employee."Bank Code" <> '' then
//                      if EmplankAccount.Get(Employee."Bank Code") then begin
//                         EmpBank := EmplankAccount.Name;
//                         AccountNo := Employee."Bank Account No";
//                         EmpBankBranch := EmplankAccount.Branch;
//                      end;

//                     SetFilter("ED Code Filter", PayrollSetupRec."NSSF ED Code");
//                     CalcFields("Membership No.");
//                     gvNssfNo := "Membership No.";
//                     SetFilter("ED Code Filter", PayrollSetupRec."PAYE ED Code");
//                     CalcFields("Membership No.");
//                     gvPinNo := "Membership No.";
//                     SetFilter("ED Code Filter", PayrollSetupRec."NHIF ED Code");
//                     CalcFields("Membership No.");
//                     gvNhifNo := "Membership No." ;

//                     //AMI 140907 OC023 show Payroll code in the Payslip
//                     if  Employee."Calculation Scheme"<> '' then begin
//                       CalculationHeader.Get(Employee."Calculation Scheme");
//                       gvPayrollCode:= CalculationHeader."Payroll Code";
//                     end;
//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     //AMI 140907 OC023 show Payroll code in the Payslip
//                     gvPayrollCode := '';
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//                     //skm070307 payslip e-mailing
//                     if gvEmployeeNoFilter <> '' then SetRange("No.", gvEmployeeNoFilter);
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 lvEmployee: Record Employee;
//                 lvDocumentLog: Record "Document Generation Log";
//                 lvEntryNo: Integer;
//             begin
//                 MonthText := Periods.Description;
//                 //wtm 20110516 function for bulk emailing
//                 /*
//                 IF SaveinPDF THEN
//                   Saveas := Saveas::Pdf;
//                 IF gvDocumentSetup.GET(gvDocumentSetup."Document Type"::Payslips) THEN

//                 IF gvEmployeeNoFilter <> '' THEN lvEmployee.SETFILTER("No.", gvEmployeeNoFilter);
//                 lvEmployee.FIND('-');
//                 REPEAT
//                   CLEAR(rptpayslip);
//                   rptpayslip.sSetParameters(gvPeriodIDFilter, lvEmployee."No.");
//                 //  rptpayslip.USEREQUESTFORM := FALSE;

//                 IF gvDocumentSetup."Document Folder"<>'' THEN
//                  fpath:= gvDocumentSetup."Document Folder"
//                  ELSE
//                   fpath:= TEMPORARYPATH + '\' ;

//                     IF ISSERVICETIER THEN BEGIN
//                       IF Saveas = Saveas ::Pdf THEN
//                         fpath:=fpath +lvEmployee."No."+ '.pdf'
//                       ELSE IF Saveas = Saveas ::Excel THEN
//                         fpath:=fpath +lvEmployee."No."+ '.Xls'
//                       ELSE IF Saveas = Saveas ::Html THEN
//                         fpath:=fpath +lvEmployee."No."+ '.html'
//                       ELSE IF Saveas = Saveas ::" " THEN
//                         fpath:=fpath +lvEmployee."No."+ '.html'
//                     END ELSE BEGIN
//                         IF Saveas = Saveas ::Pdf THEN

//                           ERROR('You Cannot Save in PDF in Classic Client')

//                         //  fpath:=fpath +lvEmployee."No."+ '.pdf'
//                         ELSE
//                           fpath:=fpath +lvEmployee."No."+ '.html';
//                         END;

//                     IF EXISTS(fpath) THEN ERASE(fpath);
//                      IF ISSERVICETIER THEN BEGIN
//                        IF ReportIDVal =  0 THEN BEGIN
//                          IF Saveas = Saveas :: Pdf THEN
//                            REPORT.SAVEASPDF(ReportIDVal,fpath,Periods)
//                          ELSE IF Saveas = Saveas :: Excel THEN
//                           REPORT.SAVEASEXCEL(ReportIDVal,fpath, Periods)
//                          ELSE IF Saveas = Saveas :: Html THEN
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)

//                          ELSE IF Saveas = Saveas :: " " THEN
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)

//                        END ELSE BEGIN
//                          IF Saveas = Saveas :: Pdf THEN
//                            REPORT.SAVEASPDF(ReportIDVal,fpath,Periods)
//                          ELSE IF Saveas = Saveas :: Excel THEN
//                            REPORT.SAVEASEXCEL(ReportIDVal,fpath, Periods)
//                          ELSE IF Saveas = Saveas :: Html THEN
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                          ELSE IF Saveas = Saveas :: " " THEN
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                        END;
//                      END ELSE BEGIN
//                        IF ReportIDVal > 0 THEN BEGIN
//                          IF Saveas = Saveas ::Pdf THEN
//                           rptpayslip.SAVEASPDF(fpath)
//                          ELSE
//                           rptpayslip.SAVEASHTML(fpath)
//                        END ELSE BEGIN
//                          IF Saveas = Saveas ::Pdf THEN
//                            REPORT.SAVEASPDF(ReportIDVal,fpath,Periods)
//                          ELSE
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods);
//                        END;
//                      END;



//                     //First get the entry No
//                     IF EXISTS(fpath) THEN BEGIN
//                       IF lvDocumentLog.FINDLAST THEN
//                         lvEntryNo:=lvDocumentLog."Entry No" + 1
//                       ELSE
//                         lvEntryNo:=1;

//                       lvDocumentLog.INIT;
//                       lvDocumentLog."Entry No" := lvEntryNo;
//                       lvDocumentLog."Account Type" := lvDocumentLog."Account Type"::Employee;
//                       lvDocumentLog."Account No.":= lvEmployee."No.";
//                       lvDocumentLog.Document.IMPORT(fpath);
//                       lvDocumentLog."E-mailed To":= lvEmployee."E-Mail";
//                       lvDocumentLog.DateTime := CURRENTDATETIME;
//                       lvDocumentLog."Document Type":= lvDocumentLog."Document Type"::Payslips;
//                       IF ISSERVICETIER THEN
//                         lvDocumentLog."File Extension":= 'pdf'
//                       ELSE BEGIN
//                        IF Saveas = Saveas::Pdf THEN
//                          lvDocumentLog."File Extension":= 'pdf'
//                        ELSE
//                          lvDocumentLog."File Extension":= 'html'
//                       END;
//                       lvDocumentLog."Document No":=EmployeeRec."No." ;
//                       lvDocumentLog.Send  := TRUE;
//                       lvDocumentLog.INSERT;
//                       COMMIT;
//                       END;
//                      UNTIL  lvEmployee.NEXT = 0;
//                   */
//                 /*
//                 IF SaveinPDF THEN
//                   Saveas := Saveas::Pdf;
//                 IF gvDocumentSetup.GET(gvDocumentSetup."Document Type"::Payslips) THEN




//                 IF gvEmployeeNoFilter <> '' THEN lvEmployee.SETFILTER("No.", gvEmployeeNoFilter);
//                 lvEmployee.FIND('-');
//                 REPEAT
//                   CLEAR(rptpayslip);
//                   rptpayslip.sSetParameters(gvPeriodIDFilter, lvEmployee."No.");
//                   rptpayslip.USEREQUESTPAGE := FALSE;

//                 IF gvDocumentSetup."Document Folder"<>'' THEN
//                  fpath:= gvDocumentSetup."Document Folder"
//                  ELSE
//                   fpath:= TEMPORARYPATH + '\' ;

//                     IF ISSERVICETIER THEN BEGIN
//                       IF Saveas = Saveas ::Pdf THEN
//                         fpath:=fpath +lvEmployee."No."+ '.pdf'
//                       ELSE IF Saveas = Saveas ::Excel THEN
//                         fpath:=fpath +lvEmployee."No."+ '.Xls'
//                       ELSE IF Saveas = Saveas ::Html THEN
//                         fpath:=fpath +lvEmployee."No."+ '.html'
//                       ELSE IF Saveas = Saveas ::" " THEN
//                         fpath:=fpath +lvEmployee."No."+ '.html'
//                     END ELSE BEGIN
//                         IF Saveas = Saveas ::Pdf THEN

//                           ERROR('You Cannot Save in PDF in Classic Client')

//                         //  fpath:=fpath +lvEmployee."No."+ '.pdf'
//                         ELSE
//                           fpath:=fpath +lvEmployee."No."+ '.html';
//                         END;

//                     IF EXISTS(fpath) THEN ERASE(fpath);
//                      IF ISSERVICETIER THEN BEGIN
//                        IF ReportIDVal =  0 THEN BEGIN
//                          IF Saveas = Saveas :: Pdf THEN
//                           rptpayslip.SAVEASPDF(fpath)
//                          ELSE IF Saveas = Saveas :: Excel THEN
//                           rptpayslip.SAVEASEXCEL(fpath)
//                          ELSE IF Saveas = Saveas :: Html THEN
//                           rptpayslip.SAVEASHTML(fpath)
//                          ELSE IF Saveas = Saveas :: " " THEN
//                           rptpayslip.SAVEASHTML(fpath)
//                        END ELSE BEGIN
//                          IF Saveas = Saveas :: Pdf THEN
//                            REPORT.SAVEASPDF(ReportIDVal,fpath,Periods)
//                          ELSE IF Saveas = Saveas :: Excel THEN
//                            REPORT.SAVEASEXCEL(ReportIDVal,fpath, Periods)
//                          ELSE IF Saveas = Saveas :: Html THEN
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                          ELSE IF Saveas = Saveas :: " " THEN
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                        END;
//                      END ELSE BEGIN
//                        IF ReportIDVal > 0 THEN BEGIN
//                          IF Saveas = Saveas ::Pdf THEN
//                           rptpayslip.SAVEASPDF(fpath)
//                          ELSE
//                           rptpayslip.SAVEASHTML(fpath)
//                        END ELSE BEGIN
//                          IF Saveas = Saveas ::Pdf THEN
//                            REPORT.SAVEASPDF(ReportIDVal,fpath,Periods)
//                          ELSE
//                            REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods);
//                        END;
//                      END;



//                     //First get the entry No
//                     IF EXISTS(fpath) THEN BEGIN
//                       IF lvDocumentLog.FINDLAST THEN
//                         lvEntryNo:=lvDocumentLog."Entry No" + 1
//                       ELSE
//                         lvEntryNo:=1;

//                       lvDocumentLog.INIT;
//                       lvDocumentLog."Entry No" := lvEntryNo;
//                       lvDocumentLog."Account Type" := lvDocumentLog."Account Type"::Employee;
//                       lvDocumentLog."Account No.":= lvEmployee."No.";
//                       lvDocumentLog.Document.IMPORT(fpath);
//                       lvDocumentLog."E-mailed To":= lvEmployee."E-Mail";
//                       lvDocumentLog.DateTime := CURRENTDATETIME;
//                       lvDocumentLog."Document Type":= lvDocumentLog."Document Type"::Payslips;
//                       IF ISSERVICETIER THEN
//                         lvDocumentLog."File Extension":= 'pdf'
//                       ELSE BEGIN
//                        IF Saveas = Saveas::Pdf THEN
//                          lvDocumentLog."File Extension":= 'pdf'
//                        ELSE
//                          lvDocumentLog."File Extension":= 'html'
//                       END;
//                       lvDocumentLog."Document No":=EmployeeRec."No." ;
//                       lvDocumentLog.Send  := TRUE;
//                       lvDocumentLog.INSERT;
//                       COMMIT;
//                       END;
//                      UNTIL  lvEmployee.NEXT = 0;
//                 */
//                        //wtm 20110516

//             end;

//             trigger OnPreDataItem()
//             begin
//                 SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//                 //skm070307 payslip e-mailing
//                 if gvPeriodIDFilter <> '' then SetRange("Period ID", gvPeriodIDFilter);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field("Start Date";Saveas)
//                     {
//                         Caption = 'Save As';
//                     }
//                     field("End Date";SaveinPDF)
//                     {
//                         Caption = 'Save As PDF';
//                         Visible = false;
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPostReport()
//     var
//         lvEmployee: Record Employee;
//         lvDocumentLog: Record "Document Generation Log";
//         lvEntryNo: Integer;
//     begin

//         if SaveinPDF then
//           Saveas := Saveas::Pdf;
//         if gvDocumentSetup.Get(gvDocumentSetup."Document Type"::Payslips) then

//         //IF gvEmployeeNoFilter <> '' THEN


//         lvEmployee.CopyFilters(Employee);
//         if lvEmployee.FindFirst then
//         repeat
//           lvEmployee.SetFilter("No.",lvEmployee."No.");//ICS APR 2018
//           //CLEAR(rptpayslip);

//         rptpayslip.sSetParameters(gvPeriodIDFilter,gvEmployeeNoFilter);
//         //  rptpayslip.USEREQUESTFORM := FALSE;

//         if gvDocumentSetup."Document Folder"<>'' then
//          fpath:= gvDocumentSetup."Document Folder"
//          else
//          // fpath:= TemporaryPath + '\' ;

//             if IsServiceTier then begin
//               if Saveas = Saveas ::Pdf then
//                 fpath:=fpath +lvEmployee."No."+ '.pdf'
//               else if Saveas = Saveas ::Excel then
//                 fpath:=fpath +lvEmployee."No."+ '.Xls'
//               else if Saveas = Saveas ::Html then
//                 fpath:=fpath +lvEmployee."No."+ '.html'
//               else if Saveas = Saveas ::" " then
//                 fpath:=fpath +lvEmployee."No."+ '.html'
//             end else begin
//                 if Saveas = Saveas ::Pdf then

//                   Error('You Cannot Save in PDF in Classic Client')

//                 //  fpath:=fpath +lvEmployee."No."+ '.pdf'
//                 else
//                   fpath:=fpath +lvEmployee."No."+ '.html';
//                 end;

//            // if Exists(fpath) then Erase(fpath);
//              if IsServiceTier then begin
//                if ReportIDVal =  0 then begin
//                  if Saveas = Saveas :: Pdf then
//                    //REPORT.SaveAsPdf(ReportIDVal,fpath,lvEmployee)
//                  else if Saveas = Saveas :: Excel then
//                   //REPORT.SaveAsExcel(ReportIDVal,fpath,lvEmployee)
//                  //ELSE IF Saveas = Saveas :: Html THEN
//                  //  REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)

//                  //ELSE IF Saveas = Saveas :: " " THEN
//                  //  REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)

//                end else begin
//                  if Saveas = Saveas :: Pdf then
//                    REPORT.SaveAsPdf(ReportIDVal,fpath,lvEmployee)
//                  else if Saveas = Saveas :: Excel then
//                    REPORT.SaveAsExcel(ReportIDVal,fpath,lvEmployee)
//                  //ELSE IF Saveas = Saveas :: Html THEN
//                  //  REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                  //ELSE IF Saveas = Saveas :: " " THEN
//                  //  REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                end;
//              end else begin
//                if ReportIDVal > 0 then begin
//                  if Saveas = Saveas ::Pdf then
//                    REPORT.SaveAsPdf(ReportIDVal,fpath,lvEmployee)

//                  //ELSE
//                  // REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods)
//                end else begin
//                  if Saveas = Saveas ::Pdf then
//                    REPORT.SaveAsPdf(ReportIDVal,fpath,lvEmployee);
//                  //ELSE
//                  //  REPORT.SAVEASHTML(ReportIDVal,fpath,FALSE,Periods);
//                end;
//              end;



//             //First get the entry No
//             if Exists(fpath) then begin
//               if lvDocumentLog.FindLast then
//                 lvEntryNo:=lvDocumentLog."Entry No" + 1
//               else
//                 lvEntryNo:=1;

//               lvDocumentLog.Init;
//               lvDocumentLog."Entry No" := lvEntryNo;
//               lvDocumentLog."Account Type" := lvDocumentLog."Account Type"::Employee;
//               lvDocumentLog."Account No.":= lvEmployee."No.";
//               lvDocumentLog.Document.Import(fpath);
//               lvDocumentLog."E-mailed To":= lvEmployee."E-Mail";
//               lvDocumentLog.DateTime := CurrentDateTime;
//               lvDocumentLog."Document Type":= lvDocumentLog."Document Type"::Payslips;
//               if IsServiceTier then
//                 lvDocumentLog."File Extension":= 'pdf'
//               else begin
//                if Saveas = Saveas::Pdf then
//                  lvDocumentLog."File Extension":= 'pdf'
//                else
//                  lvDocumentLog."File Extension":= 'html'
//               end;
//               lvDocumentLog."Document No":=EmployeeRec."No." ;
//               lvDocumentLog.Send  := true;
//               lvDocumentLog.Insert;
//               Commit;
//               end;
//               lvEmployee.SetFilter("No.",'');
//              until  lvEmployee.Next = 0;


//         Message('Report Generation Completed!');
//         //Exit quitely in style
//         Error('');
//          //wtm
//     end;

//     trigger OnPreReport()
//     begin
//         gsSegmentPayrollData;
//         PayrollSetupRec.Get(gvAllowedPayrolls."Payroll Code");
//         CompanyNameText := PayrollSetupRec."Employer Name";
//         PeriodRec.SetCurrentKey("Start Date");
//         PeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//         PeriodRec.Find('-');


//         gvPeriodIDFilter:=Employee.GetFilter("Period Filter");
//     end;

//     var
//         PeriodRec: Record Periods;
//         EmployeeRec: Record Employee;
//         PayrollSetupRec: Record "Payroll Setups";
//         HeaderRec: Record "Payroll Header";
//         EDDefRec: Record "ED Definitions";
//         TotalText: Text[60];
//         NetPayText: Text[60];
//         MonthText: Text[60];
//         EmploNameText: Text[100];
//         CompanyNameText: Text[100];
//         TotalAmountDec: Decimal;
//         NetPaydec: Decimal;
//         CumilativeDec: Decimal;
//         EmplankAccount: Record "Employee Bank Account";
//         EmpBank: Text[30];
//         AccountNo: Text[30];
//         EmpBankBranch: Text[30];
//         gvNhifNo: Code[20];
//         gvNssfNo: Code[20];
//         gvPinNo: Code[20];
//         EndDate: Date;
//         gvAllowedPayrolls: Record "Allowed Payrolls";
//         gvModeofPayment: Record "Mode of Payment";
//         gvPeriodIDFilter: Code[100];
//         gvEmployeeNoFilter: Code[100];
//         CalculationHeader: Record "Calculation Header";
//         gvPayrollCode: Text[30];
//         fpath: Text[250];
//         gvDocumentSetup: Record "Document E-Mailing Setup";
//         fPath1: Text[250];
//         PrintLogo: Boolean;
//         CompanyInfo1: Record "Company Information";
//         CompanyInfo2: Record "Company Information";
//         ReportIDVal: Integer;
//         Saveas: Option " ",Pdf,Excel,Html;
//         SaveinPDF: Boolean;
//         [InDataSet]
//         LogInteractionEnable: Boolean;
//         LogInteraction: Boolean;
//         ShowInternalInfo: Boolean;
//         gvEmployeeFilter: Text[30];
//         gvHeaderRec: Record "Payroll Header";
//         rptpayslip: Report Payslips;
//         gvemployee: Record Employee;
//         tempemployee: Record Employee;
//         AmountCaptionLbl: Label 'Amount';
//         Rate__RepaymentCaptionLbl: Label 'Rate/\Repayment';
//         Quantity__InterestCaptionLbl: Label 'Quantity/\Interest';
//         Branch_CaptionLbl: Label 'Branch:';
//         Employee__Job_Title_CaptionLbl: Label 'Job Title :';
//         Employee__No__CaptionLbl: Label 'Personnel No. :';
//         Payslip_for_CaptionLbl: Label 'Payslip for:';
//         EmploNameTextCaptionLbl: Label 'Employee Name :';
//         Cumulative_Contribution___Total_Principal__To_DateCaptionLbl: Label 'Cumulative\Contribution /\Total Principal\ To Date';
//         Outstanding_Principal_to_DateCaptionLbl: Label 'Outstanding\Principal to\Date';
//         gvPinNoCaptionLbl: Label 'PIN Code';
//         gvNhifNoCaptionLbl: Label 'NHIF No';
//         gvNssfNoCaptionLbl: Label 'NSSF No';
//         Bank_CaptionLbl: Label 'Bank:';
//         Account_No_CaptionLbl: Label 'Account No.';
//         Branch_Caption_Control1000000002Lbl: Label 'Branch:';
//         Payroll_CodeCaptionLbl: Label 'Payroll Code';
//         Dept_CodeCaptionLbl: Label 'Dept Code';

//     procedure sSetParameters(pPeriodIDFilter: Code[10];pEmployeeNoFilter: Code[10])
//     begin
//         //skm080307 this function sets global parameters for filtering the payslip when e-mailing
//         gvPeriodIDFilter := pPeriodIDFilter;
//         gvEmployeeNoFilter := pEmployeeNoFilter;
//     end;

//     procedure GetReportID(ReportID: Integer)
//     begin
//           ReportIDVal := ReportID;
//     end;

//     procedure gsSegmentPayrollData()
//     var
//         lvAllowedPayrolls: Record "Allowed Payrolls";
//         UsrID: Code[10];
//         UsrID2: Code[10];
//         StringLen: Integer;
//         lvActiveSession: Record "Active Session";
//     begin

//         lvActiveSession.Reset;
//         lvActiveSession.SetRange("Server Instance ID",ServiceInstanceId);
//         lvActiveSession.SetRange("Session ID",SessionId);
//         lvActiveSession.FindFirst;


//         gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
//         gvAllowedPayrolls.SetRange("Last Active Payroll", true);
//         if not gvAllowedPayrolls.FindFirst then
//           Error('You are not allowed access to this payroll dataset.');
//     end;

//     procedure GetReportID2(DocType: Option "Sales Invoice","Service Invoice","Customer Statement","Remittance Advice",Payslips,"Payment Receipts","EFT Remittance Advice",Reminder,"Purchase Order")
//     begin
//         //call dll to return main ReportID(pass DocType)

//         /*ReportIDVal := //returned value*/

//     end;
// }

