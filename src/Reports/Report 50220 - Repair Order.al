report 50220 "Repair Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Repair Order.rdl';

    dataset
    {
        dataitem("Transport Request"; "Transport Request")
        {
            column(SupplierNo_TransportRequest; "Transport Request"."Supplier No")
            {
            }
            column(SupplierName_TransportRequest; "Transport Request"."Supplier Name")
            {
            }
            column(SupplierAddress_TransportRequest; "Transport Request"."Supplier Address")
            {
            }
            column(VehicleNo_TransportRequest; "Transport Request"."Vehicle No")
            {
            }
            column(WNO_TransportRequest; "Transport Request"."Vehicle Name")
            {
            }
            column(JobNo_TransportRequest; "Transport Request"."Job No")
            {
            }
            column(MotorVehicleMotorCycle_TransportRequest; "Transport Request"."Motor Vehicle/Motor Cycle")
            {
            }
            column(GlobalDimension1Code_TransportRequest; "Transport Request"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_TransportRequest; "Transport Request"."Global Dimension 2 Code")
            {
            }
            column(RequestNo_TransportRequest; "Transport Request"."Request No.")
            {
            }
            column(RequestDate_TransportRequest; "Transport Request"."Request Date")
            {
            }
            column(RequestID_TransportRequest; "Transport Request"."Request ID")
            {
            }
            column(EmployeeNo_TransportRequest; "Transport Request"."Employee No.")
            {
            }
            column(EmployeeName_TransportRequest; "Transport Request"."Employee Name")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(CheckedBy; CheckedBy)
            {
            }
            column(AuthorisedBy; AuthorizedBy)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(CompanyWebPage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEmail2_; CompanyInfo."E-Mail 2")
            {
            }
            dataitem("Travelling Employee"; "Travelling Employee")
            {
                DataItemLink = "Request No." = FIELD("Request No.");
                column(RequestNo_TravellingEmployee; "Travelling Employee"."Request No.")
                {
                }
                column(Description_TravellingEmployee; "Travelling Employee".Description)
                {
                }
                column(Quantity_TravellingEmployee; "Travelling Employee".Quantity)
                {
                }
                column(PriceperUnit_TravellingEmployee; "Travelling Employee"."Price per Unit")
                {
                }
                column(Amount_TravellingEmployee; "Travelling Employee".Amount)
                {
                }
                column(LineNo_TravellingEmployee; "Travelling Employee"."Line No")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Request No.");
                DataItemTableView = WHERE(Status = FILTER(Approved));
                column(SequenceNo; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID; "Approval Entry"."Approver ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID; "Approval Entry"."Sender ID")
                {
                }
                column(ShowPreparedBy_; ShowPreparedBy)
                {
                }
                column(ApprovedByCaption_; ApprovedByCaption)
                {
                }
                column(PreparedByCaption_; PreparedByCaption)
                {
                }
                column(PreparedDate; PreparedDate)
                {
                }
                column(UserSetupRec_SignatureI_; UserSetupRecI.Signature)
                {
                }
                column(UserSetupRec_Signature_; UserSetupRec.Signature)
                {
                }
                column(EmployeeSignature2; TenantMedia.Content)
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(FirstName_Employee; Employee."First Name")
                    {
                    }
                    column(MiddleName_Employee; Employee."Middle Name")
                    {
                    }
                    column(LastName_Employee; Employee."Last Name")
                    {
                    }
                    column(EmployeeSignature; Employee."Employee Signature")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    if i = 1 then begin
                        ShowPreparedBy := true;
                        PreparedDate := "Approval Entry"."Date-Time Sent for Approval";
                        EmployeeRecI.Reset;
                        EmployeeRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if EmployeeRecI.FindFirst then begin
                            PreparedByCaption := 'Prepared By: ' + ' ' + EmployeeRecI."First Name" + ' ' + EmployeeRecI."Last Name";

                            TenantMedia.Reset;
                            if EmployeeRecI."Employee Signature".HasValue then begin
                                TenantMedia.Get(EmployeeRecI."Employee Signature".MediaId);
                                TenantMedia.CalcFields(Content);
                            end;

                        end;
                        UserSetupRec.Reset;

                        UserSetupRecI.SetRange("User ID", "Approval Entry"."Sender ID");
                        if UserSetupRecI.FindFirst then
                            UserSetupRecI.CalcFields(Signature);

                        ApprovedByCaption := 'Confirmed By: ';

                        UserSetupRec.Reset;

                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);

                    end
                    else
                        ShowPreparedBy := false;
                    if i = 2 then begin
                        ApprovedByCaption := 'Verified By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 3 then begin
                        ApprovedByCaption := 'Authorized By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end
                    else if i = 4 then begin
                        ApprovedByCaption := 'Approved By:  ';
                        UserSetupRec.Reset;
                        UserSetupRec.SetRange("User ID", "Approval Entry"."Approver ID");
                        if UserSetupRec.FindFirst then
                            UserSetupRec.CalcFields(Signature);
                    end;
                end;
            }
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        NumberText: array[2] of Text[80];
        CompanyInfo: Record "Company Information";
        PreparedBy: Text;
        CheckedBy: Text;
        AuthorizedBy: Text;
        User: Record User;
        i: Integer;
        ShowPreparedBy: Boolean;
        PreparedByCaption: Text;
        ApprovedByCaption: Text;
        UserSetupRec: Record "User Setup";
        UserSetupRecI: Record "User Setup";
        PreparedDate: DateTime;
        EmployeeRecI: Record Employee;
        TenantMedia: Record "Tenant Media";
}

