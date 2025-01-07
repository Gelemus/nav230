// report 50185 "Send HR Email Messages"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("HR Email Messages";"HR Email Messages")
//         {
//             DataItemTableView = WHERE("Email Sent"=CONST(false));

//             trigger OnAfterGetRecord()
//             begin
//                 if not "HR Email Messages"."Email Sent" then begin
//                   Clear(EmailBodyInStream);
//                   Clear(EmailBodyRequest);
//                   EmailBody:='';

//                   "HR Email Messages".CalcFields("HR Email Messages".Body);
//                   "HR Email Messages".Body.CreateInStream(EmailBodyInStream);
//                   EmailBodyRequest.Read(EmailBodyInStream);
//                   EmailBodyRequest.GetSubText(EmailBody,1);

//                   //SMTPMail.CreateMessage("HR Email Messages"."Sender Name","HR Email Messages"."Sender Address",
//                   "HR Email Messages".Recipients,"HR Email Messages".Subject,EmailBody,true);
//                   if SMTPMail.TrySend then begin
//                     "HR Email Messages"."Email Sent":=true;
//                     "HR Email Messages"."Date Sent":=Today;
//                     "HR Email Messages"."Time Sent":=Time;
//                     "HR Email Messages".Modify;
//                   end;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 "HR Email Messages".SetRange("HR Email Messages"."Email Sent",false);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         //SMTPMailSetup: Record "SMTP Mail Setup";
//         //SMTPMail: Codeunit "SMTP Mail";
//         EmailBodyInStream: InStream;
//         EmailBodyRequest: BigText;
//         EmailBody: Text;
// }

