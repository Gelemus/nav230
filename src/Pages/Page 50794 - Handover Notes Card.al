page 50794 "Handover Notes Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Transport Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = FALSE;
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                }
                field(Make; Rec.Make)
                {
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                }
                field(Mileage; Rec.Mileage)
                {
                }
                field("Last Fueling (Lts)"; Rec."Last Fueling (Lts)")
                {
                }
                field("Issue Voucher"; Rec."Issue Voucher")
                {
                }
                field("Last Service KMS:"; Rec."Last Service KMS:")
                {
                }
                field("Next Service at:"; Rec."Next Service at:")
                {
                }
                field("Engine Oil"; Rec."Engine Oil")
                {
                }
                group("Equipment/Tools")
                {
                    field(Battery; Rec.Battery)
                    {
                    }
                    field("Battery Comment"; Rec."Battery Comment")
                    {
                    }
                    field(Jack; Rec.Jack)
                    {
                    }
                    field("Jack Comments"; Rec."Jack Comments")
                    {
                    }
                    field("Wheel Spanner"; Rec."Wheel Spanner")
                    {
                    }
                    field("Wheel Spanner Comments"; Rec."Wheel Spanner Comments")
                    {
                    }
                    field("Fire Extinguisher"; Rec."Fire Extinguisher")
                    {
                    }
                    field("Fire Extinguisher Comments"; Rec."Fire Extinguisher Comments")
                    {
                    }
                    field("First Aid Kit"; Rec."First Aid Kit")
                    {
                    }
                    field("First Aid Kit Cooments"; Rec."First Aid Kit Cooments")
                    {
                    }
                    field("Radio/Cassette"; Rec."Radio/Cassette")
                    {
                    }
                    field("Radio/Cassette Comments"; Rec."Radio/Cassette Comments")
                    {
                    }
                    field("Fuel Gauge"; Rec."Fuel Gauge")
                    {
                    }
                    field("Fuel Gauge Comments"; Rec."Fuel Gauge Comments")
                    {
                    }
                    field("Speedo Meter Cable"; Rec."Speedo Meter Cable")
                    {
                    }
                    field("Speedo Meter Cable Comments"; Rec."Speedo Meter Cable Comments")
                    {
                    }
                }
                group(Conditions)
                {
                    field(Headlights; Rec.Headlights)
                    {
                    }
                    field("Headlights Comments"; Rec."Headlights Comments")
                    {
                    }
                    field(Indicator; Rec.Indicator)
                    {
                    }
                    field("Indicator Comments"; Rec."Indicator Comments")
                    {
                    }
                    field("Hazard Lights"; Rec."Hazard Lights")
                    {
                    }
                    field("Hazard Lights Comments"; Rec."Hazard Lights Comments")
                    {
                    }
                    field("Hand Break"; Rec."Hand Break")
                    {
                    }
                    field("Hand Break Comments"; Rec."Hand Break Comments")
                    {
                    }
                }
                group(Tyre)
                {
                    field("Tyres Type"; Rec."Tyres Type")
                    {
                    }
                    field("Front Right"; Rec."Front Right")
                    {
                    }
                    field("Front Left"; Rec."Front Left")
                    {
                    }
                    field("Rear Right"; Rec."Rear Right")
                    {
                    }
                    field("Rear Left"; Rec."Rear Left")
                    {
                    }
                    field("Spare Wheel Nos"; Rec."Spare Wheel Nos")
                    {
                    }
                    field("Mechanical Problem"; Rec."Mechanical Problem")
                    {
                    }
                }
                group("Body Condition")
                {
                    field(Dents; Rec.Dents)
                    {
                    }
                    field("Driving Mirrors"; Rec."Driving Mirrors")
                    {
                    }
                    field(Scratches; Rec.Scratches)
                    {
                    }
                }
            }
            group("Handing Over")
            {
                field("Handing Over By No"; Rec."Handing Over By No")
                {
                }
                field("Handing Over By"; Rec."Handing Over By")
                {
                }
                field("Handing Over Designation"; Rec."Handing Over Designation")
                {
                }
                field("Handing over Date"; Rec."Handing over Date")
                {
                }
                field("Handing over Time"; Rec."Handing over Time")
                {
                }
            }
            group("Taking Over")
            {
                field("Taking Over By No"; Rec."Taking Over By No")
                {
                }
                field("Taking Over By"; Rec."Taking Over By")
                {
                }
                field("Taking Over Designation"; Rec."Taking Over Designation")
                {
                }
                field("Taking Over Date"; Rec."Taking Over Date")
                {
                }
                field("Taking Over Time"; Rec."Taking Over Time")
                {
                }
            }
            group("Witnessed By")
            {
                field("Witnessed By No"; Rec."Witnessed By No")
                {
                }
                field("Witnessed By Name"; Rec."Witnessed By Name")
                {
                }
                field("Date Witnessed"; Rec."Date Witnessed")
                {
                }
                field(TimeWitnessed; Rec.TimeWitnessed)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Repair Order Report")
            {
                Caption = 'Hand Over Report';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.SetRange("Request No.", xRec."Request No.");
                    REPORT.Run(REPORT::"Handover Notes", true, true, Rec);
                end;
            }
            action(Submit)
            {
                Enabled = false;
                Image = SuggestLines;
                Promoted = true;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        Rec.Status := Rec.Status::Released;
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*TESTFIELD("Trip Planned Start Date");
                    TESTFIELD("Trip Planned End Date");
                    TESTFIELD("Return Time");
                    TESTFIELD("Start Time");
                    TESTFIELD(Destination);
                    //TESTFIELD("Reason for Travel");
                    
                    IF "Trip Planned Start Date" > "Trip Planned End Date" THEN BEGIN
                        ERROR('You cannot go to a Trip after the before the Trip Start date');
                    END;
                    */
                    ComInfo.Get;
                    // ComInfo.TESTFIELD(ComInfo."HR Support Email");
                    // ComInfo.TESTFIELD(ComInfo."HR Support Email");

                    if ApprovalMgt.CheckTransportRequestApprovalsWorkflowEnabled(Rec) then
                        ApprovalMgt.OnSendTransportRequestForApproval(Rec);

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalMgt.OnCancelTransportRequestApprovalRequest(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::"Handover Notes";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Handover Notes";
    end;

    var
        ApprovalMgt: Codeunit "Custom Workflow Mgmt";
        ComInfo: Record "Company Information";
        Hrmail: Text[120];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
}

