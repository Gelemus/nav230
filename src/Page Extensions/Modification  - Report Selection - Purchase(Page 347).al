pageextension 60239 pageextension60239 extends "Report Selection - Purchase" 
{

    //Unsupported feature: Code Modification on "SetUsageFilter(PROCEDURE 1)".

    //procedure SetUsageFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if ModifyRec then
          if Modify then;
        FilterGroup(2);
        #4..22
          ReportUsage2::"Prepayment Document - Test":
            SetRange(Usage,Usage::"P.Test Prepmt.");
          ReportUsage2::"Archived Quote":
            SetRange(Usage,Usage::"P.Arch.Quote");
          ReportUsage2::"Archived Order":
            SetRange(Usage,Usage::"P.Arch.Order");
          ReportUsage2::"Archived Return Order":
            SetRange(Usage,Usage::"P.Arch.Return");
          ReportUsage2::"Archived Blanket Order":
            SetRange(Usage,Usage::"P.Arch.Blanket");
          ReportUsage2::"Vendor Remittance":
            SetRange(Usage,Usage::"V.Remittance");
          ReportUsage2::"Vendor Remittance - Posted Entries":
            SetRange(Usage,Usage::"P.V.Remit.");
        end;
        FilterGroup(0);
        CurrPage.Update;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..25
            SetRange(Usage,Usage::"P.Arch. Quote");
          ReportUsage2::"Archived Order":
            SetRange(Usage,Usage::"P.Arch. Order");
          ReportUsage2::"Archived Return Order":
            SetRange(Usage,Usage::"P. Arch. Return Order");
          ReportUsage2::"Archived Blanket Order":
            SetRange(Usage,Usage::"Medical Examination");
        #33..35
            SetRange(Usage,Usage::"84");
        #37..39
        */
    //end;
}

