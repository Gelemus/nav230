page 50356 "Commitee Creation Card"
{
    PageType = Card;
    SourceTable = "Tender Commitee Appointment";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appointment No"; Rec."Appointment No")
                {
                    Editable = false;
                }
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Committee ID"; Rec."Committee ID")
                {
                    Caption = 'Committee Type';
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    Caption = 'Committee  Name';
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("No of Members"; Rec."No of Members")
                {
                }
                field("Deadline For Report Submission"; Rec."Deadline For Report Submission")
                {
                }
                field("No of Approvers"; Rec."No of Approvers")
                {
                    Editable = false;
                }
                field(Used; Rec.Used)
                {
                    Editable = false;
                }
                field("Opening_Evaluation Same"; Rec."Opening_Evaluation Same")
                {
                    Caption = 'Opening & Evaluation Same';
                    Editable = false;
                }
            }
            part(Control1000000016; "Commitee Members Subform")
            {
                SubPageLink = "Appointment No" = FIELD("Appointment No");
                SubPageView = SORTING("Appointment No", "Employee No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Committee ")
            {
                Caption = 'Committee ';
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    thisrec.Reset;
                    thisrec.SetFilter("Appointment No", Rec."Appointment No");
                    if thisrec.FindSet then begin
                        REPORT.Run(51511750, true, false, thisrec);

                    end;
                end;
            }
            action(PrintPDF)
            {
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rfqname := Rec."Appointment No";
                    rfqname2 := Rec."Tender/Quotation No";
                    rfqname := ConvertStr(rfqname, '/', '_');
                    rfqname := ConvertStr(rfqname, '\', '_');
                    //  thepdffilename:=PurchSetup."RFQ Documents Path"+(FORMAT(rfqname))+'_'+rfqname2+'.pdf';
                    Clear(thepdffilename);
                    Rec.saveCommiteeReport(Rec);

                    PurchSetup.Get;

                    rfqname2 := ConvertStr(rfqname2, '/', '_');
                    rfqname2 := ConvertStr(rfqname2, '\', '_');
                    //HYPERLINK(PurchSetup."RFQ Documents Path"+(FORMAT(rfqname))+'_'+rfqname2+'.pdf');
                end;
            }
            action("Send Approval Request.")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //======================Checking if it has members
                    committemembers.Reset;
                    committemembers.SetFilter("Appointment No", Rec."Appointment No");
                    if not committemembers.FindSet then begin
                        Error('Please Add Committee Members!');
                    end;
                    //================================================


                    //=====================================DBMS Connections====================================================
                    /*"Attached?":=FALSE;
                    GLSetup.RESET;
                    GLSetup.GET;
                    GLSetup.TESTFIELD("DBMS Host Server");
                    GLSetup.TESTFIELD("DMS DB Link");
                    GLSetup.TESTFIELD("DBMS Staging DB");
                    GLSetup.TESTFIELD("Imprest DB Table");
                    
                    ServerName:=GLSetup."DBMS Host Server";
                    NAVDB:=GLSetup."DBMS Staging DB";
                    //ServerName:='192.168.230.11';
                    //BDUserID:='navdb';
                    //BDUserID:='LAPTOP-L7NM5T6N\Attain';
                    //BDPW:='100Bags!';
                    //ERROR('%1..%2',ServerName,NAVDB);
                    //ConnectionString:='Data Source='+ServerName+'Initial Catalog='+NAVDB+'Trusted_Connection=True';
                    ConnectionString:='Data Source='+ServerName+';Initial Catalog='+NAVDB+';Trusted_Connection=True';
                    //ConnectionString:='Data Source='+ServerName+';Initial Catalog='+NAVDB+';UID='+BDUserID+';Pwd='+BDPW+';';
                    
                    SQLConnection:=SQLConnection.SqlConnection(ConnectionString);
                    SQLConnection.Open;
                    //ERROR('...');
                    SQLCommand:=SQLConnection.CreateCommand();
                    Docnobd2:=STRSUBSTNO(Docnobd,"Appointment No");
                    SQLStt:=STRSUBSTNO(BDSTT,GLSetup."DMS DB Link",GLSetup."Imprest DB Table",Docnobd2);
                    //ERROR(SQLStt);//sql statement
                    SQLCommand.CommandText:=SQLStt;
                    SQReader:=SQLCommand.ExecuteReader;
                    WHILE SQReader.Read() DO BEGIN
                        //MESSAGE('%1...%2',FORMAT(SQReader.GetString(1)),FORMAT(SQReader.GetString(2)));
                        "Attached?":=TRUE;
                    END;
                    
                    SQLConnection.Close;
                    CLEAR(SQReader);
                    CLEAR(SQLCommand);
                    CLEAR(SQLConnection);
                    //ERROR('');
                    IF "Attached?"=FALSE THEN BEGIN
                      // ERROR('Please add attachments First!');
                    END;
                    //========================================================================================================
                    
                    commiterec.RESET;
                    commiterec.SETFILTER("Appointment No","Appointment No");
                    IF NOT commiterec.FINDSET THEN BEGIN
                       ERROR('Please add Committee Members!');
                    END;
                    
                    
                    
                    IF approvalsmgmt.CheckERCComReqApprovalsWorkflowEnabled(Rec) THEN
                      approvalsmgmt.OnSendERCComReqForApproval(Rec);
                      */
                    // IF ApprovalMgt.OnSendImprestHeaderForApproval(Rec) THEN
                    //ApprovalMgt.OnSendImprestSurrenderHeaderForApproval(Rec);

                end;
            }
            action("Cancel Approval Request.")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = OpenApprovalEntriesExistForCurrUser2;

                trigger OnAction()
                begin

                    if Rec.Status <> Rec.Status::Released then
                    ;//approvalsmgmt.GetApprovalCommentERC(Rec,0,"Appointment No");
                end;
            }
            action("DMS Link")
            {
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //GLSetup.GET();
                    //Link:=GLSetup."DMS Imprest Link"+"Appointment No";
                    //HYPERLINK(Link);
                end;
            }
            action("Approval Entries")
            {
                Image = Approvals;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Page "Approval Entries";
                RunPageMode = View;
            }
            group(Approval)
            {
                Caption = 'Approval';
                Image = Alerts;
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                        //CurrPage.CLOSE;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                        //ApprovalsMgmt.GetApprovalCommentERC(Rec,1,"Appointment No");
                        //CurrPage.CLOSE;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                        //CurrPage.CLOSE;
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //saveCommiteeReport(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then begin
            Error('You can only Delete Open Committees!');
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then begin
            Error('You can only Modify Open Committees!');
        end;
    end;

    trigger OnOpenPage()
    begin
        /*approvalentry.RESET;
        approvalentry.SETFILTER(approvalentry.Status,'%1',approvalentry.Status::Open);
        approvalentry.SETFILTER(approvalentry."Document Type",'%1',approvalentry."Document Type"::Commitee);
        approvalentry.SETFILTER(approvalentry."Approver ID",'%1',USERID);
        approvalentry.SETFILTER(approvalentry."Document No.","Appointment No");
        IF approvalentry.FINDSET THEN BEGIN
           OpenApprovalEntriesExistForCurrUser:=TRUE;
          //MESSAGE('Approver...');
        END;
        IF NOT approvalentry.FINDSET THEN BEGIN
           OpenApprovalEntriesExistForCurrUser2:=TRUE;
          // MESSAGE('Not an Approver...');
        END;
        IF OpenApprovalEntriesExistForCurrUser=TRUE THEN BEGIN
           OpenApprovalEntriesExistForCurrUser2:=FALSE;
        END;
        */

    end;

    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        approvalsmgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        approvalentry: Record "Approval Entry";
        OpenApprovalEntriesExistForCurrUser2: Boolean;
        i: Integer;
        approvalentries: Record "Approval Entry";
        CUST: Record Customer;
        Internationalsee: Boolean;
        Localsee: Boolean;
        //dotnetvalue: DotNet Interaction;
        commentmsg: Text;
        commentline: Record "Approval Comment Line";
        // SQLConnection: DotNet SqlConnection;
        // SQLCommand: DotNet SqlCommand;
        // SQReader: DotNet SqlDataReader;
        ServerName: Text;
        NAVDB: Text;
        ConnectionString: Text;
        BDUserID: Text;
        BDPW: Text;
        SQLStt: Text;
        "Attached?": Boolean;
        Docnobd2: Text;
        BDSTT: Label 'SELECT * FROM %1%2 WHERE [CONTACTS]=''%3''';
        BDSTT2: Label 'SELECT * FROM [ERC2017].dbo.[ERC$Customer] where [No_]=''%1''';
        BDSTT3: Label 'SELECT * FROM [192.168.230.11].[DMSDB].[dbo].[CF_IMPREST]';
        BDSTT4: Label 'SELECT * FROM OPENQUERY([192.168.230.11],''%1'')';
        BDSTT41: Label 'SELECT * FROM [DMSDB].[dbo].[CF_IMPREST]';
        Docnobd: Label '%1';
        Link: Text;
        commiterec: Record "Commitee Members";
        thisrec: Record "Tender Commitee Appointment";
        thisrecord: Record "Tender Commitee Appointment";
        rfqname: Text;
        rfqname2: Text;
        PurchSetup: Record "Purchases & Payables Setup";
        thepdffilename: Text;
        committemembers: Record "Commitee Members";

    //  trigger SQLCommand::StatementCompleted(sender: Variant;e: DotNet StatementCompletedEventArgs)
    //  begin
    //  end;

    // trigger SQLCommand::Disposed(sender: Variant;e: DotNet EventArgs)
    // begin
    // end;

    // trigger SQLConnection::InfoMessage(sender: Variant;e: DotNet SqlInfoMessageEventArgs)
    // begin
    // end;

    // trigger SQLConnection::StateChange(sender: Variant;e: DotNet StateChangeEventArgs)
    // begin
    // end;

    // trigger SQLConnection::Disposed(sender: Variant;e: DotNet EventArgs)
    // begin
    // end;
}

