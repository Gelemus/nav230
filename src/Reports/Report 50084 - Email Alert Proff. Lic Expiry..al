// report 50084 "Email Alert Proff. Lic Expiry."
// {
//     ProcessingOnly = true;
//     UseRequestPage = false;

//     dataset
//     {
//         dataitem(Employee;Employee)
//         {

//             trigger OnAfterGetRecord()
//             begin
//                 /*SMTP.GET;
//                 ExpiryDuration:=60;
//                 UserSetup.RESET;
//                 UserSetup.SETRANGE(UserSetup."Payroll User",TRUE);
//                 IF UserSetup.FINDSET THEN BEGIN
//                   REPEAT
//                     ActualDuration:=0;
//                     ActualDuration:=Employee."Professional License Expiry"-TODAY;
//                     IF ActualDuration=60 THEN BEGIN
//                       SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",UserSetup."E-Mail",EmailHeading,'',TRUE);
                
//                       SMTPMail.AppendBody('Dear'+' '+UserSetup."User ID"+',');
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody(ProfessionalLicenseExpiryMessageToHR);
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody('Employee No: '+Employee."No.");
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody('Employee Name: '+Employee."Full Name");
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody('Expiry Date: '+FORMAT(Employee."Professional License Expiry"));
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody('Thank you.');
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody('Regards,');
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody(SMTP."Sender Name");
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody('<br><br>');
//                       SMTPMail.AppendBody(EmailReply);
//                       SMTPMail.Send;
                
//                       HREmployees.RESET;
//                       HREmployees.SETRANGE(HREmployees."No.",Employee."No.");
//                       HREmployees.SETFILTER(HREmployees."Personal E-Mail",'<>%1','');
//                       IF HREmployees.FINDFIRST THEN BEGIN
//                           SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",HREmployees."Personal E-Mail",EmailHeading,'',TRUE);
//                           SMTPMail.AppendBody('Dear'+' '+HREmployees."First Name"+',');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(ProfessionalLicenseExpiryMessageToEmployee);
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employee No: '+Employee."No.");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employee Name: '+Employee."Full Name");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Expiry Date: '+FORMAT(Employee."Professional License Expiry",0,4));
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Thank you.');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Regards,');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(SMTP."Sender Name");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(EmailReply);
//                           SMTPMail.Send;
//                        END;
//                       END;
//                   UNTIL UserSetup.NEXT=0;
//                 END;
//                 */

//             end;

//             trigger OnPostDataItem()
//             begin
//                 //MESSAGE(Text001);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         SMTP: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit "SMTP Mail";
//         ContractExpiryPeriod: Text;
//         FileName: Text;
//         Text001: Label 'Email Sent successfully';
//         HREmployees: Record Employee;
//         HumanResourcesSetup: Record "Human Resources Setup";
//         UserSetup: Record "User Setup";
//         ExpiryDuration: Integer;
//         ActualDuration: Integer;
//         EmailHeading: Label 'Employee Professional License Expiry Notification';
//         ProfessionalLicenseExpiryMessageToHR: Label 'Please note,the below employee has his/her Professional License expiring in two months';
//         EmailReply: Label 'This is a system generated mail. Please do not reply to this Email';
//         ProfessionalLicenseExpiryMessageToEmployee: Label 'Please note,your Professional practice License is due to expire in two months';
// }

