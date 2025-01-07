page 50269 "HR Medical Scheme Card"
{
    PageType = Card;
    SourceTable = "HR Medical Scheme";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Medical Scheme Description"; Rec."Medical Scheme Description")
                {
                }
                field(Provider; Rec.Provider)
                {
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    Editable = false;
                }
            }
            part("Medical Scheme Members"; "HR Medical Scheme Members")
            {
                Caption = 'Medical Scheme Members';
                SubPageLink = "Scheme No" = FIELD("No.");
            }
            part("Medical Scheme Beneficiaries"; "HR Medical Sch. Beneficiaries")
            {
                Caption = 'Medical Scheme Beneficiaries';
                SubPageLink = "Scheme No" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
                action("Insert Employees")
                {
                    Caption = 'Insert Employees';
                    Image = Hierarchy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        SchemeNo := '';
                        Scheme.Reset;
                        Scheme.SetRange(Scheme."No.", Rec."No.");
                        if Scheme.FindFirst then begin
                            SchemeNo := Scheme."No.";
                        end;

                        Members3.Reset;
                        Members3.SetRange(Members3."Scheme No", Rec."No.");
                        if Members3.FindSet then begin
                            Members3.Delete;
                        end;

                        Employees.Reset;
                        //Employees.SETRANGE(Employees.Age,Employees.Age::"0");//to be reviewed later
                        Employees.SetRange(Employees.Status, Employees.Status::Active);
                        if Employees.FindSet then begin
                            repeat
                                LineNo := LineNo + 1;
                                Members.Init;
                                Members."Line No" := LineNo;
                                Members."Scheme No" := SchemeNo;
                                Members."Employee No" := Employees."No.";
                                Members.Validate(Members."Employee No");
                                Members."Dependant Name" := UpperCase(CopyStr(Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name", 1, 249));
                                Members."Cover Option" := Members."Cover Option"::Principal;
                                Members."Date of Birth" := Employees."Birth Date";
                                Members.Insert;
                            until Employees.Next = 0;
                        end;
                        Message(MembersMessage);
                    end;
                }
                action("Insert Beneficiaries")
                {
                    Image = BreakRulesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "HR Medical SCm.Depend Update";

                    trigger OnAction()
                    begin
                        /*SchemeNo:='';
                        Scheme.RESET;
                        Scheme.SETRANGE(Scheme."No.","No.");
                        IF Scheme.FINDFIRST THEN BEGIN
                           SchemeNo:=Scheme."No.";
                          END;
                        
                        Members3.RESET;
                        Members3.SETRANGE(Members3."Scheme No","No.");
                        Members3.SETRANGE(Members3."Cover Option",Members3."Cover Option"::Dependant);
                        IF Members3.FINDSET THEN BEGIN
                          Members3.DELETE;
                          END;
                        
                        Members3.RESET;
                        Members3.SETRANGE(Members3."Scheme No","No.");
                        IF Members3.FINDLAST THEN BEGIN
                          LineNumber:=Members3."Line No";
                          END;
                        
                        Members2.RESET;
                        Members2.SETRANGE(Members2."Scheme No","No.");
                        IF Members2.FINDSET THEN BEGIN
                        REPEAT
                        Relatives.RESET;
                        Relatives.SETRANGE(Relatives."Employee No.",Members2."Employee No");
                        Relatives.SETRANGE(Relatives.Type,Relatives.Type::Relative);
                        IF Relatives.FINDSET THEN BEGIN
                        REPEAT
                        LineNumber:=LineNumber+1;
                        Members.INIT;
                        Members."Line No":=LineNumber;
                        Members."Scheme No":= SchemeNo;
                        Members."Employee No":=Members2."Employee No";
                        Members."Principal No":=Members2."Employee No";
                        Members."Dependant Name":=Relatives.Firstname+''+Relatives.Middlename+''+Relatives.Surname;
                        Members.Relation:=Relatives."Relative Code";
                        Members."Cover Option":=Members2."Cover Option"::Dependant;
                        Members."Date of Birth":=Relatives."Date of Birth";
                        Members.INSERT;
                        UNTIL Relatives.NEXT=0;
                        END;
                        UNTIL Members2.NEXT=0;
                        END;
                        MESSAGE(MembersMessage);*/

                    end;
                }
                action("HR Medical Scheme Report")
                {
                    Image = ResourceRegisters;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Headers.Reset;
                        Headers.SetRange(Headers."No.", Rec."No.");
                        if Headers.FindFirst then begin
                            REPORT.RunModal(REPORT::"HR Medical Scheme Report", true, false, Headers);
                        end;
                    end;
                }
            }
        }
    }

    var
        Relatives: Record "HR Employee Relative";
        Members: Record "HR Medical Scheme Members";
        Scheme: Record "HR Medical Scheme";
        Employees: Record Employee;
        SchemeNo: Code[20];
        LineNo: Integer;
        Members2: Record "HR Medical Scheme Members";
        Members3: Record "HR Medical Scheme Members";
        LineNumber: Integer;
        LineNumber2: Integer;
        MembersMessage: Label 'List Updated!';
        Headers: Record "HR Medical Scheme";
}

