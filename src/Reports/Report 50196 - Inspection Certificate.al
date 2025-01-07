report 50196 "Inspection Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Inspection Certificate.rdl';

    dataset
    {
        dataitem("Inspection Header"; "Inspection Header")
        {
            RequestFilterFields = "Inspection No", "Order No";
            column(TenderNo_InspectionHeader; "Inspection Header"."Tender No")
            {
            }
            column(TenderName_InspectionHeader; "Inspection Header"."Tender Name")
            {
            }
            column(OrderNo_InspectionHeader; "Inspection Header"."Order No")
            {
            }
            column(Conclusion_InspectionHeader; "Inspection Header".Conclusion)
            {
            }
            column(Preparedby_InspectionHeader; "Inspection Header"."Prepared by")
            {
            }
            column(ContractDeliveryDueDate_InspectionHeader; "Inspection Header"."Contract Delivery Due Date")
            {
            }
            column(ContractTitle_InspectionHeader; "Inspection Header"."Contract Title")
            {
            }
            column(Valueofcontract_InspectionHeader; "Inspection Header"."Value of contract")
            {
            }
            column(ProcuringDepartment_InspectionHeader; "Inspection Header"."Procuring Department Name")
            {
            }
            column(RequisitionedBy_InspectionHeader; "Inspection Header"."Requisitioned By")
            {
            }
            column(RequisitionedByName_InspectionHeader; "Inspection Header"."Requisitioned By Name")
            {
            }
            column(RefNo_InspectionHeader; "Inspection Header"."Ref No")
            {
            }
            column(RefNoFromAppointmentLetter_InspectionHeader; "Inspection Header"."Ref No From Appointment Letter")
            {
            }
            column(DateofAppointmentLetter_InspectionHeader; "Inspection Header"."Date of Appointment Letter")
            {
            }
            column(DateofContract_InspectionHeader; "Inspection Header"."Date of Contract")
            {
            }
            column(ActualDeliveryDate_InspectionHeader; "Inspection Header"."Actual Delivery Date")
            {
            }
            column(PatricularsoftheInvoice_InspectionHeader; "Inspection Header"."Patriculars of the Invoice")
            {
            }
            column(RequisitionNo_InspectionHeader; "Inspection Header"."Requisition No")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(Address2; CompInfo."Address 2")
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(Phone; CompInfo."Phone No.")
            {
            }
            column(Fax; CompInfo."Fax No.")
            {
            }
            column(Accepted_InspectionHeader1; "Inspection Header".Accepted)
            {
            }
            column(Rejected_InspectionHeader1; "Inspection Header".Rejected)
            {
            }
            column(Inspection_Header1__Inspection_Header1___Inspection_No_; "Inspection Header"."Inspection No")
            {
            }
            column(Inspection_Header1__Order_No_; "Order No")
            {
            }
            column(Inspection_Header1__Supplier_Name_; "Supplier Name")
            {
            }
            column(InspectionDate_InspectionHeader; "Inspection Header"."Inspection Date")
            {
            }
            column(Dept; Dept)
            {
            }
            column(InvoiceNo; InvoiceNo)
            {
            }
            column(V1stapprover_; "1stapprover")
            {
            }
            column(UserRecApp1_Picture; UserRecApp1."Employee No")
            {
            }
            column(UserRecApp2_Picture; UserRecApp2."Employee No")
            {
            }
            column(V2ndapprover_; "2ndapprover")
            {
            }
            column(UserRecApp3_Picture; UserRecApp3."Employee No")
            {
            }
            column(V3rdapprover_; "3rdapprover")
            {
            }
            column(V2ndapproverdate_; "2ndapproverdate")
            {
            }
            column(V1stapproverdate_; "1stapproverdate")
            {
            }
            column(V3rdapproverdate_; "3rdapproverdate")
            {
            }
            column(UserRecApp4_Picture; UserRecApp4."Employee No")
            {
            }
            column(V4thapprover_; "4thapprover")
            {
            }
            column(V4thapproverdate_; "4thapproverdate")
            {
            }
            column(UserRecApp5_Picture; UserRecApp5."Employee No")
            {
            }
            column(V5thapprover_; "5thapprover")
            {
            }
            column(V5thapproverdate_; "5thapproverdate")
            {
            }
            column(INSPECTION_AND_ACCEPTANCE_COMMITTEE__IAC__REPORTCaption; INSPECTION_AND_ACCEPTANCE_COMMITTEE__IAC__REPORTCaptionLbl)
            {
            }
            column(INSPECTION_NOCaption; INSPECTION_NOCaptionLbl)
            {
            }
            column(Inspection_Header1__Order_No_Caption; OrderNoCaptionLbl)
            {
            }
            column(Inspection_Header1__Supplier_Name_Caption; SupplierCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(Invoice_NoCaption; Invoice_NoCaptionLbl)
            {
            }
            column(Officer_In_Charge_of_stores_Name_and_Signature_Caption; Officer_In_Charge_of_stores_Name_and_Signature_CaptionLbl)
            {
            }
            column(User_Department__Name___Signature_Caption; User_Department__Name___Signature_CaptionLbl)
            {
            }
            column(Committee_Member__Name___Signature_Caption; Committee_Member__Name___Signature_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(DateCaption_Control1000000061; DateCaption_Control1000000061Lbl)
            {
            }
            column(DateCaption_Control1000000062; DateCaption_Control1000000062Lbl)
            {
            }
            column(Committee_Member__Name___Signature_Caption_Control1000000067; Committee_Member__Name___Signature_Caption_Control1000000067Lbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Chairman__Name___Signature_Caption; Chairman__Name___Signature_CaptionLbl)
            {
            }
            column(CertificationCaption; Text001)
            {
            }
            column(DescriptionCaption; Text002)
            {
            }
            column(Date_Caption_Control1000000013; Date_Caption_Control1000000013Lbl)
            {
            }
            column(DeliveryNo_InspectionHeader; "Inspection Header"."Delivery No")
            {
            }
            column(RejectionReason_InspectionHeader; "Inspection Header"."Rejection Reason")
            {
            }
            column(DeliveryNoteCaption; DeliveryNoteCaptionLbl)
            {
            }
            column(PostedByName; PostedByName)
            {
            }
            dataitem("Inspection Line"; "Inspection Line")
            {
                DataItemLink = "Inspection No" = FIELD("Inspection No");
                DataItemTableView = SORTING("Inspection No", "Line No");
                column(SpecificationinBrief_InspectionLine; "Inspection Line"."Specification in Brief")
                {
                }
                column(Score_InspectionLine; "Inspection Line"."Quantity Accepted")
                {
                }
                column(Remarks_InspectionLine; "Inspection Line".Remarks)
                {
                }
                column(Inspection_Lines1_Description; Description)
                {
                }
                column(Inspection_Lines1__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Inspection_Lines1__Quantity_Ordered_; "Quantity Ordered")
                {
                }
                column(Inspection_Lines1__Inspection_Decision_; "Inspection Decision")
                {
                }
                column(Inspection_Lines1__Inspection_Lines1___Reasons_for_Rejection_; "Inspection Line"."Reasons for Rejection")
                {
                }
                column(QTYCaption; QTYCaptionLbl)
                {
                }
                column(STATUSCaption; STATUSCaptionLbl)
                {
                }
                column(UNITCaption; UNITCaptionLbl)
                {
                }
                column(ITEM_DESCRIPTIONCaption; ITEM_DESCRIPTIONCaptionLbl)
                {
                }
                column(NOCaption; NOCaptionLbl)
                {
                }
                column(REASONSCaption; REASONSCaptionLbl)
                {
                }
                column(Inspection_Lines1_Inspection_No; "Inspection No")
                {
                }
                column(Inspection_Lines1_Line_No; "Line No")
                {
                }
                column(ItemNo; ItemNo)
                {
                }
                column(QuantityReceived_InspectionLines; "Inspection Line"."Quantity Received")
                {
                }
                column(QuantityRejected_InspectionLines; "Inspection Line"."Quantity Rejected")
                {
                }
                column(QuantityAccepted_InspectionLines; "Inspection Line"."Quantity Accepted")
                {
                }
                column(ItemNo_InspectionLines; "Inspection Line"."Item No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ItemNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    ItemNo := 0;
                end;
            }
            dataitem("Commitee Members"; "Commitee Members")
            {
                DataItemLink = "Appointment No" = FIELD("Inspection No");
                column(Commitee_CommiteeMembers; "Commitee Members".Commitee)
                {
                }
                column(EmployeeNo_CommiteeMembers; "Commitee Members"."Employee No")
                {
                }
                column(Name_CommiteeMembers; "Commitee Members".Name)
                {
                }
                column(AppointmentNo_CommiteeMembers; "Commitee Members"."Appointment No")
                {
                }
                column(Chair_CommiteeMembers; "Commitee Members".Chair)
                {
                }
                column(Secretary_CommiteeMembers; "Commitee Members".Secretary)
                {
                }
                column(Comments_CommiteeMembers; "Commitee Members".Comments)
                {
                }
                dataitem(Employee; Employee)
                {
                    DataItemLink = "No." = FIELD("Employee No");
                    column(ApproverBySignature; TenantMedia1.Content)
                    {
                    }
                    column(Comment; "Approval Comment")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Employee.Reset;
                        Employee.SetRange(Employee."No.", "Commitee Members"."Employee No");
                        "Commitee Members".SetRange("Commitee Members"."Appointment No", "Inspection Header"."Inspection No");
                        TenantMedia1.Reset;
                        if Employee."Employee Signature".HasValue then begin
                            TenantMedia1.Get(Employee."Employee Signature".MediaId);
                            TenantMedia1.CalcFields(Content);
                        end;
                        ApprovalCommentLine.Reset;
                        ApprovalCommentLine.SetRange(ApprovalCommentLine."Document No.", "Inspection Header"."Inspection No");
                        ApprovalCommentLine.SetRange(ApprovalCommentLine."User ID", EmployeeRec."User ID");
                        if ApprovalCommentLine.FindSet then begin
                            "Approval Comment" := ApprovalCommentLine.Comment;
                        end;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                GLSetup.Get;
                CompInfo.Get;
                //"Inspection Header1".CALCFIELDS(Amount);
                CompInfo.CalcFields(Picture);
                if PurchHeader.Get(PurchHeader."Document Type"::Order, "Inspection Header"."Order No") then begin
                    if DimValue.Get(GLSetup."Global Dimension 1 Code", PurchHeader."Shortcut Dimension 1 Code") then
                        Dept := DimValue.Name;
                    InvoiceNo := PurchHeader."Vendor Invoice No.";
                end;

                //Approvals
                ApprovalEntries.Reset;
                //ApprovalEntries.SETRANGE(ApprovalEntries."Table ID",51511124);
                ApprovalEntries.SetRange(ApprovalEntries."Document No.", "Inspection Header"."Inspection No");
                ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);

                if ApprovalEntries.Find('-') then begin
                    i := 0;
                    repeat
                        i := i + 1;
                        if i = 1 then begin
                            "1stapprover" := ApprovalEntries."Approver ID";
                            "1stapproverdate" := ApprovalEntries."Date-Time Sent for Approval";
                            if UserRecApp1.Get("1stapprover") then
                                UserRecApp1.CalcFields(Signature);
                        end;
                        if i = 2 then begin
                            "2ndapprover" := ApprovalEntries."Approver ID";
                            "2ndapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp2.Get("2ndapprover") then
                                UserRecApp2.CalcFields(Signature);
                        end;
                        if i = 3 then begin
                            "3rdapprover" := ApprovalEntries."Approver ID";
                            "3rdapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp3.Get("3rdapprover") then
                                UserRecApp3.CalcFields(Signature);
                        end;
                        if i = 4 then begin
                            "4thapprover" := ApprovalEntries."Approver ID";
                            "4thapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp4.Get("4thapprover") then
                                UserRecApp4.CalcFields(Signature);
                        end;
                        if i = 5 then begin
                            "5thapprover" := ApprovalEntries."Approver ID";
                            "5thapproverdate" := ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp5.Get("5thapprover") then
                                UserRecApp5.CalcFields(Signature);
                        end;

                    until
                     ApprovalEntries.Next = 0;
                end;


                if Status = Status::Released then
                    Accepted := true;

                if Status = Status::Rejected then
                    Rejected := true;
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
        CompInfo: Record "Company Information";
        PurchHeader: Record "Purchase Header";
        DimValue: Record "Dimension Value";
        Dept: Text[100];
        GLSetup: Record "General Ledger Setup";
        ApprovalEntries: Record "Approval Entry";
        "1stapprover": Code[20];
        "1stapproverdate": DateTime;
        UserRecApp1: Record "User Setup";
        i: Integer;
        "2ndapprover": Code[20];
        "2ndapproverdate": DateTime;
        UserRecApp2: Record "User Setup";
        "3rdapprover": Code[20];
        "3rdapproverdate": DateTime;
        UserRecApp3: Record "User Setup";
        "4thapprover": Code[20];
        "4thapproverdate": DateTime;
        UserRecApp4: Record "User Setup";
        "5thapprover": Code[20];
        "5thapproverdate": DateTime;
        UserRecApp5: Record "User Setup";
        InvoiceNo: Code[20];
        INSPECTION_AND_ACCEPTANCE_COMMITTEE__IAC__REPORTCaptionLbl: Label 'GOODS/SERVICES INSPECTION REPORT';
        INSPECTION_NOCaptionLbl: Label 'INSPECTION NO';
        DepartmentCaptionLbl: Label 'DEPARTMENT:';
        Invoice_NoCaptionLbl: Label 'INVOICE';
        Officer_In_Charge_of_stores_Name_and_Signature_CaptionLbl: Label 'Officer In-Charge of stores(Name and Signature)';
        User_Department__Name___Signature_CaptionLbl: Label 'User Department (Name & Signature)';
        Committee_Member__Name___Signature_CaptionLbl: Label 'Committee Member (Name & Signature)';
        DateCaptionLbl: Label 'Date';
        DateCaption_Control1000000061Lbl: Label 'Date';
        DateCaption_Control1000000062Lbl: Label 'Date';
        Committee_Member__Name___Signature_Caption_Control1000000067Lbl: Label 'Committee Member (Name & Signature)';
        Date_CaptionLbl: Label 'Date ';
        Chairman__Name___Signature_CaptionLbl: Label 'Chairman (Name & Signature)';
        Date_Caption_Control1000000013Lbl: Label 'Date ';
        QTYCaptionLbl: Label 'QUANTITY';
        STATUSCaptionLbl: Label 'STATUS';
        UNITCaptionLbl: Label 'UNIT OF MEASURE';
        ITEM_DESCRIPTIONCaptionLbl: Label 'ITEM DESCRIPTION';
        NOCaptionLbl: Label 'No';
        REASONSCaptionLbl: Label 'REASONS';
        SupplierCaptionLbl: Label 'SUPPLIER:';
        OrderNoCaptionLbl: Label 'LPO/LSO NO';
        Text001: Label 'This is to certify that the following goods/services/works have been inspected, verified/tested and:';
        Text002: Label 'Description of goods/service/works';
        Accepted: Label 'Accepted';
        Rejected: Label 'Rejected';
        DeliveryNoteCaptionLbl: Label 'Delivery Note No';
        ItemNo: Integer;
        signature: Code[10];
        TenantMedia1: Record "Tenant Media";
        HREmployee: Record Employee;
        HrEmployeeName: Text;
        ApproverName: Text;
        PostedByName: Text;
        "Approval Comment": Text;
        ApprovalCommentLine: Record "Approval Comment Line";
        EmployeeRec: Record Employee;
}

