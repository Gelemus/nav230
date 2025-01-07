report 51185 "Employee Details Reveiw Func."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee;Employee)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                if RenameRec then begin
                  RecReff.GetTable(Employee);
                  FielRef := RecReff.Field(FieldNotoAdjust);
                  if AdjustmentType = AdjustmentType::"Fixed Value" then begin
                    if "AdjustmentValue(Numeric)" <> 0 then
                      FielRef.Value := "AdjustmentValue(Numeric)"
                    else if "AdjustmentValue(Text)" <> '' then
                      FielRef.Value := "AdjustmentValue(Text)";
                  end else if AdjustmentType = AdjustmentType::"Fixed Increment" then begin
                    if "AdjustmentValue(Numeric)" <> 0 then begin
                      AddValue := FielRef.Value;
                      FielRef.Value := AddValue + "AdjustmentValue(Numeric)"
                    end;
                  end else if AdjustmentType = AdjustmentType::Factor then begin
                    if "AdjustmentValue(Numeric)" <> 0 then begin
                      MultValue := FielRef.Value;
                      FielRef.Value := MultValue * "AdjustmentValue(Numeric)"
                    end;
                  end;
                  RecReff.Modify;
                end else
                  exit;
            end;

            trigger OnPostDataItem()
            begin
                if RenameRec then
                  Message(Text001)
                else
                  Message(Text002);
            end;

            trigger OnPreDataItem()
            begin
                RenameRec := Confirm(Text000,true);
                Clear(AddValue);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(AdjustmentType;AdjustmentType)
                    {
                        Caption = 'Adjustment Type';
                    }
                    field(FieldNotoAdjust;FieldNotoAdjust)
                    {
                        Caption = 'Field No. Adjust';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            FieldRec.Reset;
                            FieldRec.SetRange(FieldRec.TableNo,DATABASE::Employee);
                            if AdjustmentType = AdjustmentType::"Fixed Increment" then
                              FieldRec.SetFilter(FieldRec.Type,'%1|%2',FieldRec.Type::Integer,FieldRec.Type::Decimal)
                            else if AdjustmentType = AdjustmentType::Factor then
                              FieldRec.SetRange(FieldRec.Type,FieldRec.Type::Decimal);
                            if FieldRec.FindFirst then repeat
                              FieldRec.Mark(true);
                            until FieldRec.Next = 0;
                            FieldRec.MarkedOnly(true);
                            if PAGE.RunModal(6218,FieldRec) = ACTION::LookupOK then begin
                              FieldNotoAdjust := FieldRec."No.";
                              FieldNametoAdjust := FieldRec.FieldName;

                              //RequestOptionsPage.FieldNametoAdjust.EDITABLE:=FALSE;
                            end;
                            if ((AdjustmentType = AdjustmentType::"Fixed Increment") or
                               (AdjustmentType = AdjustmentType::Factor))then begin
                            //  RequestOptionsForm."Adjustment Value (Numeric)".EDITABLE := TRUE;
                             // RequestOptionsForm."Adjustment Value (Text)".EDITABLE := FALSE;
                            end else if AdjustmentType = AdjustmentType::"Fixed Value" then begin
                             // RequestOptionsForm."Adjustment Value (Numeric)".EDITABLE := TRUE;
                             // RequestOptionsForm."Adjustment Value (Text)".EDITABLE := TRUE;
                            end;
                        end;
                    }
                    field(FieldNametoAdjust;FieldNametoAdjust)
                    {
                        Caption = 'Field Name to Adjust';
                    }
                    field(AdjustmentValueNumeric;"AdjustmentValue(Numeric)")
                    {
                        Caption = 'Adjustment Value (numeric)';
                    }
                    field(AdjustmentValueText;"AdjustmentValue(Text)")
                    {
                        Caption = 'Adjustment Value (Text)';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
    end;

    var
        FieldNotoAdjust: Integer;
        "AdjustmentValue(Numeric)": Decimal;
        FieldNametoAdjust: Text[250];
        "AdjustmentValue(Text)": Text[250];
        AdjustmentType: Option "Fixed Increment","Fixed Value",Factor;
        FieldRec: Record "Field";
        RecReff: RecordRef;
        FielRef: FieldRef;
        RecIS: RecordID;
        Emp: Record Employee;
        RenameRec: Boolean;
        Text000: Label 'Do you want to modify the records?';
        Text001: Label 'Records modified sucessfully';
        Text002: Label 'Did not modify any records';
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        ActPayrollID: Code[20];
        AddValue: Decimal;
        MultValue: Decimal;

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID",ServiceInstanceId);
        lvActiveSession.SetRange("Session ID",SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
          Error('You are not allowed access to this payroll dataset.');
    end;
}

