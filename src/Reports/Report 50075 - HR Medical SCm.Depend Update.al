report 50075 "HR Medical SCm.Depend Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Medical SCm.Depend Update.rdl';
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Employee Relative"; "HR Employee Relative")
        {

            trigger OnAfterGetRecord()
            begin
                Members2.Reset;
                Members2.SetRange("Employee No", "HR Employee Relative"."Employee No.");
                if Members2.FindFirst then begin
                    Members.Reset;
                    if Members.FindLast then
                        Members."Line No" := Members."Line No" + 1;
                    Members."Scheme No" := Members2."Scheme No";
                    Members."Employee No" := Members2."Employee No";
                    Members."Principal No" := Members2."Employee No";
                    Members.Validate("Employee No");
                    Members."Dependant Name" := UpperCase(CopyStr("HR Employee Relative".Firstname + ' ' + "HR Employee Relative".Middlename + ' ' + "HR Employee Relative".Surname, 1, 249));
                    Members.Relation := "HR Employee Relative"."Relative Code";
                    Members."Cover Option" := Members2."Cover Option"::Dependant;
                    Members."Date of Birth" := "HR Employee Relative"."Date of Birth";
                    Members.Insert;
                end;
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

    trigger OnPostReport()
    begin
        Message(MessageRep);
    end;

    var
        Relatives: Record "HR Employee Relative";
        Members: Record "HR Medical Scheme Members";
        Scheme: Record "HR Medical Scheme";
        Employees: Record Employee;
        SchemeNo: Code[20];
        LineNo: Integer;
        Members2: Record "HR Medical Scheme Members";
        MessageRep: Label 'List Updated !';
}

