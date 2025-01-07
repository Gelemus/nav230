// report 50082 "Email Alert HR Contract Expiry"
// {
//     ProcessingOnly = true;
//     UseRequestPage = false;

//     dataset
//     {
//         dataitem(Employee;Employee)
//         {
//             DataItemTableView = WHERE("Contract Expiry Date"=FILTER(<>0D));

//             trigger OnAfterGetRecord()
//             begin
//                 SMTP.Get;
//                 ExpiryDuration:=60;
//                 UserSetup.Reset;
//                 UserSetup.SetRange(UserSetup."Payroll Admin",true);
//                 if UserSetup.FindSet then begin
//                    repeat
//                      HREmployees.Reset;
//                      HREmployees.SetRange("User ID",UserSetup."User ID");
//                      if HREmployees.FindFirst then begin
//                     ActualDuration:=0;
//                     ActualDuration:=Employee."Contract Expiry Date"-Today;
//                     if ActualDuration=60 then begin
//                           SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",UserSetup."E-Mail",EmailHeading,'',true);
//                           SMTPMail.AppendBody('Dear'+' '+HREmployees."First Name"+',');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(ContractExpiryMessage);
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employee No: '+Employee."No.");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employee Name: '+Employee."Full Name");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Contract start Date: '+Format(Employee."Contract Start Date",0,4));
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Contract End Date: '+Format(Employee."Contract Expiry Date",0,4));
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Thank you.');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Regards,');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(SMTP."Sender Name");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(EmailReply);
//                           //SMTPMail.AddAttachment(FileName,SalesInvAttachment);
//                           SMTPMail.Send;
//                           end;
//                         end;
//                       until UserSetup.Next=0;
//                    end;
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
//         ContractExpiryMessage: Label 'Please note the contract of Employeement for the below Employee expires in 60 days';
//         EmailHeading: Label 'Employee Contract Expiry Notification';
//         EmailReply: Label 'This is a system generated mail. Please do not reply to this Email';
// }

