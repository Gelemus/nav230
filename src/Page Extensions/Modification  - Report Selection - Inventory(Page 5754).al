pageextension 60431 pageextension60431 extends "Report Selection - Inventory" 
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
        case ReportUsage2 of
          ReportUsage2::"Transfer Order":
            SetRange(Usage,Usage::Inv1);
          ReportUsage2::"Transfer Shipment":
            SetRange(Usage,Usage::Inv2);
          ReportUsage2::"Transfer Receipt":
            SetRange(Usage,Usage::Inv3);
          ReportUsage2::"Inventory Period Test":
            SetRange(Usage,Usage::"Invt.Period Test");
          ReportUsage2::"Assembly Order":
            SetRange(Usage,Usage::"Asm.Order");
          ReportUsage2::"Posted Assembly Order":
            SetRange(Usage,Usage::"P.Asm.Order");
          ReportUsage2::"Phys. Invt. Order":
            SetRange(Usage,Usage::"Phys.Invt.Order");
          ReportUsage2::"Phys. Invt. Order Test":
            SetRange(Usage,Usage::"Phys.Invt.Order Test");
          ReportUsage2::"Phys. Invt. Recording":
            SetRange(Usage,Usage::"Phys.Invt.Rec.");
          ReportUsage2::"Posted Phys. Invt. Order":
            SetRange(Usage,Usage::"P.Phys.Invt.Order");
          ReportUsage2::"Posted Phys. Invt. Recording":
            SetRange(Usage,Usage::"P.Phys.Invt.Rec.");
        end;
        FilterGroup(0);
        CurrPage.Update;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11
            SetRange(Usage,Usage::"Invt. Period Test");
          ReportUsage2::"Assembly Order":
            SetRange(Usage,Usage::"Asm. Order");
          ReportUsage2::"Posted Assembly Order":
            SetRange(Usage,Usage::"P.Assembly Order");
          ReportUsage2::"Phys. Invt. Order":
            SetRange(Usage,Usage::"Exit Interview");
          ReportUsage2::"Phys. Invt. Order Test":
            SetRange(Usage,Usage::"Letter of Appointment");
          ReportUsage2::"Phys. Invt. Recording":
            SetRange(Usage,Usage::"Tenant Offer");
          ReportUsage2::"Posted Phys. Invt. Order":
            SetRange(Usage,Usage::"Clearance Form");
          ReportUsage2::"Posted Phys. Invt. Recording":
            SetRange(Usage,Usage::Complaints);
        #27..29
        */
    //end;
}

