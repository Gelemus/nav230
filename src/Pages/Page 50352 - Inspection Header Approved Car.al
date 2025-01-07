page 50352 "Inspection Header Approved Car"
{
    PageType = Card;
    SourceTable = "Inspection Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Inspection No"; Rec."Inspection No")
                {
                }
                field("Order No"; Rec."Order No")
                {
                }
                field("Commitee Appointment No"; Rec."Commitee Appointment No")
                {
                }
                field("Inspection Date"; Rec."Inspection Date")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Chair Employee ID"; Rec."Chair Employee ID")
                {
                }
                field("Chair E-mail"; Rec."Chair E-mail")
                {
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    MultiLine = true;
                }
            }
            part("Inspection Lines"; "Inspection Lines Subform")
            {
                Caption = 'Inspection Lines';
                SubPageLink = "Inspection No" = FIELD("Inspection No");
            }
            part(Control6; "Commitee Members Subform")
            {
                SubPageLink = "Appointment No" = FIELD("Inspection No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM(STRSUBSTNO('Do you want to Approve %1 the Inspection?',"Inspection No"),TRUE) THEN
                          BEGIN
                        Status :=Status::Released;
                        MESSAGE('The Inspection %1 has been Approved',"Inspection No");
                        MODIFY;
                        CurrPage.CLOSE;
                        END;
                        */

                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        TESTFIELD("Rejection Reason");

                       IF CONFIRM(STRSUBSTNO('Do you want to Reject %1 the Inspection?',"Inspection No"),TRUE) THEN
                         BEGIN

                       Status :=Status::Rejected;
                       MESSAGE('The Inspection %1 has been Rejected',"Inspection No");
                       MODIFY;
                       CurrPage.CLOSE;
                       END;
                       */

                    end;
                }
                action("View Order")
                {
                    Caption = 'View Order';
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Purchase Order";
                    RunPageLink = "No." = FIELD("Order No");
                    RunPageMode = View;
                }
                action("View Inspection Certificate")
                {
                    Caption = 'View Inspection Certificate';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.Reset;
                        Rec.SetFilter("Inspection No", Rec."Inspection No");
                        REPORT.Run(50196, true, true, Rec);
                        Rec.Reset;
                    end;
                }
            }
        }
    }
}

