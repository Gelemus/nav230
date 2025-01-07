namespace spaBC.spaBC;

using Microsoft.Bank.Reconciliation;
using Microsoft.Bank.Ledger;
using Microsoft.Utilities;
using System.IO;
using System;
using System.Environment;
using System.Integration;
using System.Utilities;

codeunit 50055 CustomCodeFromStandard
{
    // procedure MatchManually2(VAR SelectedBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; VAR SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry");
    // VAR
    //     BankAccReconciliationLine: Record "Bank Acc. Statement Linevb";
    //     BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    //     BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
    //     BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
    // BEGIN
    //     IF SelectedBankAccReconciliationLine.FINDFIRST THEN BEGIN
    //         BankAccReconciliationLine.GET(
    //           SelectedBankAccReconciliationLine."Statement Type",
    //           SelectedBankAccReconciliationLine."Bank Account No.",
    //           SelectedBankAccReconciliationLine."Statement No.",
    //           SelectedBankAccReconciliationLine."Statement Line No.");
    //         IF BankAccReconciliationLine.Type <> BankAccReconciliationLine.Type::"Bank Account Ledger Entry" THEN
    //             EXIT;

    //         IF SelectedBankAccountLedgerEntry.FINDSET THEN BEGIN
    //             REPEAT
    //                 BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
    //                 BankAccEntrySetReconNo.RemoveApplication2(BankAccountLedgerEntry);
    //                 //**changes added to include the matched statement line to the reconciliation line
    //                 BankAccReconciliationLine2.RESET;
    //                 BankAccReconciliationLine2.SETRANGE("Bank Ledger Entry Line No", BankAccountLedgerEntry."Entry No.");
    //                 BankAccReconciliationLine2.FINDSET;
    //                 BankAccEntrySetReconNo.ApplyEntries2(BankAccReconciliationLine2, BankAccountLedgerEntry, Relation::"One-to-Many", SelectedBankAccReconciliationLine);
    //             UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
    //         END;
    //     END;
    // END;

    // procedure RemoveMatch2(VAR SelectedBankAccReconciliationLine: Record "Bank Acc. Statement Linevb"; VAR SelectedBankAccountLedgerEntry: Record "Bank Account Ledger Entry");
    // VAR
    //     BankAccReconciliationLine: Record "Bank Acc. Statement Linevb";
    //     BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    //     BankAccEntrySetReconNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
    //     BankAccReconciliationLine2: Record "Bank Acc. Reconciliation Line";
    // BEGIN
    //     IF SelectedBankAccReconciliationLine.FINDSET THEN
    //         REPEAT
    //             BankAccReconciliationLine.GET(
    //               SelectedBankAccReconciliationLine."Statement Type",
    //               SelectedBankAccReconciliationLine."Bank Account No.",
    //               SelectedBankAccReconciliationLine."Statement No.",
    //               SelectedBankAccReconciliationLine."Statement Line No.");
    //             BankAccountLedgerEntry.SETRANGE("Bank Account No.", BankAccReconciliationLine."Bank Account No.");
    //             BankAccountLedgerEntry.SETRANGE("Statement No.", BankAccReconciliationLine."Statement No.");
    //             BankAccountLedgerEntry.SETRANGE("Statement Line No.", BankAccReconciliationLine."Statement Line No.");
    //             BankAccountLedgerEntry.SETRANGE(Open, TRUE);
    //             BankAccountLedgerEntry.SETRANGE("Statement Status", BankAccountLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
    //             IF BankAccountLedgerEntry.FINDSET THEN
    //                 REPEAT
    //                     BankAccEntrySetReconNo.RemoveApplication2(BankAccountLedgerEntry);
    //                 UNTIL BankAccountLedgerEntry.NEXT = 0;
    //         UNTIL SelectedBankAccReconciliationLine.NEXT = 0;

    //     IF SelectedBankAccountLedgerEntry.FINDSET THEN
    //         REPEAT
    //             BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
    //             BankAccEntrySetReconNo.RemoveApplication2(BankAccountLedgerEntry);
    //         UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
    // END;

    // procedure MatchSingle2(BankAccReconciliation: Record "Bank Acc. Reconciliation"; DateRange: Integer);
    // VAR
    //     TempBankStatementMatchingBuffer: Record "Bank Statement Matching Buffer";
    //     BankRecMatchCandidates: Query "Bank Rec. Match Candidates";
    //     Window: Dialog;
    //     Score: Integer;
    //     mainCu : Codeunit "Match Bank Rec. Lines";
    // BEGIN
    //     TempBankStatementMatchingBuffer.DELETEALL;

    //     Window.OPEN('Please wait while the operation is being completed.');
    //     mainCu.SetMatchLengthTreshold(4);
    //     mainCu.SetNormalizingFactor(10);
    //     BankRecMatchCandidates.SETRANGE(Rec_Line_Bank_Account_No, BankAccReconciliation."Bank Account No.");
    //     BankRecMatchCandidates.SETRANGE(Rec_Line_Statement_No, BankAccReconciliation."Statement No.");
    //     IF BankRecMatchCandidates.OPEN THEN
    //         WHILE BankRecMatchCandidates.READ DO BEGIN
    //             Score := 0;

    //             IF BankRecMatchCandidates.Rec_Line_Difference = BankRecMatchCandidates.Remaining_Amount THEN
    //                 Score += 13;

    //             //change the matching to check with check no.
    //             IF BankRecMatchCandidates.Rec_Line_Check_No = BankRecMatchCandidates.External_Document_No THEN
    //                 Score += 12;

    //             Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_Description, BankRecMatchCandidates.Description,
    //                 BankRecMatchCandidates.Document_No, BankRecMatchCandidates.External_Document_No);

    //             Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_RltdPty_Name, BankRecMatchCandidates.Description,
    //                 BankRecMatchCandidates.Document_No, BankRecMatchCandidates.External_Document_No);

    //             Score += GetDescriptionMatchScore(BankRecMatchCandidates.Rec_Line_Transaction_Info, BankRecMatchCandidates.Description,
    //                 BankRecMatchCandidates.Document_No, BankRecMatchCandidates.External_Document_No);

    //             IF BankRecMatchCandidates.Rec_Line_Difference <> BankRecMatchCandidates.Remaining_Amount THEN    //changes if check no is same, but amount is diff.
    //                 Score := 0;
    //             IF BankRecMatchCandidates.Rec_Line_Check_No <> BankRecMatchCandidates.External_Document_No THEN
    //                 Score := 0;
    //             IF BankRecMatchCandidates.Rec_Line_Check_No = '' THEN
    //                 Score := 0;
    //             IF BankRecMatchCandidates.Rec_Line_Check_No <> BankRecMatchCandidates.External_Document_No THEN
    //                 Score := 0;

    //             IF Score > 2 THEN
    //                 TempBankStatementMatchingBuffer.AddMatchCandidate(BankRecMatchCandidates.Rec_Line_Statement_Line_No,
    //                   BankRecMatchCandidates.Entry_No, Score, 0, '');
    //         END;

    //     SaveOneToOneMatching(TempBankStatementMatchingBuffer, BankAccReconciliation."Bank Account No.",
    //       BankAccReconciliation."Statement No.");

    //     Window.CLOSE;
    //     ShowMatchSummary(BankAccReconciliation);




    // END;
}