table 51116 "Document Generation Log"
{
    Permissions = TableData "G/L Entry"=rimd;

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(2;"Account Type";Option)
        {
            OptionCaption = 'Customer,Vendor,Employee';
            OptionMembers = Customer,Vendor,Employee;
        }
        field(3;"Account No.";Code[20])
        {
        }
        field(4;Document;BLOB)
        {
        }
        field(5;"E-mailed To";Text[80])
        {
        }
        field(6;DateTime;DateTime)
        {
        }
        field(7;"Document Type";Option)
        {
            OptionCaption = 'Sales Invoice,Service Invoice,Customer Statement,Remittance Advice,Payslips,Payment Receipts,EFT Remittance Advice,Reminder,Purchase Order';
            OptionMembers = "Sales Invoice","Service Invoice","Customer Statement","Remittance Advice",Payslips,"Payment Receipts","EFT Remittance Advice",Reminder,"Purchase Order";
        }
        field(8;"File Extension";Text[250])
        {
            Caption = 'File Extension';
        }
        field(9;"Document No";Code[20])
        {
        }
        field(10;Send;Boolean)
        {

            trigger OnValidate()
            begin
                if Send then TestField("E-Mailed",false);
            end;
        }
        field(11;"E-Mailed";Boolean)
        {
        }
        field(12;"E-Mailed By";Code[50])
        {
        }
        field(13;"E-Mail DateTime";DateTime)
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text002: Label 'The attachment is empty.';
        Text003: Label 'Attachment is already in use on this machine.';
        Text004: Label 'When you have saved your document, click Yes to import the document.';
        Text005: Label 'Export Attachment';
        Text006: Label 'Import Attachment';
        Text007: Label 'All Files (*.*)|*.*';
        Text008: Label 'Error during copying file.';
        Text009: Label 'Do you want to remove %1?';
        Text010: Label 'External file could not be removed.';
        Text012: Label '\Doc';
        Text013: Label 'You can only print Microsoft Word documents.';
        Text014: Label 'You can only fax Microsoft Word documents.';
        Text015: Label 'The e-mail has been deleted.';
        Text016: Label 'When you have finished working with a document, you should delete the associated temporary file. Please note that this will not delete the document.\\Do you want to delete the temporary file?';
        AutomationManagement: Codeunit "File Management";
        TableCodeTransfer: Codeunit "Table Code Transferred-Layer";

    procedure ExportAttachment(ExportToFile: Text[260]): Boolean
    var
        FileName: Text[260];
        FileFilter: Text[260];
    begin
        //EXIT(TableCodeTransfer.DocGenLogExportAttachment(Rec,ExportToFile));
    end;

    procedure DeleteFile(FileName: Text[260]): Boolean
    var
        I: Integer;
    begin
        //EXIT(TableCodeTransfer.DocGenLogDeleteFile(FileName));
    end;

    procedure ConstFilename() FileName: Text[260]
    var
        I: Integer;
        DocNo: Text[30];
    begin
        //EXIT(TableCodeTransfer.DocGenLogConstFilename);
    end;
}

