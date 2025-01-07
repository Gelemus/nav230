pageextension 60231 pageextension60231 extends "Report Selection - Sales" 
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
        #4..28
          ReportUsage2::"Prepayment Document - Test":
            SetRange(Usage,Usage::"S.Test Prepmt.");
          ReportUsage2::"Archived Quote":
            SetRange(Usage,Usage::"S.Arch.Quote");
          ReportUsage2::"Archived Order":
            SetRange(Usage,Usage::"S.Arch.Order");
          ReportUsage2::"Archived Return Order":
            SetRange(Usage,Usage::"S.Arch.Return");
          ReportUsage2::"Customer Statement":
            SetRange(Usage,Usage::"C.Statement");
          ReportUsage2::"Pro Forma Invoice":
            SetRange(Usage,Usage::"Pro Forma S. Invoice");
          ReportUsage2::"Archived Blanket Order":
            SetRange(Usage,Usage::"S.Arch.Blanket");
        end;
        FilterGroup(0);
        CurrPage.Update;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..31
            SetRange(Usage,Usage::"S.Arch. Quote");
          ReportUsage2::"Archived Order":
            SetRange(Usage,Usage::"S.Arch. Order");
          ReportUsage2::"Archived Return Order":
            SetRange(Usage,Usage::"S. Arch. Return Order");
        #37..41
            SetRange(Usage,Usage::"Job Offer");
        #43..45
        */
    //end;
}

