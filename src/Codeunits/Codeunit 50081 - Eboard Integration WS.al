codeunit 50081 "Eboard Integration WS"
{

    trigger OnRun()
    begin
        //CreateInvoiceHeader(1,'test001','C00010',102819D,102919D,'904921','','','');
        //CreateInvoiceHeader(2,'test002','C00010',102819D,102919D,'904921','','','')
        //MESSAGE(ReverseReceipt('299360'));
        //CreateDepositRefundHeader('PVDP0001',092820D,'','test','test','0001');

        //HYPERLINK(GenerateMinutesReport('001'));
        //HYPERLINK(Generate('0402','1-2022'));
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesPost: Codeunit "Sales-Post";
        FundsManagement: Codeunit "Funds Management";
        "DocNo.": Code[20];
        FundsUserSetup: Record "Funds User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        UserAccountNotSetup: Label 'User Account %1 is not Setup for Receipt Posting, Contact the System Administrator';
        SalesInvoiceHeader: Record "Sales Invoice Header";
        FundsGeneralSetup: Record "Funds General Setup";
        PaymentHeaderRec: Record "Payment Header";
        PaymentLineRec: Record "Payment Line";
        LineNo: Integer;
        CustomerRec: Record Customer;
        JournalVoucherHeader: Record "Journal Voucher Header";
        JournalVoucherLines: Record "Journal Voucher Lines";
        DepositTransactionRec: Record "Deposit Transaction";
        Employee: Record Employee;
        SaleInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        lineAmount: Decimal;
        MeetingMinutes: Record "Meeting Minutes";
        AgendaVoteItemsII: Record "Agenda vote items";
        MeetingAttachment: Record "Board Meeting Attachments";
        OnlineRepoCategory: Record "Online Repo Category";
        OnlineRepoDocument: Record "Online Repo Documents";
        BoardMeetings: Record "Board Meeting";
        MeetingAttendance: Record "Meeting Attendance";

    [Scope('Personalization')]
    procedure GetBoardMeetingList(var BoardMeetingExport: XMLport BoardMeetingExport)
    var
        BoardMeeting: Record "Board Meeting";
    begin
    end;

    [Scope('Personalization')]
    procedure GetBoardMeetingAgendaList(var BoardMeetingAgendaExport: XMLport BoardMeetingAgendaExport; MeetingCode: Code[50])
    var
        BoardMeetingAgenda: Record "Meeting Agenda";
    begin
        BoardMeetingAgenda.Reset;
        BoardMeetingAgenda.SetRange("Meeting No", MeetingCode);
        if BoardMeetingAgenda.FindFirst then;
        BoardMeetingAgendaExport.SetTableView(BoardMeetingAgenda);
    end;

    [Scope('Personalization')]
    procedure GetCommitteeList(var BoardCommitteeExport: XMLport BoardCommitteExport)
    var
        BoardMeeting: Record "Board Meeting";
    begin
        /*Employee.RESET;
        Employee.SETCURRENTKEY("Board Members Sequence");
        BoardCommitteeExport.SETTABLEVIEW(Employee);*/

    end;

    [Scope('Personalization')]
    procedure GetCommitteMembersList(var BoardCommitteeMembersExport: XMLport BoardCommitteMembersExport; CommitteeCode: Code[50])
    var
        CommitteeMembers: Record "Board Committee Members";
    begin
        CommitteeMembers.Reset;
        CommitteeMembers.SetRange("Committee Code", CommitteeCode);
        if CommitteeMembers.FindFirst then
            BoardCommitteeMembersExport.SetTableView(CommitteeMembers);
    end;

    [Scope('Personalization')]
    procedure GetMeetingVoteItemsList(var BoardMeetingVoteItemsExport: XMLport VoteItemsExport; MeetingCode: Code[50]; AgendaNo: Code[50])
    var
        VoteItems: Record "Agenda vote items";
    begin
        //VoteItemsExport ,VoteItems
        VoteItems.Reset;
        VoteItems.SetRange("Meeting No", MeetingCode);
        VoteItems.SetRange("Agenda No", AgendaNo);
        if VoteItems.FindFirst then;
        BoardMeetingVoteItemsExport.SetTableView(VoteItems);
    end;

    [Scope('Personalization')]
    procedure GetEvaluationsList(var BoardMembersEvaluationExport: XMLport EvaluationExport)
    var
        BoardMeeting: Record "Board Meeting";
    begin
    end;

    [Scope('Personalization')]
    procedure GetBoardMembersList(var BoardMembersExport: XMLport BoardMemebrsExport)
    var
        BoardMeeting: Record "Board Meeting";
    begin
    end;

    [Scope('Personalization')]
    procedure GetMeetingApprovalItemsList(var BoardMeetingApprovalItemsExport: XMLport BoardMeetingApprovalItemExport; MeetingCode: Code[50])
    var
        BoardMeeting: Record "Board Meeting";
    begin
    end;

    [Scope('Personalization')]
    procedure GetMeetingAttendanceList(var BoardMeetingAttendanceExport: XMLport MeetingAttendanceExport; MeetingCode: Code[50])
    var
        BoardMeetingAttendance: Record "Meeting Attendance";
    begin
        BoardMeetingAttendance.Reset;
        BoardMeetingAttendance.SetRange("Meeting No", MeetingCode);
        if BoardMeetingAttendance.FindFirst then;
        BoardMeetingAttendanceExport.SetTableView(BoardMeetingAttendance);
    end;

    [Scope('Personalization')]
    procedure GetMeetingCommentsList(var BoardMeetingCommentsExport: XMLport BoardMeetingCommentsExport; MeetingCode: Code[50])
    var
        BoardMeetingComments: Record "Meeting Comments";
    begin
        BoardMeetingComments.Reset;
        BoardMeetingComments.SetRange("Meeting No", MeetingCode);
        if BoardMeetingComments.FindFirst then;
        BoardMeetingCommentsExport.SetTableView(BoardMeetingComments);
    end;

    [Scope('Personalization')]
    procedure GetPeriods(var GetPayrollPeriods: XMLport GetPayrollPeriods; EmployeeNo: Code[20])
    var
        Employee: Record Employee;
        Periods: Record Periods;
    begin
        Employee.Get(EmployeeNo);
        Periods.Reset;
        Periods.SetFilter(Status, '=%1|%2', Periods.Status::Open, Periods.Status::Posted);
        Periods.SetRange("Approval Status", Periods."Approval Status"::Approved);
        Periods.SetRange("Payroll Code", Employee."Payroll Code");
        if Periods.FindFirst then;

        GetPayrollPeriods.SetTableView(Periods);
    end;

    [Scope('Personalization')]
    procedure GeneratePayslip(EmployeeNo: Code[20]; PayrollPeriod: Code[20]) ServerPath: Text
    var
        Payslips: Report "Portal Payslips";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        Period: Record Periods;
    begin

        Employee.Reset;
        Employee.Get(EmployeeNo);
        Period.SetRange("Period ID", PayrollPeriod);
        //Period.SETRANGE("Approval Status",Period."Approval Status"::Approved);
        if Period.FindFirst then begin
            //IF Period."Approval Status" = Period."Approval Status"::Approved THEN BEGIN
            //IF (Period."Enable Payslip" = TRUE) OR (Period."Approval Status" = Period."Approval Status"::Approved) THEN BEGIN
            PortalSetup.Reset;
            PortalSetup.Get;
            PortalSetup.TestField("Server File Path");
            PortalSetup.TestField("Local File Path");
            Filename := DelChr(EmployeeNo, '=', '/') + '_' + PayrollPeriod + '.pdf';
            Filepath := PortalSetup."Local File Path" + Filename;
            // if FILE.Exists(Filepath) then
            //   FILE.Erase(Filepath);
            Payslips.sSetParameters(PayrollPeriod, EmployeeNo);
            // Payslips.SaveAsPdf(Filepath);
            // if FILE.Exists(Filepath) then
            //   ServerPath:=PortalSetup."Server File Path"+Filename
            // else
            //   Error('There was an Error. Please Try again');
            //END ELSE ERROR('Payslip for this '+PayrollPeriod+' Period is NOT Ready. Please try Again Later.');
        end else
            Error('Payslip for this ' + PayrollPeriod + ' Period is NOT Ready. Please try Again Later.');
    end;

    [Scope('Personalization')]
    procedure CreateMeetingComments(MeetingNo: Code[20]; Comment: Text; DateCreated: Date; MemberNo: Code[20]; TimeCreated: Time; EntryNo: Code[20]) ReturnValue: Text
    var
        BoardMeetingComments: Record "Meeting Comments";
    begin
        BoardMeetingComments.Init;
        //BoardMeetingComments.VALIDATE("Entry No",EntryNo);
        //BoardMeetingComments."Meeting No" := MeetingNo;
        BoardMeetingComments.Validate("Meeting No", MeetingNo);
        BoardMeetingComments.Validate(Comment, Comment);
        BoardMeetingComments.Validate("Date Created", DateCreated);
        BoardMeetingComments.Validate("Member No", MemberNo);
        BoardMeetingComments.Validate("Time Created", TimeCreated);
        if BoardMeetingComments.Insert then
            ReturnValue := '200: Meeting Comment ' + Format(BoardMeetingComments."Entry No") + ' Created Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyMeetingComments(MeetingNo: Code[20]; Comment: Text; DateCreated: Date; MemberNo: Code[20]; TimeCreated: Time; EntryNo: Code[20]) ReturnValue: Text
    var
        BoardMeetingComments: Record "Meeting Comments";
    begin
        BoardMeetingComments.Get(MeetingNo);
        //BoardMeetingComments.VALIDATE("Entry No",EntryNo);
        BoardMeetingComments.Validate("Meeting No", MeetingNo);
        BoardMeetingComments.Validate(Comment, Comment);
        BoardMeetingComments.Validate("Date Created", DateCreated);
        BoardMeetingComments.Validate("Meeting No", MemberNo);
        BoardMeetingComments.Validate("Time Created", TimeCreated);
        if BoardMeetingComments.Modify then
            ReturnValue := '200: Meeting Comment ' + MeetingNo + ' Updated Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyMeetingAttendance(MeetingNo: Code[20]; MeetingName: Text; MeetingDate: Date; TypeofParticipant: Option; CommitteeCode: Code[50]; CommitteeName: Text; Venue: Text; MemberNo: Code[20]; MemberName: Text; Inattendance: Boolean; VisitorInstitution: Text; MeetingRole: Text; Attendance: Option " ",Present,Absent,"Absent With Apology"; ConfirmationofInvitation: Option " ",Yes,Maybe,No) ReturnValue: Text
    var
        MeetingAttendance: Record "Meeting Attendance";
    begin
        MeetingAttendance.Get(MeetingNo);
        MeetingAttendance.Validate("Meeting No", MeetingNo);
        MeetingAttendance.Validate("Member No", MemberNo);
        MeetingAttendance.Validate("Member Name", MemberName);
        MeetingAttendance.Validate("Committee Code", CommitteeCode);
        MeetingAttendance."Type of Participant" := TypeofParticipant;
        MeetingAttendance.Validate("Committee Name", CommitteeName);
        MeetingAttendance.Validate("In attendance", Inattendance);
        MeetingAttendance.Validate(Venue, Venue);
        MeetingAttendance.Validate("Meeting Date", MeetingDate);
        MeetingAttendance.Validate("Meeting Name", MeetingName);

        MeetingAttendance.Validate("Visitor Institution", VisitorInstitution);
        MeetingAttendance.Validate("Meeting Role", MeetingRole);
        MeetingAttendance.Validate("Attendance during the meeting", Attendance);
        MeetingAttendance.Validate("Confirmation of an invitation", ConfirmationofInvitation);

        if MeetingAttendance.Modify then
            ReturnValue := '200: Meeting ' + MeetingNo + ' updated Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure CreateMeetingVoteItems(VoterID: Code[20]; Name: Text; AgendaVoteItemCode: Code[20]; Voted: Boolean; VoteDecision: Option Yes,No,Abstain; MeetingNo: Code[20]; AgendaNo: Code[20]) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        AgendaVoteItems.Init;
        AgendaVoteItems.Validate("Voter ID", VoterID);
        AgendaVoteItems.Validate(Name, Name);
        AgendaVoteItems.Validate("Agenda Vote Item code", AgendaVoteItemCode);
        AgendaVoteItems.Validate("Vote decision", VoteDecision);
        AgendaVoteItems.Validate("Meeting No", MeetingNo);
        AgendaVoteItems.Validate("Agenda No", AgendaNo);
        if AgendaVoteItems.Insert then begin
            ReturnValue := Format(AgendaVoteItems."Entry No");//VoterID//'200: Vote Entry for '+Name+' Created Successfully'


            AgendaVoteItemsII.Reset;
            AgendaVoteItemsII.SetRange("Agenda No", AgendaVoteItems."Agenda No");
            AgendaVoteItemsII.SetRange("Item No", AgendaVoteItems."Agenda Vote Item code");
            AgendaVoteItemsII.SetRange("Meeting No", AgendaVoteItems."Meeting No");

            if AgendaVoteItemsII.FindFirst then begin
                if AgendaVoteItems."Vote decision" = AgendaVoteItems."Vote decision"::Yes then
                    AgendaVoteItemsII."Yes Count" := AgendaVoteItemsII."Yes Count" + 1
                else if AgendaVoteItems."Vote decision" = AgendaVoteItems."Vote decision"::No then
                    AgendaVoteItemsII."No Count" := AgendaVoteItemsII."No Count" + 1
                else if AgendaVoteItems."Vote decision" = AgendaVoteItems."Vote decision"::Abstain then
                    AgendaVoteItemsII."Abstain Count" := AgendaVoteItemsII."Abstain Count" + 1;

                AgendaVoteItemsII."Total Votes" := AgendaVoteItemsII."Total Votes" + 1;
                AgendaVoteItemsII.Modify;
            end;

        end
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyMeetingVoteItems(VoterID: Code[20]; Name: Text; AgendaVoteItemCode: Code[20]; Voted: Boolean; VoteDecision: Option Yes,No,Abstain; MeetingNo: Code[20]; AgendaNo: Code[20]) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        AgendaVoteItems.Get(VoterID);
        AgendaVoteItems.Validate("Voter ID", VoterID);
        AgendaVoteItems.Validate(Name, Name);
        AgendaVoteItems.Validate("Agenda Vote Item code", AgendaVoteItemCode);
        AgendaVoteItems.Validate("Vote decision", VoteDecision);
        AgendaVoteItems.Validate("Meeting No", MeetingNo);
        AgendaVoteItems.Validate("Agenda No", AgendaNo);
        if AgendaVoteItems.Modify then
            ReturnValue := '200: Vote Entry for' + Name + ' Updated Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetAgendaVoteItemsList(var AgendaVoteItemsExport: XMLport AgendaVoteItemsExport; AgendaVoteItemId: Code[50])
    var
        BoardMeetingComments: Record "Meeting Comments";
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        AgendaVoteItems.Reset;
        //AgendaVoteItems.SETRANGE("Voter ID",AgendaVoteItemId);
        AgendaVoteItems.SetRange("Agenda No", AgendaVoteItemId);
        if AgendaVoteItems.FindFirst then;
        AgendaVoteItemsExport.SetTableView(AgendaVoteItems);
    end;

    [Scope('Personalization')]
    procedure CreateMeetingMinutes(MeetingNo: Code[20]; AgendaNo: Code[20]; Minutes: Text) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingMinutes.Init;
        MeetingMinutes.Validate("Meeting No", MeetingNo);
        MeetingMinutes.Validate("Agenda No", AgendaNo);
        MeetingMinutes.Validate(Minutes, Minutes);
        if MeetingMinutes.Insert then
            ReturnValue := Format(MeetingMinutes."Entry No")//VoterID//'200: Vote Entry for '+Name+' Created Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure ModifyMeetingMinutes(EntryNo: Integer; MeetingNo: Code[20]; AgendaNo: Code[20]; Minutes: Text) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingMinutes.Get(EntryNo);
        MeetingMinutes.Validate("Meeting No", MeetingNo);
        MeetingMinutes.Validate("Agenda No", AgendaNo);
        MeetingMinutes.Validate(Minutes, Minutes);
        if MeetingMinutes.Modify then
            ReturnValue := Format(MeetingMinutes."Entry No")//FORMAT(MeetingMinutes.Minutes);
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetMeetingMinutes(var MeetingMinutesExport: XMLport MeetingMinutesExport; AgendaNo: Code[20]; MeetingNo: Code[20])
    var
        BoardMeetingComments: Record "Meeting Comments";
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingMinutes.Reset;
        MeetingMinutes.SetRange("Meeting No", MeetingNo);
        MeetingMinutes.SetRange("Agenda No", AgendaNo);
        if MeetingMinutes.FindFirst then;
        MeetingMinutesExport.SetTableView(MeetingMinutes);
    end;

    [Scope('Personalization')]
    procedure GenerateMinutesReport(meetingNo: Code[50]) ServerPath: Text
    var
        MeetingMinutesReport: Report "Eboard Meeting Minutes";
        Filename: Text;
        PortalSetup: Record "Portal Setup";
        Filepath: Text;
        Period: Record Periods;
    begin

        PortalSetup.Reset;
        PortalSetup.Get;
        PortalSetup.TestField("Server File Path");
        PortalSetup.TestField("Local File Path");
        Filename := DelChr(UserId, '=', '/') + '_' + meetingNo + '.pdf';
        Filepath := PortalSetup."Local File Path" + Filename;
        // if FILE.Exists(Filepath) then
        //   FILE.Erase(Filepath);
        //Payslips.sSetParameters(PayrollPeriod,EmployeeNo);
        //Payslips.SAVEASPDF(Filepath);

        MeetingMinutesReport.sSetParameters(meetingNo);
        // MeetingMinutesReport.SaveAsPdf(Filepath);
        // if FILE.Exists(Filepath) then
        //   ServerPath:=PortalSetup."Server File Path"+Filename
        // else
        //   Error('There was an Error. Please Try again');
    end;

    [Scope('Personalization')]
    procedure CreateMeetingAttachment(MeetingNo: Code[20]; Description: Text; FileName: Text; Comments: Text) ReturnValue: Text
    begin
        MeetingAttachment.Init;
        MeetingAttachment.Validate("Meeting No", MeetingNo);
        MeetingAttachment.Validate(Description, Description);
        MeetingAttachment.Validate(FileName, FileName);
        MeetingAttachment.Validate(Comments, Comments);
        if MeetingAttachment.Insert then
            ReturnValue := Format(MeetingMinutes."Entry No")//VoterID//'200: Vote Entry for '+Name+' Created Successfully'
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure DeleteMeetingAttachment(EntryNo: Integer; MeetingNo: Code[20]) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingAttachment.Reset;
        MeetingAttachment.SetRange("Meeting No", MeetingNo);
        MeetingAttachment.SetRange("Entry No", EntryNo);
        if MeetingAttachment.FindFirst then begin
            MeetingAttachment.Delete;
            ReturnValue := '200: Delete Successfully';
        end
        else
            ReturnValue := '400: Record Not Found';
    end;

    [Scope('Personalization')]
    procedure GetMeetingAttachments(var MeetingAttachmentsExport: XMLport BoardMeetingAttachmentExport; MeetingNo: Code[20])
    var
        BoardMeetingComments: Record "Meeting Comments";
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingAttachment.Reset;
        MeetingAttachment.SetRange("Meeting No", MeetingNo);
        if MeetingAttachment.FindFirst then;
        MeetingAttachmentsExport.SetTableView(MeetingAttachment);
    end;

    [Scope('Personalization')]
    procedure ModifyMeetingAttachments(EntryNo: Integer; MeetingNo: Code[20]; Description: Text; FileName: Text; Comments: Text) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingAttachment.Get(EntryNo);
        MeetingAttachment.Validate("Meeting No", MeetingNo);
        MeetingAttachment.Validate(Description, Description);
        MeetingAttachment.Validate(FileName, FileName);
        MeetingAttachment.Validate(Comments, Comments);
        if MeetingAttachment.Modify then
            ReturnValue := Format(MeetingAttachment."Entry No")//FORMAT(MeetingMinutes.Minutes);
        else
            ReturnValue := '400:' + GetLastErrorCode + '-' + GetLastErrorText;
    end;

    [Scope('Personalization')]
    procedure GetOnlineRepoCategoryList(var OnlineRepoCategoryExport: XMLport "Online Repo Category Export")
    var
        BoardMeeting: Record "Board Meeting";
    begin
    end;

    [Scope('Personalization')]
    procedure GetOnlineRepoDocumentList(var OnlineRepoDocumentExport: XMLport "Online Repo Document Export"; DocumentNo: Code[50])
    var
        BoardMeetingAgenda: Record "Meeting Agenda";
    begin
        OnlineRepoDocument.Reset;
        OnlineRepoDocument.SetRange("Document No", DocumentNo);
        if OnlineRepoDocument.FindFirst then;
        OnlineRepoDocumentExport.SetTableView(OnlineRepoDocument);
    end;

    [Scope('Personalization')]
    procedure GetBoardMemberDetails(var BoardMembersExport: XMLport BoardMemebrsExport; EmpNo: Code[20])
    var
        BoardMeeting: Record "Board Meeting";
    begin
        Employee.Reset;
        Employee.SetRange("No.", EmpNo);
        if Employee.FindFirst then;
        BoardMembersExport.SetTableView(Employee)
    end;

    [Scope('Personalization')]
    procedure GetMemberBoardMeetingList(var MeetingAttendanceExport: XMLport BoardMemberMettingsExport; EmpNo: Code[20])
    var
        BoardMeeting: Record "Board Meeting";
    begin
        MeetingAttendance.Reset;
        MeetingAttendance.SetRange("Member No", EmpNo);
        if MeetingAttendance.FindFirst then;
        MeetingAttendanceExport.SetTableView(MeetingAttendance)
    end;

    [Scope('Personalization')]
    procedure RemoveMemberFromMeeting(MemberNo: Code[20]; MeetingNo: Code[20]) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingAttendance.Reset;
        MeetingAttendance.SetRange("Meeting No", MeetingNo);
        MeetingAttendance.SetRange("Member No", MemberNo);
        if MeetingAttendance.FindFirst then begin
            MeetingAttendance.Delete;
            ReturnValue := '200: Delete Successfully';
        end
        else
            ReturnValue := '400: Record Not Found';
    end;

    [Scope('Personalization')]
    procedure ModifyAttendanceStatus(MemberNo: Code[20]; MeetingNo: Code[20]; AttendanceStatus: Option " ",Present,Absent,"Absent With Apology"; AbsentReason: Text) ReturnValue: Text
    var
        AgendaVoteItems: Record "Agenda Item Voters";
    begin
        MeetingAttendance.Reset;
        MeetingAttendance.SetRange("Meeting No", MeetingNo);
        MeetingAttendance.SetRange("Member No", MemberNo);
        if MeetingAttendance.FindFirst then begin
            MeetingAttendance."Attendance during the meeting" := AttendanceStatus;
            MeetingAttendance."Absentism Reason" := AbsentReason;
            MeetingAttendance.Modify;
            ReturnValue := '200: Status Updated Successfully';
        end
        else
            ReturnValue := '400: Record Not Found';
    end;
}

