report 50021 "Journal Voucher Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Journal Voucher Report.rdl';

    dataset
    {
        dataitem("Journal Voucher Header"; "Journal Voucher Header")
        {
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            column(JVNo_JournalVoucherHeader; "Journal Voucher Header"."JV No.")
            {
            }
            column(Documentdate_JournalVoucherHeader; "Journal Voucher Header"."Document date")
            {
            }
            column(PostingDate_JournalVoucherHeader; "Journal Voucher Header"."Posting Date")
            {
            }
            column(DateCreated_JournalVoucherHeader; "Journal Voucher Header"."Date Created")
            {
            }
            column(UserID_JournalVoucherHeader; "Journal Voucher Header"."User ID")
            {
            }
            column(Status_JournalVoucherHeader; "Journal Voucher Header".Status)
            {
            }
            column(Description_JournalVoucherHeader; "Journal Voucher Header".Description)
            {
            }
            column(JVLinesCont_JournalVoucherHeader; "Journal Voucher Header"."JV Lines Cont")
            {
            }
            column(TotalAmount_JournalVoucherHeader; "Journal Voucher Header"."Total Amount")
            {
            }
            column(NoSeries_JournalVoucherHeader; "Journal Voucher Header"."No. Series")
            {
            }
            column(Posted_JournalVoucherHeader; "Journal Voucher Header".Posted)
            {
            }
            column(TimePosted_JournalVoucherHeader; "Journal Voucher Header"."Time Posted")
            {
            }
            column(PostedBy_JournalVoucherHeader; "Journal Voucher Header"."Posted By")
            {
            }
            column(Reversed_JournalVoucherHeader; "Journal Voucher Header".Reversed)
            {
            }
            column(ReversalDate_JournalVoucherHeader; "Journal Voucher Header"."Reversal Date")
            {
            }
            column(ReversalTime_JournalVoucherHeader; "Journal Voucher Header"."Reversal Time")
            {
            }
            column(ReversedBy_JournalVoucherHeader; "Journal Voucher Header"."Reversed By")
            {
            }
            column(Approval1_; Approval1)
            {
            }
            column(Approval1Date_; Approval1Date)
            {
            }
            column(EmployeeSignature; TenantMedia.Content)
            {
            }
            column(Approval2; Approval2)
            {
            }
            column(Approval2Date_; Approval2Date)
            {
            }
            column(EmployeeSignature2; TenantMedia1.Content)
            {
            }
            column(Approval3; Approval3)
            {
            }
            column(Approval3Date_; Approval3Date)
            {
            }
            column(EmployeeSignature3; TenantMedia2.Content)
            {
            }
            column(Approval4; Approval4)
            {
            }
            column(Approval4Date_; Approval4Date)
            {
            }
            column(EmployeeSignature4; TenantMedia3.Content)
            {
            }
            column(Approval5; Approval5)
            {
            }
            column(Approval5Date_; Approval5Date)
            {
            }
            column(EmployeeSignature5; TenantMedia4.Content)
            {
            }
            dataitem("Journal Voucher Lines"; "Journal Voucher Lines")
            {
                DataItemLink = "JV No." = FIELD("JV No.");
                column(JVNo_JournalVoucherLines; "Journal Voucher Lines"."JV No.")
                {
                }
                column(AccountName_JournalVoucherLines; "Journal Voucher Lines"."Account Name")
                {
                }
                column(BalAccountName_JournalVoucherLines; "Journal Voucher Lines"."Bal. Account Name")
                {
                }
                column(LineNo_JournalVoucherLines; "Journal Voucher Lines"."Line No.")
                {
                }
                column(AccountType_JournalVoucherLines; "Journal Voucher Lines"."Account Type")
                {
                }
                column(AccountNo_JournalVoucherLines; "Journal Voucher Lines"."Account No.")
                {
                }
                column(PostingDate_JournalVoucherLines; "Journal Voucher Lines"."Posting Date")
                {
                }
                column(DocumentType_JournalVoucherLines; "Journal Voucher Lines"."Document Type")
                {
                }
                column(DocumentNo_JournalVoucherLines; "Journal Voucher Lines"."Document No.")
                {
                }
                column(Description_JournalVoucherLines; "Journal Voucher Lines".Description)
                {
                }
                column(VAT_JournalVoucherLines; "Journal Voucher Lines"."VAT %")
                {
                }
                column(BalAccountNo_JournalVoucherLines; "Journal Voucher Lines"."Bal. Account No.")
                {
                }
                column(CurrencyCode_JournalVoucherLines; "Journal Voucher Lines"."Currency Code")
                {
                }
                column(Amount_JournalVoucherLines; "Journal Voucher Lines".Amount)
                {
                }
                column(DebitAmount_JournalVoucherLines; "Journal Voucher Lines"."Debit Amount")
                {
                }
                column(CreditAmount_JournalVoucherLines; "Journal Voucher Lines"."Credit Amount")
                {
                }
                column(AmountLCY_JournalVoucherLines; "Journal Voucher Lines"."Amount (LCY)")
                {
                }
                column(BalanceLCY_JournalVoucherLines; "Journal Voucher Lines"."Balance (LCY)")
                {
                }
                column(CurrencyFactor_JournalVoucherLines; "Journal Voucher Lines"."Currency Factor")
                {
                }
                column(ShortcutDimension1Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 2 Code")
                {
                }
                column(AppliestoDocType_JournalVoucherLines; "Journal Voucher Lines"."Applies-to Doc. Type")
                {
                }
                column(AppliestoDocNo_JournalVoucherLines; "Journal Voucher Lines"."Applies-to Doc. No.")
                {
                }
                column(BalAccountType_JournalVoucherLines; "Journal Voucher Lines"."Bal. Account Type")
                {
                }
                column(ExternalDocumentNo_JournalVoucherLines; "Journal Voucher Lines"."External Document No.")
                {
                }
                column(FAPostingDate_JournalVoucherLines; "Journal Voucher Lines"."FA Posting Date")
                {
                }
                column(FAPostingType_JournalVoucherLines; "Journal Voucher Lines"."FA Posting Type")
                {
                }
                column(DepreciationBookCode_JournalVoucherLines; "Journal Voucher Lines"."Depreciation Book Code")
                {
                }
                column(Description2_JournalVoucherLines; "Journal Voucher Lines".Description2)
                {
                }
                column(ShortcutDimension3Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 4 Code")
                {
                }
                column(ShortcutDimension5Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 5 Code")
                {
                }
                column(ShortcutDimension6Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 6 Code")
                {
                }
                column(ShortcutDimension7Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 7 Code")
                {
                }
                column(ShortcutDimension8Code_JournalVoucherLines; "Journal Voucher Lines"."Shortcut Dimension 8 Code")
                {
                }
                column(PostingGroup_JournalVoucherLines; "Journal Voucher Lines"."Posting Group")
                {
                }
                column(Posted_JournalVoucherLines; "Journal Voucher Lines".Posted)
                {
                }
                column(DatePosted_JournalVoucherLines; "Journal Voucher Lines"."Date Posted")
                {
                }
                column(PostedBy_JournalVoucherLines; "Journal Voucher Lines"."Posted By")
                {
                }
                column(TimePosted_JournalVoucherLines; "Journal Voucher Lines"."Time Posted")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ApprovalEntryRec.Reset;
                ApprovalEntryRec.SetRange("Document No.", "Journal Voucher Header"."JV No.");
                if ApprovalEntryRec.FindFirst then
                    repeat
                        if ApprovalEntryRec."Sequence No." = 1 then begin
                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", ApprovalEntryRec."Sender ID");
                            if EmployeeRec.FindFirst then begin
                                TenantMedia1.Reset;
                                if EmployeeRec."Employee Signature".HasValue then begin
                                    TenantMedia.Get(EmployeeRec."Employee Signature".MediaId);
                                    TenantMedia.CalcFields(Content);
                                end;

                                Approval1 := EmployeeRec.FullName;
                            end;
                            //Approver 2 detailsa
                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", ApprovalEntryRec."Approver ID");
                            if EmployeeRec.FindFirst then begin
                                TenantMedia1.Reset;
                                if EmployeeRec."Employee Signature".HasValue then begin
                                    TenantMedia1.Get(EmployeeRec."Employee Signature".MediaId);
                                    TenantMedia1.CalcFields(Content);
                                end;
                                Approval2 := EmployeeRec.FullName;
                            end;
                            //approval dates
                            Approval1Date := ApprovalEntryRec."Date-Time Sent for Approval";
                            Approval2Date := ApprovalEntryRec."Last Date-Time Modified";


                        end else if ApprovalEntryRec."Sequence No." = 2 then begin
                            //Approver 3 detailsa
                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", ApprovalEntryRec."Approver ID");
                            if EmployeeRec.FindFirst then begin
                                TenantMedia2.Reset;
                                if EmployeeRec."Employee Signature".HasValue then begin
                                    TenantMedia2.Get(EmployeeRec."Employee Signature".MediaId);
                                    TenantMedia2.CalcFields(Content);
                                end;
                                Approval3 := EmployeeRec.FullName;
                            end;
                            //approval dates
                            Approval3Date := ApprovalEntryRec."Last Date-Time Modified";
                        end else if ApprovalEntryRec."Sequence No." = 3 then begin
                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", ApprovalEntryRec."Approver ID");
                            if EmployeeRec.FindFirst then begin
                                TenantMedia3.Reset;
                                if EmployeeRec."Employee Signature".HasValue then begin
                                    TenantMedia3.Get(EmployeeRec."Employee Signature".MediaId);
                                    TenantMedia3.CalcFields(Content);
                                end;
                                Approval4 := EmployeeRec.FullName;
                            end;
                            //approval dates
                            Approval4Date := ApprovalEntryRec."Last Date-Time Modified";
                        end else if ApprovalEntryRec."Sequence No." = 4 then begin
                            EmployeeRec.Reset;
                            EmployeeRec.SetRange("User ID", ApprovalEntryRec."Approver ID");
                            if EmployeeRec.FindFirst then begin
                                TenantMedia4.Reset;
                                if EmployeeRec."Employee Signature".HasValue then begin
                                    TenantMedia4.Get(EmployeeRec."Employee Signature".MediaId);
                                    TenantMedia4.CalcFields(Content);
                                end;
                                Approval5 := EmployeeRec.FullName;
                            end;
                            //approval dates
                            Approval5Date := ApprovalEntryRec."Last Date-Time Modified";
                        end;

                    until ApprovalEntryRec.Next = 0;
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
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        TenantMedia: Record "Tenant Media";
        EmployeeRec: Record Employee;
        Approval1: Code[50];
        ApprovedByCaption: Text;
        Approval1Date: DateTime;
        Approval2: Code[50];
        Approval2Date: DateTime;
        Approval3: Code[50];
        Approval3Date: DateTime;
        Approval4: Code[50];
        Approval4Date: DateTime;
        Approval5: Code[50];
        Approval5Date: DateTime;
        Approval1Signature: Integer;
        TenantMedia1: Record "Tenant Media";
        ApprovalEntryRec: Record "Approval Entry";
        TenantMedia2: Record "Tenant Media";
        TenantMedia3: Record "Tenant Media";
        TenantMedia4: Record "Tenant Media";
}

