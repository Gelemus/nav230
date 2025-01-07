// report 50045 "Email Sender-Report(RFQ)"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Request for Quotation Header";"Request for Quotation Header")
//         {

//             trigger OnAfterGetRecord()
//             begin
//                 SMTP.Get;
//                 RFQNumber:=RFQNo;

//                 RFQVendor.Reset;
//                 RFQVendor.SetRange("RFQ Document No.","Request for Quotation Header"."No.");
//                 if RFQVendor.FindSet then begin
//                   repeat

//                   if RFQVendor."E-Mail" <> '' then
//                   ProgressWindow.Open('Sending RFQ for Vendor No. #1#######');
//                   FileName:='';
//                   FileName:= SMTP."Path to Save Documents"+'RFQ.pdf';
//                   REPORT.SaveAsPdf(REPORT::"Request for Quatation Report",FileName,"Request for Quotation Header");
//                   SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",RFQVendor."E-Mail",'Request For Quatation Report','',true);
//                   SMTPMail.AppendBody('Dear'+' '+RFQVendor."Vendor Name"+',');
//                   SMTPMail.AppendBody('<br><br>');
//                   SMTPMail.AppendBody('Please find attached your Request for Quatation');
//                   SMTPMail.AppendBody('<br><br>');
//                   SMTPMail.AppendBody('Thank you.');
//                   SMTPMail.AppendBody('<br><br>');
//                   SMTPMail.AppendBody('Regards,');
//                   SMTPMail.AppendBody('<br><br>');
//                   SMTPMail.AppendBody(SMTP."Sender Name");
//                   SMTPMail.AppendBody('<br><br>');
//                   SMTPMail.AppendBody('<br><br>');
//                   SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
//                   SMTPMail.AddAttachment(FileName,RFQAttachment);
//                   SMTPMail.Send;
//                   ProgressWindow.Update(1,RFQVendor."Vendor No."+':'+RFQVendor."Vendor Name");
//                   ProgressWindow.Close;
//                   until RFQVendor.Next=0;
//                 end;
//                 //END;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message(Text001);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(RFQNo;RFQNo)
//                 {
//                     Caption = 'RFQNo';
//                     TableRelation = Table52136986.Field1;
//                     Visible = false;
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

//     var
//         Vendors: Record Vendor;
//         SMTP: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit "SMTP Mail";
//         PayPeriod: Text;
//         FileName: Text;
//         RFQAttachment: Text;
//         RFQVendor: Record "Request for Quotation Vendors";
//         PeriodName: Text;
//         ProgressWindow: Dialog;
//         RFQNumber: Code[30];
//         Text001: Label 'Emails sent successfully';
//         RFQNo: Code[30];
// }

