codeunit 51158 "NdovuPay Integration WS"
{

    trigger OnRun()
    begin
        //SendStoreRequisitionApprovalRequest('S-REQ0313')

        //MESSAGE(GetItemNo('4.0'));
    end;

    var
        Text_0001: Label 'The inventory is insufficient';
        Paymentheader: Record "Payment Header";
        PaymentLine: Record "Payment Line";

    [Scope('Personalization')]
    procedure GetPaymentVouchersToPay(var NdovuPayPaymentsXml: XMLport "Import/Export Travelling Emp")
    begin

        Paymentheader.Reset;
        Paymentheader.SetRange(Status, Paymentheader.Status::Posted);
        Paymentheader.SetRange("Payment Mode",Paymentheader."Payment Mode"::NdovuPay);
        //Paymentheader.SETRANGE("Bank Account No.",'NDOVUPAY');
        Paymentheader.SetRange(Posted, true);
        Paymentheader.SetRange("Ndovu Pay Status", Paymentheader."Ndovu Pay Status"::"Awaiting Payment");
        //Paymentheader.CALCFIELDS("Net Amount");
        if Paymentheader.FindFirst then;
          NdovuPayPaymentsXml.SetTableView(Paymentheader);
    end;

    [Scope('Personalization')]
    procedure UpdatePaymentStatus(PvNo: Code[20];Response: Text[100];Status: Option "Payment In Progress","Payment Failed") ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
    begin
        ReturnValue:='400:-';
        Paymentheader.Reset;
        Paymentheader.SetRange("No.",PvNo);
        if Paymentheader.FindFirst then begin
          if Status = Status::"Payment In Progress" then
            Paymentheader."Ndovu Pay Status" := Paymentheader."Ndovu Pay Status"::"Payment In Progress"
          else
            Paymentheader."Ndovu Pay Status" := Paymentheader."Ndovu Pay Status"::"Payment Failed";

          Paymentheader."Ndovu Pay Response" := Response;
          if Paymentheader.Modify then
            ReturnValue := '200: Status Updated Successfully';
          end
    end;

    [Scope('Personalization')]
    procedure CompletePayment(PvNo: Code[20];Response: Text) ReturnValue: Text
    begin
        ReturnValue:='400:-';
        Paymentheader.Reset;
        Paymentheader.SetRange("No.",PvNo);
        if Paymentheader.FindFirst then begin
          Paymentheader."Ndovu Pay Status" := Paymentheader."Ndovu Pay Status"::"Payment Completed";
          Paymentheader."Ndovu Pay Response" :=Paymentheader."Ndovu Pay Response"+' -> '+ Response;
          if Paymentheader.Modify then
            ReturnValue := '200: Status Updated Successfully';
          end;
    end;

    [Scope('Personalization')]
    procedure UpdatePaymentLineStatus(PvNo: Code[20];LineNo: Integer;Response: Text[100];Status: Option "Payment In Progress","Payment Successful","Payment Failed") ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
    begin
        ReturnValue:='400:-';
        PaymentLine.Reset;
        PaymentLine.SetRange("Document No.",PvNo);
        PaymentLine.SetRange("Line No.",LineNo);

        if PaymentLine.FindFirst then begin

          if Status = Status::"Payment In Progress" then
            PaymentLine."NdovuPay Status" := PaymentLine."NdovuPay Status"::"Payment In Progress"
          else if Status = Status::"Payment Successful" then
            PaymentLine."NdovuPay Status" := PaymentLine."NdovuPay Status"::"Payment Successful"
          else
            PaymentLine."NdovuPay Status" := PaymentLine."NdovuPay Status"::"Payment Failed";

          PaymentLine."NdovuPay Response" :=PaymentLine."NdovuPay Response"+' -> '+ Response;
          if PaymentLine.Modify then
            ReturnValue := '200: Status Updated Successfully';

        end
    end;
}

