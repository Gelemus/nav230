page 50324 "Vehicel Allocation Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Transport Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Control1000000056; '')
                {
                    CaptionClass = Text19003756;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Request No."; Rec."Request No.")
                {
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        frmcalendar.SetDate("Trip Planned Start Date");
                        frmcalendar.RUNMODAL;
                        D := frmcalendar.GetDate;
                        CLEAR(frmcalendar);
                        IF D <> 0D THEN
                          "Trip Planned Start Date" := D;
                           */

                    end;
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        frmcalendar.SetDate("Trip Planned End Date");
                        frmcalendar.RUNMODAL;
                        D := frmcalendar.GetDate;
                        CLEAR(frmcalendar);
                        IF D <> 0D THEN
                          "Trip Planned End Date" := D;
                         */

                    end;
                }
                field("Type of Request"; Rec."Type of Request")
                {
                }
                field(Destination; Rec.Destination)
                {
                    Caption = 'Destination/Itinerary';
                    Editable = false;
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Caption = 'No. of Employees';
                    Editable = false;
                }
                field("No. of Non Employees"; Rec."No. of Non Employees")
                {
                    HideValue = false;
                    Visible = false;
                }
                field("Travel Details"; Rec."Travel Details")
                {
                }
                field("Allocate a Vehicle"; Rec."Allocate a Vehicle")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    Caption = 'Vehicle Allocated';
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    Editable = true;
                }
                field(Driver; Rec.Driver)
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    Editable = false;
                }
                field(Taxi; Rec.Taxi)
                {
                    Caption = 'Registration No. of Taxi';
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("Return Time"; Rec."Return Time")
                {
                }
                field(Cancelled; Rec.Cancelled)
                {
                }
            }
            part(Control1000000037; "Travelling Employees  Subform")
            {
                SubPageLink = "Request No." = FIELD("Request No.");
                SubPageView = SORTING("Request No.");
            }
            group("Travel Registration")
            {
                Caption = 'Travel Registration';
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Odometer Reading Before"; Rec."Odometer Reading Before")
                {
                }
                field("Return Date"; Rec."Return Date")
                {
                }
                field("Odometer Reading After"; Rec."Odometer Reading After")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transport)
            {
                Caption = 'Transport';
                action("CANCEL REQUEST")
                {
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Released then
                            Rec.Status := Rec.Status::Open;
                    end;
                }
                action("ALLOCATE  REQUEST")
                {
                    Caption = 'ALLOCATE REQUEST';
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Released then
                            Rec.Status := Rec.Status::Allocated;
                        Rec.Allocated := true;
                    end;
                }
                action("Complete Return")
                {
                    Caption = 'Complete Return';
                    Image = Completed;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Allocated);
                        Rec.TestField("Return Date");
                        Rec.TestField("Odometer Reading After");
                        if Confirm('Are you sure you want to Complete this Request?') then begin
                            Rec.Status := Rec.Status::Completed;
                            Rec.Modify;
                            Message('Return successfuly');
                        end;
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.SendTransportApprovalRequest(Rec) THEN;
                    end;
                }
                action("Procurement Requisition")
                {
                    Caption = 'Procurement Requisition';
                }
                action("Send Notifications")
                {
                    Caption = 'Send Notifications';
                    Visible = false;

                    trigger OnAction()
                    begin
                        DriverBody := 'This is to notify you that you are the assigned driver for a trip to '
                        + Rec.Destination + ' for ' + Rec."Reason for Travel" + ', Dates ' + Format(Rec."Trip Planned Start Date") + ' to ' + Format(Rec."Trip Planned End Date") +
                        ', from ' + Format(Rec."Start Time") + ' to ' + Format(Rec."Return Time");

                        EmployeeBody := 'This is to notify you that you have been assigned driver ' + Rec."Driver Name" + ' and vehicle ' + Rec."Vehicle Allocated" + ' for the trip to '
                        + Rec.Destination + ' for ' + Rec."Reason for Travel" + ', Dates ' + Format(Rec."Trip Planned Start Date") + ' to ' + Format(Rec."Trip Planned End Date") +
                        ', from ' + Format(Rec."Start Time") + ' to ' + Format(Rec."Return Time");


                        EmployeeRec.Reset;
                        if EmployeeRec.Get(Rec.Driver) then begin

                            if EmployeeRec."E-Mail" = '' then begin

                                UserSetup.Reset;
                                UserSetup.SetRange(UserSetup."Employee No", EmployeeRec."No.");
                                if UserSetup.Find('-') then
                                    DriverEmail := UserSetup."E-Mail";
                            end else
                                DriverEmail := EmployeeRec."E-Mail";

                            //Mail.NewIncidentMail(DriverEmail,"Request No.",DriverBody);

                            //Mail.NewMessage(DriverEmail,'',"Request No.",DriverBody,'',FALSE);

                        end;

                        TravellingEmployees.Reset;
                        TravellingEmployees.SetRange(TravellingEmployees."Request No.", Rec."Request No.");
                        if TravellingEmployees.Find('-') then begin
                            repeat
                                EmployeeRec.Reset;
                                if EmployeeRec.Get(TravellingEmployees."Employee No.") then begin

                                    if EmployeeRec."E-Mail" = '' then begin

                                        UserSetup.Reset;
                                        UserSetup.SetRange(UserSetup."Employee No", EmployeeRec."No.");
                                        if UserSetup.Find('-') then
                                            EmployeeEmail := UserSetup."E-Mail";
                                    end else
                                        EmployeeEmail := EmployeeRec."E-Mail";

                                    //Mail.NewIncidentMail(EmployeeEmail,"Request No.",EmployeeBody);

                                    //Mail.NewMessage(EmployeeEmail,'',"Request No.",EmployeeBody,'',FALSE);

                                end;

                            until TravellingEmployees.Next = 0;
                        end;
                    end;
                }
            }
        }
    }

    var
        D: Date;
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        RequisitionHeader: Record "Purchase Requisitions";
        Text19003756: Label 'For Official Use Only';
        Mail: Codeunit Mail;
        EmployeeRec: Record Employee;
        TravellingEmployees: Record "Travelling Employee";
        DriverBody: Text;
        EmployeeBody: Text;
        UserSetup: Record "User Setup";
        DriverEmail: Text;
        EmployeeEmail: Text;
}

