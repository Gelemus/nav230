codeunit 51107 "Table Code Transferred-Layer"
{
    // Permissions = TableData TableData52020881=rimd,
    //               TableData TableData52020883=rimd;

    trigger OnRun()
    begin
    end;

    var
        Text001: Label '%1 is not a valid limit type for table %2.';
        Text002: Label '%1 is only valid for table %2.';
        Text004: Label '%1 is only valid when document type is Quote and Table ID is %2.';
        Text006: Label 'Do you want to cancel all outstanding approvals? ';
        Text007: Label 'Additional Approvers must be inserted if %1 is %2 and %3 is Credit Limit.';
        Text005: Label 'Additional Approvers must be inserted if %1 is blank.';
        Text008: Label 'You have canceled the create process.';
        Text009: Label 'Replace existing attachment?';
        Text010: Label 'You have canceled the import process.';
        Text012: Label '\Doc';
}

