tableextension 60320 tableextension60320 extends "Approval Entry"
{
    fields
    {
        modify("Document Type")
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Journal Voucher ,Payment,Receipt,Imprest,Imprest Surrender,Funds Refund,Requisition,Funds Transfer,HR Document,Property,CRM,Transport Request,Leave,Leave Plan,Store Requisition,Salary Advance,Allowance,Appraisal,Payroll,Work Ticket,Inspection,HR Training';

            //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 2)".

        }

        //Unsupported feature: Code Modification on "Status(Field 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (xRec.Status = Status::Created) and (Status = Status::Open) then
          "Date-Time Sent for Approval" := CreateDateTime(Today,Time);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {companyInfo.RESET;
        IF companyInfo.FINDFIRST THEN BEGIN
          IF companyInfo.Name <> 'Test' THEN BEGIN



        //Approver Notification
        IF (xRec.Status = Status::Created) AND (Status = Status::Open) THEN
          "Date-Time Sent for Approval" := CREATEDATETIME(TODAY,TIME);

          IF (xRec.Status = Status::Created) AND (Status = Status::Open) THEN BEGIN
          Employee.RESET;
          Employee.SETRANGE("User ID","Approver ID");
          Employee.SETFILTER("Company E-Mail",'<>%1','');
          IF  Employee.FINDFIRST THEN BEGIN
            SMTP.GET;
              Subject := 'Dynamics ERP Approval Request';
              SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",
                          Employee."Company E-Mail",
                          Subject,'',TRUE);

              SMTPMail.AppendBody('Dear, '+Employee."Full Name");
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Your approval for the below Document is required.');
              SMTPMail.AppendBody('<br><br>');
              Body:='Document Type: '+ FORMAT("Document Type")+ ', Document No: ' +"Document No.";
              SMTPMail.AppendBody(Body);
              SMTPMail.AppendBody('<br><br><br>');
              Body2:= 'To Approved click the Link below '+ 'https://erp-billing.mombasawater.co.ke/';
              SMTPMail.AppendBody(Body2);
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Regards,');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');
              SMTPMail.Send;
            END;
          END;

        //Sender Notification if Approved
          IF (xRec.Status = Status::Open) AND (Status = Status::Approved) THEN BEGIN
          Employee.RESET;
          Employee.SETRANGE("User ID","Sender ID");
          Employee.SETFILTER("Company E-Mail",'<>%1','');
          IF  Employee.FINDFIRST THEN BEGIN
            SMTP.GET;
              Subject := 'Dynamics ERP Approval Request';
              SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",
                          Employee."Company E-Mail",
                          Subject,'',TRUE);

              SMTPMail.AppendBody('Dear, '+Employee."Full Name");
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Your Document has been approved by '+ "Approver ID");
              SMTPMail.AppendBody('<br>');
              Body:='Document Type: '+ FORMAT("Document Type")+ ', Document No: ' +"Document No.";
              SMTPMail.AppendBody(Body);
              SMTPMail.AppendBody('<br><br><br>');
              Body2:= 'To Login to the system click the Link below '+ 'https://erp-billing.mombasawater.co.ke/';
              SMTPMail.AppendBody(Body2);
              SMTPMail.AppendBody('<br>');
              SMTPMail.AppendBody('Regards,');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');
              SMTPMail.Send;
            END;
          END;

          //Sender Notification if Rejected
          IF (xRec.Status = Status::Open) AND (Status = Status::Rejected) THEN BEGIN
          Employee.RESET;
          Employee.SETRANGE("User ID","Sender ID");
          Employee.SETFILTER("Company E-Mail",'<>%1','');
          IF  Employee.FINDFIRST THEN BEGIN
            SMTP.GET;
              Subject := 'Dynamics ERP Approval Request';
              SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",
                          Employee."Company E-Mail",
                          Subject,'',TRUE);

              SMTPMail.AppendBody('Dear, '+Employee."Full Name");
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Your Document has been Rejected by '+ "Approver ID");
              SMTPMail.AppendBody('<br>');
              Body:='Document Type: '+ FORMAT("Document Type")+ ', Document No: ' +"Document No.";
              SMTPMail.AppendBody(Body);
              SMTPMail.AppendBody('<br><br><br>');
              Body2:= 'To Amend and Resend click the Link below '+ 'https://erp-billing.mombasawater.co.ke/';
              SMTPMail.AppendBody(Body2);
              SMTPMail.AppendBody('<br>');
              SMTPMail.AppendBody('Regards,');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('This is a system generated mail. Please do not reply.');
              SMTPMail.Send;
            END;
          END;

        END;
        END;
        }
        */
        //end;
        field(50000; "Web Portal Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Description2; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52136923; Description; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(52136924; "Document Source"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52136925; Document_Type; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52136926; "Rejection Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52136927; "Record Opened"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowRecord(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "RecordCaption(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: StoreRequisitionHeader) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: PurchaseRequisitions) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: InspectionHeader) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: PaymentHeader) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: ImprestHeader) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: HRLeaveReimbursement) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: SalaryAdvance) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: HRLeaveApplication) (VariableCollection) on "RecordDetails(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "RecordDetails(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "RecordDetails(PROCEDURE 3)".

    //procedure RecordDetails();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not RecRef.Get("Record ID to Approve") then
      exit(RecNotExistTxt);

    #4..19
            StrSubstNo(
              '%1 ; %2: %3',PurchHeader."Buy-from Vendor Name",PurchHeader.FieldCaption(Amount),PurchHeader.Amount);
        end;
      else
        Details := Format("Record ID to Approve",0,1) + ChangeRecordDetails;
    end;

    OnAfterGetRecordDetails(RecRef,ChangeRecordDetails,Details);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22
      DATABASE::"Store Requisition Header":
        begin
          RecRef.SetTable(StoreRequisitionHeader);
          StoreRequisitionHeader.CalcFields("Cost Amount");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',StoreRequisitionHeader.Description,StoreRequisitionHeader.FieldCaption("Cost Amount"),StoreRequisitionHeader."Cost Amount");
         end;
        DATABASE::"Purchase Requisitions":
        begin
          RecRef.SetTable(PurchaseRequisitions);
          PurchaseRequisitions.CalcFields(Amount);
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',PurchaseRequisitions.Description,PurchaseRequisitions.FieldCaption(Amount),PurchaseRequisitions.Amount);
         end;
        DATABASE::"Inspection Header":
        begin
          RecRef.SetTable(InspectionHeader);
          InspectionHeader.CalcFields("Amount Invoiced");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',InspectionHeader."Contract Title",InspectionHeader.FieldCaption("Amount Invoiced"),InspectionHeader."Amount Invoiced");
         end;
          DATABASE::"Payment Header":
        begin
          RecRef.SetTable(PaymentHeader);
          PaymentHeader.CalcFields("Total Amount(LCY)");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',PaymentHeader."Payee Name",PaymentHeader.FieldCaption(PaymentHeader."Total Amount(LCY)"),PaymentHeader."Total Amount(LCY)");
         end;
             DATABASE::"Imprest Header":
        begin
          RecRef.SetTable(ImprestHeader);
          ImprestHeader.CalcFields("Amount(LCY)");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',ImprestHeader."Employee Name",ImprestHeader.FieldCaption("Amount(LCY)"),ImprestHeader."Amount(LCY)");
         end;
             DATABASE::"Salary Advance":
        begin
          RecRef.SetTable(SalaryAdvance);
          //SalaryAdvance.CALCSUMS("First Name");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',SalaryAdvance."Employee Name",SalaryAdvance.FieldCaption(Principal),SalaryAdvance.Principal);
         end;
              DATABASE::"HR Leave Application":
        begin
          RecRef.SetTable(HRLeaveApplication);
         // HRLeaveApplication.CALCSUMS(HRLeaveApplication."Days Applied");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',HRLeaveApplication."Employee Name",HRLeaveApplication.FieldCaption("Days Applied"),HRLeaveApplication."Days Applied");
         end;
          DATABASE::"HR Leave Reimbursement":
        begin
          RecRef.SetTable(HRLeaveReimbursement);
          //HRLeaveReimbursement.CALCSUMS("Days to Reimburse");
          Details :=
            StrSubstNo(
              '%1 ; %2: %3',HRLeaveReimbursement."Employee Name",HRLeaveReimbursement.FieldCaption("Days to Reimburse"),HRLeaveReimbursement."Days to Reimburse");
         end
    #23..27
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsOverdue(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustVendorDetails(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetChangeRecordDetails(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "CanCurrentUserEdit(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "MarkAllWhereUserisApproverOrSender(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "MarkAllWhereUserisApproverOrSender(PROCEDURE 9)".

    //procedure MarkAllWhereUserisApproverOrSender();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserSetup.Get(UserId) and UserSetup."Approval Administrator" then
      exit;
    FilterGroup(-1); // Used to support the cross-column search
    SetRange("Approver ID",UserId);
    SetRange("Sender ID",UserId);
    if FindSet then
      repeat
        Mark(true);
      until Next = 0;
    MarkedOnly(true);
    FilterGroup(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //SETRANGE("Approver ID",USERID);
    //SETRANGE("Sender ID",USERID);
    #6..11
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetRecordDetails(PROCEDURE 8)".


    var
        ApprovalEntry: Record "Approval Entry";
        // SMTP: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        Subject: Text;
        Body: Text;
        Employee: Record Employee;
        Body2: Text;
        companyInfo: Record "Company Information";
}

