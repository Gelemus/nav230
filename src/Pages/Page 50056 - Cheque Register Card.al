page 50056 "Cheque Register Card"
{
    PageType = Card;
    SourceTable = "Cheque Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Bank Account"; Rec."Bank Account")
                {
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                }
                field("Last Cheque No."; Rec."Last Cheque No.")
                {
                }
                field("Cheque Book Number"; Rec."Cheque Book Number")
                {
                }
                field("No of Leaves"; Rec."No of Leaves")
                {
                }
                field("Cheque Number From"; Rec."Cheque Number From")
                {
                    ShowMandatory = true;
                }
                field("Cheque Number To."; Rec."Cheque Number To.")
                {
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            part(Control10; "Receipt Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Cheque Numbers")
            {
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Cheque Number From");
                    Rec.TestField("Cheque Number To.");

                    if Rec."Cheque Number To." < Rec."Cheque Number To." then
                        Error(Error101);



                    IncrNo := Rec."Cheque Number From";

                    while IncrNo <= Rec."Cheque Number To." do begin

                        ChequeRegisterLines.Init;
                        ChequeRegisterLines."Document No." := Rec."No.";
                        ChequeRegisterLines."Cheque No." := IncrNo;
                        ChequeRegisterLines."Bank  Account No." := Rec."Bank Account";
                        ChequeRegisterLines.Insert;

                        IncrNo := IncStr(IncrNo);
                    end;
                end;
            }
            action("Cheque Register Lines")
            {
                Image = AvailableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Cheque Register Lines";
                RunPageLink = "Document No." = FIELD("No.");
            }
            action("Authorize Cheque Register")
            {
                Image = AutofillQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;

                    ChequeRegisterLines.Reset;
                    ChequeRegisterLines.SetRange(ChequeRegisterLines."Document No.", Rec."No.");
                    if ChequeRegisterLines.FindSet then begin
                        repeat
                            ChequeRegisterLines.Status := Rec.Status;
                            ChequeRegisterLines.Modify;
                        until ChequeRegisterLines.Next = 0;
                    end;

                    Message(ChequesAuthorized);
                    CurrPage.Close;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable(false);
    end;

    var
        ChequesAuthorized: Label 'Cheque register successfully authorized for use';
        Error101: Label 'Beginning number is more than ending number';
        IncrNo: Code[10];
        ChequeRegisterLines: Record "Cheque Register Lines";
}

