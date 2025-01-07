// page 51188 "Create Payroll Transfer File"
// {
//     PageType = Card;

//     layout
//     {
//         area(content)
//         {
//             group("Tranfer Information")
//             {
//                 Caption = 'Tranfer Information';
//                 field(gvPeriodCode;gvPeriodCode)
//                 {
//                     Caption = 'Period';
//                     Lookup = true;
//                     LookupPageID = "Journal Voucher";

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                           if ACTION::LookupOK = PAGE.RunModal(0, gvPeriodRec) then begin
//                             gvPeriodCode := gvPeriodRec."Period ID";
//                             gvMonthText := gvPeriodRec.Description;
//                           end;
//                     end;
//                 }
//                 field(gvTransferType;gvTransferType)
//                 {
//                     Caption = 'File type';
//                 }
//                 field(gvValueDate;gvValueDate)
//                 {
//                     Caption = 'Value Date';

//                     trigger OnValidate()
//                     begin
//                         case gvTransferType of
//                           gvTransferType::PAYNET          :
//                              gvFileName := StrSubstNo('CITI%1%2.Txt',
//                                                      Date2DMY(gvValueDate, 2),
//                                                      CopyStr(StrSubstNo('%1', Date2DMY(gvValueDate, 3)
//                                                                        ),
//                                                              3,
//                                                              2
//                                                             )
//                                                    );
//                           gvTransferType::FOSO             :
//                              gvFileName := StrSubstNo('NHIF%1%2.Txt',
//                                                      Date2DMY(gvValueDate, 2),
//                                                      CopyStr(StrSubstNo('%1', Date2DMY(gvValueDate, 3)
//                                                                        ),
//                                                              3,
//                                                              2
//                                                             )
//                                                    );
//                         end;
//                     end;
//                 }
//                 field(gvFileName;gvFileName)
//                 {
//                     Caption = 'File Name (Without Path)';
//                     ToolTip = 'Enter File Name without path';
//                 }
//                 field(gvModeofPaymentCode;gvModeofPaymentCode)
//                 {
//                     Caption = 'Mode of Payment';
//                     TableRelation = "Mode of Payment";
//                 }
//                 field(gvEDCode;gvEDCode)
//                 {
//                     Caption = 'ED Code';
//                     Lookup = true;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                           if ACTION::LookupOK = PAGE.RunModal(0, gvEDDefns) then  begin
//                             gvEDCode := gvEDDefns."ED Code";
//                             EDName := gvEDDefns.Description;
//                           end;
//                     end;
//                 }
//                 field(EDName;EDName)
//                 {
//                     Editable = false;
//                 }
//             }
//         }
//     }

// actions
// {
//     area(processing)
//     {
//         action("Make File")
//         {
//             Caption = 'Make File';
//             Promoted = true;
//             PromotedCategory = Process;

//             trigger OnAction()
//             var
//                 FileExtension: Text[5];
//                 PointPosition: Integer;
//             begin
//                 if gvPeriodCode = '' then Error('A Payroll Period must be selected');
//                 gvPeriodRec.SetRange("Period ID", gvPeriodCode);
//                 gvPeriodRec.Find('-');

//                 if (gvFileName = '') and (gvTransferType <> gvTransferType::HELB) then Error('File Name must be entered'); //cmm 080813  HELB File
//                 //IF (gvFileName = '') THEN ERROR('File Name must be entered'); //cmm commented

//                 gvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
//                 gvPayrollSetup.TestField("Payroll Transfer Path");

//                 if (gvModeofPaymentCode = '') and (gvTransferType <> gvTransferType::HELB) then Error('Mode of Payment must be specified.');    //cmm 080813  HELB File
//                 //IF gvModeofPaymentCode = ''  THEN ERROR('Mode of Payment must be specified.');  //cmm 080813  HELB File   commented

//                 if (gvTransferType <> gvTransferType::HELB) then begin //cmm 080813
//                 Clear(gvTranferFile);
//                 // gvTranferFile.TextMode := true;
//                 // gvTranferFile.WriteMode := true;
//                 //gvTranferFile.QUERYREPLACE := TRUE;   TNG: QUERYREPLACE is obsolete. 20131219
//                 //if Exists(gvPayrollSetup."Payroll Transfer Path" + '\' + gvFileName)  then
//                   if not Confirm('A file with the same name exists. Do you want to replace it?') then
//                     exit;
//                // gvTranferFile.Create(gvPayrollSetup."Payroll Transfer Path" + '\' + gvFileName);
//                 end ;// cmm

// case gvTransferType of
//   gvTransferType::COOP:    CreateCOOP;
//   gvTransferType::KCB:    CreateKCB;
//   gvTransferType::CITI:    CreateLocalCitibanking;
//   gvTransferType::NHIF:    CreateNHIF;
//   gvTransferType::NSSF:    CreateNSSF;
//   gvTransferType::FOSO:    CreateFOSO;
//   gvTransferType::PAYNET:  CreatePAYNET;
//   gvTransferType::NBK:     CreateNBK;
//   gvTransferType::BBK:     CreateBBK;
//   gvTransferType::FINA:    CreateFINA;
//   gvTransferType::CFC:     CreateCFC;
//   gvTransferType::CFCSFI:  CreateCFCSFI;
//   gvTransferType::HELB:    CreateHELBFile;
//   gvTransferType::SCB:    CreateSCB;
// end;

//                 if (gvTransferType <> gvTransferType::HELB) then begin  //cmm 080813
//                  // gvTranferFile.Close;
//                   Message('File generation successfully completed.');
//                 end; //cmm
//             end;
//         }
//     }
// }

// trigger OnInit()
// var
//     lvPayrollUtilities: Codeunit "Payroll Posting";
// begin
//     //IGS make windows logins aware
//     gvAllowedPayrolls.SetRange("User ID",UserId);
//     gvAllowedPayrolls.SetRange("Last Active Payroll", true);
//     if gvAllowedPayrolls.FindFirst then begin
//       gvPeriodRec.SetRange(Status, gvPeriodRec.Status::Open);
//       gvPeriodRec.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//     end else
//       Error('You are not allowed access to any payroll.');
// end;

// var
//     gvPeriodRec: Record Periods;
//     gvEmployee: Record Employee;
//     gvHeader: Record "Payroll Header";
//     gvPayrollSetup: Record "Payroll Setups";
//     gvEmployeeBank: Record "Employee Bank Account";
//     gvPeriodCode: Code[10];
//     gvValueDate: Date;
//     gvFileName: Text[30];
//     gvTransferType: Option CITI,NHIF,NSSF,PAYNET,FOSO,NBK,BBK,FINA,CFC,CFCSFI,HELB,SCB,COOP,KCB;
//     gvTranferFile: File;
//     gvNetPayAmount: Decimal;
//     gvNegativeCounter: Integer;
//     gvFieldCounter: Integer;
//     gvMonthText: Text[30];
//     gvFullPath: Text[8];
//     gvHeaderText: Text[200];
//     FooterText: Text[80];
//     gvEmpCount: Integer;
//     gvTotalNetpay: Decimal;
//     gvHeaderDate: Text[30];
//     gvAmountToPay: Decimal;
//     gvAllowedPayrolls: Record "Allowed Payrolls";
//     gvModeofPaymentCode: Code[10];
//     gvEDCode: Code[20];
//     gvEDDefns: Record "ED Definitions";
//     EDName: Text[30];
//     PayrollSetup: Record "Payroll Setups";

// procedure CreateLocalCitibanking()
// var
//     NoofZeros: Integer;
//     WithLeadZerosNet: Text[30];
//     i: Integer;
//     WithLeadZerosEmpBank: Text[50];
//     WithLeadZerosCoBank: Text[50];
//     EmployerName: Text[50];
//     ZeroFilled: Text[50];
//     lvEmployeeName: Text[100];
// begin
//     gvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
//     //gvPayrollSetup.TESTFIELD("Bank Account No");

