// report 50083 "Email Alert Probation Expiry"
// {
//     ProcessingOnly = true;
//     UseRequestPage = false;

//     dataset
//     {
//         dataitem(Employee;Employee)
//         {
//             DataItemTableView = WHERE("Employment Date"=FILTER(<>0D));

//             trigger OnAfterGetRecord()
//             begin
//                 SMTP.Get;
//                 ExpiryDuration:=60;
//                 ProbationExpiryDate:=0D;
//                 UserSetup.Reset;
//                 UserSetup.SetRange(UserSetup."Payroll Admin",true);
//                 if UserSetup.FindSet then begin
//                    repeat
//                    HREmployees.Reset;
//                    HREmployees.SetRange("User ID",UserSetup."User ID");
//                    if HREmployees.FindFirst then begin
//                         ActualDuration:=0;
//                         ProbationExpiryDate:=CalcDate('90D',Employee."Employment Date");
//                         ActualDuration:=ProbationExpiryDate-Today;
//                         if ActualDuration=60 then begin
//                          // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",UserSetup."E-Mail",EmailHeading,'',true);
//                           SMTPMail.AppendBody('Dear'+' '+HREmployees."First Name"+',');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(ProbationExpiryMessage);
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employee No: '+Employee."No.");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employee Name: '+Employee."Full Name");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Employment Date: '+Format(Employee."Employment Date",0,4));
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Probation End Date: '+Format(ProbationExpiryDate,0,4));
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Thank you.');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('Regards,');
//                           SMTPMail.AppendBody('<br><br>');
//                           //SMTPMail.AppendBody(SMTP."Sender Name");
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody('<br><br>');
//                           SMTPMail.AppendBody(EmailReply);
//                           //SMTPMail.AddAttachment(FileName,SalesInvAttachment);
//                           SMTPMail.Send;
//                            end;
//                          end;
//                       until UserSetup.Next=0;
//                    end;
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
//        // SMTP: Record "SMTP Mail Setup";
//        // SMTPMail: Codeunit "SMTP Mail";
//         ContractExpiryPeriod: Text;
//         FileName: Text;
//         Text001: Label 'Email Sent successfully';
//         HREmployees: Record Employee;
//         HumanResourcesSetup: Record "Human Resources Setup";
//         UserSetup: Record "User Setup";
//         ExpiryDuration: Integer;
//         ActualDuration: Integer;
//         ProbationExpiryDate: Date;
//         EmailHeading: Label 'Employee Probation Expiry Notification';
//         ProbationExpiryMessage: Label 'Please note the Expiry of the Probation period for the Employee below is due in two months';
//         EmailReply: Label 'This is a system generated mail. Please do not reply to this Email';
// }

