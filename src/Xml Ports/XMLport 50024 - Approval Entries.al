xmlport 50024 "Approval Entries"
{
    Format = Xml;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Approvalroot)
        {
            tableelement("Approval Entry";"Approval Entry")
            {
                AutoUpdate = true;
                XmlName = 'Approval';
                fieldelement(DocumentType;"Approval Entry"."Document Type")
                {
                }
                fieldelement(DocumentNo;"Approval Entry"."Document No.")
                {
                }
                fieldelement(SequenceNo;"Approval Entry"."Sequence No.")
                {
                }
                fieldelement(SenderID;"Approval Entry"."Sender ID")
                {
                }
                fieldelement(ApproverID;"Approval Entry"."Approver ID")
                {
                }
                fieldelement(Status;"Approval Entry".Status)
                {
                }
                fieldelement(DueDate;"Approval Entry"."Due Date")
                {
                }
                textelement(employeeno)
                {
                    XmlName = 'EmployeeNo';
                }
                fieldelement(RejectionComments;"Approval Entry"."Rejection Comments")
                {
                }
                fieldelement(LastModifiedBy;"Approval Entry"."Last Modified By User ID")
                {
                }
                fieldelement(Description;"Approval Entry".Description)
                {
                }
                fieldelement(Amount;"Approval Entry"."Amount (LCY)")
                {
                }
                fieldelement(DateTimeSent;"Approval Entry"."Date-Time Sent for Approval")
                {
                }
                fieldelement(Comment;"Approval Entry".Comment)
                {
                }
                fieldelement(EntryNo;"Approval Entry"."Entry No.")
                {
                }
                fieldelement(Remarks;"Approval Entry".Remarks)
                {
                }
                fieldelement(Description2;"Approval Entry".Description2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //"Bank Acc. Statement Linevb".VALIDATE("Bank Acc. Statement Linevb"."Document No.");
                    EmployeeNO:='';
                    Employee.Reset;
                    Employee.SetRange("User ID","Approval Entry"."Approver ID");
                    if Employee.FindFirst then
                      EmployeeNO:=Employee."No.";
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

    var
        Employee: Record Employee;
}