//     gvHeaderDate := DelChr(Format(Today),'=','-');
//     gvHeaderDate := InsStr(gvHeaderDate,'20',5);
//     gvHeaderText := '186' + gvHeaderDate + '01000000        ' + gvPayrollSetup."Employer Name";

//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     if gvEmployee.Find('-') then begin
//       // gvTranferFile.Write(
//       // StrSubstNo(gvHeaderText));
//       repeat
//         lvEmployeeName := gvEmployee.FullName;
//         gvEmployee.TestField("Bank Code");
//         gvEmployee.TestField("Bank Account No");
//         gvEmployeeBank.Get(gvEmployee."Bank Code");
//         gvEmployeeBank.TestField("KBA Code");
//         if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then begin
//           gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//           gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//           gvNetPayAmount := gvNetPayAmount * 100;
//           if gvNetPayAmount > 0 then begin
//               gvEmpCount := gvEmpCount +1;
//               gvTotalNetpay := gvTotalNetpay + gvNetPayAmount;
//               WithLeadZerosNet := Format(gvNetPayAmount,0,1);
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=','.');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//               NoofZeros := 13 - StrLen(WithLeadZerosNet);
//               for i := 1 to NoofZeros  do WithLeadZerosNet := '0' + WithLeadZerosNet;
//               NoofZeros := 15 - StrLen(gvEmployee."Bank Account No");
//               WithLeadZerosEmpBank :=  gvEmployee."Bank Account No";
//               for i := 1 to NoofZeros  do WithLeadZerosEmpBank := '0' + WithLeadZerosEmpBank;
//               NoofZeros :=15-  StrLen(gvPayrollSetup."Bank Account No");
//               WithLeadZerosCoBank := gvPayrollSetup."Bank Account No";
//               for i := 1 to NoofZeros  do WithLeadZerosCoBank := '0' + WithLeadZerosCoBank;
//               for i := 1 to 15 do lvEmployeeName := ' ' + lvEmployeeName;
//               lvEmployeeName := Format(lvEmployeeName,50);
//               EmployerName :=  Format(gvPayrollSetup."Employer Name",35);
//               ZeroFilled := '0000000000';

//         gvTranferFile.Write(
//           StrSubstNo('00') +
//           StrSubstNo('58') +
//           StrSubstNo(WithLeadZerosNet) +
//           StrSubstNo('0') +
//           StrSubstNo('01') +
//           StrSubstNo(gvEmployee."Bank Branch Code") +
//           StrSubstNo(WithLeadZerosCoBank) +
//           StrSubstNo(gvEmployeeBank."KBA Code") +
//           StrSubstNo(WithLeadZerosEmpBank) +
//           StrSubstNo('01') +
//           //skm100506 commented line below, to use Multiple Dim Feature later
//           //STRSUBSTNO(gvEmployee."Emp Branch Code") +
//           'Branch' +
//           StrSubstNo(lvEmployeeName) +
//           StrSubstNo(EmployerName) +
//           StrSubstNo(ZeroFilled));
//     end else begin
//       gvNegativeCounter += 1;
//     end;
//   end;
// until gvEmployee.Next = 0;

// FooterText := '190100000000' + Format(gvEmpCount) + '00000'+ Format(gvTotalNetpay);
//  gvTranferFile.Write(
//  StrSubstNo(FooterText));
// end;
// end;

// procedure CreateNHIF()
// var
//     lvNHIFNO: Code[10];
//     lvEmpNo: Code[20];
//     lvEmpID: Text[30];
//     lvNHIFAmount: Decimal;
//     lvEmployeeName: Text[100];
// begin
//     gvTotalNetpay := 0;
//     gvEmployee.Reset;
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     if gvEmployee.Find('-') then begin
// gvTranferFile.Write('Employer Code,' + gvPayrollSetup."Employer NHIF No.");
// gvTranferFile.Write('Employer Name,' + gvPayrollSetup."Employer Name");
// gvTranferFile.Write('Month of Contribution,' + gvPeriodCode);
// gvTranferFile.Write('');

//gvHeaderText := 'PERSONAL NO.,' + 'LAST NAME,' + 'FIRST NAMES,' + 'I/D NO.,' + 'NHIF NO.,' + 'AMOUNT';
// gvTranferFile.Write(StrSubstNo(gvHeaderText));
// gvTranferFile.Write('');

// gvEmployee.SetFilter("ED Code Filter", gvPayrollSetup."NHIF ED Code");
// gvEmployee.SetFilter("Period Filter", gvPeriodCode);

// repeat
//   gvEmployee.CalcFields(Amount);
//   // lvNHIFAmount := gvEmployee.Amount;
//   // gvTotalNetpay += lvNHIFAmount;

//  // if lvNHIFAmount > 0 then begin
//      gvEmployee.TestField("Last Name");
//      gvEmployee.TestField("First Name");

//      lvEmployeeName := gvEmployee."Last Name" + ',' + gvEmployee."First Name" + ' ' + gvEmployee."Middle Name" + ',';

//gvEmployee.TESTFIELD("NHIF No.");
/*IF gvEmployee."NHIF No." = '' THEN
  ERROR('Enter NHIF Membership No for ED %1, Employee %2', gvPayrollSetup."NHIF ED Code", gvEmployee."No.");*/
//      lvNHIFNO := gvEmployee."NHIF No." + ',';

//      lvEmpNo := gvEmployee."No." + ',';

//      //gvEmployee.TESTFIELD("National ID");
//      lvEmpID := gvEmployee."National ID" + ',';

//      gvTranferFile.Write(
//         StrSubstNo(lvEmpNo) +
//         StrSubstNo(lvEmployeeName) +
//         StrSubstNo(lvEmpID) +
//         StrSubstNo(lvNHIFNO) +
//         StrSubstNo(Format(lvNHIFAmount)))
//   end
// until gvEmployee.Next = 0;

// FooterText := ',,,,Total,' + Format(gvTotalNetpay);
// gvTranferFile.Write(FooterText);
// end;

//end;

// procedure CreateNSSF()
// var
//     lvNSSFAmount: Decimal;
//     lvEmployeeName: Text[100];
// begin
//     gvTotalNetpay := 0;
//     gvEmployee.Reset;
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     if gvEmployee.Find('-') then begin
// gvTranferFile.Write('Employer Name,' + gvPayrollSetup."Employer Name");
// gvTranferFile.Write('Employer Code,' + gvPayrollSetup."Employer NSSF No.");
// gvTranferFile.Write('Address,' + gvPayrollSetup."Employers Address");
// gvTranferFile.Write('');

// gvTranferFile.Write('Month,' + StrSubstNo('%1', gvPeriodRec."Period Month"));
// gvTranferFile.Write('Year,' +  StrSubstNo('%1', gvPeriodRec."Period Year"));
// gvTranferFile.Write('');

// gvTranferFile.Write('PERSONAL NUMBER,EMPLOYEE''S NAMES,FUND MEMBERSHIP NUMBER,MANANTORY CONTRIBUTIONS (KSHS),' +
//   'VOLUNTARY CONTRIBUTIONS (KSHS),TOTAL AMOUNT KSHS,NATIONAL ID NO');
// gvTranferFile.Write('');

// gvEmployee.SetFilter("ED Code Filter", gvPayrollSetup."NSSF ED Code");
// gvEmployee.SetFilter("Period Filter", gvPeriodCode);

// repeat
//   gvEmployee.CalcFields(Amount);
// lvNSSFAmount := gvEmployee.Amount;
// gvTotalNetpay += lvNSSFAmount;

//         if lvNSSFAmount > 0 then begin
//            lvEmployeeName := gvEmployee.FullName;
//            if lvEmployeeName = '' then Error('All employee names are blank for employee number %1', gvEmployee."No.");

