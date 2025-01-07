page 50362 "Grievance List-Self Service"
{
    CardPageID = "Grievance Card";
    PageType = List;
    SourceTable = "User Support Incidences";
    SourceTableView = WHERE(Category = CONST(Grievance));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'Grievance Reference';
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Caption = 'Grievance Description';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Caption = 'Grievance Date';
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("User email Address"; Rec."User email Address")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Caption = 'Grievance Status';
                }
                field("Work place Controller"; Rec."Work place Controller")
                {
                }
                field("Work place Controller Name"; Rec."Work place Controller Name")
                {
                }
                field("Action taken"; Rec."Action taken")
                {
                }
                field("Action Date"; Rec."Action Date")
                {
                }
                field("System Support Email Address"; Rec."System Support Email Address")
                {
                }
                field("Remarks HR"; Rec."Remarks HR")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        Emp.Reset;
        DimValue.Reset;
        Rec.FilterGroup(2);
        UserSetup.SetRange("User ID", UserId);
        UserSetup.FindFirst;
        /*
        Emp.SETRANGE("No.",UserSetup."Employee No");
        DimValue.SETRANGE("Dimension Code",Emp."Global Dimension 1 Code");
        IF DimValue.HOD<>USERID THEN
          ERROR('This Page can only be viewed by HoDs.\Kindly contact the ICT Admin for assistance.');
        FILTERGROUP(0);
        */

    end;

    var
        UserSetup: Record "User Setup";
        DimValue: Record "Dimension Value";
        Emp: Record Employee;
}

