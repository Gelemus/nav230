pageextension 60822 pageextension60822 extends "Report Selection - Prod. Order" 
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
        #4..10
          ReportUsage2::"Gantt Chart":
            SetRange(Usage,Usage::M4);
          ReportUsage2::"Prod. Order":
            SetRange(Usage,Usage::"Prod.Order");
        end;
        FilterGroup(0);
        CurrPage.Update;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
            SetRange(Usage,Usage::"Prod. Order");
        #15..17
        */
    //end;
}