//            gvEmployee.TestField("NSSF No.");
//            if gvEmployee."NSSF No." = '' then
//              Error('Enter NSSF Membership No for ED %1, Employee %2', gvPayrollSetup."NSSF ED Code", gvEmployee."No.");

//            gvEmployee.TestField("National ID");

//            gvTranferFile.Write(
//               gvEmployee."No." + ',' +
//               lvEmployeeName + ',' +
//               gvEmployee."NSSF No." + ',' +
//               ',,' +
//               StrSubstNo(Format(lvNSSFAmount)) + ',' +
//               gvEmployee."National ID")
//         end
//       until gvEmployee.Next = 0;

//       gvTranferFile.Write(',,,,TOTAL CONTRIBUTIONS,' + Format(gvTotalNetpay));
//     end;
// end;

// procedure CreateFOSO()
// var
//     WithLeadZerosNet: Text[30];
//     lvEmployeeName: Text[30];
//     lvEmployeeNo: Code[4];
//     NoofZeros: Integer;
//     i: Integer;
//     lvDeptCode: Code[1];
//     lvDeptRec: Record "Dimension Value";
// begin
//     gvEmpCount:=0;
//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     if gvEmployee.Find('-') then begin

//       repeat
//         lvEmployeeName := gvEmployee.FullName;
//         if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then begin
//           gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//           gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//           if gvNetPayAmount > 0 then begin
//               gvEmpCount := gvEmpCount +1;
//               gvTotalNetpay := gvTotalNetpay + gvNetPayAmount;
//               WithLeadZerosNet := Format(gvNetPayAmount,0,'<Precision,2:2><Standard Format,1>');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//               NoofZeros := 15 - StrLen(WithLeadZerosNet);
//               for i := 1 to NoofZeros  do
//               begin
//               WithLeadZerosNet := '0' + WithLeadZerosNet;
//               end;

//               lvDeptRec.SetRange("Dimension Code", 'DEPARTMENT');
//               if lvDeptRec.Find('-') then

//               lvEmployeeName := Format(lvEmployeeName,24);
//               lvEmployeeNo := Format(gvEmployee."No.",4);

//               gvTranferFile.Write(
//               StrSubstNo('5-02-') +
//               StrSubstNo('01') +
//               StrSubstNo('/') +
//               StrSubstNo(lvEmployeeNo)+
//               StrSubstNo('-00') +
//               StrSubstNo(' ') +
//               StrSubstNo(lvEmployeeName) +
//               StrSubstNo(' ') +
//               StrSubstNo(WithLeadZerosNet) +
//               StrSubstNo(' '));
//           end else begin
//             gvNegativeCounter := gvNegativeCounter + 1;
//           end;
//         end;
//       until gvEmployee.Next = 0;
//     end;
// end;

// procedure CreatePAYNET()
// var
//     WithLeadZerosNet: Text[30];
//     lvEmployeeName: Text[35];
//     lvEmployeeNo: Text[9];
//     NoofZeros: Integer;
//     i: Integer;
//     lvDeptCode: Code[1];
//     lvDeptRec: Record "Dimension Value";
//     lvCompanyName: Text[30];
//     lvCompanyRec: Record "Company Information";
//     lvZeroes: Text[130];
//     lvEmpBankCode: Text[2];
//     lvEmpBankBranch: Text[3];
//     lvEmpBankNo: Text[15];
//     lvSpaces: Text[15];
//     lvCountText: Text[5];
//     j: Integer;
// begin
//     if gvValueDate = 0D then Error('The Value Date must be specified');
//     gvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");

//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     gvEmpCount:=0;
//     gvTotalNetpay := 0;

//     gvHeaderDate := Format(gvValueDate,0,'<Closing><Day,2><Month,2><Year4>');
//     lvCompanyRec.Get;
//     lvCompanyName := Format(lvCompanyRec.Name,30);

//     for i := 1 to 101 do begin
//      lvZeroes := '0' + lvZeroes;
//     end;

//Header Record
// gvTranferFile.Write(
//           StrSubstNo('186') +
//           StrSubstNo(gvHeaderDate) +
//           StrSubstNo('01') +
//           StrSubstNo('000000') +
//           StrSubstNo(gvPayrollSetup."Payroll Company Code")+
//           StrSubstNo('01100') +
//           StrSubstNo(lvCompanyName) +
//           StrSubstNo(lvZeroes));

//Detail Records
// if gvEmployee.Find('-') then begin
//   repeat
//     lvEmployeeName := gvEmployee.FullName;
//     if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then begin
//       gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//       gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";

//       if gvNetPayAmount > 0 then begin
//           gvEmpCount := gvEmpCount +1;
//           gvTotalNetpay := gvTotalNetpay + gvNetPayAmount;
//           WithLeadZerosNet := Format(gvNetPayAmount,0,'<Precision,2:2><Standard Format,1>');
//           WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//           WithLeadZerosNet := DelChr(WithLeadZerosNet,'=','.');
//           NoofZeros := 13 - StrLen(WithLeadZerosNet);
//           for i := 1 to NoofZeros  do
//           begin
//           WithLeadZerosNet := '0' + WithLeadZerosNet;
//           end;

/* lvBranchRec.GET(gvEmployee."Emp Branch Code");
 lvBranchCode := lvBranchRec."Branch ID";
 lvBranchCode := FORMAT(lvBranchCode,2);
 lvDeptRec.GET(gvEmployee."Department Code");
 lvDeptCode :=  lvDeptRec."CMC Payroll Code";  */


//               lvEmployeeName := Format(lvEmployeeName,35);
//               lvEmployeeNo := Format(gvEmployee."No.",9);
//               lvEmpBankCode := Format(gvEmployee."Bank Code",2);
//               lvEmpBankBranch := Format(gvEmployee."Bank Branch Code",3);
//               lvEmpBankNo := Format(gvEmployee."Bank Account No",15);

//               lvSpaces :='';
//               for i := 1 to 15  do
//               begin
//               lvSpaces := ' ' + lvSpaces;
//               end;

//               lvCompanyName := Format(lvCompanyRec.Name,26);

//               gvTranferFile.Write(
//               StrSubstNo('0058') +
//               StrSubstNo(WithLeadZerosNet) +
//               StrSubstNo('0') +
//               StrSubstNo('32') +
//               StrSubstNo('000') +
//               StrSubstNo('000000200514408') +
//               StrSubstNo(lvEmpBankCode)+
//               StrSubstNo(lvEmpBankBranch) +
//               StrSubstNo(lvEmpBankNo) +
//               StrSubstNo('32') +
//               StrSubstNo('000') +
//               StrSubstNo(lvSpaces) +
//               StrSubstNo(lvEmployeeName) +
//               StrSubstNo(lvCompanyName) +
//               StrSubstNo(lvEmployeeNo) +
//               StrSubstNo('0000000000'));
//           end else begin
//             gvNegativeCounter := gvNegativeCounter + 1;
//           end;
//         end;
//       until gvEmployee.Next = 0;

//               lvCountText:= Format(gvEmpCount,0);
//               NoofZeros := 5 - StrLen(lvCountText);
//               for i := 1 to NoofZeros  do
//               begin
//               lvCountText := '0' + lvCountText;
//               end;

//               WithLeadZerosNet:='';
//               WithLeadZerosNet := Format(gvTotalNetpay,0,'<Precision,2:2><Standard Format,1>');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=','.');
//               NoofZeros := 14 - StrLen(WithLeadZerosNet);
//               for i := 1 to NoofZeros  do begin
//                 WithLeadZerosNet := '0' + WithLeadZerosNet;
//               end;

//               lvZeroes := '';
//               for i := 1 to 129 do
//               begin
//                lvZeroes := '0' + lvZeroes;
//               end;

