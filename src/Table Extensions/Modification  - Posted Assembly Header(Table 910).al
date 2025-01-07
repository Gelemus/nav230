tableextension 60710 tableextension60710 extends "Posted Assembly Header" 
{

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowStatistics(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "PrintRecords(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        with PostedAssemblyHeader do begin
          Copy(Rec);
          ReportSelections.PrintWithGUIYesNo(
            ReportSelections.Usage::"P.Asm.Order",PostedAssemblyHeader,ShowRequestForm,0);
        end;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
            ReportSelections.Usage::"P.Assembly Order",PostedAssemblyHeader,ShowRequestForm,0);
        end;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "Navigate(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemTrackingLines(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIsNotAsmToOrder(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrder(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrder(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "CalcActualCosts(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "CalcTotalCost(PROCEDURE 25)".

}

