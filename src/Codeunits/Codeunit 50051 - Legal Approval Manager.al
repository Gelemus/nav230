codeunit 50051 "Legal Approval Manager"
{

    trigger OnRun()
    begin
    end;

    procedure ReleaseSecurityPreparationHeader(var SecuritiesPreparations: Record "Payment Terms")
    var
        SecuritiesPreparations2: Record "Payment Terms";
    begin
        /*SecuritiesPreparations2.RESET;
        SecuritiesPreparations2.SETRANGE(SecuritiesPreparations2."No.",SecuritiesPreparations."No.");
        IF SecuritiesPreparations2.FINDFIRST THEN BEGIN
          SecuritiesPreparations2.Status:=SecuritiesPreparations2.Status::"2";
          SecuritiesPreparations2.MODIFY;
        END;*/

    end;

    procedure ReOpenSecurityPreparationHeader(var SecuritiesPreparations: Record "Payment Terms")
    var
        SecuritiesPreparations2: Record "Payment Terms";
    begin
        /*SecuritiesPreparations2.RESET;
        SecuritiesPreparations2.SETRANGE(SecuritiesPreparations2."No.",SecuritiesPreparations."No.");
        IF SecuritiesPreparations2.FINDFIRST THEN BEGIN
          SecuritiesPreparations2.Status:=SecuritiesPreparations2.Status::"1";
          SecuritiesPreparations2.MODIFY;
        END;*/

    end;
}