//               //Trailer Record
//               gvTranferFile.Write(
//               StrSubstNo('1901') +
//               StrSubstNo('000000') +
//               StrSubstNo(lvCountText) +
//               StrSubstNo(WithLeadZerosNet) +
//               StrSubstNo(lvZeroes));
//     end;

// end;

// procedure CreateNBK()
// var
//     NoofZeros: Integer;
//     WithLeadZerosNet: Text[30];
//     i: Integer;
//     WithLeadZerosEmpBank: Text[50];
//     WithLeadZerosCoBank: Text[50];
//     EmployerName: Text[50];
//     ZeroFilled: Text[50];
//     lvEmployeeName: Text[100];
//     j: Integer;
// begin
//     j := 0;
//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     if gvEmployee.Find('-') then
//       repeat
//        j:= j +1;
//         lvEmployeeName := gvEmployee.FullName;
//         CheckNameLength(lvEmployeeName);

//         CheckReferenceLength('KEMSA'+gvEmployee."No.");

//         gvEmployee.TestField("Bank Code");
//         gvEmployee.TestField("Bank Account No");
//         CheckAccNoLength(gvEmployee."Bank Account No");

//         gvEmployeeBank.Get(gvEmployee."Bank Code");

//         gvEmployeeBank.TestField("KBA Code");
//         CheckBankCodeLength(gvEmployeeBank."KBA Code");

//         gvEmployeeBank.TestField("Bank Branch Code");
//         CheckBranchCodeLength(gvEmployeeBank."Bank Branch Code");

//         if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then
//         begin
//           gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//           gvAmountToPay := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//           if gvAmountToPay > 0 then
//           begin
//               gvTranferFile.Write(
//               StrSubstNo(Format(j)) +  ','+
//               StrSubstNo(lvEmployeeName) + ','+
//               StrSubstNo(Format(gvEmployeeBank."KBA Code")) +  ','+
//               StrSubstNo(Format(gvEmployee."Bank Branch Code")) + ','+
//               StrSubstNo(Format(gvEmployee."Bank Account No",13)) + ','+
//               StrSubstNo(Format('KEMSA'+gvEmployee."No.")) + ','+
//               StrSubstNo(Format(gvAmountToPay,13,1)));
//           end;
//         end
//       until gvEmployee.Next = 0;
// end;

// procedure CreateBBK()
// var
//     lvEmployeeName: Text[100];
//     lvNetPayText: Text[30];
// begin
//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//     if gvEmployee.Find('-') then
//       repeat
//         if gvHeader.Get(gvPeriodCode, gvEmployee."No.") then begin
//           if StrPos(gvEmployee."No.", ',') > 0 then Error('Comma not allowed in Emp No %1', gvEmployee."No.");
//           if StrLen(gvEmployee."No.") > 15 then Error('Employee''s No %1 is longer than 15 characters.', gvEmployee."No.");

//           lvEmployeeName := gvEmployee.FullName;
//           if StrPos(lvEmployeeName, ',') > 0 then Error('Comma not allowed in Emp Full Name %1', lvEmployeeName);
//           if StrLen(lvEmployeeName) > 30 then Error('Employee''s Full Name %1 is longer than 30 characters.', lvEmployeeName);

//           gvEmployee.TestField("Bank Code");
//           if StrPos(gvEmployee."Bank Code", ',') > 0 then
//             Error('Comma not allowed in Bank Code %1 for Emp No %2', gvEmployee."Bank Code", gvEmployee."No.");
//           if StrLen(gvEmployee."Bank Code") > 5 then
//             Error('Emp No %1 Bank Code %2 is longer than 5 characters.', gvEmployee."No.", gvEmployee."Bank Code");

//           gvEmployee.TestField("Bank Account No");
//           if StrPos(gvEmployee."Bank Account No", ',') > 0 then
//             Error('Comma not allowed in Bank Account No %1 for Emp No %2', gvEmployee."Bank Account No", gvEmployee."No.");
//           if StrLen(gvEmployee."Bank Account No") > 13 then
//             Error('Emp No %1 Bank Account No %2 is longer than 13 characters.', gvEmployee."No.", gvEmployee."Bank Account No");

//           gvHeader.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
//           gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//           if gvNetPayAmount > 0 then begin
//             lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//             lvNetPayText := DelChr(lvNetPayText, '=', ',');
//             if StrLen(lvNetPayText) > 12 then
//               Error('Emp No %1 Net Pay %2 is more than 12 digits.', gvEmployee."No.", lvNetPayText);

//             gvTranferFile.Write(
//                 gvEmployee."No." + ',' +
//                 lvEmployeeName  + ',' +
//                 gvEmployee."Bank Code" + ',' +
//                 gvEmployee."Bank Account No" + ',' +
//                 lvNetPayText)
//           end;
//         end;
//       until gvEmployee.Next = 0;
// end;

// procedure CreateFINA()
// var
//     lvEmployeeName: Text[100];
//     lvNetPayText: Text[30];
//     lvEmployeeBank: Record "Employee Bank Account";
//     lvCompanyBank: Record "Employee Bank Account";
// begin
//     gvPayrollSetup.TestField("Bank Code");
//     gvPayrollSetup.TestField("Bank Account No");

//     // lvCompanyBank.Get(gvPayrollSetup."Bank Code");
//     // lvCompanyBank.TestField("KBA Code");
//     // lvCompanyBank.TestField("Bank Branch Code");
//     // if StrLen(lvCompanyBank."KBA Code") > 2 then
//     //   Error('Company KBA Bank Code %3 is longer than 2 characters.', lvEmployeeBank."KBA Code");
//     // if StrLen(lvCompanyBank."Bank Branch Code") > 3 then
//     //   Error('Company KBA Bank Branch Code %3 is longer than 3 characters.', lvCompanyBank."Bank Branch Code");

//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//     if gvEmployee.Find('-') then
//       repeat
//         if gvHeader.Get(gvPeriodCode, gvEmployee."No.") then begin

//           lvEmployeeName := gvEmployee.FullName;
//           if StrLen(lvEmployeeName) > 35 then Error('Employee''s Full Name %1 is longer than 35 characters.', lvEmployeeName);

//           gvEmployee.TestField("Bank Code");
// lvEmployeeBank.Get(gvEmployee."Bank Code");
// if StrLen(lvEmployeeBank."KBA Code") > 2 then
//     Error('Emp No %1 Bank Code %2 KBA Code %3 is longer than 2 characters.',
//         gvEmployee."No.", gvEmployee."Bank Code", lvEmployeeBank."KBA Code");

//   gvEmployee.TestField("Bank Account No");
//   if StrLen(gvEmployee."Bank Account No") > 15 then
//     Error('Emp No %1 Bank Account No %2 is longer than 15 characters.', gvEmployee."No.", gvEmployee."Bank Account No");

//   gvHeader.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
//   gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//   if gvNetPayAmount > 0 then begin
//     lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//     lvNetPayText := DelChr(lvNetPayText, '=', ',');
//     if StrLen(lvNetPayText) > 13 then
//       Error('Emp No %1 Net Pay %2 is more than 13 digits.', gvEmployee."No.", lvNetPayText);

//     gvTranferFile.Write(
//         PadStr(lvNetPayText, 13) +
//         PadStr(lvCompanyBank."KBA Code", 2) +
//         PadStr(lvCompanyBank."Bank Branch Code", 3) +
//         PadStr(gvPayrollSetup."Bank Account No", 15) +
//         PadStr(gvPayrollSetup."Employer Name", 20) +
//         PadStr(StrSubstNo('%1 Salary', gvPeriodRec.Description), 15) +
//         PadStr(lvEmployeeName, 35) +
//         PadStr(lvEmployeeBank."KBA Code", 2) +
//         PadStr(lvEmployeeBank."Bank Branch Code", 3) +
//         PadStr(gvEmployee."Bank Account No", 15) +
//         PadStr(StrSubstNo('%1', gvValueDate), 10)
//         )
//   end;
// end;
//until gvEmployee.Next = 0;
//end;

