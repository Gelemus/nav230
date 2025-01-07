codeunit 50018 "CRM Approval Manager"
{

    trigger OnRun()
    begin
    end;

    procedure ReleaseMarketingPlan(CRMCampaign: Record "Employee Account Invoice2")
    var
        Campaign: Record "Employee Account Invoice2";
    begin
        Campaign.Reset;
        Campaign.SetRange(Campaign."Loan Account No.",CRMCampaign."Loan Account No.");
        if Campaign.FindFirst then begin
          Campaign.Status:=Campaign.Status::Approved;
          Campaign.Validate(Campaign.Status);
          Campaign.Modify;
        end;
    end;

    procedure ReOpenMarketingPlan(CRMCampaign: Record "Employee Account Invoice2")
    var
        Campaign: Record "Employee Account Invoice2";
    begin
        Campaign.Reset;
        Campaign.SetRange(Campaign."Loan Account No.",CRMCampaign."Loan Account No.");
        if Campaign.FindFirst then begin
          Campaign.Status:=Campaign.Status::Open;
          Campaign.Validate(Campaign.Status);
          Campaign.Modify;
        end;
    end;
}

