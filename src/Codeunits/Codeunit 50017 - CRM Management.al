codeunit 50017 "CRM Management"
{

    trigger OnRun()
    begin
    end;

    var
        Enquiry: Record "Employee Loan Applications";
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "SMTP Mail";
        Text_0001: Label 'Email Message must be entered';
        Text_0002: Label 'Closing Remarks must be entered';
        Text_0003: Label 'The enquiry  will be closed. Kindly ensure that the response has been send to the client. Close this enquiry?';
        Text_0004: Label 'Enquiry no. %1  closed successfully.';
        Text_0005: Label 'Your activity is not assigned to any user, hence no action will be taken.';
        Text_0006: Label 'Enquiry successfully assigned to %1';
        CRMUserSetup: Record "Loan Product Grades";
        UserSetup: Record "User Setup";
        Text_0009: Label 'The complaint will be closed. Kindly ensure that the response has been send to the client. Close this Complaint?';
        Text_0010: Label 'Complaint No. %1 successfully closed';
        Text_0011: Label 'Execute activity, the complaint will be assigned to ';
        Text_0012: Label 'Enquiry successfully assigned to %1';
        Text_0015: Label 'This will create and send Email to all contacts below, continue?';
        EmailBodySeparator: Label '______________________________________________________________________________________________________________________________________';
        EmailBodyFooter: Label '<i>This email was sent from an unmonitored mailbox. Please do not reply.</i>';
        ProgressWindow: Dialog;

    procedure ExecuteComplaint(ComplaintNo: Code[20])
    var
        Complaints: Record "Employee Loan Disbursement";
        ComplaintActivities: Record "Employee Repayment Schedule";
        Employee: Record Employee;
        MailGroupHeader: Record "Employee Loans General Setup";
    begin
        /*Complaints.GET(ComplaintNo);
        
        ComplaintActivities.RESET;
        ComplaintActivities.SETRANGE(ComplaintActivities."Loan No.",ComplaintNo);
        ComplaintActivities.SETRANGE("Total Repayment",FALSE);
        IF ComplaintActivities.FINDFIRST THEN BEGIN
          IF ComplaintActivities."Instalment No."='' THEN
            ERROR(Text_0005);
        
        IF CONFIRM(Text_0011 +' ' +ComplaintActivities."Instalment No."+', Continue?') =FALSE THEN EXIT;
          MailGroupHeader.RESET;
          MailGroupHeader.SETRANGE("Primary Key",ComplaintActivities."Instalment No.");
          IF MailGroupHeader.FINDFIRST THEN BEGIN
            Complaints."Global Dimension 1 Code":=ComplaintActivities."Instalment No.";
            ComplaintActivities."Total Repayment":=TRUE;
            ComplaintActivities.MODIFY;
            IF Complaints.MODIFY THEN BEGIN
               CreateComplaintsAllocationEmail(ComplaintNo,MailGroupHeader."Loan Application No's",MailGroupHeader."Group Email");
              MESSAGE(Text_0006,ComplaintActivities."Instalment No.");
            END;
          END;
        END;
        */

    end;

    procedure ExecuteEnquiry(EnquiryNo: Code[20])
    var
        Enquiries: Record "Employee Loan Applications";
        EnquiryActivities: Record "Employee Loan Accounts";
        Employee: Record Employee;
        EnquiryActivities2: Record "Employee Loan Accounts";
        MailGroupHeader: Record "Employee Loans General Setup";
    begin
        /*Enquiries.GET(EnquiryNo);
        
        EnquiryActivities.RESET;
        EnquiryActivities.SETRANGE(EnquiryActivities."Document Date",EnquiryNo);
        EnquiryActivities.SETRANGE("Loan Product Description",FALSE);
        IF EnquiryActivities.FINDFIRST  THEN BEGIN
          IF EnquiryActivities."Loan Product Code"='' THEN
            ERROR(Text_0005);
        
          IF CONFIRM('Execute activity, the enquiry will be assigned to '+EnquiryActivities."Loan Product Code"+', Continue?') THEN BEGIN
        
            MailGroupHeader.RESET;
            MailGroupHeader.SETRANGE("Primary Key",EnquiryActivities."Loan Product Code");
            IF MailGroupHeader.FINDFIRST THEN BEGIN
              EnquiryActivities."Loan Product Description":=TRUE;
              EnquiryActivities.MODIFY;
              IF Enquiries.MODIFY THEN BEGIN
               CreateEnquiryAllocationEmail(EnquiryNo,MailGroupHeader."Loan Application No's",MailGroupHeader."Group Email");
              MESSAGE(Text_0006,EnquiryActivities."Loan Product Code");
              END;
            END;
          END;
        END;*/

    end;

    procedure CloseEnquiry(Enquiries: Record "Employee Loan Applications")
    var
        Enquiries2: Record "Employee Loan Applications";
    begin
        /*IF Enquiries."Enquiry Email Message" = '' THEN
          ERROR(Text_0001);
        
        IF Enquiries."Date Created" = '' THEN
          ERROR(Text_0002);
        
        IF CONFIRM(Text_0003)= FALSE THEN EXIT;
        
        Enquiries2.RESET;
        Enquiries2.SETRANGE("No.",Enquiries."No.");
        IF Enquiries2.FINDFIRST THEN BEGIN
          Enquiries2.Status:=Enquiries2.Status::"Pending Approval";
          Enquiries2."Time Created":=USERID;
          Enquiries2."Date Closed":=TODAY;
          Enquiries2."Time Closed":=TIME;
          IF Enquiries2.MODIFY THEN BEGIN
            CreateEnquiryFeedbackEmail(Enquiries2."No.");
            MESSAGE(Text_0004,Enquiries."No.");
          END;
        END;*/

    end;

    procedure CloseComplaint(Complaint: Record "Employee Loan Disbursement")
    var
        Complaint2: Record "Employee Loan Disbursement";
    begin
        /*IF Complaint."Loan Product Code" = '' THEN
          ERROR(Text_0002);
        
        //IF Complaint."Complaints Email Body" = '' THEN
          //ERROR(Text_0001);
        
        IF CONFIRM(Text_0009)= FALSE THEN EXIT;
        
        Complaint2.RESET;
        Complaint2.SETRANGE("No.",Complaint."No.");
        IF Complaint2.FINDFIRST THEN BEGIN
          Complaint2.Status:=Complaint2.Status::"Pending Approval";
          Complaint2."Loan Product Description":=USERID;
          Complaint2."Applied Amount":=CURRENTDATETIME;
          Complaint2."Approved Amount":=TIME;
          IF Complaint2.MODIFY THEN BEGIN
            MESSAGE(Text_0010,Complaint2."No.");
            CreateComplaintsFeedbackEmail(Complaint2."No.");
          END;
        END;*/

    end;

    procedure CreateEnquiryAllocationEmail("EnquiryNo.": Code[20];EmployeeName: Text;EmployeeEmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        Complaints: Record "Employee Loan Disbursement";
        Employee: Record Employee;
        EmailBody: Text;
    begin
          /*Enquiry.RESET;
          Enquiry.GET("EnquiryNo.");
        
          EmailBody:='';
          EmailBody:='Dear '+EmployeeName+'<br><br>';
          EmailBody:=EmailBody+'The following enquiry has been assigned to you.<br>';
          EmailBody:=EmailBody+'Enquiry No.:'+"EnquiryNo."+'<br>';
          EmailBody:=EmailBody+'Client Name:'+Enquiry."Loan Product Code"+'<br>';
          EmailBody:=EmailBody+'Company Name:'+Enquiry."Company Name"+'<br>';
          EmailBody:=EmailBody+'Enquiry:'+Enquiry.Description+'<br>';
          EmailBody:=EmailBody+'Contact the client via the following email address'+Enquiry."Repayment Start Date"+'<br>';
          EmailBody:=EmailBody+'_____________________________________________________________________________<br>';
          EmailBody:=EmailBody+'<i>This is a system generated email, do not reply to this email</i><br>';
        
          SMTPMailSetup.GET;
          SenderName:='CRM Department';
          SenderAddress:=SMTPMailSetup."User ID";
          Subject:='Enquiry No. '+"EnquiryNo.";
          Recipients:=EmployeeEmailAddress;
          RecipientsCC:='';
          RecipientsBCC:='';
        
          InsertCRMEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
          */

    end;

    procedure CreateComplaintsAllocationEmail(ComplaintNo: Code[20];EmployeeName: Text;EmployeeEmailAddress: Text)
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        Complaints: Record "Employee Loan Disbursement";
        Employee: Record Employee;
    begin
          /*Complaints.RESET;
          Complaints.GET(ComplaintNo);
        
          EmailBody:='';
          EmailBody:='Dear '+EmployeeName+'<br><br>';
          EmailBody:=EmailBody+'The following complaint has been assigned to you.<br>';
          EmailBody:=EmailBody+'Complaint No.:'+ComplaintNo+'<br>';
          EmailBody:=EmailBody+'Client Name:'+Complaints.Names+'<br>';
          EmailBody:=EmailBody+'Complaint:'+Complaints."Loan No."+'<br>';
          EmailBody:=EmailBody+'Contact the client via the following email address'+Complaints."Email Address"+'<br>';
          EmailBody:=EmailBody+'_____________________________________________________________________________<br>';
          EmailBody:=EmailBody+'<i>This is a system generated email, do not reply to this email</i><br>';
        
          SMTPMailSetup.GET;
          SenderName:='CRM Department';
          SenderAddress:=SMTPMailSetup."User ID";
          Subject:=' Complaint No. '+ComplaintNo;
          Recipients:=EmployeeEmailAddress;
          RecipientsCC:='';
          RecipientsBCC:='';
        
          InsertCRMEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
          */

    end;

    procedure CreateEnquiryFeedbackEmail(EnquiryNo: Code[20])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        Enquiries: Record "Employee Loan Applications";
        Employee: Record Employee;
        EmployeeName: Text;
    begin
         /* Enquiry.RESET;
          Enquiry.GET(EnquiryNo);
        
          EmailBody:='';
          EmailBody:='Dear '+Enquiry."Loan Product Code"+ ' :Ref No. Enquiry No. '+Enquiry."No."+ '<br><br>';
          EmailBody:=EmailBody+Enquiry."Enquiry Email Message"+'<br>';
          EmailBody:=EmailBody+'<i>This is a system generated email, do not reply to this email</i><br><br>';
          EmailBody:=EmailBody+'Kind Regards<br><br>';
          EmailBody:=EmailBody+'CRM Department<br>';
          EmailBody:=EmailBody+'<br><br>';
          EmailBody:=EmailBody+EmailBodySeparator+'<br>';
          EmailBody:=EmailBody+EmailBodyFooter+'<br>';
        
          SMTPMailSetup.GET;
          SenderName:='ICDC Marketing Department';
          SenderAddress:=SMTPMailSetup."User ID";
          Subject:=' Enquiry No. '+Enquiry."No.";
          Recipients:=Enquiry."Repayment Start Date";
          RecipientsCC:='';
          RecipientsBCC:='';
        
          InsertCRMEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
          */

    end;

    procedure CreateComplaintsFeedbackEmail(ComplaintNo: Code[20])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        Complaint: Record "Employee Loan Disbursement";
        Employee: Record Employee;
        EmployeeName: Text;
    begin
         /* Complaint.RESET;
          Complaint.GET(ComplaintNo);
          IF Complaint."Email Address"<>'' THEN BEGIN
            EmailBody:='';
            EmailBody:='Dear '+Complaint.Names+ ' :Ref No. Complaint No. '+Complaint."No."+ '<br><br>';
            EmailBody:=EmailBody+Complaint."Disbursement Date"+'<br>';
            EmailBody:=EmailBody+'<i>This is a system generated email, do not reply to this email</i><br><br>';
            EmailBody:=EmailBody+'Kind Regards<br><br>';
            EmailBody:=EmailBody+'CRM Department<br>';
            EmailBody:=EmailBody+'<br><br>';
            EmailBody:=EmailBody+EmailBodySeparator+'<br>';
            EmailBody:=EmailBody+EmailBodyFooter+'<br>';
        
            SMTPMailSetup.GET;
            SenderName:='CRM Department';
            SenderAddress:=SMTPMailSetup."User ID";
            Subject:=' Complaint No. '+Complaint."No.";
            Recipients:=Complaint."Email Address";
            RecipientsCC:='';
            RecipientsBCC:='';
        
            InsertCRMEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
          END;*/

    end;

    procedure InsertCRMEmailMessage("Sender Name": Text[100];"Sender Address": Text[80];Subject: Text[100];Recipients: Text[250];"Recipients CC": Text[250];"Recipients BCC": Text[250];Body: Text) EmailMessageInserted: Boolean
    var
        CRMEmailMessage: Record "Loan Product Allowances";
        EmailBodyText: BigText;
        EmailBodyOutStream: OutStream;
    begin
        /*EmailMessageInserted:=FALSE;
        
        CRMEmailMessage.INIT;
        CRMEmailMessage."Loan Product Code":=0;
        CRMEmailMessage."Payroll Transaction Code":="Sender Name";
        CRMEmailMessage."Payroll Transaction Name":="Sender Address";
        CRMEmailMessage.Subject:=Subject;
        CRMEmailMessage.Recipients:=Recipients;
        CRMEmailMessage."Recipients CC" :="Recipients CC";
        CRMEmailMessage."Recipients BCC":="Recipients BCC";
        EmailBodyText.ADDTEXT(Body);
        CRMEmailMessage.Body.CREATEOUTSTREAM(EmailBodyOutStream);
        EmailBodyText.WRITE(EmailBodyOutStream);
        CRMEmailMessage.HtmlFormatted:=TRUE;
        CRMEmailMessage."Created By":=USERID;
        CRMEmailMessage."Date Created":=TODAY;
        CRMEmailMessage."Time Created":=TIME;
        IF CRMEmailMessage.INSERT THEN
          EmailMessageInserted:=TRUE;
          */

    end;

    procedure CreateEmailtoCRMOfficerForNewEnquiries(EnquiryNo: Code[20])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        Enquiries: Record "Employee Loan Applications";
        Employee: Record Employee;
        EmployeeName: Text;
    begin
        /*Enquiries.GET(EnquiryNo);
        
        CRMUserSetup.RESET;
        CRMUserSetup.SETRANGE("Job Grade",TRUE);
        IF CRMUserSetup.FINDSET THEN BEGIN
          REPEAT
            UserSetup.GET(CRMUserSetup."Loan Product");
            Employee.RESET;
            Employee.SETRANGE("User ID",CRMUserSetup."Loan Product");
            IF Employee.FINDFIRST THEN
              EmployeeName:=Employee."First Name";
            EmailBody:='';
            EmailBody:='Dear '+EmployeeName+',<br><br>';
            EmailBody:=EmailBody+'Enquiry No.'+ Enquiries."No." +' has been submitted to ICDC.<br> Kindly log in to Microsoft Dynamics NAV to see more details.<br>';
            EmailBody:=EmailBody+'Kind Regards<br><br>';
            EmailBody:=EmailBody+'CRM Department<br>';
            EmailBody:=EmailBody+'<br><br>';
            EmailBody:=EmailBody+EmailBodySeparator+'<br>';
            EmailBody:=EmailBody+EmailBodyFooter+'<br>';
        
            SMTPMailSetup.GET;
            SenderName:='ICDC Marketing Department';
            SenderAddress:=SMTPMailSetup."User ID";
            Subject:=' Enquiry No. '+Enquiries."No.";
            Recipients:=UserSetup."E-Mail";
            RecipientsCC:='';
            RecipientsBCC:='';
        
            InsertCRMEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
          UNTIL CRMUserSetup.NEXT=0;
        END;
        */

    end;

    procedure InsertCustomersGroupEmail(GroupMailingHeader: Record "Employee Loan Product Document")
    var
        GroupMailingLines2: Record "Employee Loans User Setup";
        GroupMailingLines: Record "Employee Loans User Setup";
        Customer: Record Customer;
        GroupMailingHeader2: Record "Employee Loan Product Document";
    begin
        //clear all
        /*GroupMailingLines2.RESET;
        GroupMailingLines2.SETRANGE("Document No.",GroupMailingHeader.No);
        IF GroupMailingLines2.FINDSET THEN
          GroupMailingLines2.DELETEALL;
        
        Customer.RESET;
        Customer.SETRANGE(Blocked,Customer.Blocked::" ");
        IF Customer.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting customer No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Customer."No.";
            GroupMailingLines."Account Name":=Customer.Name;
            GroupMailingLines."E-Mail":=Customer."E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Customer."No.");
          UNTIL Customer.NEXT =0;
        END;
        ProgressWindow.CLOSE;
        
        GroupMailingHeader2.RESET;
        GroupMailingHeader2.SETRANGE(No,GroupMailingHeader.No);
        IF GroupMailingHeader2.FINDFIRST THEN BEGIN
          GroupMailingHeader2."Sent By":=USERID;
          GroupMailingHeader2."Date Sent":=TODAY;
          GroupMailingHeader2."Time Sent":=TIME;
          GroupMailingHeader.MODIFY;
        END;*/

    end;

    procedure InsertEmployeesGroupEmail(GroupMailingHeader: Record "Employee Loan Product Document")
    var
        GroupMailingLines: Record "Employee Loans User Setup";
        Employee: Record Employee;
        GroupMailingLines2: Record "Employee Loans User Setup";
        GroupMailingHeader2: Record "Employee Loan Product Document";
    begin
        //clear all
        /*GroupMailingLines2.RESET;
        GroupMailingLines2.SETRANGE("Document No.",GroupMailingHeader.No);
        IF GroupMailingLines2.FINDSET THEN
          GroupMailingLines2.DELETEALL;
        
        Employee.RESET;
        Employee.SETRANGE(Status,Employee.Status::Active);
        IF Employee.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Employee No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Employee."No.";
            GroupMailingLines."Account Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
            GroupMailingLines."E-Mail":=Employee."Company E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Employee."No.");
          UNTIL Employee.NEXT =0;
        END;
        ProgressWindow.CLOSE;
        
        GroupMailingHeader2.RESET;
        GroupMailingHeader2.SETRANGE(No,GroupMailingHeader.No);
        IF GroupMailingHeader2.FINDFIRST THEN BEGIN
          GroupMailingHeader2."Sent By":=USERID;
          GroupMailingHeader2."Date Sent":=TODAY;
          GroupMailingHeader2."Time Sent":=TIME;
          GroupMailingHeader.MODIFY;
        END;
        */

    end;

    procedure InsertVendorsGroupEmail(GroupMailingHeader: Record "Employee Loan Product Document")
    var
        GroupMailingLines: Record "Employee Loans User Setup";
        Vendors: Record Vendor;
        GroupMailingLines2: Record "Employee Loans User Setup";
        GroupMailingHeader2: Record "Employee Loan Product Document";
    begin
        //clear all
        /*GroupMailingLines2.RESET;
        GroupMailingLines2.SETRANGE("Document No.",GroupMailingHeader.No);
        IF GroupMailingLines2.FINDSET THEN
          GroupMailingLines2.DELETEALL;
        
        Vendors.RESET;
        Vendors.SETRANGE(Blocked,Vendors.Blocked::" ");
        IF Vendors.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Vendors No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Vendors."No.";
            GroupMailingLines."Account Name":=Vendors.Name;
            GroupMailingLines."E-Mail":=Vendors."E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Vendors."No.");
          UNTIL Vendors.NEXT =0;
        END;
        ProgressWindow.CLOSE;
        
        GroupMailingHeader2.RESET;
        GroupMailingHeader2.SETRANGE(No,GroupMailingHeader.No);
        IF GroupMailingHeader2.FINDFIRST THEN BEGIN
          GroupMailingHeader2."Sent By":=USERID;
          GroupMailingHeader2."Date Sent":=TODAY;
          GroupMailingHeader2."Time Sent":=TIME;
          GroupMailingHeader.MODIFY;
        END;
        */

    end;

    procedure InsertAllGroupEmail(GroupMailingHeader: Record "Employee Loan Product Document")
    var
        GroupMailingLines2: Record "Employee Loans User Setup";
        Customer: Record Customer;
        GroupMailingLines: Record "Employee Loans User Setup";
        Vendors: Record Vendor;
        Employee: Record Employee;
        Contact: Record Contact;
        GroupMailingHeader2: Record "Employee Loan Product Document";
    begin
        //clear all
        /*GroupMailingLines2.RESET;
        GroupMailingLines2.SETRANGE("Document No.",GroupMailingHeader.No);
        IF GroupMailingLines2.FINDSET THEN
          GroupMailingLines2.DELETEALL;
        
        
        Customer.RESET;
        Customer.SETRANGE(Blocked,Customer.Blocked::" ");
        IF Customer.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting customer No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Customer."No.";
            GroupMailingLines."Account Name":=Customer.Name;
            GroupMailingLines."E-Mail":=Customer."E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Customer."No.");
          UNTIL Customer.NEXT =0;
        END;
        
        Vendors.RESET;
        Vendors.SETRANGE(Blocked,Vendors.Blocked::" ");
        IF Vendors.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Vendors No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Vendors."No.";
            GroupMailingLines."Account Name":=Vendors.Name;
            GroupMailingLines."E-Mail":=Vendors."E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Vendors."No.");
          UNTIL Vendors.NEXT =0;
        END;
        ProgressWindow.CLOSE;
        
        Employee.RESET;
        Employee.SETRANGE(Status,Employee.Status::Active);
        IF Employee.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Employee No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Employee."No.";
            GroupMailingLines."Account Name":=Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name";
            GroupMailingLines."E-Mail":=Employee."Company E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Employee."No.");
          UNTIL Employee.NEXT =0;
        END;
        
        Contact.RESET;
        IF Contact.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Contact No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Contact."No.";
            GroupMailingLines."Account Name":=Contact.Name;
            GroupMailingLines."E-Mail":=Contact."E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Contact."No.");
          UNTIL Contact.NEXT =0;
        END;
        ProgressWindow.CLOSE;
        
        
        GroupMailingHeader2.RESET;
        GroupMailingHeader2.SETRANGE(No,GroupMailingHeader.No);
        IF GroupMailingHeader2.FINDFIRST THEN BEGIN
          GroupMailingHeader2."Sent By":=USERID;
          GroupMailingHeader2."Date Sent":=TODAY;
          GroupMailingHeader2."Time Sent":=TIME;
          GroupMailingHeader.MODIFY;
        END;*/

    end;

    procedure InsertContactsGroupEmail(GroupMailingHeader: Record "Employee Loan Product Document")
    var
        GroupMailingLines: Record "Employee Loans User Setup";
        Contact: Record Contact;
        GroupMailingLines2: Record "Employee Loans User Setup";
        GroupMailingHeader2: Record "Employee Loan Product Document";
    begin
        //clear all
        /*GroupMailingLines2.RESET;
        GroupMailingLines2.SETRANGE("Document No.",GroupMailingHeader.No);
        IF GroupMailingLines2.FINDSET THEN
          GroupMailingLines2.DELETEALL;
        
        Contact.RESET;
        IF Contact.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Contact No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=Contact."No.";
            GroupMailingLines."Account Name":=Contact.Name;
            GroupMailingLines."E-Mail":=Contact."E-Mail";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,Contact."No.");
          UNTIL Contact.NEXT =0;
        END;
        ProgressWindow.CLOSE;*/

    end;

    procedure InsertMailGroupEmail(GroupMailingHeader: Record "Employee Loan Product Document")
    var
        GroupMailingLines: Record "Employee Loans User Setup";
        GroupMailingLines2: Record "Employee Loans User Setup";
        GroupMailingHeader2: Record "Employee Loan Product Document";
        MailGroupLines: Record "HR Email Messages";
    begin
        //clear all
        /*GroupMailingLines2.RESET;
        GroupMailingLines2.SETRANGE("Document No.",GroupMailingHeader.No);
        IF GroupMailingLines2.FINDSET THEN
          GroupMailingLines2.DELETEALL;
        
        MailGroupLines.RESET;
        MailGroupLines.SETRANGE("Entry No.",GroupMailingHeader."Mail Group");
        IF MailGroupLines.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Inserting Contact No. #1#######');
           REPEAT
            GroupMailingLines.INIT;
            GroupMailingLines."Document No.":=GroupMailingHeader.No;
            GroupMailingLines."Line No":=0;
            GroupMailingLines."Contact Type":=GroupMailingHeader."Contact Type";
            GroupMailingLines."Account No.":=MailGroupLines."Sender Name";
            GroupMailingLines."Account Name":=MailGroupLines."Sender Address";
            GroupMailingLines."E-Mail":=MailGroupLines."Employee Email";
            GroupMailingLines.INSERT;
          ProgressWindow.UPDATE(1,MailGroupLines."Sender Address");
          UNTIL MailGroupLines.NEXT =0;
        END;
        
        ProgressWindow.CLOSE;
        */

    end;

    procedure CreateEmailAllContacts("No.": Code[20])
    var
        SenderName: Text[100];
        SenderAddress: Text[80];
        Subject: Text[100];
        Recipients: Text[250];
        RecipientsCC: Text[250];
        RecipientsBCC: Text[250];
        EmailBody: Text;
        GroupMailingHeader: Record "Employee Loan Product Document";
        GroupMailingLines: Record "Employee Loans User Setup";
        GroupMailingHeader2: Record "Employee Loan Product Document";
    begin
        /*IF CONFIRM(Text_0015) = FALSE THEN EXIT;
        GroupMailingHeader.GET("No.");
        
        GroupMailingLines.RESET;
        GroupMailingLines.SETRANGE("Document No.","No.");
        IF GroupMailingLines.FINDSET THEN BEGIN
          ProgressWindow.OPEN('Sending Email to: #1#######');
          REPEAT
            EmailBody:='';
            EmailBody:='Dear '+GroupMailingLines."Account Name"+','+'<br><br>';
            EmailBody:=EmailBody+GroupMailingHeader."Email Body"+'<br><br>';
            EmailBody:=EmailBody+'<i>This is a system generated email, do not reply to this email</i><br><br>';
            EmailBody:=EmailBody+'Kind Regards<br><br>';
            EmailBody:=EmailBody+'CRM Department<br>';
            EmailBody:=EmailBody+'<br><br>';
            EmailBody:=EmailBody+EmailBodySeparator+'<br>';
            EmailBody:=EmailBody+EmailBodyFooter+'<br>';
        
            SMTPMailSetup.GET;
            SenderName:='CRM Department';
            SenderAddress:=SMTPMailSetup."User ID";
            Subject:=GroupMailingHeader."Email Subject";
            Recipients:=GroupMailingLines."E-Mail";
            RecipientsCC:='';
            RecipientsBCC:='';
        
            InsertCRMEmailMessage(SenderName,SenderAddress,Subject,Recipients,RecipientsCC,RecipientsBCC,EmailBody);
            ProgressWindow.UPDATE(1,GroupMailingLines."Account Name");
         UNTIL GroupMailingLines.NEXT =0;
        END;
        ProgressWindow.CLOSE;
        
        GroupMailingHeader2.RESET;
        GroupMailingHeader2.SETRANGE(No,GroupMailingHeader.No);
        IF GroupMailingHeader2.FINDFIRST THEN BEGIN
          GroupMailingHeader2."Sent By":=USERID;
          GroupMailingHeader2."Date Sent":=TODAY;
          GroupMailingHeader2."Time Sent":=TIME;
          GroupMailingHeader2.Sent:=TRUE;
          GroupMailingHeader2.MODIFY;
        END;
        */

    end;
}