// procedure CreateCFC()
// var
//     lvEmployeeName: Text[100];
//     lvNetPayText: Text[30];
// begin
//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//     //gvEmployee.SETRANGE(SACCO, FALSE);//IGS Oct 2016
//     if gvEmployee.Find('-') then begin
//     if gvEmployee.FindSet(false) then
//       repeat
//         if gvHeader.Get(gvPeriodCode, gvEmployee."No.") then begin
//           lvEmployeeName := gvEmployee.FullName;
//           if StrPos(lvEmployeeName, ',') > 0 then Error('Comma not allowed in Emp Full Name %1', lvEmployeeName);
//           if StrLen(lvEmployeeName) > 30 then Error('Employee''s Full Name %1 is longer than 30 characters.', lvEmployeeName);

//           gvEmployee.TestField("Bank Code");
//           if StrPos(gvEmployee."Bank Code", ',') > 0 then
//             Error('Comma not allowed in Bank Code %1 for Emp No %2', gvEmployee."Bank Code", gvEmployee."No.");
//           if StrLen(gvEmployee."Bank Code") > 5 then
//             Error('Emp No %1 Bank Code %2 is longer than 5 characters.', gvEmployee."No.", gvEmployee."Bank Code");

//           gvEmployee.TestField("Bank Account No");
//           if StrPos(gvEmployee."Bank Account No", ',') > 0 then
//             Error('Comma not allowed in Bank Account No %1 for Emp No %2', gvEmployee."Bank Account No", gvEmployee."No.");
//           //IF STRLEN(gvEmployee."Bank Account No.") > 13 THEN
//           //  ERROR('Emp No %1 Bank Account No %2 is longer than 13 characters.', gvEmployee."No.", gvEmployee."Bank Account No.");

//           gvHeader.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
//           gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";

//           if gvNetPayAmount > 0 then begin
//             lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//             lvNetPayText := DelChr(lvNetPayText, '=', ',');
//             if StrLen(lvNetPayText) > 12 then
//               Error('Emp No %1 Net Pay %2 is more than 12 digits.', gvEmployee."No.", lvNetPayText);

//             gvTranferFile.Write(
//                 lvEmployeeName+ ',' +gvEmployee."Bank Account No" + ',' +gvEmployee."Bank Code"+ ',' +
//                 lvNetPayText + ',' +
//                 Format('Salary '+ gvPeriodCode+' for '+gvEmployee."No."))
//           end;
//         end;
//       until gvEmployee.Next = 0;
//  end;

// gvNetPayAmount:=0;
// gvEmployee.Reset;
// gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
// gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
// //gvEmployee.SETRANGE(SACCO, TRUE);//IGS Oct 2016
// if gvEmployee.Find('-') then begin
//   repeat
//     lvEmployeeName := 'SACCO Employees';
//     if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then begin
//       gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//       gvNetPayAmount := gvNetPayAmount+(gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)");
//   end;
//   until gvEmployee.Next = 0;
//       if StrPos(lvEmployeeName, ',') > 0 then Error('Comma not allowed in Emp Full Name %1', lvEmployeeName);
//       if StrLen(lvEmployeeName) > 30 then Error('Employee''s Full Name %1 is longer than 30 characters.', lvEmployeeName);

//       gvEmployee.TestField("Bank Code");
//       if StrPos(gvEmployee."Bank Code", ',') > 0 then
//         Error('Comma not allowed in Bank Code %1 for Emp No %2', gvEmployee."Bank Code", gvEmployee."No.");
//       if StrLen(gvEmployee."Bank Code") > 5 then
//         Error('Emp No %1 Bank Code %2 is longer than 5 characters.', gvEmployee."No.", gvEmployee."Bank Code");

//       gvEmployee.TestField("Bank Account No");
//       if StrPos(gvEmployee."Bank Account No", ',') > 0 then
//         Error('Comma not allowed in Bank Account No %1 for Emp No %2', gvEmployee."Bank Account No", gvEmployee."No.");
//       //IF STRLEN(gvEmployee."Bank Account No.") > 13 THEN
//       //  ERROR('Emp No %1 Bank Account No %2 is longer than 13 characters.', gvEmployee."No.", gvEmployee."Bank Account No.");
//       // if gvNetPayAmount > 0 then begin
//       //   lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//       //   lvNetPayText := DelChr(lvNetPayText, '=', ',');
//       //   if StrLen(lvNetPayText) > 12 then
//       //     Error('Emp No %1 Net Pay %2 is more than 12 digits.', gvEmployee."No.", lvNetPayText);

//       //   gvTranferFile.Write(
//       //       lvEmployeeName+ ',' +gvEmployee."Bank Account No" + ',' +gvEmployee."Bank Code"+ ',' +
//       //       lvNetPayText + ',' +
//       //       Format('Salary '+ gvPeriodCode+' for SACCO employees'))
//       // end;
//     end;
//end;

// procedure CheckNameLength(Name: Text[100])
// begin
//     if StrLen(Name) > 35 then
//       Error('Employee Full Name cannot exceed 35 characters, value is %1 for employee No. %2', Name, gvEmployee."No.");
// end;

// procedure CheckBankCodeLength(BankCode: Code[5])
// begin
//     if StrLen(BankCode) > 2 then
//       Error('Bank Code cannot exceed 2 characters, value is %1 for employee %2', BankCode, gvEmployee."No.");
// end;

// procedure CheckBranchCodeLength(BranchCode: Code[5])
// begin
//     if StrLen(BranchCode) > 3 then
//       Error('Bank Branch Code cannot exceed 3 characters, value is %1 for employee %2', BranchCode, gvEmployee."No.");
// end;

// procedure CheckAccNoLength(AccountNo: Code[15])
// begin
//     if StrLen(AccountNo) > 13 then
//       Error('Employee Bank Account number cannot exceed 13 characters, value is %1 for employee %2', AccountNo, gvEmployee."No.");
// end;

// procedure CheckReferenceLength(Reference: Text[15])
// begin
//     if StrLen(Reference) > 12 then
//       Error('Reference number cannot exceed 13 characters, value is %1 for employee %2', Reference, gvEmployee."No.");
// end;

// procedure CreateCFCSFI()
// var
//     lvEmployeeName: Text[100];
//     lvNetPayText: Text[30];
//     lvEmployeeBank: Record "Employee Bank Account";
//     SortCode: Text[30];
//     lvEDAmount: Decimal;
//     lvEDAmountText: Text[30];
// begin
//       gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//       gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

//       if gvEmployee.FindSet(false) then
//         repeat
//           if gvHeader.Get(gvPeriodCode, gvEmployee."No.") then begin
//             lvEmployeeName := gvEmployee.FullName;
//             if StrPos(lvEmployeeName, ',') > 0 then Error('Comma not allowed in Emp Full Name %1', lvEmployeeName);
//             if StrLen(lvEmployeeName) > 30 then Error('Employee''s Full Name %1 is longer than 30 characters.', lvEmployeeName);

//             gvEmployee.TestField("Bank Code");
//             if StrPos(gvEmployee."Bank Code", ',') > 0 then
//               Error('Comma not allowed in Bank Code %1 for Emp No %2', gvEmployee."Bank Code", gvEmployee."No.");

//             if lvEmployeeBank.Get(gvEmployee."Bank Code") then
//               //SortCode := FORMAT(lvEmployeeBank."KBA Code" + lvEmployeeBank."Bank Branch Code");
//               SortCode := Format(gvEmployee."Bank Code");//IGS 2016
//             if StrLen(SortCode) > 5 then
//               Error('Emp No %1''s bank code and branch code combined is longer than 5 characters.', gvEmployee."No.");

