report 50135 "Assign Cost Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Assign Cost Lines.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {

            trigger OnAfterGetRecord()
            begin
                /*ChargeAllocations.RESET;
                IF ChargeAllocations.FINDSET THEN BEGIN
                  ChargeAllocations.DELETEALL;
                END;
                
                
                
                PropertyChargeCodes.RESET;
                PropertyChargeCodes.SETRANGE(PropertyChargeCodes."Charge Type",PropertyChargeCodes."Charge Type"::"2");
                IF PropertyChargeCodes.FINDSET THEN BEGIN
                  REPEAT
                    Properties.RESET;
                    IF Properties.FINDSET THEN BEGIN
                     REPEAT
                       PropertyFloors.RESET;
                       PropertyFloors.SETRANGE(PropertyFloors."Property No.",Properties."No.");
                       IF PropertyFloors.FINDSET THEN BEGIN
                        REPEAT
                          LineNo:=LineNo+1;
                          ChargeAllocations.INIT;
                          ChargeAllocations."Line No":=LineNo;
                          ChargeAllocations.Code:=PropertyChargeCodes.Code;
                          ChargeAllocations.VALIDATE(ChargeAllocations.Code);
                          ChargeAllocations.Property:=PropertyFloors."Property No.";
                          ChargeAllocations.Floor:=PropertyFloors."Floor Code";
                          ChargeAllocations.INSERT;
                      UNTIL PropertyFloors.NEXT=0;
                    END;
                    UNTIL Properties.NEXT=0;
                    END;
                  UNTIL PropertyChargeCodes.NEXT=0;
                 END;
                 */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LineNo: Integer;
}

