pageextension 60779 pageextension60779 extends "Vendor Report Selections" 
{
    layout
    {

        //Unsupported feature: Code Modification on "Usage2(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            case Usage2 of
              Usage2::"Purchase Order":
                Usage := Usage::"P.Order";
              Usage2::"Vendor Remittance":
                Usage := Usage::"V.Remittance";
              Usage2::"Vendor Remittance - Posted Entries":
                Usage := Usage::"P.V.Remit.";
            end;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
                Usage := Usage::"84";
            end;
            */
        //end;
    }


    //Unsupported feature: Code Modification on "MapTableUsageValueToPageValue(PROCEDURE 1)".

    //procedure MapTableUsageValueToPageValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        case Usage of
          CustomReportSelection.Usage::"P.Order":
            Usage2 := Usage2::"Purchase Order";
          CustomReportSelection.Usage::"V.Remittance":
            Usage2 := Usage2::"Vendor Remittance";
          CustomReportSelection.Usage::"P.V.Remit.":
            Usage2 := Usage2::"Vendor Remittance - Posted Entries";
        end;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
          CustomReportSelection.Usage::"84":
            Usage2 := Usage2::"Vendor Remittance - Posted Entries";
        end;
        */
    //end;
}