//             gvEmployee.TestField("Bank Account No");
//             if StrPos(gvEmployee."Bank Account No", ',') > 0 then
//               Error('Comma not allowed in Bank Account No %1 for Emp No %2', gvEmployee."Bank Account No", gvEmployee."No.");
//             if StrLen(gvEmployee."Bank Account No") > 13 then
//               Error('Emp No %1 Bank Account No %2 is longer than 13 characters.', gvEmployee."No.", gvEmployee."Bank Account No");

//             if gvEDCode <> '' then
//               begin
//                gvEmployee.SetFilter("ED Code Filter", gvEDCode);
//                gvEmployee.SetFilter("Period Filter", gvPeriodCode);
//                gvEmployee.CalcFields(Amount);
//                lvEDAmount := gvEmployee.Amount;
//                if lvEDAmount > 0 then begin
//                  lvEDAmountText := StrSubstNo('%1', lvEDAmount);
//                  lvEDAmountText := DelChr(lvEDAmountText, '=', ',');
//                  if StrLen(lvEDAmountText) > 12 then
//                    Error('Emp No %1 Amount %2 is more than 12 digits.', gvEmployee."No.", lvEDAmountText);

//                  gvTranferFile.Write(
//                      lvEmployeeName + ',' +
//                      gvEmployee."Bank Account No" + ',' +
//                      SortCode + ',' +
//                      lvEDAmountText + ',' +
//                      gvEmployee."No.");
//                  end;
//               end else begin
//                 gvHeader.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
//                 gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//                 if gvNetPayAmount > 0 then begin
//                   lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//                   lvNetPayText := DelChr(lvNetPayText, '=', ',');
//                   if StrLen(lvNetPayText) > 12 then
//                     Error('Emp No %1 Net Pay %2 is more than 12 digits.', gvEmployee."No.", lvNetPayText);

//                 if gvNetPayAmount > 0 then
//                   gvTranferFile.Write(
//                       lvEmployeeName + ',' +
//                     gvEmployee."Bank Account No" + ',' +
//                     SortCode + ',' +
//                     lvNetPayText + ',' +
//                     gvEmployee."No.");
//                end;
//             end;
//          end
//         until gvEmployee.Next = 0;
// end;

// procedure CreateHELBFile()
// var
//     lvPayrollLine: Record "Payroll Lines";
//     lvTempExcelBuffer: Record "Excel Buffer" temporary;
//     lvEmployee: Record Employee;
//     lvTotalAmount: Decimal;
// begin
//     if gvEDCode= '' then Error('ED Code must be specified for HELB file');
//     lvPayrollLine.SetRange("Payroll ID",gvPeriodCode);
//     lvPayrollLine.SetRange("Payroll Code",gvAllowedPayrolls."Payroll Code");
//     lvPayrollLine.SetRange("ED Code",gvEDCode);
//     if lvPayrollLine.FindFirst then begin
//     PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
//     lvTempExcelBuffer.AddColumn('HELB LOAN MONTHLY REPAYMENT SCHEDULE',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.AddColumn('NAME OF EMPLOYER',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(PayrollSetup."Employer Name",false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(' ',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(' ',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('EMPLOYER PIN NO.',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(PayrollSetup."Employer PIN No.",false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.AddColumn('POSTAL ADDRESS',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(PayrollSetup."Employers Address",false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(' ',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(' ',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('EMPLOYER HELB No.',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(PayrollSetup."Employer HELB No.",false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('PAYROLL MONTH',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     //lvTempExcelBuffer.AddColumn(,FALSE,'',TRUE,FALSE,TRUE,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('HELB PAYMENT DETAILS',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.AddColumn('S/NO',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('PAYROLL NO.',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('NAME OF LOANEE',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text) ;
//     lvTempExcelBuffer.AddColumn('ID NO.',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('PIN NO.',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('AMOUNT DEDUCTED',false,'',true,false,true,'',lvTempExcelBuffer."Cell Type"::Text);
//     repeat
//       lvTempExcelBuffer.NewRow;
//       lvEmployee.Get(lvPayrollLine."Employee No.");
//       lvTempExcelBuffer.AddColumn(' ',false,'',false,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//       lvTempExcelBuffer.AddColumn(lvPayrollLine."Employee No.",false,'',false,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//       lvTempExcelBuffer.AddColumn(lvEmployee.FullName,false,'',false,false,false,'',lvTempExcelBuffer."Cell Type"::Text) ;
//       lvTempExcelBuffer.AddColumn(lvEmployee."National ID",false,'',false,false,false,'',lvTempExcelBuffer."Cell Type"::Text) ;
//       lvTempExcelBuffer.AddColumn(lvEmployee.PIN,false,'',false,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//       lvTempExcelBuffer.AddColumn(Abs(lvPayrollLine."Amount (LCY)"),false,'',false,false,false,'',lvTempExcelBuffer."Cell Type"::Number);
//       lvTotalAmount+=Abs(lvPayrollLine."Amount (LCY)");
//     until lvPayrollLine.Next=0;
//     end;
//     lvTempExcelBuffer.NewRow;
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text) ;
//     lvTempExcelBuffer.AddColumn('TOTAL DEDUCTIONS (KSHS)',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn('',false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Text);
//     lvTempExcelBuffer.AddColumn(lvTotalAmount,false,'',true,false,false,'',lvTempExcelBuffer."Cell Type"::Number);

//     lvTempExcelBuffer.CreateBook(StrSubstNo('HELB - %1',gvPeriodCode),gvPeriodCode);
//     lvTempExcelBuffer.WriteSheet(gvAllowedPayrolls."Payroll Code",CompanyName,UserId);
//     lvTempExcelBuffer.CloseBook;
//     lvTempExcelBuffer.OpenExcel;
//     //lvTempExcelBuffer.UpdateBookStream
// end;

// procedure CreateSCB()
// var
//     WithLeadZerosNet: Text[30];
//     lvEmployeeName: Text[35];
//     lvEmployeeNo: Text[9];
//     NoofZeros: Integer;
//     i: Integer;
//     lvDeptCode: Code[1];
//     lvDeptRec: Record "Dimension Value";
//     lvCompanyName: Text[30];
//     lvCompanyRec: Record "Company Information";
//     lvZeroes: Text[130];
//     lvEmpBankCode: Text[2];
//     lvEmpBankBranch: Text[3];
//     lvEmpBankNo: Text[15];
//     lvSpaces: Text[15];
//     lvCountText: Text[5];
//     j: Integer;
// begin
//     if gvValueDate = 0D then Error('The Value Date must be specified');
//     gvPayrollSetup.Get(gvAllowedPayrolls."Payroll Code");

//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//     //gvEmployee.SETRANGE(SACCO, FALSE);//IGS Oct 2016
//     gvEmpCount:=0;
//     gvTotalNetpay := 0;

//     gvHeaderDate := Format(gvValueDate,0,'<Closing><Day,2>/<Month,2>/<Year4>');
//     lvCompanyRec.Get;
//     lvCompanyName := Format(lvCompanyRec.Name,30);

//     for i := 1 to 101 do begin
//      lvZeroes := '0' + lvZeroes;
//     end;

//     //Header Record
//     // gvTranferFile.Write(
//     //           'H,P');

//     //Detail Records
//     if gvEmployee.Find('-') then begin
//       repeat
//         lvEmployeeName := gvEmployee.FullName;
//         if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then begin
//           gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//           gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";

//           if gvNetPayAmount > 0 then begin
//               gvEmpCount := gvEmpCount +1;
//               gvTotalNetpay := gvTotalNetpay + gvNetPayAmount;
//               WithLeadZerosNet := Format(gvNetPayAmount,0,'<Precision,2:2><Standard Format,1>');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=','.');
//               NoofZeros := 13 - StrLen(WithLeadZerosNet);
//               for i := 1 to NoofZeros  do
//               begin
//               WithLeadZerosNet := '0' + WithLeadZerosNet;
//               end;

