codeunit 51155 "E Procurement Management WS"
{

    trigger OnRun()
    begin
        //MESSAGE(ReleasePurchaseQuoteHeader('QUOTEN0001'))
        //MESSAGE(CreateTenderPrequalification('','','','','','','','','','','',))
        //MESSAGE(CreateTenderEvaluations('TENDER0017',TODAY,'NWE0102'))
        //MESSAGE(AcceptOrRejectSupplierApplication('','TENDEV0288',0,'',''));
    end;

    var
        Text0001: Label 'You Have exceeded the Budget by ';
        Text0002: Label 'Do you want to Continue?';
        Text0003: Label 'There is no Budget to Check against do you wish to continue?';
        Text0004: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0005: Label 'The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3';
        Text0006: Label 'No Budget To Check Against';
        Text0007: Label 'Item Does not Exist';
        Text0008: Label 'Ensure Fixed Asset No %1 has the Maintenance G/L Account';
        Text0009: Label 'Ensure Fixed Asset No %1 has the Acquisition G/L Account';
        Text0010: Label 'No Budget To Check Against';
        Text0011: Label 'The Amount On Purchase Requisition No %1  %2 %3  Exceeds The Budget By %4';
        PurchaseRequisition: Record "Purchase Requisitions";
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        "Purchases&PayablesSetup": Record "Purchases & Payables Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ProcurementApprovalManager: Codeunit "Procurement Approval Manager";
        PurchaseRequisitions2: Record "Purchase Requisitions";
        ApprovalEntry: Record "Approval Entry";
        TenderLine: Record "Tender Lines";
        TenderHeader: Record "Tender Header";
        SupplierProfile: Record "Supplier Profile";
        TenderPrequalification: Record "Tender Lines";
        SupplierProfileDoc: Record "Supplier Profile Documents";
        RequestHeader: Record "Request for Quotation Header";
        RequestLines: Record "Request for Quotation Line";
        QuoteHeader: Record "Purchase Header";
        QuoteLines: Record "Purchase Line";
        TenderQuestions: Record "Tender Questions";
        TenderBankInfo: Record "Tender Bank Info";
        TenderDirectors: Record "Tender Directors";
        TenderAnswers: Record "Tender Answers";
        TenderPersonnel: Record "Tender Personnel";
        TenderExperience: Record "Tender Experience";
        TenderFinancialCapability: Record "Tender Financial Capability";
        TenderLitigation: Record "Tender Litigation";
        EvaluationCriteria: Record "Evaluation Criteria";
        TenderEvaluators: Record "Tender Evaluators";
        TenderEvaluationHeader: Record "Tender Evaluation";
        TenderEvaluationLine: Record "Tender Evaluation Line";
        QuoteStatus: Record "Purchase Header";
        LitigationQuestionsHeader: Record "Liigation Question Setup.";
        LitigationAnswersHeader: Record "Litigation Answer Setup";
        TenderEvaluationLineII: Record "Tender Evaluation Line";
        LineNo: Integer;
        Vendors: Record Vendor;

    [Scope('Personalization')]
    procedure GetTenderHeaderList(var TenderExport: XMLport "Tender Export"; TenderNo: Code[20]; DocumentType: Option " ","Registration of Supplier","Open Tender","Request for Proposal")
    var
        TenderHeader: Record "Tender Header";
    begin
        TenderHeader.Reset;
        //TenderHeader.SETRANGE("No.",TenderNo);
        if DocumentType = DocumentType::"Open Tender" then
            TenderHeader.SetRange("Document Type", DocumentType::"Open Tender")
        else if DocumentType = DocumentType::"Registration of Supplier" then
            TenderHeader.SetRange("Document Type", DocumentType::"Registration of Supplier")
        else if DocumentType = DocumentType::"Request for Proposal" then
            TenderHeader.SetRange("Document Type", DocumentType::"Request for Proposal");

        // TenderHeader.SETFILTER("Tender Status",'<>%1',TenderHeader."Tender Status"::"Tender Preparation");

        if TenderNo <> '' then
            TenderHeader.SetRange("No.", TenderNo);

        if TenderHeader.FindFirst then;
        TenderExport.SetTableView(TenderHeader);
    end;

    [Scope('Personalization')]
    procedure GetTenderLineList(var TenderLneExport: XMLport "Tender Line Export"; SupplierProfileID: Code[20])
    begin
        if SupplierProfileID <> '' then begin
            TenderLine.Reset;
            TenderLine.SetFilter("Document No.", SupplierProfileID);
            if TenderLine.FindFirst then;
            TenderLneExport.SetTableView(TenderLine);
        end
    end;

    [Scope('Personalization')]
    procedure CreateTenderHeader("TenderNo.": Code[20]; TenderDesc: Text; SpecialCondition: Text[100]; SpecialGroup: Option " ",Youth,Women,"Persons with Disability"; TypeofSupply: Option " ","Supply of Goods","Provision of Services","Provisions of Works"; FinancialYearStartDate: Date; FinancialYearEndDate: Date; TenderType: Option ,Open,Restricted; SupplierCategory: Code[100]; SupplierCatDesc: Text[200]; TenderSubmissionFrom: Date; TenderSubmissionTo: Date; TenderOpeningDate: Date; TenderOpeningTime: Time; TenderClosingDate: Date; TenderClosingTIme: Time; AwardDate: Date; TenderStatus: Option ,"Tender Preparation","Tender Opening","Tender Evaluation",Closed; ApprovalStatus: Option ,Open,"Pending Approval",Approved,Rejected; UserId: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        TenderHeader.Reset;

        "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Tender Doc No.", 0D, true);
        //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
        if "DocNo." <> '' then begin
            TenderHeader.Init;
            TenderHeader."No." := "DocNo.";
            TenderHeader."Tender No" := "TenderNo.";
            TenderHeader."Tender Description" := TenderDesc;
            TenderHeader."Special Condition" := SpecialCondition;
            TenderHeader."Special Group" := SpecialGroup;
            TenderHeader."Type of supply" := TypeofSupply;
            TenderHeader."Financial Year Start Date" := FinancialYearStartDate;
            TenderHeader."Financial Year End Date" := FinancialYearEndDate;
            TenderHeader.Eligibility := TenderType;
            TenderHeader."Supplier Category" := SupplierCategory;
            TenderHeader."Supplier Category Description" := SupplierCatDesc;
            TenderHeader."Tender Submission (From)" := TenderSubmissionFrom;
            TenderHeader."Tender Submission (To)" := TenderSubmissionTo;
            TenderHeader."Tender Opening Date" := TenderOpeningDate;
            TenderHeader."Tender Opening Time" := TenderOpeningTime;
            TenderHeader."Tender Closing Date" := TenderClosingDate;
            TenderHeader."Tender Closing Time" := TenderClosingTIme;
            TenderHeader."Award Date" := AwardDate;
            TenderHeader."Tender Status" := TenderStatus;
            TenderHeader.Status := ApprovalStatus;
            TenderHeader."User ID" := UserId;

            if TenderHeader.Insert then begin
                ReturnValue := '200: E-Procurement Tender No ' + "TenderNo." + ' Successfully Created';
                if TenderHeader."Tender Status" = TenderHeader."Tender Status"::"Tender Preparation" then begin
                    ReturnValue := '400: Tender Prequalification Already Exist';
                    exit;
                end
                else
                    ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
            end;
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyTenderHeader("DocNo.": Code[20]; "TenderNo.": Code[20]; TenderDesc: Text; SpecialCondition: Text[100]; SpecialGroup: Option " ",Youth,Women,"Persons with Disability"; TypeofSupply: Option " ","Supply of Goods","Provision of Services","Provisions of Works"; FinancialYearStartDate: Date; FinancialYearEndDate: Date; TenderType: Option Open,Restricted; SupplierCategory: Code[100]; SupplierCatDesc: Text[200]; TenderSubmissionFrom: Date; TenderSubmissionTo: Date; TenderOpeningDate: Date; TenderOpeningTime: Time; TenderClosingDate: Date; TenderClosingTIme: Time; AwardDate: Date; TenderStatus: Option "Tender Preparation","Tender Opening","Tender Evaluation",Closed; ApprovalStatus: Option Open,"Pending Approval",Approved,Rejected; UserId: Code[20]) TenderHeaderModified: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        TenderHeaderModified := '';
        TenderHeader.Reset;
        TenderHeader.SetRange(TenderHeader."No.", "DocNo.");
        if TenderHeader.FindFirst then begin
            TenderHeader."Tender No" := "TenderNo.";
            TenderHeader."Tender Description" := TenderDesc;
            TenderHeader."Special Condition" := SpecialCondition;
            TenderHeader."Special Group" := SpecialGroup;
            TenderHeader."Type of supply" := TypeofSupply;
            TenderHeader."Financial Year Start Date" := FinancialYearStartDate;
            TenderHeader."Financial Year End Date" := FinancialYearEndDate;
            TenderHeader.Eligibility := TenderType;
            TenderHeader."Supplier Category" := SupplierCategory;
            TenderHeader."Supplier Category Description" := SupplierCatDesc;
            TenderHeader."Tender Submission (From)" := TenderSubmissionFrom;
            TenderHeader."Tender Submission (To)" := TenderSubmissionTo;
            TenderHeader."Tender Opening Date" := TenderOpeningDate;
            TenderHeader."Tender Opening Time" := TenderOpeningTime;
            TenderHeader."Tender Closing Date" := TenderClosingDate;
            TenderHeader."Tender Closing Time" := TenderClosingTIme;
            TenderHeader."Award Date" := AwardDate;
            TenderHeader."Tender Status" := TenderStatus;
            TenderHeader.Status := ApprovalStatus;
            TenderHeader."User ID" := UserId;


            if TenderHeader.Modify then
                TenderHeaderModified := '200: E-Procurement Tender No ' + "TenderNo." + ' Successfully Modified';
            ;
        end;
    end;

    [Scope('Personalization')]
    procedure GetSupplierProfileList(var SupplierProfileExport: XMLport "Supplier Export")
    begin
    end;

    [Scope('Personalization')]
    procedure GetSupplierProfile(var SupplierProfileExport: XMLport "Supplier Export"; SupplierNo: Code[20])
    begin
        if SupplierNo <> '' then begin
            SupplierProfile.Reset;
            //SupplierProfile.SETFILTER(No,SupplierNo);
            SupplierProfile.SetRange(No, SupplierNo);
            if SupplierProfile.FindFirst then;
            SupplierProfileExport.SetTableView(SupplierProfile);

        end;
    end;

    [Scope('Personalization')]
    procedure CreateSupplierProfile(Name: Text; Telephone: Integer; CompanyName: Code[100]; PhysicalAddress: Text[250]; PostalAddress: Text[100]; Email: Code[100]; Website: Code[100]; LegalStatus: Code[100]; MaxBusinessValue: Integer; BusinessNature: Code[100]; KraPinCertNo: Text[100]; VatCertNo: Text[1000]; CompanyRegCertNo: Text[100]; BankersName: Code[100]; TradeTerms: Text[100]; Country: Code[100]; County: Code[100]; DateCreated: DateTime; DateUpdated: DateTime; UserId: Code[100]; SupplierProfileID: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        TenderHeader.Reset;

        //"DocNo.":=NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Supplier Nos",0D,TRUE);
        //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
        if SupplierProfileID <> 0 then begin
            SupplierProfile.Init;
            SupplierProfile.No := Format(SupplierProfileID);
            SupplierProfile."Supplier Name" := Name;
            SupplierProfile."Supplier Telephone" := Telephone;
            SupplierProfile."Supplier Company Name" := CompanyName;
            SupplierProfile."Supplier Physical Address" := PhysicalAddress;
            SupplierProfile."Supplier Postal Address" := PostalAddress;
            SupplierProfile."Supplier Email" := Email;
            SupplierProfile."Supplier Website" := Website;
            SupplierProfile."Supplier Legal Status" := LegalStatus;
            SupplierProfile."Supplier Telephone" := Telephone;
            SupplierProfile."Supplier Max Bussiness Value" := MaxBusinessValue;
            SupplierProfile."Supplier Business Nature" := BusinessNature;
            SupplierProfile."Supplier Kra Pin Cert No" := KraPinCertNo;
            SupplierProfile."Supplier Company Reg Cert No" := CompanyRegCertNo;
            SupplierProfile."Supplier Vat Cert No" := VatCertNo;
            SupplierProfile."Supplier Bankers Name" := BankersName;
            SupplierProfile."Supplier Trade Terms" := TradeTerms;
            SupplierProfile."Supplier Country" := Country;
            SupplierProfile."Supplier County" := County;
            SupplierProfile."Supplier Date Created" := DateCreated;
            SupplierProfile."Supplier Date Updated" := DateUpdated;
            SupplierProfile."Supplier Id" := UserId;
            if SupplierProfile.Insert then
                ReturnValue := '200: Record ' + SupplierProfile.No + ' Successfully Created'

            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure ModifySupplierProfile(No: Code[20]; Name: Text; Telephone: Integer; CompanyName: Code[100]; PhysicalAddress: Text[100]; PostalAddress: Text[100]; Email: Text[100]; Website: Code[100]; LegalStatus: Code[100]; MaxBusinessValue: Integer; BusinessNature: Code[100]; KraPinCertNo: Text[100]; VatCertNo: Text[100]; CompanyRegCertNo: Text[100]; BankersName: Code[100]; TradeTerms: Text[100]; Country: Code[100]; County: Code[100]; DateCreated: DateTime; DateUpdated: DateTime; UsrId: Code[100]) ReturnValue: Text
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        SupplierProfile.Reset;
        SupplierProfile.SetRange(SupplierProfile.No, No);
        if SupplierProfile.FindFirst then begin
            SupplierProfile."Supplier Name" := Name;
            SupplierProfile."Supplier Telephone" := Telephone;
            SupplierProfile."Supplier Company Name" := CompanyName;
            SupplierProfile."Supplier Physical Address" := PhysicalAddress;
            SupplierProfile."Supplier Postal Address" := PostalAddress;
            SupplierProfile."Supplier Email" := Email;
            SupplierProfile."Supplier Website" := Website;
            SupplierProfile."Supplier Legal Status" := LegalStatus;
            SupplierProfile."Supplier Telephone" := Telephone;
            SupplierProfile."Supplier Max Bussiness Value" := MaxBusinessValue;
            SupplierProfile."Supplier Business Nature" := BusinessNature;
            SupplierProfile."Supplier Kra Pin Cert No" := KraPinCertNo;
            SupplierProfile."Supplier Vat Cert No" := VatCertNo;
            SupplierProfile."Supplier Company Reg Cert No" := CompanyRegCertNo;
            SupplierProfile."Supplier Bankers Name" := BankersName;
            SupplierProfile."Supplier Trade Terms" := TradeTerms;
            SupplierProfile."Supplier Country" := Country;
            SupplierProfile."Supplier County" := County;
            SupplierProfile."Supplier Date Created" := DateCreated;
            SupplierProfile."Supplier Date Updated" := DateUpdated;
            SupplierProfile."Supplier Id" := UserId;

            if SupplierProfile.Modify then
                ReturnValue := '200: Record ' + No + ' Successfully Modified'
        end else
            ReturnValue := '400: ' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure CreateTenderPrequalification(CreatedBy: Integer; UpdatedBy: Integer; Status: Text; Description: Text; DateCreated: Date; DateUpdated: Date; BusinessRegistrationName: Text; TenderNo: Code[100]; SupplierProfileID: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        SupplierProfile.Reset;
        SupplierProfile.SetRange(No, Format(SupplierProfileID));

        if SupplierProfile.FindFirst then begin

            TenderHeader.Reset;
            TenderPrequalification.Reset;
            TenderPrequalification.SetRange("Supplier Profile ID", SupplierProfileID);
            TenderPrequalification.SetRange("Document Type", TenderPrequalification."Document Type"::"Registration of Supplier");
            /* IF TenderPrequalification.FINDFIRST THEN BEGIN
                  ReturnValue:='400: Your Prequalification Application is Already Submitted';
               EXIT;
               END;*/
            "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Prequalification Nos", 0D, true);
            //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
            if "DocNo." <> '' then begin
                TenderPrequalification.Init;
                TenderPrequalification."Application No" := "DocNo.";
                TenderPrequalification."Supplier Name" := SupplierProfile."Supplier Name";
                TenderPrequalification.Telephone := Format(SupplierProfile."Supplier Telephone");
                TenderPrequalification."Created By" := CreatedBy;
                TenderPrequalification."Updated By" := UpdatedBy;
                TenderPrequalification."Date Created" := DateCreated;
                TenderPrequalification."Date Updated" := DateUpdated;
                TenderPrequalification.Status := Status;
                TenderPrequalification.Description := Description;
                TenderPrequalification."Document Type" := TenderPrequalification."Document Type"::"Registration of Supplier";
                //  TenderPrequalification."Approval status":=ApprovalStatus;
                //TenderPrequalification.Location:=Location;
                TenderPrequalification."Legal status" := SupplierProfile."Supplier Legal Status";
                //TenderPrequalification."Incorporation Year":=IncorporationYear;
                TenderPrequalification."Business Nature" := SupplierProfile."Supplier Business Nature";
                TenderPrequalification."Max Business Value" := SupplierProfile."Supplier Max Bussiness Value";
                TenderPrequalification."Bankers Name" := SupplierProfile."Supplier Bankers Name";
                TenderPrequalification."Business Registration Name" := SupplierProfile."Supplier Company Name";
                //TenderPrequalification."Payment Mode":=PaymentMode;
                TenderPrequalification."Document No." := TenderNo;
                TenderPrequalification.Website := SupplierProfile."Supplier Website";
                TenderPrequalification."KRA PIN" := SupplierProfile."Supplier Kra Pin Cert No";
                TenderPrequalification."Supplier Profile ID" := SupplierProfileID;
                //TenderPrequalification."Approval Remarks":=ApprovalRemarks;
                //TenderPrequalification."Recommendation Remarks":=RecommendationRemarks;
                //TenderPrequalification.Score:=Score;
                //TenderPrequalification."Recommendation By":=RecommendationBy;
                //TenderPrequalification."Approved By":=ApprovedBy;
                //TenderPrequalification."Recommendation Date":=RecommendationDate;
                //TenderPrequalification."Recommendation Status":=RecommendationStatus;
                if TenderPrequalification.Insert then
                    ReturnValue := TenderPrequalification."Application No"

                else
                    ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

            end;
        end else
            ReturnValue := '400: Supplier with Id ' + Format(SupplierProfileID) + ' does not exist';

    end;

    [Scope('Personalization')]
    procedure ModifyTenderPrequalification(ApplicationNo: Code[20]; CreatedBy: Integer; UpdatedBy: Integer; Status: Text; Description: Text[30]; Location: Text; DateCreated: Date; DateUpdated: Date; ApprovalStatus: Text; IncorporationYear: Integer; BusinessRegistrationName: Text; PaymentMode: Text; TenderNo: Code[20]; SupplierProfileID: Integer; ApprovalRemarks: Text; RecommendationRemarks: Text; Score: Text; RecommendationBy: Integer; ApprovedBy: Integer; RecommendationDate: Date; RecommendationStatus: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderPrequalification.Reset;
        TenderPrequalification.SetRange(TenderPrequalification."Application No", ApplicationNo);
        if TenderPrequalification.FindFirst then begin
            TenderPrequalification."Supplier Name" := SupplierProfile."Supplier Name";
            TenderPrequalification.Telephone := Format(SupplierProfile."Supplier Telephone");
            TenderPrequalification."Created By" := CreatedBy;
            TenderPrequalification."Updated By" := UpdatedBy;
            TenderPrequalification."Date Created" := DateCreated;
            TenderPrequalification."Date Updated" := DateUpdated;
            TenderPrequalification.Status := Status;
            TenderPrequalification.Description := Description;
            TenderPrequalification."Approval status" := ApprovalStatus;
            TenderPrequalification.Location := Location;
            TenderPrequalification."Legal status" := SupplierProfile."Supplier Legal Status";
            TenderPrequalification."Incorporation Year" := IncorporationYear;
            TenderPrequalification."Business Nature" := SupplierProfile."Supplier Business Nature";
            TenderPrequalification."Max Business Value" := SupplierProfile."Supplier Max Bussiness Value";
            TenderPrequalification."Bankers Name" := SupplierProfile."Supplier Bankers Name";
            TenderPrequalification."Business Registration Name" := BusinessRegistrationName;
            TenderPrequalification."Payment Mode" := PaymentMode;
            TenderPrequalification."Document No." := TenderNo;
            TenderPrequalification.Website := SupplierProfile."Supplier Website";
            TenderPrequalification."KRA PIN" := SupplierProfile."Supplier Kra Pin Cert No";
            TenderPrequalification."Supplier Profile ID" := SupplierProfileID;
            TenderPrequalification."Approval Remarks" := ApprovalRemarks;
            TenderPrequalification."Recommendation Remarks" := RecommendationRemarks;
            TenderPrequalification.Score := Score;
            TenderPrequalification."Recommendation By" := RecommendationBy;
            TenderPrequalification."Approved By" := ApprovedBy;
            TenderPrequalification."Recommendation Date" := RecommendationDate;
            TenderPrequalification."Recommendation Status" := RecommendationStatus;

            if TenderPrequalification.Modify then
                ReturnValue := '200: Record ' + TenderNo + ' Successfully Modified'
        end else
            ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetTenderPrequalificationList(var TenderPrequalificationExport: XMLport "Tender Prequalification Export")
    begin
    end;

    [Scope('Personalization')]
    procedure GetSuppPreqDoc(var SupplierProfileDocExport: XMLport "Supplier Profile Doc Export"; ReferenceNo: Code[20]; Type: Option "Supplier Profile",Prequalification)
    begin
        if ReferenceNo <> '' then begin
            SupplierProfileDoc.Reset;
            //SupplierProfile.SETFILTER(No,SupplierNo);
            SupplierProfileDoc.SetRange("Reference No", ReferenceNo);
            if SupplierProfileDoc.FindFirst then;
            SupplierProfileDocExport.SetTableView(SupplierProfileDoc);
        end;
    end;

    [Scope('Personalization')]
    procedure CreateSuppPreqDoc(FileName: Text; ActualFileName: Text; ReferenceNo: Code[50]; Type: Option "Supplier Profile",Prequalification,Tender,Rfp,Qoute) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        if ReferenceNo <> '' then begin
            SupplierProfileDoc.Init;
            SupplierProfileDoc."Reference No" := ReferenceNo;
            SupplierProfileDoc."File Name" := FileName;
            SupplierProfileDoc."Actual File" := ActualFileName;
            SupplierProfileDoc.Type := Type;
            if SupplierProfileDoc.Insert then
                ReturnValue := Format(SupplierProfileDoc."Entry No")//'200: Record '+FORMAT(SupplierProfileDoc."Entry No")+ ' Successfully Created'

            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure ModifySuppPreqDoc(EntryNo: Integer; FileName: Text; ActualFileName: Text; SupplierNo: Code[20]) ReturnValue: Text
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        SupplierProfileDoc.Reset;
        SupplierProfileDoc.SetRange(SupplierProfileDoc."Entry No", EntryNo);
        if SupplierProfile.FindFirst then begin
            SupplierProfileDoc."Reference No" := SupplierNo;
            SupplierProfileDoc."File Name" := FileName;
            SupplierProfileDoc."Actual File" := ActualFileName;
            if SupplierProfileDoc.Modify then
                ReturnValue := '200: Record ' + Format(SupplierProfileDoc."Entry No") + ' Successfully Modified'
        end else
            ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetRequestForQuotationHeaderList(var RequestForQuotationExport: XMLport "RequestForQuotation Export"; RfqNo: Code[20])
    begin
        RequestHeader.Reset;
        RequestHeader.SetRange("No.", RfqNo);
        if RequestHeader.FindFirst then;
        RequestForQuotationExport.SetTableView(RequestHeader);
    end;

    [Scope('Personalization')]
    procedure GetRequestForQuotationLineList(var RfqLineExport: XMLport "RequestForQuotationLine Export"; HeaderNo: Code[20])
    begin
        if HeaderNo <> '' then begin
            RequestLines.Reset;
            RequestLines.SetFilter("Document No.", HeaderNo);
            if RequestLines.FindFirst then;
            RfqLineExport.SetTableView(RequestLines);
        end;
    end;

    [Scope('Personalization')]
    procedure CreateRequestForQuotationHeader(RfqNo: Code[20]; RfqDesc: Text; RfqType: Option RFQ,RFP; DocDate: Date; RfqStatus: Option ,Open,"Pending Approval",Approved,Rejected; ApprovalStatus: Option ,Open,"Pending Approval",Approved,Rejected; UserId: Code[20]; IssueDate: Date; ClosingDate: Date; "RequestForQuotationNo.": Code[10]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        RequestHeader.Reset;

        "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Tender Doc No.", 0D, true);
        //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
        if "DocNo." <> '' then begin
            RequestHeader.Init;
            RequestHeader."No." := RfqNo;
            RequestHeader."Request For Quotation No" := "RequestForQuotationNo.";
            RequestHeader."Document Date" := DocDate;
            RequestHeader.Description := RfqDesc;
            RequestHeader."Issue Date" := IssueDate;
            RequestHeader."Closing Date" := ClosingDate;
            RequestHeader.Type := RfqType;
            RequestHeader.Status := RfqStatus;
            RequestHeader.Status := ApprovalStatus;
            RequestHeader."User ID" := UserId;

            if RequestHeader.Insert then begin
                ReturnValue := '200: E-Procurement Rfq No ' + RfqNo + ' Successfully Created';
            end
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

        end;
    end;

    [Scope('Personalization')]
    procedure ModifyRequestForQuotationrHeader("66": Code[20]; RfqDesc: Text; RfqType: Option ,Open,Restricted; DocDate: Date; RfqStatus: Option ,"Tender Preparation","Tender Opening","Tender Evaluation",Closed; ApprovalStatus: Option ,Open,"Pending Approval",Approved,Rejected; UserId: Code[20]; IssueDate: Date; ClosingDate: Date; RequestForQuotationNo: Code[10]) RequestHeaderModified: Text
    var
        HREmployee: Record Employee;
        "DocNo.": Code[10];
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        RequestHeaderModified := '';
        RequestHeader.Reset;
        RequestHeader.SetRange(RequestHeader."No.", "DocNo.");
        if TenderHeader.FindFirst then begin
            RequestHeader."Request For Quotation No" := RequestForQuotationNo;
            RequestHeader."Document Date" := DocDate;
            RequestHeader.Description := RfqDesc;
            RequestHeader."Issue Date" := IssueDate;
            RequestHeader."Closing Date" := ClosingDate;
            RequestHeader.Type := RfqType;
            RequestHeader.Status := RfqStatus;
            RequestHeader.Status := ApprovalStatus;
            RequestHeader."User ID" := UserId;

            if RequestHeader.Modify then
                RequestHeaderModified := '200: E-Procurement Request For Quotation No' + RequestForQuotationNo + ' Successfully Modified';
            ;
        end;
    end;

    [Scope('Personalization')]
    procedure GetPurchaseQuoteHeaderList(var PurchaseQuoteExport: XMLport PurchaseQuoteExport; DocumenType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order")
    begin
        QuoteHeader.Reset;
        QuoteHeader.SetRange("Document Type", DocumenType);
        //QuoteHeader.SETFILTER("No.",QuoteNo);

        if QuoteHeader.FindFirst then;
        PurchaseQuoteExport.SetTableView(QuoteHeader);
    end;

    [Scope('Personalization')]
    procedure GetPurchaseQuoteLineList(var PurchaseQuoteLineExport: XMLport "PurchaseQuoteLine Export"; HeaderNo: Code[20])
    var
        PurchHeader: Record "Purchase Header";
    begin
        if HeaderNo <> '' then begin
            QuoteLines.Reset;
            QuoteLines.SetFilter("Document No.", HeaderNo);

            if QuoteLines.FindFirst then;
            PurchaseQuoteLineExport.SetTableView(QuoteLines);
        end;
    end;

    [Scope('Personalization')]
    procedure ModifyPurchaseQuoteLineList(LineNo: Integer; DocumentNo: Code[20]; UnitCost: Decimal; Remarks: Text) PurchaseQuoteModified: Text
    var
        HREmployee: Record Employee;
        "DocNo.": Code[10];
        PurchHeader: Record "Purchase Header";
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        PurchaseQuoteModified := '';
        QuoteLines.Reset;
        QuoteLines.SetRange("Document No.", DocumentNo);
        QuoteLines.SetRange("Document Type", QuoteLines."Document Type"::Quote);
        QuoteLines.SetRange("Line No.", LineNo);
        if QuoteLines.FindFirst then begin
            //QuoteLines."Line No." :=LineNo;
            QuoteLines."Direct Unit Cost" := UnitCost;
            QuoteLines.Validate("Direct Unit Cost");
            // QuoteLines.Remarks:=Remarks;
            // QuoteLines.VALIDATE(Remarks);
            if QuoteLines.Modify then
                PurchaseQuoteModified := '200: E-Procurement Request For Quotation No' + DocumentNo + ' Successfully Modified';
            ;
        end;
    end;

    [Scope('Personalization')]
    procedure ReleasePurchaseQuoteHeader(QuoteNo: Code[10]) ReturnValue: Text
    var
        ReleasePurquote: Codeunit "Release Purchase Document";
    begin
        if QuoteNo <> '' then begin
            QuoteHeader.Reset;
            QuoteHeader.SetRange("No.", QuoteNo);
            if QuoteHeader.FindFirst then begin
                QuoteHeader.Status := QuoteHeader.Status::Released;

                //QuoteHeader.Status := QuoteStatus.Status::Released;
                //QuoteHeader.MODIFY;
                if QuoteHeader.Modify then
                    ReturnValue := '200: E-Procurement Purchase Quote No' + QuoteNo + 'Successfully Submitted'
            end else
                ReturnValue := '400: Purchase Quote Not Submitted'
        end;
    end;

    [Scope('Personalization')]
    procedure CreateTenderBankInfo(ApplicatioNo: Code[20]; Bank: Text; BankAddress: Text[250]; SupplierProfileID: Integer; BankTelephoneNo: Text; BankEmail: Text; BankMobileNo: Text; TenderNo: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicatioNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderBankInfo.Init;
            TenderBankInfo.Bank := Bank;
            TenderBankInfo."Document No" := ApplicatioNo;
            TenderBankInfo."Bank Address" := BankAddress;
            TenderBankInfo."Bank Email" := BankEmail;
            TenderBankInfo."Bank Mobile No" := BankMobileNo;
            TenderBankInfo."Bank Telephone No" := BankTelephoneNo;
            TenderBankInfo."Supplier Profile ID" := SupplierProfileID;
            // TenderBankInfo."Document No":= FORMAT(TenderLine."Application No");
            TenderBankInfo.TenderNo := TenderLine."Document No.";
            if TenderBankInfo.Insert then
                ReturnValue := Format(TenderBankInfo."Line No")
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicatioNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderBankInfo(LineNo: Integer; Bank: Text; BankAddress: Text[250]; BankTelephoneNo: Text; BankEmail: Text; BankMobileNo: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderBankInfo.Reset;
        TenderBankInfo.SetRange("Line No", LineNo);
        if TenderBankInfo.FindFirst then begin
            TenderBankInfo.Bank := Bank;
            TenderBankInfo."Bank Address" := BankAddress;
            TenderBankInfo."Bank Email" := BankEmail;
            TenderBankInfo."Bank Mobile No" := BankMobileNo;
            TenderBankInfo."Bank Telephone No" := BankTelephoneNo;
            if TenderBankInfo.Modify then
                ReturnValue := '200: Bank Info ' + TenderBankInfo."Document No" + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderBankInfoList(var TenderBankInfoExport: XMLport "TenderBankInfo Export"; ApplicationNo: Code[20])
    begin
        TenderBankInfo.Reset;
        TenderBankInfo.SetFilter("Document No", ApplicationNo);
        if TenderBankInfo.FindFirst then;
        TenderBankInfoExport.SetTableView(TenderBankInfo);
    end;

    [Scope('Personalization')]
    procedure CreateDirectorsProfile(ApplicationNo: Code[20]; DirectorName: Text; DirectorNationality: Text[250]; DirectorShares: Text; DateCreated: Date; DateUpdated: Date) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicationNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderDirectors.Init;
            TenderDirectors."Application No" := ApplicationNo;
            TenderDirectors."Director Name" := DirectorName;
            TenderDirectors."Director Nationality" := DirectorNationality;
            TenderDirectors."Director Shares" := DirectorShares;
            TenderDirectors."Date Created" := DateCreated;
            TenderDirectors."Date Updated" := DateUpdated;
            TenderDirectors."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            if TenderDirectors.Insert then
                ReturnValue := Format(TenderDirectors."Line No")
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyDirectorsProfile(LineNo: Integer; DirectorName: Text; DirectorNationality: Text[250]; DirectorShares: Text; DateCreated: Date; DateUpdated: Date; CreatedBy: Integer; UpdatedBy: Integer; Description: Text; AttachUrl: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderDirectors.Reset;
        TenderDirectors.SetRange("Line No", LineNo);
        if TenderDirectors.FindFirst then begin
            TenderDirectors."Director Name" := DirectorName;
            TenderDirectors."Director Nationality" := DirectorNationality;
            TenderDirectors."Director Shares" := DirectorShares;
            TenderDirectors."Date Created" := DateCreated;
            TenderDirectors."Date Updated" := DateUpdated;
            TenderDirectors."Created By" := CreatedBy;
            TenderDirectors."Updated By" := UpdatedBy;
            TenderDirectors."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderDirectors.Description := Description;
            TenderDirectors."Attach URL" := AttachUrl;
            if TenderDirectors.Modify then
                ReturnValue := '200: Record ' + Format(TenderDirectors."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetDirectorsProfileList(var TenderDirectorsProfileExport: XMLport "TenderDirectors Export"; ApplicationNo: Code[20])
    begin
        TenderDirectors.Reset;
        TenderDirectors.SetFilter("Application No", ApplicationNo);
        if TenderDirectors.FindFirst then;
        TenderDirectorsProfileExport.SetTableView(TenderDirectors);
    end;

    [Scope('Personalization')]
    procedure GetTenderQuestions(var TenderQuestionsExport: XMLport "TenderQuestions Export"; QuestionType: Option "ELIGIBILITY/LITIGATION","CAPABILITY/COMPETENCE")
    begin
        TenderQuestions.Reset;
        //TenderQuestions.SETFILTER("Line No","LineNo.");
        TenderQuestions.SetRange("Quest type", QuestionType);
        if TenderQuestions.FindFirst then;
        TenderQuestionsExport.SetTableView(TenderQuestions);
    end;

    [Scope('Personalization')]
    procedure CreateTenderAnswer(Answer: Text; DateCreated: Date; DateUpdated: Date; QuestionId: Integer; ApplicationNo: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicationNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderAnswers.Init;
            TenderAnswers.Answer := Answer;
            TenderAnswers."Date Created" := DateCreated;
            TenderAnswers."Date Update" := DateUpdated;
            //TenderAnswers."Created By":=CreatedBy;
            // TenderAnswers."Updated By":=UpdatedBy;
            TenderAnswers."Document No" := ApplicationNo;
            TenderAnswers."Question ID" := QuestionId;

            TenderQuestions.Reset;
            TenderQuestions.SetRange("Line No", QuestionId);
            if TenderQuestions.FindFirst then
                TenderAnswers."Question Description" := TenderQuestions.Question;

            TenderAnswers."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            if TenderAnswers.Insert then
                ReturnValue := Format(TenderAnswers."Line No")
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderAnswer(LineNo: Integer; Answer: Text; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; QuestionId: Integer) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderAnswers.Reset;
        TenderAnswers.SetRange("Line No", LineNo);
        if TenderAnswers.FindFirst then begin
            TenderAnswers.Answer := Answer;
            TenderAnswers."Date Created" := DateCreated;
            TenderAnswers."Date Update" := DateUpdated;
            TenderAnswers."Created By" := CreatedBy;
            TenderAnswers."Updated By" := UpdatedBy;
            //TenderAnswers."Document No":=ApplicationNo;
            TenderAnswers."Question ID" := QuestionId;
            TenderAnswers."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            if TenderAnswers.Modify then
                ReturnValue := '200: Record ' + Format(TenderDirectors."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderAnswers(var TenderAnswersExport: XMLport "TenderAnswers Export"; ApplicationNo: Code[20]; QuestionId: Integer)
    begin
        TenderAnswers.Reset;
        TenderAnswers.SetFilter("Document No", ApplicationNo);
        TenderAnswers.SetRange("Question ID", QuestionId);
        if TenderAnswers.FindFirst then;
        TenderAnswersExport.SetTableView(TenderAnswers);
    end;

    [Scope('Personalization')]
    procedure CreateTenderPersonnel(ApplicationNo: Code[20]; Name: Text; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; Age: Integer; DateOfBirth: Date; Gender: Code[10]; AcademicQualification: Text; ProfessionalQualification: Text; Description: Text; AttachUrl: Text) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicationNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderPersonnel.Init;
            TenderPersonnel.Name := Name;
            TenderPersonnel."Date Created" := DateCreated;
            TenderPersonnel."Date Update" := DateUpdated;
            TenderPersonnel."Created By" := CreatedBy;
            TenderPersonnel."Updated By" := UpdatedBy;
            TenderPersonnel."Document No" := ApplicationNo;
            TenderPersonnel.Age := Age;
            TenderPersonnel."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderPersonnel."Date of Birth" := DateOfBirth;
            TenderPersonnel.Gender := Gender;
            TenderPersonnel."Academic Qualification" := AcademicQualification;
            TenderPersonnel."Professional Qualification" := ProfessionalQualification;
            TenderPersonnel.Description := Description;
            TenderPersonnel."Attach URL" := AttachUrl;
            if TenderPersonnel.Insert then
                ReturnValue := Format(TenderPersonnel."Line No")//'200: Bank Info '+ApplicationNo+ ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderPersonnel(LineNo: Integer; Name: Text; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; Age: Integer; DateOfBirth: Date; Gender: Code[10]; AcademicQualification: Text; ProfessionalQualification: Text; Description: Text; AttachUrl: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderPersonnel.Reset;
        TenderPersonnel.SetRange("Line No", LineNo);
        if TenderPersonnel.FindFirst then begin
            TenderPersonnel.Name := Name;
            TenderPersonnel."Date Created" := DateCreated;
            TenderPersonnel."Date Update" := DateUpdated;
            TenderPersonnel."Created By" := CreatedBy;
            TenderPersonnel."Updated By" := UpdatedBy;
            TenderPersonnel.Age := Age;
            TenderPersonnel."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderPersonnel."Date of Birth" := DateOfBirth;
            TenderPersonnel.Gender := Gender;
            TenderPersonnel."Academic Qualification" := AcademicQualification;
            TenderPersonnel."Professional Qualification" := ProfessionalQualification;
            TenderPersonnel.Description := Description;
            TenderPersonnel."Attach URL" := AttachUrl;
            if TenderPersonnel.Modify then
                ReturnValue := '200: Record ' + Format(TenderPersonnel."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderPersonnel(var TenderPersonnelExport: XMLport "TenderPersonnel Export"; ApplicationNo: Code[20])
    begin
        TenderPersonnel.Reset;
        TenderPersonnel.SetFilter("Document No", ApplicationNo);
        if TenderPersonnel.FindFirst then;
        TenderPersonnelExport.SetTableView(TenderPersonnel);
    end;

    [Scope('Personalization')]
    procedure CreateTenderExperience(ApplicationNo: Code[20]; AttachUrl: Text; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; Type: Text; Description: Text; StartDate: Date; EndDate: Date; Institution: Text) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicationNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderExperience.Init;
            TenderExperience."Attach URL" := AttachUrl;
            TenderExperience."Date Created" := DateCreated;
            TenderExperience."Date Update" := DateUpdated;
            TenderExperience."Document No" := ApplicationNo;
            TenderExperience.Type := Type;
            TenderExperience."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderExperience.Description := Description;
            TenderExperience."Start Date" := StartDate;
            TenderExperience."End Date" := EndDate;
            if TenderExperience.Insert then
                ReturnValue := Format(TenderExperience."Line No")//'200: Record '+ApplicationNo+ ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderExperience(LineNo: Integer; AttachUrl: Text; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; Type: Text; Description: Text; StartDate: Date; EndDate: Date; Institution: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderExperience.Reset;
        TenderExperience.SetRange("Line No", LineNo);
        if TenderExperience.FindFirst then begin
            TenderExperience."Attach URL" := AttachUrl;
            TenderExperience."Date Created" := DateCreated;
            TenderExperience."Date Update" := DateUpdated;
            TenderExperience."Created By" := CreatedBy;
            TenderExperience."Updated By" := UpdatedBy;
            TenderExperience.Type := Type;
            TenderExperience."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderExperience.Description := Description;
            TenderExperience."Start Date" := StartDate;
            TenderExperience."End Date" := EndDate;
            TenderExperience.Institution := Institution;
            if TenderExperience.Modify then
                ReturnValue := '200: Record ' + Format(TenderExperience."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderExperience(var TenderExperienceExport: XMLport "TenderExperience Export"; ApplicationNo: Code[20])
    begin
        TenderExperience.Reset;
        TenderExperience.SetFilter("Document No", ApplicationNo);
        if TenderExperience.FindFirst then;
        TenderExperienceExport.SetTableView(TenderExperience);
    end;

    [Scope('Personalization')]
    procedure CreateTenderFinancialCapability(ApplicationNo: Code[20]; TotalAssets: Decimal; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; CurrentAssets: Decimal; TotalLiabilities: Decimal; AttachUrl: Text; Description: Text; FinancialYear: Text; CurrentLiabilites: Decimal) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicationNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderFinancialCapability.Init;
            TenderFinancialCapability."Total Assets" := TotalAssets;
            TenderFinancialCapability."Date Created" := DateCreated;
            TenderFinancialCapability."Date Update" := DateUpdated;
            TenderFinancialCapability."Created By" := CreatedBy;
            TenderFinancialCapability."Updated By" := UpdatedBy;
            TenderFinancialCapability."Document No" := ApplicationNo;
            TenderFinancialCapability."Current Assets" := CurrentAssets;
            TenderFinancialCapability."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderFinancialCapability."Total Liabities" := TotalLiabilities;
            TenderFinancialCapability."Current Liabilities" := CurrentLiabilites;
            TenderFinancialCapability."Attach URL" := AttachUrl;
            TenderFinancialCapability.Description := Description;
            TenderFinancialCapability."Financial Year" := FinancialYear;
            if TenderFinancialCapability.Insert then
                ReturnValue := Format(TenderFinancialCapability."Line No")//'200: Bank Info '+ApplicationNo+ ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderFinancialCapability(LineNo: Integer; TotalAssets: Decimal; DateCreated: Date; DateUpdated: Date; CreatedBy: Code[20]; UpdatedBy: Code[20]; CurrentAssets: Decimal; TotalLiabilities: Decimal; AttachUrl: Text; Description: Text; FinancialYear: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderFinancialCapability.Reset;
        TenderFinancialCapability.SetRange("Line No", LineNo);
        if TenderFinancialCapability.FindFirst then begin
            TenderFinancialCapability."Total Assets" := TotalAssets;
            TenderFinancialCapability."Date Created" := DateCreated;
            TenderFinancialCapability."Date Update" := DateUpdated;
            TenderFinancialCapability."Created By" := CreatedBy;
            TenderFinancialCapability."Updated By" := UpdatedBy;
            TenderFinancialCapability."Current Assets" := CurrentAssets;
            TenderFinancialCapability."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderFinancialCapability."Total Liabities" := TotalLiabilities;
            TenderFinancialCapability."Attach URL" := AttachUrl;
            TenderFinancialCapability.Description := Description;
            TenderFinancialCapability."Financial Year" := FinancialYear;
            if TenderFinancialCapability.Modify then
                ReturnValue := '200: Record ' + Format(TenderFinancialCapability."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderFinancialCapability(var TenderFinancialCapabilityExport: XMLport "TenderFinancialCapability Xml"; ApplicationNo: Code[20])
    begin
        TenderFinancialCapability.Reset;
        TenderFinancialCapability.SetFilter("Document No", ApplicationNo);
        if TenderFinancialCapability.FindFirst then;
        TenderFinancialCapabilityExport.SetTableView(TenderFinancialCapability);
    end;

    [Scope('Personalization')]
    procedure CreateTenderLitigation(ApplicationNo: Code[20]; Year: Text; DateCreated: Date; DateUpdated: Date; NameOfClient: Text; Description: Text; DisputedAmount: Decimal; AwardforOrAganist: Text) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        TenderLine.Reset;
        TenderLine.SetRange("Application No", ApplicationNo);
        if TenderLine.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderLitigation.Init;
            TenderLitigation.Year := Year;
            TenderLitigation."Date Created" := DateCreated;
            TenderLitigation."Date Update" := DateUpdated;
            TenderLitigation."Document No" := ApplicationNo;
            TenderLitigation."Award for/or Aganist" := AwardforOrAganist;
            TenderLitigation."Name of Client" := NameOfClient;
            TenderLitigation."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderLitigation.Description := Description;
            TenderLitigation."Disputed Amount" := DisputedAmount;
            if TenderLitigation.Insert then
                ReturnValue := Format(TenderLitigation."Line No")//'200: record '+ApplicationNo+ ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + ApplicationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderLitigation(LineNo: Integer; Year: Text; DateUpdated: Date; NameOfClient: Text; Description: Text; DisputedAmount: Decimal; AwardforOrAganist: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderLitigation.Reset;
        TenderLitigation.SetRange("Line No", LineNo);
        if TenderLitigation.FindFirst then begin
            TenderLitigation.Year := Year;
            //TenderLitigation."Date Created" := DateCreated;
            TenderLitigation."Date Update" := DateUpdated;
            TenderLitigation."Name of Client" := NameOfClient;
            TenderLitigation."Supplier Profile ID" := TenderLine."Supplier Profile ID";
            TenderLitigation.Description := Description;
            TenderLitigation."Award for/or Aganist" := AwardforOrAganist;
            TenderLitigation."Disputed Amount" := DisputedAmount;
            if TenderLitigation.Modify then
                ReturnValue := '200: Record ' + Format(TenderLitigation."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderLitigation(var TenderLitigationExport: XMLport "TenderLitigation Xml"; ApplicationNo: Code[20])
    begin
        TenderLitigation.Reset;
        TenderLitigation.SetFilter("Document No", ApplicationNo);
        if TenderLitigation.FindFirst then;
        TenderLitigationExport.SetTableView(TenderLitigation);
    end;

    [Scope('Personalization')]
    procedure GetEmployeeList(var TenderLneExport: XMLport "Committee Export")
    begin
    end;

    [Scope('Personalization')]
    procedure CreateTenderCommittee(TenderNo: Code[20]; Evaluator: Code[50]; EvaluatorName: Text; USERID: Code[20]; Email: Text; Chairperson: Boolean; TenderOpening: Boolean; TenderEvaluation: Boolean; DateCreated: Date; CreatedBy: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        TenderHeader.Reset;
        TenderHeader.SetRange("No.", TenderNo);
        if TenderHeader.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderEvaluators.Init;
            TenderEvaluators."Evaluator No" := Evaluator;
            TenderEvaluators."Evaluator Name" := EvaluatorName;
            TenderEvaluators."User ID" := USERID;
            TenderEvaluators."E-Mail" := Email;
            TenderEvaluators."Tender No" := TenderHeader."No.";
            TenderEvaluators."Committee Chairperson" := Chairperson;
            TenderEvaluators."Tender Opening" := TenderOpening;
            TenderEvaluators.Evaluation := TenderEvaluation;
            TenderEvaluators."Date Created" := DateCreated;
            TenderEvaluators."Created By" := CreatedBy;
            if TenderEvaluators.Insert then
                ReturnValue := '200: Record ' + TenderNo + ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + TenderNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderCommittee(TenderNo: Code[20]; Evaluator: Code[50]; EvaluatorName: Text; USERID: Code[20]; Email: Text; Chairperson: Boolean; TenderOpening: Boolean; TenderEvaluation: Boolean; LineNo: Integer; DateUpdated: Date; UpdatedBy: Integer) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderEvaluators.Reset;
        TenderEvaluators.SetRange("Line No", LineNo);
        if TenderEvaluators.FindFirst then begin
            TenderEvaluators."Evaluator No" := Evaluator;
            TenderEvaluators."Evaluator Name" := EvaluatorName;
            TenderEvaluators."User ID" := USERID;
            TenderEvaluators."E-Mail" := Email;
            TenderEvaluators."Tender No" := TenderNo;
            TenderEvaluators."Committee Chairperson" := Chairperson;
            TenderEvaluators."Tender Opening" := TenderOpening;
            TenderEvaluators.Evaluation := TenderEvaluation;
            TenderEvaluators."Date Updated" := DateUpdated;
            TenderEvaluators."Updated By" := UpdatedBy;

            if TenderEvaluators.Modify then
                ReturnValue := '200: Record ' + Format(TenderEvaluators."Line No") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + TenderNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderEvaluationCommittee(var TenderEvaluatorExport: XMLport "Tender Evaluators Export"; TenderNo: Code[20])
    begin
        TenderEvaluators.Reset;
        TenderEvaluators.SetFilter("Tender No", TenderNo);
        //TenderEvaluators.SETRANGE(Evaluation,TRUE);
        if TenderEvaluators.FindFirst then;
        TenderEvaluatorExport.SetTableView(TenderEvaluators);
    end;

    [Scope('Personalization')]
    procedure GetTenderOpeningCommittee(var TenderEvaluatorExport: XMLport "Tender Evaluators Export"; TenderNo: Code[20])
    begin
        TenderEvaluators.Reset;
        TenderEvaluators.SetFilter("Tender No", TenderNo);
        TenderEvaluators.SetRange("Tender Opening", true);
        if TenderEvaluators.FindFirst then;
        TenderEvaluatorExport.SetTableView(TenderEvaluators);
    end;

    [Scope('Personalization')]
    procedure GetTenderEvaluationCriteria(var TenderEvaluationCriteriaExport: XMLport "Tender Evaluation Crite Export")
    begin
    end;

    [Scope('Personalization')]
    procedure GetTenderEvaluationCategory(var TenderEvaluationCategoryExport: XMLport "Tender Evaluation Cat Export")
    begin
    end;

    [Scope('Personalization')]
    procedure GetTenderEvaluationHeaderList(var TenderEvaluationHeaderExport: XMLport "Tender Evaluation Heade Export"; EmpNo: Code[20])
    begin
        TenderEvaluationHeader.Reset;
        TenderEvaluationHeader.SetRange("Employee No", EmpNo);
        if TenderEvaluationHeader.FindFirst then;
        TenderEvaluationHeaderExport.SetTableView(TenderEvaluationHeader);
    end;

    [Scope('Internal')]
    procedure CreateTenderEvaluationHeaderList(TenderNo: Code[20]; EvaluatorName: Text; EmpNo: Code[20]; EvaluationDate: Date; SupplierName: Text; SupplierProfileID: Integer; ApplicationNo: Code[20]; TenderDate: Date) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        TenderHeader.Reset;

        "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Tender Evaluation No.", 0D, true);

        TenderHeader.Reset;
        TenderHeader.SetRange("No.", TenderNo);
        if TenderHeader.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderEvaluationHeader.Init;
            TenderEvaluationHeader."Evaluation No." := "DocNo.";
            TenderEvaluationHeader."Document Date" := Today;
            TenderEvaluationHeader.Validate("Employee No", EmpNo);
            TenderEvaluationHeader."Document Type" := TenderHeader."Document Type";
            TenderEvaluationHeader."Tender No." := TenderHeader."No.";
            TenderEvaluationHeader.Eligibility := TenderHeader.Eligibility;
            TenderEvaluationHeader."Evaluation Date" := EvaluationDate;
            TenderEvaluationHeader."Supplier Name" := SupplierName;
            TenderEvaluationHeader."Supplier Profile ID" := SupplierProfileID;
            TenderEvaluationHeader."Tender Date" := TenderDate;
            TenderEvaluationHeader."Application No" := ApplicationNo;
            TenderEvaluationHeader."Evaluator Name" := EvaluatorName;
            if TenderEvaluationHeader.Insert then
                ReturnValue := '200: Record ' + "DocNo." + ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + TenderNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderEvaluationHeaderList(EvaluationNo: Code[20]; TenderNo: Code[20]; EvaluatorName: Text; USERID: Code[20]; EvaluationDate: Date; SupplierName: Text; SupplierProfileID: Integer; ApplicationNo: Code[20]; TenderDate: Date) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderEvaluationHeader.Reset;
        TenderEvaluationHeader.SetRange("Evaluation No.", EvaluationNo);
        if TenderEvaluationHeader.FindFirst then begin
            TenderEvaluationHeader."User ID" := USERID;
            TenderEvaluationHeader."Document Type" := TenderHeader."Document Type";
            TenderEvaluationHeader."Tender No." := TenderHeader."No.";
            TenderEvaluationHeader.Eligibility := TenderHeader.Eligibility;
            TenderEvaluationHeader."Evaluation Date" := EvaluationDate;
            TenderEvaluationHeader."Supplier Name" := SupplierName;
            TenderEvaluationHeader."Supplier Profile ID" := SupplierProfileID;
            TenderEvaluationHeader."Tender Date" := TenderDate;
            TenderEvaluationHeader."Application No" := ApplicationNo;
            TenderEvaluationHeader."Evaluator Name" := EvaluatorName;
            if TenderEvaluationHeader.Modify then
                ReturnValue := '200: Record ' + Format(EvaluationNo) + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + EvaluationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetTenderEvaluationLinesList(var TenderEvaluationLneExport: XMLport "Tender Evaluation Lines Export"; EmpNo: Code[20]; ApplicationNo: Code[20])
    begin
        TenderEvaluationHeader.Reset;
        TenderEvaluationHeader.SetRange("Employee No", EmpNo);
        TenderEvaluationHeader.SetRange("Evaluation No.", ApplicationNo);
        if TenderEvaluationHeader.FindFirst then begin
            TenderEvaluationLine.Reset;
            TenderEvaluationLine.SetRange("Document No.", TenderEvaluationHeader."Evaluation No.");

            if TenderEvaluationLine.FindFirst then;
            TenderEvaluationLneExport.SetTableView(TenderEvaluationLine);
        end;
    end;

    [Scope('Internal')]
    procedure CreateTenderEvaluationLinesList(EvaluationNo: Code[20]; Comments: Text; MaxScore: Decimal; Marks: Decimal; Requirements: Text; EvaluatorEmpNo: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        TenderEvaluationHeader.Reset;
        TenderEvaluationHeader.SetRange("Evaluation No.", EvaluationNo);
        if TenderEvaluationHeader.FindFirst then begin
            //TenderBankInfo.RESET;
            TenderEvaluationLine.Init;
            TenderEvaluationLine."Document No." := EvaluationNo;
            //TenderEvaluationLine."Evaluator EmpNo" := EvaluatorEmpNo;
            //TenderEvaluationLine.VALIDATE("Evaluator EmpNo");
            TenderEvaluationLine.Comments := Comments;
            TenderEvaluationLine."Max Score" := MaxScore;
            TenderEvaluationLine.Marks := Marks;
            TenderEvaluationLine.Requirements := Requirements;
            if TenderEvaluationLine.Insert then
                ReturnValue := '200: Record ' + EvaluationNo + ' Successfully Created'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + EvaluationNo + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure ModifyTenderEvaluationLinesList(LineNo: Integer; Comments: Text; Marks: Decimal) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderEvaluationLine.Reset;
        TenderEvaluationLine.SetRange("Line No.", LineNo);
        if TenderEvaluationLine.FindFirst then begin
            TenderEvaluationLine.Comments := Comments;
            // TenderEvaluationLine."Max Score":=MaxScore;
            TenderEvaluationLine.Marks := Marks;
            //TenderEvaluationLine.Requirements:=Requirements;

            if TenderEvaluationLine.Modify then
                ReturnValue := '200: Record ' + Format(TenderEvaluationLine."Line No.") + ' Successfully Modified'
            else
                ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
        end
        else
            ReturnValue := '400: Application No ' + Format(LineNo) + ' does not exist.'
    end;

    [Scope('Personalization')]
    procedure GetLitigationQuestionsHeader(var LitigationQuestionsimport: XMLport "NdovuPay Payments Export"; LineNo: Integer)
    begin
        LitigationQuestionsHeader.Reset;
        LitigationQuestionsHeader.SetRange("Line No", LineNo);
        if RequestHeader.FindFirst then;
        LitigationQuestionsimport.SetTableView(LitigationQuestionsHeader);
    end;

    [Scope('Personalization')]
    procedure GetLitigationQuestionsList(var LitigationQuestionsimport: XMLport "NdovuPay Payments Export"; LineNo: Code[20])
    begin
        if LineNo <> '' then begin
            LitigationQuestionsHeader.Reset;
            LitigationQuestionsHeader.SetFilter("Line No", LineNo);
            if LitigationQuestionsHeader.FindFirst then;
            LitigationQuestionsimport.SetTableView(LitigationQuestionsHeader);
        end;
    end;

    [Scope('Personalization')]
    procedure CreateLitigationQuestionHeader("LineNo.": Integer; LitigaQuestion: Text; IsAttachmentRequired: Boolean; AnswerType: Option; "PreQNo.": Code[10]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        LineNo: Integer;
        PreqNo: Record "Liigation Question Setup.";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        LitigationQuestionsHeader.Reset;

        "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Litigation Question Doc No.", 0D, true);
        //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
        if "DocNo." <> '' then begin
            LitigationQuestionsHeader.Init;
            LitigationQuestionsHeader."Line No" := LineNo;
            LitigationQuestionsHeader.Question := LitigaQuestion;
            LitigationQuestionsHeader."Answer type" := AnswerType;
            LitigationQuestionsHeader.LitigationDocNo := "DocNo.";



            if LitigationQuestionsHeader.Insert then begin
                ReturnValue := '200: E-Procurement Line No ' + "DocNo." + ' Successfully Created';
            end;
            //ELSE ReturnValue:=GETLASTERRORCODE+'-'+GETLASTERRORTEXT;

        end;
    end;

    [Scope('Personalization')]
    procedure GetTenderLinePerDocument(var TenderLneExport: XMLport "Tender Line Export"; documentNo: Code[20])
    begin
        if documentNo <> '' then begin
            TenderLine.Reset;
            TenderLine.SetFilter("Document No.", documentNo);
            if TenderLine.FindFirst then;
            TenderLneExport.SetTableView(TenderLine);
        end;
    end;

    [Scope('Personalization')]
    procedure GetTenderLineByType(var TenderLineExport: XMLport "Tender Line Export"; DocumentNo: Code[20]; DocType: Option " ","Registration of Supplier","Open Tender","Request for Proposal")
    var
        PurchHeader: Record "Purchase Header";
    begin
        //----Justo----TenderLine.SETRANGE("Document Type",DocType,TenderLine."Document Type"::"Open Tender");
        TenderLine.Reset;
        if DocType = DocType::"Open Tender" then
            TenderLine.SetRange("Document Type", DocType::"Open Tender")
        else if DocType = DocType::"Registration of Supplier" then
            TenderLine.SetRange("Document Type", DocType::"Registration of Supplier")
        else if DocType = DocType::"Request for Proposal" then
            TenderLine.SetRange("Document Type", DocType::"Request for Proposal");

        if DocumentNo <> '' then
            TenderLine.SetRange("Document No.", DocumentNo);

        if TenderLine.FindFirst then;
        TenderLineExport.SetTableView(TenderLine);
    end;

    [Scope('Personalization')]
    procedure GetTenderLineToEvalute(var TenderLineExport: XMLport "Tender Line Export"; EmpNo: Code[20]; DocType: Option " ","Registration of Supplier","Open Tender","Request for Proposal")
    var
        PurchHeader: Record "Purchase Header";
    begin
        //----Justo----TenderLine.SETRANGE("Document Type",DocType,TenderLine."Document Type"::"Open Tender");
        TenderEvaluators.Reset;
        TenderEvaluators.SetRange("Evaluator No", EmpNo);

        /*
        
        TenderLine.RESET;
        IF DocType = DocType::"Open Tender" THEN
          TenderLine.SETRANGE("Document Type",DocType::"Open Tender")
        ELSE IF  DocType = DocType::"Registration of Supplier" THEN
          TenderLine.SETRANGE("Document Type",DocType::"Registration of Supplier")
        ELSE IF  DocType = DocType::"Request for Proposal" THEN
          TenderLine.SETRANGE("Document Type",DocType::"Request for Proposal");
        
        IF DocumentNo <> '' THEN
          TenderLine.SETRANGE("Document No.",DocumentNo);
        
        IF TenderLine.FINDFIRST THEN;
            TenderLineExport.SETTABLEVIEW(TenderLine);
            */

    end;

    [Scope('Personalization')]
    procedure ModifyTenderPreqStatus(ApplicationNo: Code[20]; Status: Text) ReturnValue: Text
    var
        HREmployee: Record Employee;
    begin
        //Check requisition document is attached
        //CheckProcurementUploadedDocumentAttached("PurchaseRequisitionNo.");
        ReturnValue := '';
        TenderPrequalification.Reset;
        TenderPrequalification.SetRange(TenderPrequalification."Application No", ApplicationNo);
        if TenderPrequalification.FindFirst then begin
            TenderPrequalification.Status := Status;
            if TenderPrequalification.Modify then
                ReturnValue := '200: Record ' + TenderPrequalification."Document No." + ' Successfully Modified'
        end else
            ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure CreateTenderEvaluations(TenderNo: Code[20]; EvaluationDate: Date; EmpNo: Code[20]) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';
        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        TenderHeader.Reset;

        TenderHeader.Reset;
        TenderHeader.SetRange("No.", TenderNo);
        if TenderHeader.FindFirst then begin

            if TenderHeader."Tender Status" = TenderHeader."Tender Status"::"Tender Evaluation" then begin
                ReturnValue := '400: Tender Already Initiated';
                exit;
            end;
            //TenderBankInfo.RESET;
            TenderEvaluators.Reset;
            TenderEvaluators.SetRange("Tender No", TenderNo);
            if TenderEvaluators.FindFirst then begin
                repeat
                    TenderLine.Reset;
                    TenderLine.SetRange("Document No.", TenderNo);

                    if TenderLine.FindFirst then begin
                        repeat

                            "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Tender Evaluation No.", 0D, true);
                            TenderEvaluationHeader.Init;
                            TenderEvaluationHeader."Evaluation No." := "DocNo.";
                            TenderEvaluationHeader."Document Date" := Today;
                            TenderEvaluationHeader.Validate("Employee No", TenderEvaluators."Evaluator No");
                            TenderEvaluationHeader."Document Type" := TenderHeader."Document Type";
                            TenderEvaluationHeader."Tender No." := TenderHeader."No.";
                            TenderEvaluationHeader.Eligibility := TenderHeader.Eligibility;
                            TenderEvaluationHeader."Evaluation Date" := EvaluationDate;
                            TenderEvaluationHeader."Supplier Name" := TenderLine."Supplier Name";
                            TenderEvaluationHeader."Supplier Profile ID" := TenderLine."Supplier Profile ID";
                            TenderEvaluationHeader."Tender Date" := TenderHeader."Date Tender Opened";
                            TenderEvaluationHeader."Application No" := TenderLine."Application No";
                            if TenderEvaluationHeader.Insert then begin
                                EvaluationCriteria.Reset;
                                EvaluationCriteria.SetRange("Document Type", TenderHeader."Document Type");
                                if EvaluationCriteria.FindSet then begin
                                    repeat
                                        // TenderEvaluationLine.RESET;
                                        LineNo := 0;

                                        TenderEvaluationLineII.Reset;
                                        if TenderEvaluationLineII.FindLast then
                                            LineNo := TenderEvaluationLineII."Line No." + 100;

                                        TenderEvaluationLine.Init;
                                        TenderEvaluationLine."Line No." := LineNo;
                                        TenderEvaluationLine."Document No." := TenderEvaluationHeader."Evaluation No.";
                                        TenderEvaluationLine."Tender No." := TenderHeader."No.";
                                        TenderEvaluationLine.Requirements := EvaluationCriteria.Description;
                                        TenderEvaluationLine."Max Score" := EvaluationCriteria."Max Score";
                                        TenderEvaluationLine."Evaluation Category" := EvaluationCriteria."Evaluation Category";
                                        TenderEvaluationLine.Validate(Evaluator, TenderEvaluators."Evaluator No");
                                        TenderEvaluationLine.Insert;
                                    until EvaluationCriteria.Next = 0;
                                end;
                            end

                        until TenderLine.Next = 0;
                    end;
                until TenderEvaluators.Next = 0;
            end;
            TenderHeader."Tender Status" := TenderHeader."Tender Status"::"Tender Evaluation";
            TenderHeader."Evaluation Date" := Today;
            TenderHeader.Modify;
            ReturnValue := '200: Evaluations Successfully Created For All The  Applications';
        end;
    end;

    [Scope('Personalization')]
    procedure GetAllAppliedPrequalificationsList(var TenderLneExport: XMLport "Tender Line Export"; SupplierId: Code[20]; Type: Option Prequalification,Tender,Rfp; DocumentNo: Code[20])
    begin
        TenderLine.Reset;

        if Type = Type::Prequalification then
            TenderLine.SetRange("Document Type", TenderLine."Document Type"::"Registration of Supplier");

        if Type = Type::Rfp then
            TenderLine.SetRange("Document Type", TenderLine."Document Type"::"Request for Proposal");

        if Type = Type::Tender then
            TenderLine.SetRange("Document Type", TenderLine."Document Type"::"Open Tender");

        if SupplierId <> '' then
            TenderLine.SetFilter("Supplier Profile ID", SupplierId);

        if DocumentNo <> '' then
            TenderLine.SetRange("Document No.", DocumentNo);

        if TenderLine.FindFirst then;
        TenderLneExport.SetTableView(TenderLine);
    end;

    [Scope('Personalization')]
    procedure GetTendersToEvalute(var TenderEvalutorsAndTenders: XMLport "Employee2 Export"; EmpNo: Code[20]; DocType: Option " ","Registration of Supplier","Open Tender","Request for Proposal")
    var
        PurchHeader: Record "Purchase Header";
    begin
        //----Justo----TenderLine.SETRANGE("Document Type",DocType,TenderLine."Document Type"::"Open Tender");
        TenderEvaluators.Reset;
        TenderEvaluators.SetRange("Evaluator No", EmpNo);

        if TenderEvaluators.FindFirst then;
        TenderEvalutorsAndTenders.SetTableView(TenderEvaluators);

        /*
        
        TenderLine.RESET;
        IF DocType = DocType::"Open Tender" THEN
          TenderLine.SETRANGE("Document Type",DocType::"Open Tender")
        ELSE IF  DocType = DocType::"Registration of Supplier" THEN
          TenderLine.SETRANGE("Document Type",DocType::"Registration of Supplier")
        ELSE IF  DocType = DocType::"Request for Proposal" THEN
          TenderLine.SETRANGE("Document Type",DocType::"Request for Proposal");
        
        IF DocumentNo <> '' THEN
          TenderLine.SETRANGE("Document No.",DocumentNo);
        
        IF TenderLine.FINDFIRST THEN;
            TenderLineExport.SETTABLEVIEW(TenderLine);
            */

    end;

    [Scope('Personalization')]
    procedure SubmitEvaluation(EvaluationNo: Code[50])
    begin
        TenderEvaluationHeader.Reset;
        TenderEvaluationHeader.SetRange("Evaluation No.", EvaluationNo);
        if TenderEvaluationHeader.FindFirst then begin
            TenderEvaluationHeader.Status := TenderEvaluationHeader.Status::Submitted;
            TenderEvaluationHeader.Modify;
        end;
    end;

    [Scope('Personalization')]
    procedure AcceptOrRejectSupplierApplication(EmployeeNo: Code[10]; ApplicationNo: Code[10]; "Action": Option Accept,Reject; SupplierId: Code[10]; Remarks: Text) ReturnValue: Text
    begin
        if Action = Action::Accept then begin
            TenderLine.Reset;
            TenderLine.SetRange("Application No", ApplicationNo);
            //TenderLine.SETFILTER("Supplier No.",'=%1','');
            if TenderLine.FindFirst then begin

                if TenderLine."Supplier No." = '' then begin

                    /* Employee.RESET;
                          Employee.SETRANGE("No.",Employee."User ID",USERID);
                          IF Employee.FINDFIRST THEN BEGIN
                           IF EmployeeNo= '' THEN BEGIN
                             Employee.RESET;
                             Employee.INIT;
                             Employee."User ID":='PKAHUTHU';*/

                    SupplierProfile.Reset;
                    SupplierProfile.SetRange(No, Format(TenderLine."Supplier Profile ID"));
                    if SupplierProfile.FindFirst then begin
                        if SupplierId = '' then begin
                            Vendors.Reset;
                            Vendors.Init;
                            Vendors.Name := SupplierProfile."Supplier Name";
                            Vendors.PIN := SupplierProfile."Supplier Kra Pin Cert No";
                            Vendors."Bank Name" := SupplierProfile."Supplier Bankers Name";
                            //Vendors.:=SupplierProfile."Supplier Bankers Name";


                            if Vendors.Insert(true) then begin
                                TenderLine."Supplier No." := Vendors."No.";
                                TenderLine.Remarks := Remarks;
                                TenderLine.Modify;
                                SupplierProfile."Supplier Id" := Vendors."No.";
                                SupplierProfile.Modify;

                                //-- send email to supplier.

                                ReturnValue := '200: Application No ' + TenderLine."Application No" + ' Successfully awarded to Vendor No ' + Vendors."No.";
                            end
                        end;
                        ReturnValue := '400: Error'
                    end else begin
                        TenderLine."Supplier No." := Vendors."No.";
                        TenderLine.Remarks := Remarks;
                        TenderLine.Modify;
                        SupplierProfile."Supplier Id" := Vendors."No.";
                        SupplierProfile.Modify;
                        //-- send email to supplier.
                        ReturnValue := '200: Application No ' + TenderLine."Application No" + ' Successfully awarded to Vendor No ' + Vendors."No.";
                    end
                end;

            end else
                ReturnValue := '400: This Application has already being Award N/B (Vendor No: ' + TenderLine."Supplier No." + ')';


        end else begin
            TenderLine.Disqualified := true;
            TenderLine."Reason for Disqualification" := Remarks;
            TenderLine.Modify;
            ReturnValue := '200: This Application No ' + TenderLine."Application No" + ' has being Declined.';
            //--send regret email
        end;
        //END;
        //END;

    end;

    [Scope('Personalization')]
    procedure CreateTenderLineApplication(CreatedBy: Integer; UpdatedBy: Integer; Status: Text; Description: Text; DateCreated: Date; DateUpdated: Date; BusinessRegistrationName: Text; TenderNo: Code[100]; SupplierProfileID: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        SupplierProfile.Reset;
        SupplierProfile.SetRange(No, Format(SupplierProfileID));

        if SupplierProfile.FindFirst then begin

            //TenderHeader.RESET;
            /*TenderLine.RESET;
            TenderLine.SETRANGE("Supplier Profile ID",SupplierProfileID);
            TenderLine.SETRANGE("Document Type",TenderLine."Document Type"::"Open Tender");
              IF TenderLine.FINDFIRST THEN BEGIN
                   ReturnValue:='400: Your Prequalification Application is Already Submitted';
                EXIT;
                END;*/
            "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Tender Doc No.", 0D, true);
            //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
            if "DocNo." <> '' then begin
                TenderLine.Init;
                TenderLine."Application No" := "DocNo.";
                TenderLine."Supplier Name" := SupplierProfile."Supplier Name";
                TenderLine.Telephone := Format(SupplierProfile."Supplier Telephone");
                TenderLine."Created By" := CreatedBy;
                TenderLine."Updated By" := UpdatedBy;
                TenderLine."Date Created" := DateCreated;
                TenderLine."Date Updated" := DateUpdated;
                TenderLine.Description := Description;
                TenderLine."Legal status" := SupplierProfile."Supplier Legal Status";
                TenderLine."Business Nature" := SupplierProfile."Supplier Business Nature";
                TenderLine."Max Business Value" := SupplierProfile."Supplier Max Bussiness Value";
                TenderLine."Bankers Name" := SupplierProfile."Supplier Bankers Name";
                TenderLine."Business Registration Name" := SupplierProfile."Supplier Company Name";
                TenderLine."Document No." := TenderNo;
                TenderLine.Website := SupplierProfile."Supplier Website";
                TenderLine."KRA PIN" := SupplierProfile."Supplier Kra Pin Cert No";
                TenderLine."Supplier Profile ID" := SupplierProfileID;
                TenderLine."Document Type" := TenderLine."Document Type"::"Open Tender";

                if TenderLine.Insert then
                    ReturnValue := TenderLine."Application No"

                else
                    ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

            end;
        end else
            ReturnValue := '400: Supplier with Id ' + Format(SupplierProfileID) + ' does not exist';

    end;

    [Scope('Personalization')]
    procedure CreateRfpApplication(CreatedBy: Integer; UpdatedBy: Integer; Status: Text; Description: Text; DateCreated: Date; DateUpdated: Date; BusinessRegistrationName: Text; TenderNo: Code[100]; SupplierProfileID: Integer) ReturnValue: Text
    var
        "DocNo.": Code[20];
        HREmployee: Record Employee;
        PurchaseRequisition2: Record "Purchase Requisitions";
        ProcurementPortalDocuments: Record "Procurement  Portal Documents";
    begin
        ReturnValue := '';

        //Employee.RESET;
        //Employee.GET("EmployeeNo.");

        "Purchases&PayablesSetup".Reset;
        "Purchases&PayablesSetup".Get;

        SupplierProfile.Reset;
        SupplierProfile.SetRange(No, Format(SupplierProfileID));

        if SupplierProfile.FindFirst then begin

            //TenderHeader.RESET;
            /*TenderLine.RESET;
            TenderLine.SETRANGE("Supplier Profile ID",SupplierProfileID);
            TenderLine.SETRANGE("Document Type",TenderLine."Document Type"::"Open Tender");
              IF TenderLine.FINDFIRST THEN BEGIN
                   ReturnValue:='400: Your Prequalification Application is Already Submitted';
                EXIT;
                END;*/
            "DocNo." := NoSeriesMgt.GetNextNo("Purchases&PayablesSetup"."Request For Proposal", 0D, true);
            //NoSeriesMgt.InitSeries("Purchases&PayablesSetup"."Tender Doc No.",xRec."No. Series",0D,"No.","No. Series");
            if "DocNo." <> '' then begin
                TenderLine.Init;
                TenderLine."Application No" := "DocNo.";
                TenderLine."Supplier Name" := SupplierProfile."Supplier Name";
                TenderLine.Telephone := Format(SupplierProfile."Supplier Telephone");
                TenderLine."Created By" := CreatedBy;
                TenderLine."Updated By" := UpdatedBy;
                TenderLine."Date Created" := DateCreated;
                TenderLine."Date Updated" := DateUpdated;
                TenderLine.Description := Description;
                TenderLine."Legal status" := SupplierProfile."Supplier Legal Status";
                TenderLine."Business Nature" := SupplierProfile."Supplier Business Nature";
                TenderLine."Max Business Value" := SupplierProfile."Supplier Max Bussiness Value";
                TenderLine."Bankers Name" := SupplierProfile."Supplier Bankers Name";
                TenderLine."Business Registration Name" := SupplierProfile."Supplier Company Name";
                TenderLine."Document No." := TenderNo;
                TenderLine.Website := SupplierProfile."Supplier Website";
                TenderLine."KRA PIN" := SupplierProfile."Supplier Kra Pin Cert No";
                TenderLine."Supplier Profile ID" := SupplierProfileID;
                TenderLine."Document Type" := TenderLine."Document Type"::"Request for Proposal";

                if TenderLine.Insert then
                    ReturnValue := TenderLine."Application No"

                else
                    ReturnValue := GetLastErrorCode + '-' + GetLastErrorText;

            end;
        end else
            ReturnValue := '400: Supplier with Id ' + Format(SupplierProfileID) + ' does not exist';

    end;
}

