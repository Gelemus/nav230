codeunit 50031 "Fleet Management WS"
{

    trigger OnRun()
    begin
        /*IF SendWorkticketApprovalRequest('F00410') THEN
          MESSAGE('TRUE')
        ELSE MESSAGE('False');*/
        Message(Format(SendVehicleRequisitionApprovalRequest('REPO000458')));

    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

        ApprovalsMgmt: Codeunit "Custom Workflow Mgmt";
        ApprovalsMgmtMain: Codeunit "Approvals Mgmt.";
        "FleetMgmt.": Codeunit "Fleet Management";
        FleetApprovalManager: Codeunit "Fleet Approval Manager";
        Employee: Record Employee;
        FleetGeneralSetup: Record "Human Resources Setup";
        VehicleRequisition: Record "Transport Request";
        WorkTicket: Record "Work Ticket";
        FixedAsset: Record "Fixed Asset";
        ApprovalEntry: Record "Approval Entry";
        FuelRequisition: Record "Vehicle Filling";
        HumanResSetup: Record "Human Resources Setup";

    procedure CheckOpenVehicleRequisitionExists("EmployeeNo.": Code[20]) OpenVehicleRequisitionExist: Boolean
    begin
        OpenVehicleRequisitionExist := false;
        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Employee No.", "EmployeeNo.");
        VehicleRequisition.SetRange(VehicleRequisition.Status, VehicleRequisition.Status::Open);
        if VehicleRequisition.FindFirst then begin
            OpenVehicleRequisitionExist := true;

        end;
    end;

    procedure CheckVehicleRequisitionExists("VehicleRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]) VehicleRequisitionExist: Boolean
    begin
        VehicleRequisitionExist := false;
        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Employee No.", "EmployeeNo.");
        VehicleRequisition.SetRange(VehicleRequisition."Request No.", "VehicleRequisitionNo.");
        if VehicleRequisition.FindFirst then begin
            VehicleRequisitionExist := true;
        end;
    end;

    [Scope('Personalization')]
    procedure CreateVehicleRequisition("EmployeeNo.": Code[20]; Destination: Text; PurposeOftravel: Text; StartDate: Date; ReturnDate: Date; StartTime: Time; EndTime: Time; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; RequestType: Option " ",Routine,Planned,Emergency) "VehicleRequisitionNo.": Text
    var
        "DocNo.": Code[20];
    begin
        "VehicleRequisitionNo." := '';

        FleetGeneralSetup.Reset;
        FleetGeneralSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        "DocNo." := '';
        "DocNo." := NoSeriesMgt.GetNextNo(FleetGeneralSetup."Transport Request Nos", 0D, true);
        if "DocNo." <> '' then begin
            VehicleRequisition.Init;
            VehicleRequisition."Request No." := "DocNo.";
            VehicleRequisition."Request Date" := Today;
            VehicleRequisition."Employee No." := "EmployeeNo.";

            VehicleRequisition.Validate(VehicleRequisition."Employee No.");
            VehicleRequisition.Destination := Destination;
            VehicleRequisition."Travel Details" := PurposeOftravel;
            VehicleRequisition."Trip Planned Start Date" := StartDate;
            VehicleRequisition."Trip Planned End Date" := ReturnDate;
            VehicleRequisition."Start Date" := StartDate;
            VehicleRequisition.Validate(VehicleRequisition."Start Date");
            VehicleRequisition."Return Date" := ReturnDate;

            VehicleRequisition."Start Time" := StartTime;
            VehicleRequisition."Return Time" := EndTime;
            VehicleRequisition."Global Dimension 1 Code" := GlobalDimension1Code;
            VehicleRequisition.Validate(VehicleRequisition."Global Dimension 1 Code");
            VehicleRequisition."Global Dimension 2 Code" := GlobalDimension2Code;
            VehicleRequisition.Validate(VehicleRequisition."Global Dimension 2 Code");
            VehicleRequisition."Type of Request" := RequestType;
            //VehicleRequisition."Responsibility Center":=ResponsibilityCenter;
            VehicleRequisition."User ID" := Employee."User ID";

            if VehicleRequisition.Insert then begin
                "VehicleRequisitionNo." := '200: Transport requisition no ' + "DocNo." + ' successfully';
            end
            else
                "VehicleRequisitionNo." := '400: ' + GetLastErrorCode + ':' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyVehicleRequisition("VehicleRequisitionNo.": Code[20]; "EmployeeNo.": Code[20]; Destination: Code[50]; PurposeOftravel: Code[50]; StartDate: Date; ReturnDate: Date; StartTime: Time; EndTime: Time; GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; ShortcutDimension3Code: Code[20]; RequestType: Option " ",Routine,Planned,Emergency) VehicleRequisitionModified: Text
    begin
        VehicleRequisitionModified := '';

        FleetGeneralSetup.Reset;
        FleetGeneralSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Request No.", "VehicleRequisitionNo.");
        if VehicleRequisition.FindFirst then begin
            VehicleRequisition.Destination := Destination;
            VehicleRequisition."Travel Details" := PurposeOftravel;

            VehicleRequisition."Start Date" := StartDate;
            VehicleRequisition.Validate(VehicleRequisition."Start Date");
            VehicleRequisition."Return Date" := ReturnDate;
            VehicleRequisition."Trip Planned Start Date" := StartDate;
            VehicleRequisition."Trip Planned End Date" := ReturnDate;
            VehicleRequisition."Start Time" := StartTime;
            VehicleRequisition."Return Time" := EndTime;
            VehicleRequisition."User ID" := Employee."User ID";
            VehicleRequisition."Type of Request" := RequestType;
            if VehicleRequisition.Modify then
                VehicleRequisitionModified := '200: Transport Requisition  modified successfully'
            else
                VehicleRequisitionModified := '400: ' + GetLastErrorCode + ':' + GetLastErrorText;
        end else
            VehicleRequisitionModified := '400: Transport Requisition does not exist'
    end;

    procedure GetTripReturnDate(StartDate: Date; DaysApplied: Integer) ReturnDate: Date
    begin
        ReturnDate := 0D;
        //ReturnDate:="FleetMgmt.".CalculateReturnDate(StartDate,DaysApplied);
    end;

    procedure GetOpenVehicleRequisition("EmployeeNo.": Code[20]) "OpenVehicleRequisitionNo.": Code[20]
    begin
        "OpenVehicleRequisitionNo." := '';
        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Employee No.", "EmployeeNo.");
        VehicleRequisition.SetRange(VehicleRequisition.Status, VehicleRequisition.Status::Open);
        if VehicleRequisition.FindLast then begin
            "OpenVehicleRequisitionNo." := VehicleRequisition."Request No.";
        end;
    end;

    procedure GetVehicleRequisitionStatus("VehicleRequisitionNo.": Code[20]) VehicleRequisitionStatus: Text
    begin
        VehicleRequisitionStatus := '';
        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Request No.", "VehicleRequisitionNo.");
        if VehicleRequisition.FindFirst then begin
            VehicleRequisitionStatus := Format(VehicleRequisition.Status);
        end;
    end;

    procedure CheckVehicleRequisitionApprovalWorkflowEnabled("VehicleRequisitionNo.": Code[20]) ApprovalWorkflowEnabled: Boolean
    begin
        ApprovalWorkflowEnabled := false;

        VehicleRequisition.Reset;
        if VehicleRequisition.Get("VehicleRequisitionNo.") then;
        //ApprovalWorkflowEnabled:=ApprovalsMgmt.CheckTransportRequisitionApprovalsWorkflowEnabled(VehicleRequisition);
    end;

    [Scope('Personalization')]
    procedure SendVehicleRequisitionApprovalRequest("VehicleRequisitionNo.": Code[20]) VehicleRequisitionApprovalRequestSent: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        VehicleRequisitionApprovalRequestSent := false;

        VehicleRequisition.Reset;
        if VehicleRequisition.Get("VehicleRequisitionNo.") then begin
            if ApprovalsMgmt.CheckTransportRequestApprovalsWorkflowEnabled(VehicleRequisition) then
                ApprovalsMgmt.OnSendTransportRequestForApproval(VehicleRequisition);
            //ApprovalsMgmt.OnSendTransportRequestForApproval(VehicleRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", VehicleRequisition."Request No.");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                VehicleRequisitionApprovalRequestSent := true;
        end;
    end;

    procedure CancelVehicleRequisitionApprovalRequest("VehicleRequisitionNo.": Code[20]) VehicleRequisitionApprovalRequestCanceled: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        VehicleRequisitionApprovalRequestCanceled := false;

        VehicleRequisition.Reset;
        if VehicleRequisition.Get("VehicleRequisitionNo.") then begin
            ApprovalsMgmt.OnCancelTransportRequestApprovalRequest(VehicleRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", VehicleRequisition."Request No.");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    VehicleRequisitionApprovalRequestCanceled := true;
            end;
        end;
    end;

    procedure ReopenVehicleRequisition("VehicleRequisitionNo.": Code[20]) VehicleRequisitionOpened: Boolean
    begin
        VehicleRequisitionOpened := false;

        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Request No.", "VehicleRequisitionNo.");
        if VehicleRequisition.FindFirst then begin
            // FleetApprovalManager.re(VehicleRequisition);
            VehicleRequisitionOpened := true;
        end;
    end;

    [Scope('Personalization')]
    procedure GetTransportPeremployeeApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Transport Request");
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetTransportRequistionApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; HeaderNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"Transport Request");
        if HeaderNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", HeaderNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetTransportRequistionList(var TransportrequisitionExport: XMLport "Transport requisition Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            VehicleRequisition.Reset;
            VehicleRequisition.SetFilter("Employee No.", EmployeeNo);
            if VehicleRequisition.FindFirst then;
            TransportrequisitionExport.SetTableView(VehicleRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure GetTransportRequistionListStatus(var TransportrequisitionExport: XMLport "Transport requisition Export"; EmployeeNo: Code[20]; StatusFilter: Option Open,"Pending Approval",Approved,Rejected,Posted)
    begin
        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(Status, StatusFilter);
        if EmployeeNo <> '' then begin

            VehicleRequisition.SetFilter("Employee No.", EmployeeNo);
            if VehicleRequisition.FindFirst then;
            TransportrequisitionExport.SetTableView(VehicleRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure GetTransportRequistionHeaderLines(var TransportrequisitionExport: XMLport "Transport requisition Export"; HeaderNo: Code[20])
    begin

        if HeaderNo <> '' then begin
            VehicleRequisition.Reset;
            VehicleRequisition.SetFilter("Request No.", HeaderNo);
            if VehicleRequisition.FindFirst then;
            TransportrequisitionExport.SetTableView(VehicleRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure GetTransporteRequistionCreatedByList(var TransportrequisitionExport: XMLport "Transport requisition Export"; EmployeeNo: Code[20]; Createdby: Code[20])
    begin
        if EmployeeNo <> '' then begin
            VehicleRequisition.Reset;
            VehicleRequisition.SetFilter("Employee No.", '<>%1', EmployeeNo);
            // VehicleRequisition.SETFILTER("User ID",Createdby);
            if VehicleRequisition.FindFirst then;
            TransportrequisitionExport.SetTableView(VehicleRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure ApproveTransportRequisition("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
        ApprovalEntry: Record "Approval Entry";
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Transport Requisition Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectTransportRequisition("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
        ApprovalEntry: Record "Approval Entry";
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Transport Requisition Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure CreateVehicleRequisitionLine(EmployeeNo: Code[20]; TransReqCode: Code[20]) CreatedMsg: Text
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Init;
        TravellingEmployeeRec."Request No." := TransReqCode;
        TravellingEmployeeRec."Employee No." := EmployeeNo;
        TravellingEmployeeRec.Validate("Employee No.");
        if TravellingEmployeeRec.Insert then
            CreatedMsg := 'Line created successfully'
        else
            CreatedMsg := GetLastErrorCode + '-' + GetLastErrorText;
        ;
    end;

    [Scope('Personalization')]
    procedure ModifyVehicleRequisitionLine(EmployeeNo: Code[20]; TransReqCode: Code[20]) LineModified: Boolean
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Reset;
        TravellingEmployeeRec.SetRange("Request No.", TransReqCode);
        TravellingEmployeeRec.SetRange("Employee No.", EmployeeNo);
        if TravellingEmployeeRec.FindFirst then begin
            TravellingEmployeeRec."Employee No." := EmployeeNo;
            TravellingEmployeeRec.Validate("Employee No.");
            if TravellingEmployeeRec.Modify then
                LineModified := true
            else
                LineModified := false;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteVehicleRequisitionLine(TransReqCode: Code[20]; EmployeeNo: Code[20]) LineDeleted: Boolean
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Reset;
        TravellingEmployeeRec.SetRange("Request No.", TransReqCode);
        TravellingEmployeeRec.SetRange("Employee No.", EmployeeNo);
        if TravellingEmployeeRec.FindFirst then
            if TravellingEmployeeRec.Delete then
                LineDeleted := true
            else
                LineDeleted := false;
    end;

    [Scope('Personalization')]
    procedure CreateWorkTicket(VehicleNo: Code[20]; TicketDate: Date; OilDrawn: Decimal; FuelDrawn: Decimal; OdometerStart: Decimal; OdometerReturn: Decimal; StartTime: Time; ReturnTime: Time; JourneyDetails: Text; EmpNo: Code[20]; DefectReport: Code[250]; Department: Code[50]) TicketReturnText: Text
    begin
        TicketReturnText := '';
        FleetGeneralSetup.Get;
        Employee.Reset;

        WorkTicket.Init;
        WorkTicket."Ticket No" := NoSeriesMgt.GetNextNo(FleetGeneralSetup."Card Nos", 0D, true);
        WorkTicket.Validate("Vehicle No", VehicleNo);
        WorkTicket.Validate("Driver No", EmpNo);
        WorkTicket.Validate(Date, TicketDate);
        WorkTicket.Validate("Oil Drawn (Litres)", OilDrawn);
        WorkTicket.Validate("Fuel Drawn (Litres)", FuelDrawn);
        WorkTicket.Validate("Start Speedometer Reading", OdometerStart);
        WorkTicket.Validate("Last Mileage Reading", OdometerReturn);
        WorkTicket.Validate("Start Time", StartTime);
        WorkTicket.Validate("Return TIme", ReturnTime);
        WorkTicket.DefectReport := DefectReport;
        /*WorkTicket."External Ticket No":=ExternalTicketNo;
        WorkTicket."Previous Ticket No" := PreviousTicketNo;
        WorkTicket."Receipt No" := ReceiptNo;*/
        if Employee.Get(EmpNo) then
            WorkTicket.Region := Employee."Global Dimension 1 Code";
        WorkTicket.Department := Department;
        WorkTicket.Validate("Journey Details", JourneyDetails);
        if WorkTicket.Insert then
            TicketReturnText := '200: Work ticket Created successfully'
        else
            TicketReturnText := '400:' + GetLastErrorCode + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure ModifyWorkTicket(TicketNo: Code[20]; VehicleNo: Code[20]; TicketDate: Date; OilDrawn: Decimal; FuelDrawn: Decimal; OdometerStart: Decimal; OdometerReturn: Decimal; StartTime: Time; ReturnTime: Time; JourneyDetails: Text; EmpNo: Code[20]; DefectReport: Text[250]; Department: Code[50]; ExternalTicketNo: Code[20]; PreviousTicketNo: Code[20]; ReceiptNo: Code[20]) TicketReturnText: Text
    begin
        TicketReturnText := '';
        WorkTicket.Get(TicketNo);
        Employee.Reset;
        //WorkTicket."Ticket No":=NoSeriesMgt.GetNextNo(FleetGeneralSetup."Work Ticket Nos",TODAY,TRUE);
        WorkTicket.Validate("Vehicle No", VehicleNo);
        WorkTicket.Validate(Date, TicketDate);
        WorkTicket.Validate("Driver No", EmpNo);
        WorkTicket.Validate("Oil Drawn (Litres)", OilDrawn);
        WorkTicket.Validate("Fuel Drawn (Litres)", FuelDrawn);
        WorkTicket.Validate("Start Speedometer Reading", OdometerStart);
        WorkTicket.Validate("Start Time", StartTime);

        WorkTicket."External Ticket No" := ExternalTicketNo;
        WorkTicket."Previous Ticket No" := PreviousTicketNo;
        WorkTicket."Receipt No" := ReceiptNo;

        if Employee.Get(EmpNo) then
            WorkTicket.Region := Employee."Global Dimension 1 Code";

        WorkTicket.Department := Department;
        WorkTicket.Validate("Return TIme", ReturnTime);
        WorkTicket.Validate("Journey Details", JourneyDetails);


        /*IF WorkTicket.Status <> WorkTicket.Status::Approved THEN
          WorkTicket.VALIDATE("Last Mileage Reading",OdometerStart)
        ELSE*/
        WorkTicket.Validate("Last Mileage Reading", OdometerReturn);

        WorkTicket.DefectReport := DefectReport;
        if WorkTicket.Modify then
            TicketReturnText := '200: Work Ticket Modified successfully'
        else
            TicketReturnText := '400:' + GetLastErrorCode + GetLastErrorText;

    end;

    [Scope('Personalization')]
    procedure GetWorkTicket(var WorkTicketExport: XMLport "Import/Export Appraisal Academ"; TicketNo: Code[20])
    begin
        if TicketNo <> '' then begin
            WorkTicket.Reset;
            WorkTicket.SetRange("Ticket No", TicketNo);
            if WorkTicket.FindFirst then;
            WorkTicketExport.SetTableView(WorkTicket);
        end
    end;

    [Scope('Personalization')]
    procedure GetVehicleList(var FixedAssetExport: XMLport "Fixed Asset Export"; EmployeeNo: Code[20])
    begin
        //FixedAsset.RESET;
        //FixedAsset.SETFILTER("Transport Type",'<>%1',FixedAsset."Transport Type"::" ");
        //FixedAsset.SETRANGE("Transport Type",FixedAsset."Transport Type"::Vehicle);
        /*IF EmployeeNo<>'' THEN BEGIN
          FixedAsset.SETRANGE("Responsible Employee",EmployeeNo);
        END ;*/
        //IF FixedAsset.FINDFIRST THEN;
        //FixedAssetExport.SETTABLEVIEW(FixedAsset);

        //ERROR('error');

    end;

    [Scope('Personalization')]
    procedure GetWorkTicketEmployee(var WorkTicketExport: XMLport "Work Ticket  Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            WorkTicket.Reset;
            WorkTicket.SetRange("Driver No", EmployeeNo);
            if WorkTicket.FindFirst then;
            WorkTicketExport.SetTableView(WorkTicket);
        end
    end;

    [Scope('Personalization')]
    procedure SubmitWorkTicket(TicketNo: Code[20]) TicketReturnText: Text
    begin
        TicketReturnText := '';
        WorkTicket.Reset;
        WorkTicket.SetRange("Ticket No", TicketNo);
        if WorkTicket.FindFirst then begin
            // WorkTicket.TESTFIELD("Kms Covered");
            WorkTicket.TestField("Inspection Remarks");
            WorkTicket.TestField("Return TIme");
            WorkTicket.TestField("Last Mileage Reading");
            /*MileageRegistrationRec.INIT;
            MileageRegistrationRec."Vehicle No.":=WorkTicket."Vehicle No";
            MileageRegistrationRec."Work Ticket No.":=WorkTicket."Ticket No";
            MileageRegistrationRec.Date:=TODAY;
            MileageRegistrationRec."Curent Reading":=WorkTicket."Last Mileage Reading";
            MileageRegistrationRec."Previous Reading":=WorkTicket."Current Mileage Reading";
            MileageRegistrationRec."User ID":=USERID;
            MileageRegistrationRec.INSERT;*/


            WorkTicket.Status := WorkTicket.Status::Closed;
            if WorkTicket.Modify then
                TicketReturnText := '200: Work Ticket Successfully closed'
            else
                TicketReturnText := '400:' + GetLastErrorCode + GetLastErrorText;
        end else
            TicketReturnText := '400: Work Ticket does not exist'

    end;

    [Scope('Personalization')]
    procedure PrintWorkticket(WorkticketNo: Code[20]) ServerPath: Text
    var
        Filename: Text;
        Filepath: Text;
        WorkTicket: Record "Work Ticket";
    begin
        /*PortalSetup.RESET;
        PortalSetup.GET;
        PortalSetup.TESTFIELD("Server File Path");
        PortalSetup.TESTFIELD("Local File Path");
        Filename:=WorkticketNo+'_'+'WorkTicket.pdf';
        Filepath:=PortalSetup."Server File Path"+Filename;
        IF FILE.EXISTS(Filepath) THEN
          FILE.ERASE(Filepath);
        
        WorkTicket.RESET;
        WorkTicket.SETRANGE("Ticket No",WorkticketNo);
        WorkTicketReport.SETTABLEVIEW(WorkTicket);
        WorkTicketReport.SAVEASPDF(Filepath);
        IF FILE.EXISTS(Filepath) THEN
          ServerPath:=PortalSetup."Server File Path"+Filename
        ELSE
          ERROR('There was an Error. Please Try again');*/

    end;

    [Scope('Personalization')]
    procedure CreateVehicleRequisitionLineNomStaff(IdNo: Code[20]; TransReqCode: Code[20]; StaffName: Code[20]) CreatedMsg: Text
    var
        TravellingEmployeeNonStaffRec: Record "Non Staff Travelling";
    begin
        TravellingEmployeeNonStaffRec.Init;
        TravellingEmployeeNonStaffRec."Request No." := TransReqCode;
        TravellingEmployeeNonStaffRec."ID No" := IdNo;
        TravellingEmployeeNonStaffRec.Name := StaffName;
        if TravellingEmployeeNonStaffRec.Insert then
            CreatedMsg := 'Line created successfully'
        else
            CreatedMsg := '400: ' + GetLastErrorCode + '-' + GetLastErrorText;
        ;
    end;

    [Scope('Personalization')]
    procedure GetTravellingEmployeeNonStaff(RequestNo: Code[10]; var ImportExportTravellingEmpNonStaff: XMLport "Travelling EmpNonStaff Export")
    var
        TravellingEmployeeNonStaffRec: Record "Non Staff Travelling";
    begin
        TravellingEmployeeNonStaffRec.Reset;
        TravellingEmployeeNonStaffRec.SetRange("Request No.", RequestNo);
        if TravellingEmployeeNonStaffRec.FindFirst then;
        ImportExportTravellingEmpNonStaff.SetTableView(TravellingEmployeeNonStaffRec);
    end;

    [Scope('Personalization')]
    procedure DeleteVehicleRequisitionNonStaffLine(TransReqNo: Code[20]; IdNo: Code[20]) LineDeleted: Boolean
    var
        TravellingEmployeeNonStaffRec: Record "Non Staff Travelling";
    begin
        TravellingEmployeeNonStaffRec.Reset;
        TravellingEmployeeNonStaffRec.SetRange("Request No.", TransReqNo);
        TravellingEmployeeNonStaffRec.SetRange("ID No", IdNo);
        if TravellingEmployeeNonStaffRec.FindFirst then
            if TravellingEmployeeNonStaffRec.Delete then
                LineDeleted := true
            else
                LineDeleted := false;
    end;

    [Scope('Personalization')]
    procedure SendWorkticketApprovalRequest("WorkTicketNo.": Code[20]) WorkTicketApprovalRequestSent: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkTicketApprovalRequestSent := false;

        WorkTicket.Reset;
        if WorkTicket.Get("WorkTicketNo.") then begin
            //WorkTicket.Status := WorkTicket.Status::"Pending Approval";
            ApprovalsMgmt.OnSendWorkTicketForApproval(WorkTicket);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", WorkTicket."Ticket No");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);

            if WorkTicket.Modify then
                WorkTicketApprovalRequestSent := true;
        end;
    end;

    [Scope('Personalization')]
    procedure ApproveWorkTicket("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; InspectionRemarks: Text) Approved: Text
    var
        "EntryNo.": Integer;
        ApprovalEntry: Record "Approval Entry";
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            WorkTicket.Reset;
            WorkTicket.Get("DocumentNo.");
            WorkTicket."Inspection Remarks" := InspectionRemarks;
            // WorkTicket.MODIFY;
            if WorkTicket.Modify then begin
                "EntryNo." := ApprovalEntry."Entry No.";
                ApprovalEntry."Web Portal Approval" := true;
                ApprovalEntry.Modify;
                ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
            end else begin
                Approved := '400: Inspection Remarks Must have a value';
                exit;
            end
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Record Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectWorkTicket("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
        ApprovalEntry: Record "Approval Entry";
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Record Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetWorkTicketApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; HeaderNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::Payroll);
        if HeaderNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", HeaderNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetEmployeeWorkTicketApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::Payroll);
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetWorkTicketDocument(var WorkTicketExport: XMLport "Work Ticket  Export"; DocumentNo: Code[20])
    begin
        if DocumentNo <> '' then begin
            WorkTicket.Reset;
            WorkTicket.SetRange("Ticket No", DocumentNo);
            if WorkTicket.FindFirst then;
            WorkTicketExport.SetTableView(WorkTicket);
        end
    end;

    [Scope('Personalization')]
    procedure CreateFuelRequisition("EmployeeNo.": Code[20]; VehicleNo: Code[20]; FillingDate: Date; KilometerReading: Decimal; PreviousKms: Decimal; FuelDrawn: Decimal; OilDrawn: Decimal; CostPerLitre: Decimal; Remarks: Text; ReceiptNo: Code[20]; Description: Text) "FuelRequisitionNo.": Text
    var
        "DocNo.": Code[20];
        "Employee No.": Code[20];
    begin
        "FuelRequisitionNo." := '';


        HumanResSetup.Reset;
        HumanResSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        "DocNo." := '';
        "DocNo." := NoSeriesMgt.GetNextNo(HumanResSetup."Vehicle Filling Nos", 0D, true);
        if "DocNo." <> '' then begin
            FuelRequisition.Init;
            FuelRequisition."Filling No" := "DocNo.";
            FuelRequisition."No." := VehicleNo;
            FuelRequisition.Validate("No.");
            FuelRequisition."Employee No" := "EmployeeNo.";
            FuelRequisition.Validate(FuelRequisition."Employee No");
            FuelRequisition.Validate("Fuel Type");
            FuelRequisition."Filling Date" := FillingDate;
            FuelRequisition."Kms Covered" := KilometerReading;
            FuelRequisition."Previoust Kms" := PreviousKms;
            FuelRequisition."Fuel Drawn (Litres)" := FuelDrawn;
            FuelRequisition."Oil Drawn (Litres)" := OilDrawn;
            FuelRequisition."Cost per Litre" := CostPerLitre;
            FuelRequisition.Remarks := Remarks;


            //VehicleRequisition."Responsibility Center":=ResponsibilityCenter;
            //VehicleRequisition."User ID" := Employee."User ID";

            if FuelRequisition.Insert then begin
                "FuelRequisitionNo." := '200: Fuel Requisition no ' + "DocNo." + ' successfully';
            end
            else
                "FuelRequisitionNo." := '400: ' + GetLastErrorCode + ':' + GetLastErrorText;
        end;
        "FuelRequisitionNo." := '';
    end;

    [Scope('Personalization')]
    procedure GetFuelRequisitionList(var FuelRequisitionExport: XMLport "Fuel Requisition  Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            FuelRequisition.Reset;
            FuelRequisition.SetFilter("Employee No", EmployeeNo);
            if FuelRequisition.FindFirst then;
            FuelRequisitionExport.SetTableView(FuelRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure ModifyFuelRequisition(DocumentNo: Code[20]; VehicleNo: Code[20]; "EmployeeNo.": Code[20]; FillingDate: Date; KilometerReading: Decimal; PreviousKms: Decimal; FuelDrawn: Decimal; OilDrawn: Decimal; CostPerLitre: Decimal; Remarks: Text; Description: Text) TicketReturnText: Text
    begin
        TicketReturnText := '';
        FuelRequisition.Get(DocumentNo);
        //Employee.RESET;
        FuelRequisition."Employee No" := "EmployeeNo.";
        FuelRequisition.Validate(FuelRequisition."Employee No");
        FuelRequisition."No." := VehicleNo;
        FuelRequisition.Validate("No.");
        FuelRequisition."Filling Date" := FillingDate;
        FuelRequisition."Kms Covered" := KilometerReading;
        FuelRequisition."Previoust Kms" := PreviousKms;
        FuelRequisition."Fuel Drawn (Litres)" := FuelDrawn;
        FuelRequisition."Oil Drawn (Litres)" := OilDrawn;
        FuelRequisition."Cost per Litre" := CostPerLitre;
        FuelRequisition.Remarks := Remarks;
        FuelRequisition.Description := Description;

        if FuelRequisition.Modify then
            TicketReturnText := '200: Fuel Request Modified successfully'
        else
            TicketReturnText := '400:' + GetLastErrorCode + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure SendFuelRequisitionApprovalRequest("DocumentNo.": Code[20]) ReturnValue: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ReturnValue := '400: An Error Occurred, Please Contact Admin.';

        FuelRequisition.Reset;
        FuelRequisition.SetRange("Filling No", "DocumentNo.");
        if FuelRequisition.FindFirst then begin
            ApprovalsMgmt.OnSendVehicleFillingForApproval(FuelRequisition);// OnSendFuelRequestForApproval(FuelRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", FuelRequisition."Filling No");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst then
                ReturnValue := '200: Request Sent Successfully.';
        end;
    end;

    [Scope('Personalization')]
    procedure CancelFuelRequisitionApprovalRequest("DocumentNo.": Code[20]) ReturnValue: Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ReturnValue := '400: An Error Occurred, Please Contact Admin.';

        FuelRequisition.Reset;
        FuelRequisition.SetRange("Filling No", "DocumentNo.");
        if FuelRequisition.FindFirst then begin
            ApprovalsMgmt.OnCancelVehicleFillingApprovalRequest(FuelRequisition); //OnCancelFuelRequestApprovalRequest(FuelRequisition);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", FuelRequisition."Filling No");
            if ApprovalEntry.FindLast then begin
                if ApprovalEntry.Status = ApprovalEntry.Status::Canceled then
                    ReturnValue := '200: Record Cancelled Successfully.';
            end;
        end;
    end;

    procedure ReopenFuelRequisition("DocumentNo.": Code[20]) ReturnValue: Text
    begin
        ReturnValue := '400: An Error Occurred, Please Contact Admin.';

        FuelRequisition.Reset;
        FuelRequisition.SetRange(FuelRequisition."Filling No", "DocumentNo.");
        if FuelRequisition.FindFirst then begin
            // FleetApprovalManager.re(VehicleRequisition);
            //ReturnValue:=TRUE;
        end;
    end;

    [Scope('Personalization')]





    procedure GetFuelReqEmployeeApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; EmployeeNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::"HR Document");//"Vehicle Filling");
        if EmployeeNo <> '' then begin
            Employee.Get(EmployeeNo);
            Employee.TestField("User ID");
            ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure GetFuelRequistionApprovalEntries(var ApprovalEntries: XMLport "Approval Entries"; HeaderNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        Employee: Record Employee;
    begin
        ApprovalEntry.Reset;
        //ApprovalEntry.SetRange("Document Type",ApprovalEntry."Document Type"::"HR Document");
        if HeaderNo <> '' then begin
            ApprovalEntry.SetRange("Document No.", HeaderNo);
        end;
        if ApprovalEntry.FindFirst then;
        ApprovalEntries.SetTableView(ApprovalEntry);
    end;

    [Scope('Personalization')]
    procedure ApproveFuelRequisition("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Text
    var
        "EntryNo.": Integer;
        ApprovalEntry: Record "Approval Entry";
    begin

        Approved := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.ApproveApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);

        if ApprovalEntry.FindFirst then
            Approved := '200: Fuel Requisition Approved Successfully '
        else
            Approved := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure RejectFuelRequisition("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Text
    var
        "EntryNo.": Integer;
        ApprovalEntry: Record "Approval Entry";
    begin
        Rejected := '';
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalEntry."Web Portal Approval" := true;
            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify;
            ApprovalsMgmtMain.RejectApprovalRequests(ApprovalEntry);
        end;
        Commit;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Entry No.", "EntryNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindFirst then
            Rejected := '200: Fuel Requisition Rejected Successfully '
        else
            Rejected := '400:' + GetLastErrorCode + '-' + GetLastErrorText;


        //**************************************** HR Leave Reimbursement ********************************************************************************************************************************************************
    end;

    [Scope('Personalization')]
    procedure GetFuelRequisition(var FuelRequisitionExport: XMLport "Fuel Requisition  Export"; "DocumentNo.": Code[20])
    begin
        if "DocumentNo." <> '' then begin
            FuelRequisition.Reset;
            FuelRequisition.SetRange("Filling No", "DocumentNo.");
            if FuelRequisition.FindFirst then;
            FuelRequisitionExport.SetTableView(FuelRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure CreateRepairOrder("EmployeeNo.": Code[20]; "Supplier No": Text; VehicleNo: Text; VehicleType: Option " ","Motor Vehicle","Motor Cycle"; WNO: Code[20]; TotalAmount: Decimal) "VehicleRequisitionNo.": Text
    var
        "DocNo.": Code[20];
    begin
        "VehicleRequisitionNo." := '';

        FleetGeneralSetup.Reset;
        FleetGeneralSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        "DocNo." := '';
        "DocNo." := NoSeriesMgt.GetNextNo(FleetGeneralSetup."Repair Order Nos", 0D, true);

        //HumanResSetup.TESTFIELD(HumanResSetup."Repair Order Nos");
        //NoSeriesMgt.InitSeries(HumanResSetup."Repair Order Nos",xRec."No. Series",0D,"Request No.","No. Series");
        if "DocNo." <> '' then begin
            VehicleRequisition.Init;
            VehicleRequisition."Request No." := "DocNo.";
            VehicleRequisition."No." := "DocNo.";
            VehicleRequisition."Request Date" := Today;
            VehicleRequisition."Repair Order" := true;
            VehicleRequisition."No. Series" := FleetGeneralSetup."Repair Order Nos";
            VehicleRequisition."Employee No." := "EmployeeNo.";
            VehicleRequisition.Validate("Employee No.");
            VehicleRequisition."Vehicle No" := VehicleNo;
            VehicleRequisition."Document Type" := VehicleRequisition."Document Type"::"Repair Order";
            VehicleRequisition."Vehicle Name" := WNO;
            VehicleRequisition."Motor Vehicle/Motor Cycle" := VehicleType;
            VehicleRequisition.Validate("Supplier No", "Supplier No");
            VehicleRequisition."Total Amount" := TotalAmount;

            if VehicleRequisition.Insert then begin
                "VehicleRequisitionNo." := '200: Transport requisition no ' + "DocNo." + ' successfully';
            end
            else
                "VehicleRequisitionNo." := '400: ' + GetLastErrorCode + ':' + GetLastErrorText;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyRepairOrder(No: Code[20]; "EmployeeNo.": Code[20]; "Supplier No": Text; VehicleNo: Text; VehicleType: Option " ","Motor Vehicle","Motor Cycle"; WNO: Code[20]; TotalAmount: Decimal) VehicleRequisitionModified: Text
    begin
        VehicleRequisitionModified := '';

        FleetGeneralSetup.Reset;
        FleetGeneralSetup.Get;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        VehicleRequisition.Reset;
        VehicleRequisition.SetRange(VehicleRequisition."Request No.", No);
        if VehicleRequisition.FindFirst then begin
            VehicleRequisition."Request No." := No;
            VehicleRequisition."Employee No." := "EmployeeNo.";
            VehicleRequisition."Vehicle No" := VehicleNo;
            VehicleRequisition."Vehicle Name" := WNO;
            VehicleRequisition."Motor Vehicle/Motor Cycle" := VehicleType;
            VehicleRequisition."Total Amount" := TotalAmount;

            if VehicleRequisition.Modify then
                VehicleRequisitionModified := '200: Transport Requisition  modified successfully'
            else
                VehicleRequisitionModified := '400: ' + GetLastErrorCode + ':' + GetLastErrorText;
        end else
            VehicleRequisitionModified := '400: Transport Requisition does not exist'
    end;

    [Scope('Personalization')]
    procedure GetRepairOrderList(var TransportrequisitionExport: XMLport "Transport requisition Export"; EmployeeNo: Code[20])
    begin
        if EmployeeNo <> '' then begin
            VehicleRequisition.Reset;
            VehicleRequisition.SetFilter("Employee No.", EmployeeNo);
            VehicleRequisition.SetRange("Document Type", VehicleRequisition."Document Type"::"Repair Order");
            if VehicleRequisition.FindFirst then;
            TransportrequisitionExport.SetTableView(VehicleRequisition);
        end
    end;

    [Scope('Personalization')]
    procedure CreateRepairOrderLine(TransReqCode: Code[20]; Description: Code[250]; Quantity: Decimal; PricePerUnit: Decimal; Amount: Decimal) CreatedMsg: Text
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Init;
        TravellingEmployeeRec."Request No." := TransReqCode;
        TravellingEmployeeRec.Quantity := Quantity;
        TravellingEmployeeRec.Description := Description;
        TravellingEmployeeRec."Price per Unit" := PricePerUnit;
        TravellingEmployeeRec.Amount := Amount;
        if TravellingEmployeeRec.Insert then
            CreatedMsg := 'Line created successfully'
        else
            CreatedMsg := GetLastErrorCode + '-' + GetLastErrorText;
        ;
    end;

    [Scope('Personalization')]
    procedure ModifyRepairOrderLine(LineNo: Integer; TransReqCode: Code[20]; Description: Code[20]; Quantity: Decimal; PricePerUnit: Decimal; Amount: Decimal) LineModified: Boolean
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Reset;
        TravellingEmployeeRec.SetRange("Request No.", TransReqCode);
        TravellingEmployeeRec.SetRange("Line No", LineNo);
        if TravellingEmployeeRec.FindFirst then begin
            TravellingEmployeeRec.Quantity := Quantity;
            TravellingEmployeeRec.Description := Description;
            TravellingEmployeeRec."Price per Unit" := PricePerUnit;
            TravellingEmployeeRec.Amount := Amount;
            if TravellingEmployeeRec.Modify then
                LineModified := true
            else
                LineModified := false;
        end;
    end;

    [Scope('Personalization')]
    procedure DeleteRepairOrderLine(TransReqCode: Code[20]; LineNo: Integer) LineDeleted: Boolean
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Reset;
        TravellingEmployeeRec.SetRange("Request No.", TransReqCode);
        TravellingEmployeeRec.SetRange("Line No", LineNo);
        if TravellingEmployeeRec.FindFirst then
            if TravellingEmployeeRec.Delete then
                LineDeleted := true
            else
                LineDeleted := false;
    end;

    [Scope('Personalization')]
    procedure GetRepairOrderLine(RequestNo: Code[20]; var ImportExportTravellingEmp: XMLport "Import/Export Travelling Emp")
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Reset;
        TravellingEmployeeRec.SetRange("Request No.", RequestNo);
        if TravellingEmployeeRec.FindFirst then;
        ImportExportTravellingEmp.SetTableView(TravellingEmployeeRec);
    end;

    [Scope('Personalization')]
    procedure GetTravellingEmployee(RequestNo: Code[20]; var ImportExportTravellingEmp: XMLport "Import/Export Travelling Emp")
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
        TravellingEmployeeRec.Reset;
        TravellingEmployeeRec.SetRange("Request No.", RequestNo);
        if TravellingEmployeeRec.FindFirst then;
        ImportExportTravellingEmp.SetTableView(TravellingEmployeeRec);
    end;

    [Scope('Personalization')]
    procedure GetSuppliers(var SupplierExport: XMLport "Supplier Export")
    var
        TravellingEmployeeRec: Record "Travelling Employee";
    begin
    end;

    [Scope('Personalization')]
    procedure CancelWorkticketApprovalRequest(WorkTicketNo: Code[20]) WorkTicketSent: Text
    var
        ApprovalEntry: Record "Approval Entry";
        WorkTicket: Record "Work Ticket";
    begin
        WorkTicketSent := '400: Not Found';

        WorkTicket.Reset;
        if WorkTicket.Get(WorkTicketNo) then begin
            ApprovalsMgmt.OnCancelWorkTicketApprovalRequest(WorkTicket);
            Commit;
            ApprovalEntry.Reset;
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", WorkTicketNo);
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Canceled);
            if ApprovalEntry.FindFirst then
                WorkTicketSent := '200: Cancelled Successfully';
        end;
    end;
}