//              /* lvBranchRec.GET(gvEmployee."Emp Branch Code");
//               lvBranchCode := lvBranchRec."Branch ID";
//               lvBranchCode := FORMAT(lvBranchCode,2);
//               lvDeptRec.GET(gvEmployee."Department Code");
//               lvDeptCode :=  lvDeptRec."CMC Payroll Code";  */


//               lvEmployeeName := Format(lvEmployeeName,35);
//               lvEmployeeNo := Format(gvEmployee."No.",9);
//               lvEmpBankCode := Format(gvEmployee."Bank Code",2);
//               lvEmpBankBranch := CopyStr(gvEmployee."Bank Code",3,3);
//               lvEmpBankNo := Format(gvEmployee."Bank Account No",15);

//               lvSpaces :='';
//               for i := 1 to 15  do
//               begin
//               lvSpaces := ' ' + lvSpaces;
//               end;

//               lvCompanyName := Format(lvCompanyRec.Name,26);
//               //gvNetPayAmount:=DELCHR(FORMAT(gvNetPayAmount),'=',',');//IGS Sep 2016
//               gvTranferFile.Write(
//               StrSubstNo('P,PAY, BA,,') +
//               StrSubstNo(DelChr(lvEmployeeNo,'<>',' ')) +
//               StrSubstNo(',,KE,NBO,0106023681600,') +
//               StrSubstNo(gvHeaderDate) +
//               StrSubstNo(',') +
//               StrSubstNo(DelChr(lvEmployeeName,'<>',' ')) +
//               StrSubstNo(',') +
//               StrSubstNo(',,,,') +
//               StrSubstNo(lvEmpBankCode)+
//               StrSubstNo(',,')+
//               StrSubstNo(lvEmpBankBranch) +
//               StrSubstNo(',,')+
//               StrSubstNo(DelChr(lvEmpBankNo,'<>',' ')) +
//               StrSubstNo(',,,,,,,,,,,,,,,,,,') +
//               StrSubstNo('KES') +
//               StrSubstNo(',') +
//               Format(DelChr(Format(gvNetPayAmount),'=',',')) +
//               StrSubstNo(',,,,,,,,,,,,,,,,,,,,,,') +
//               StrSubstNo('SCBLKENXXXX,,'));

//           end else begin
//             gvNegativeCounter := gvNegativeCounter + 1;
//           end;
//         end;
//       until gvEmployee.Next = 0;
//     /*
//               lvCountText:= FORMAT(gvEmpCount,0);
//               NoofZeros := 5 - STRLEN(lvCountText);
//               FOR i := 1 TO NoofZeros  DO
//               BEGIN
//               lvCountText := '0' + lvCountText;
//               END;
//     */
//     //IGS Oct 2016
//     gvNetPayAmount:=0;
//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//     //gvEmployee.SETRANGE(SACCO, TRUE);//IGS Oct 2016
//     if gvEmployee.Find('-') then begin
//       repeat
//         lvEmployeeName := 'SACCO Employees';
//         if gvHeader.Get(gvPeriodCode,gvEmployee."No.") then begin
//           gvHeader.CalcFields("Total Payable (LCY)","Total Deduction (LCY)");
//           gvNetPayAmount := gvNetPayAmount+(gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)");
//       end;
//       until gvEmployee.Next = 0;

//           if gvNetPayAmount > 0 then begin
//               gvEmpCount := gvEmpCount +1;
//               gvTotalNetpay := gvTotalNetpay + gvNetPayAmount;
//               WithLeadZerosNet := Format(gvNetPayAmount,0,'<Precision,2:2><Standard Format,1>');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=','.');
//               NoofZeros := 13 - StrLen(WithLeadZerosNet);
//               for i := 1 to NoofZeros  do
//               begin
//               WithLeadZerosNet := '0' + WithLeadZerosNet;
//               end;

//              /* lvBranchRec.GET(gvEmployee."Emp Branch Code");
//               lvBranchCode := lvBranchRec."Branch ID";
//               lvBranchCode := FORMAT(lvBranchCode,2);
//               lvDeptRec.GET(gvEmployee."Department Code");
//               lvDeptCode :=  lvDeptRec."CMC Payroll Code";  */


//               lvEmployeeName := Format(lvEmployeeName,35);
//               lvEmployeeNo := Format(9999,9);//IGS Oct 2016
//               lvEmpBankCode := Format(gvEmployee."Bank Code",2);
//               lvEmpBankBranch := CopyStr(gvEmployee."Bank Code",3,3);
//               lvEmpBankNo := Format(gvEmployee."Bank Account No",15);

//               lvSpaces :='';
//               for i := 1 to 15  do
//               begin
//               lvSpaces := ' ' + lvSpaces;
//               end;

//               lvCompanyName := Format(lvCompanyRec.Name,26);
//               //gvNetPayAmount:=DELCHR(FORMAT(gvNetPayAmount),'=',',');//IGS Sep 2016
//               gvTranferFile.Write(
//               StrSubstNo('P,PAY, BA,,') +
//               StrSubstNo(DelChr(lvEmployeeNo,'<>',' ')) +
//               StrSubstNo(',,KE,NBO,0106023681600,') +
//               StrSubstNo(gvHeaderDate) +
//               StrSubstNo(',') +
//               StrSubstNo(DelChr(lvEmployeeName,'<>',' ')) +
//               StrSubstNo(',') +
//               StrSubstNo(',,,,') +
//               StrSubstNo(lvEmpBankCode)+
//               StrSubstNo(',,')+
//               StrSubstNo(lvEmpBankBranch) +
//               StrSubstNo(',,')+
//               StrSubstNo(DelChr(lvEmpBankNo,'<>',' ')) +
//               StrSubstNo(',,,,,,,,,,,,,,,,,,') +
//               StrSubstNo('KES') +
//               StrSubstNo(',') +
//               Format(DelChr(Format(gvNetPayAmount),'=',',')) +
//               StrSubstNo(',,,,,,,,,,,,,,,,,,,,,,') +
//               StrSubstNo('SCBLKENXXXX,,'));

//             end else begin
//               gvNegativeCounter := gvNegativeCounter + 1;
//           end;
//         end;
//       //IGS OCT 2016
//                 lvCountText:= Format(gvEmpCount,0);
//               NoofZeros := 5 - StrLen(lvCountText);
//               for i := 1 to NoofZeros  do
//               begin
//               lvCountText := '0' + lvCountText;
//               end;

//               WithLeadZerosNet:='';
//               WithLeadZerosNet := Format(gvTotalNetpay,0,'<Precision,2:2><Standard Format,1>');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=',',');
//               WithLeadZerosNet := DelChr(WithLeadZerosNet,'=','.');
//               NoofZeros := 14 - StrLen(WithLeadZerosNet);
//               for i := 1 to NoofZeros  do begin
//                 WithLeadZerosNet := '0' + WithLeadZerosNet;
//               end;

//               lvZeroes := '';
//               for i := 1 to 129 do
//               begin
//                lvZeroes := '0' + lvZeroes;
//               end;

//               //Trailer Record
//               //gvTotalNetpay:=DELCHR(gvTotalNetpay,'=',',');//IGS Sep 2016
//               gvTranferFile.Write(
//               StrSubstNo('T,') +
//               StrSubstNo(lvCountText) +
//               StrSubstNo(',') +
//               Format(DelChr(Format(gvTotalNetpay),'=',',')) +
//               StrSubstNo(''));
//     end;

// end;

