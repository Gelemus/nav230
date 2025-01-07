report 50053 "Store Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Store Requisition.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type");
            RequestFilterFields = "Document Type";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            
            column(USERID; UserId)
            {
            }
            column(Store_Requistion_Header__Required_Date_; "Purchase Header"."Posting Date")
            {
            }
            column(Store_Requistion_Header__Request_date_; "Purchase Header"."Posting Date")
            {
            }
            column(Store_Requistion_Header__Request_Description_; "Purchase Header"."Posting Description")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Store_Requistion_Header__No__; "No.")
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_; "Shortcut Dimension 1 Code")
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755048; UserId)
            {
            }
            column(Store_RequistionCaption; Store_RequistionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Store_Requistion_Lines_DescriptionCaption; "Purchase Header"."Posting Description")
            {
            }
            column(UoMCaption; UoMCaptionLbl)
            {
            }
            column(Store_Requistion_Header__Required_Date_Caption; FieldCaption("Purchase Header"."Posting Date"))
            {
            }
            column(Store_Requistion_Lines__No__Caption; FieldCaption("No."))
            {
            }
            column(Store_Requistion_Header__Request_date_Caption; FieldCaption("Purchase Header"."Posting Date"))
            {
            }
            column(Store_Requistion_Header__Request_Description_Caption; FieldCaption("Posting Description"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_Caption; FieldCaption("Shortcut Dimension 2 Code"))
            {
            }
            column(Store_Requistion_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_Caption; FieldCaption("Shortcut Dimension 1 Code"))
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Name_Caption_Control1102755052; Name_Caption_Control1102755052Lbl)
            {
            }
            column(Date_Caption_Control1102755053; Date_Caption_Control1102755053Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(AuthorisationsCaption; AuthorisationsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption_Control1102755000; Signature_Caption_Control1102755000Lbl)
            {
            }
            column(DocHeader; DocHeader)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAdd; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAdd2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Store_Requistion_Lines__No__; "No.")
                {
                }
                column(Store_Requistion_Lines_Description; Description)
                {
                }
                column(Store_Requistion_Lines_Quantity; Quantity)
                {
                }
                column(Store_Requistion_Lines__Unit_of_Measure_; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(Store_Requistion_Lines__Line_Amount_; "Line Amount")
                {
                }
                column(Store_Requistion_Lines__Unit_Cost_; "Unit Cost")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if "Document Type" = "Document Type"::Order then
                    DocHeader := 'Staff Requisition'
                else
                    DocHeader := 'Store Requisition';

                /*IF Status = Status::"5" THEN BEGIN
                  IF "Document Type"="Document Type"::Order THEN
                   DocHeader:='Staff Grant Issue'
                  ELSE
                   DocHeader:='Store Issue'
                END*/

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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        DocHeader: Text;
        CompanyInfo: Record "Company Information";
        Store_RequistionCaptionLbl: Label 'Store Requistion';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        UoMCaptionLbl: Label 'UoM';
        Date_CaptionLbl: Label 'Date:';
        Name_CaptionLbl: Label 'Name:';
        RecipientCaptionLbl: Label 'Recipient';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Name_Caption_Control1102755052Lbl: Label 'Name:';
        Date_Caption_Control1102755053Lbl: Label 'Date:';
        Signature_CaptionLbl: Label 'Signature:';
        AuthorisationsCaptionLbl: Label 'Authorisations';
        EmptyStringCaptionLbl: Label '================================================================================================================================================================================================';
        Signature_Caption_Control1102755000Lbl: Label 'Signature:';
}