// procedure CreateCOOP()
// var
//     lvEmployeeName: Text[100];
//     lvNetPayText: Text[30];
// begin
//     gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//     gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//     if gvEmployee.Find('-') then
//       gvHeaderText := 'Employee No.,' + 'Employee Name,' + 'Bank Code,' + 'Bank Account No.,' + 'Net Pay';
//             //gvTranferFile.WRITE('');
//             repeat
//         if gvHeader.Get(gvPeriodCode, gvEmployee."No.") then begin
//           if StrPos(gvEmployee."No.", ',') > 0 then Error('Comma not allowed in Emp No %1', gvEmployee."No.");
//           if StrLen(gvEmployee."No.") > 15 then Error('Employee''s No %1 is longer than 15 characters.', gvEmployee."No.");

//           lvEmployeeName := gvEmployee.FullName;
//           if StrPos(lvEmployeeName, ',') > 0 then Error('Comma not allowed in Emp Full Name %1', lvEmployeeName);
//           if StrLen(lvEmployeeName) > 30 then Error('Employee''s Full Name %1 is longer than 30 characters.', lvEmployeeName);

//           gvEmployee.TestField("Bank Code");
//           if StrPos(gvEmployee."Bank Code", ',') > 0 then
//             Error('Comma not allowed in Bank Code %1 for Emp No %2', gvEmployee."Bank Code", gvEmployee."No.");
//           if StrLen(gvEmployee."Bank Code") > 5 then
//             Error('Emp No %1 Bank Code %2 is longer than 5 characters.', gvEmployee."No.", gvEmployee."Bank Code");

//           gvEmployee.TestField("Bank Account No");
//           if StrPos(gvEmployee."Bank Account No", ',') > 0 then
//             Error('Comma not allowed in Bank Account No %1 for Emp No %2', gvEmployee."Bank Account No", gvEmployee."No.");
//           if StrLen(gvEmployee."Bank Account No") > 15 then
//             Error('Emp No %1 Bank Account No %2 is longer than 13 characters.', gvEmployee."No.", gvEmployee."Bank Account No");

//           gvHeader.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
//           gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//           if gvNetPayAmount > 0 then begin
//             lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//             lvNetPayText := DelChr(lvNetPayText, '=', ',');
//             if StrLen(lvNetPayText) > 12 then
//              Error('Emp No %1 Net Pay %2 is more than 12 digits.', gvEmployee."No.", lvNetPayText);
//             gvTranferFile.Write(
//                 gvEmployee."No." + ',' +
//                 lvEmployeeName  + ',' +
//                 gvEmployee."Bank Code" + ',' +
//                 gvEmployee."Bank Account No" + ',' +
//                 lvNetPayText)
//           end;
//         end;
//       until gvEmployee.Next = 0;
// end;

//     procedure CreateKCB()
//     var
//         lvEmployeeName: Text[100];
//         lvNetPayText: Text[30];
//         LvDebitAcc: Code[15];
//         BranchBIC: Code[10];
//         EmpBank: Record "Employee Bank Account";
//         BankName: Text[100];
//         Branch: Text[100];
//         SortCode: Code[10];
//     begin
//         gvEmployee.SetRange("Mode of Payment", gvModeofPaymentCode);
//         gvEmployee.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
//         if gvEmployee.Find('-') then
//           gvHeaderText := 'Debit/From Account,' + 'Your Branch BIC/SORT Code,' + 'Beneficiary Name,' + 'Bank,' + 'Branch,'+'BIC/SORT Code (Mpesa 99999),'+'Account No./ Phone Number,'+'Net Pay/Amount,';
//                 gvTranferFile.Write(StrSubstNo(gvHeaderText));
//                 //gvTranferFile.WRITE('');
//                 repeat
//             if gvHeader.Get(gvPeriodCode, gvEmployee."No.") then begin
//               LvDebitAcc := '1224944313';
//               if StrPos(LvDebitAcc, ',') > 0 then Error('Comma not Debit/From Account %1', LvDebitAcc);
//               if StrLen(LvDebitAcc) > 15 then Error('Debit/From Account %1 is longer than 15 characters.', LvDebitAcc);

//               BranchBIC := '01259';
//               if StrPos(BranchBIC, ',') > 0 then Error('Comma not Your Branch BIC/SORT Code %1', BranchBIC);
//               if StrLen(BranchBIC) > 10 then Error('Your Branch BIC/SORT Code %1 is longer tha 15 characters.', BranchBIC);

//               if StrPos(gvEmployee."No.", ',') > 0 then Error('Comma not allowed in Emp No %1', gvEmployee."No.");
//               if StrLen(gvEmployee."No.") > 15 then Error('Employee''s No %1 is longer than 15 characters.', gvEmployee."No.");

//               lvEmployeeName := gvEmployee."First Name" +' '+ gvEmployee."Middle Name" +' '+ gvEmployee."Last Name";
//               if StrPos(lvEmployeeName, ',') > 0 then Error('Comma not allowed in Emp Full Name %1', lvEmployeeName);
//               if StrLen(lvEmployeeName) > 30 then Error('Employee''s Full Name %1 is longer than 30 characters.', lvEmployeeName);
//               gvEmployee.TestField("Bank Code");
//                  EmpBank.SetRange("No.",gvEmployee."Bank Code");
//               if EmpBank.Find('-') then
//                 BankName:=EmpBank.Name;
//                 Branch:=EmpBank.Branch;
//                 SortCode:=EmpBank."KBA Code";

//               if StrPos(BankName, ',') > 0 then Error('Comma not allowed in Bank %1', BankName);
//               if StrLen(BankName) > 100 then Error('Bank Name %1 is longer than 100 characters.', BankName);

//               if StrPos(Branch, ',') > 0 then Error('Comma not allowed in Branch %1', Branch);
//               if StrLen(Branch) > 100 then Error('Branch Name %1 is longer than 100 characters.', Branch);

//               if StrPos(SortCode, ',') > 0 then Error('Comma not allowed in BIC/SORT Code (Mpesa 99999) %1', SortCode);
//               if StrLen(SortCode) > 10 then Error('BIC/SORT Code (Mpesa 99999) %1 is longer than 10 characters.', SortCode);

//                 gvEmployee.TestField("Bank Code");
//               if StrPos(gvEmployee."Bank Code", ',') > 0 then
//                 Error('Comma not allowed in Bank Code %1 for Emp No %2', gvEmployee."Bank Code", gvEmployee."No.");
//               if StrLen(gvEmployee."Bank Code") > 5 then
//                 Error('Emp No %1 Bank Code %2 is longer than 5 characters.', gvEmployee."No.", gvEmployee."Bank Code");

//                  gvEmployee.TestField("Bank Account No");
//               if StrPos(gvEmployee."Bank Account No", ',') > 0 then
//                 Error('Comma not allowed in Account No./ Phone Number %1 for Emp No %2', gvEmployee."Bank Account No", gvEmployee."No.");
//               if StrLen(gvEmployee."Bank Account No") > 15 then
//                 Error('Emp No %1 Account No./ Phone Number %2 is longer than 15 characters.', gvEmployee."No.", gvEmployee."Bank Account No");

//               gvHeader.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)");
//               gvNetPayAmount := gvHeader."Total Payable (LCY)" - gvHeader."Total Deduction (LCY)";
//               if gvNetPayAmount > 0 then begin
//                 lvNetPayText := StrSubstNo('%1', gvNetPayAmount);
//                 lvNetPayText := DelChr(lvNetPayText, '=', ',');
//                 if StrLen(lvNetPayText) > 12 then
//                  Error('Emp No %1 Net Pay %2 is more than 12 digits.', gvEmployee."No.", lvNetPayText);
//                 gvTranferFile.Write(
//                     LvDebitAcc + ',' +
//                     BranchBIC  + ',' +
//                     lvEmployeeName + ',' +
//                     BankName + ',' +
//                     Branch + ',' +
//                     SortCode + ',' +
//                     gvEmployee."Bank Account No" + ',' +
//                     lvNetPayText)
//               end;
//             end;
//           until gvEmployee.Next = 0;
//     end;
// }
