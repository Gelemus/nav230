page 50332 "File Card"
{
    Caption = 'File Card';
    PageType = Card;
    SourceTable = "File Detail";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("File Code"; Rec."File Code")
                {
                    Caption = 'Code';
                    Editable = true;
                }
                field("File Description"; Rec."File Description")
                {
                    Caption = 'Description';
                    Editable = true;
                }
                field("File Class"; Rec."File Class")
                {
                    Caption = 'Class';
                }
                field("File Status"; Rec."File Status")
                {
                    Caption = 'Status';
                }
                field("Folio No."; Rec."Folio No.")
                {
                }
                field(Volume; Rec.Volume)
                {
                }
                field("Shelf  No."; Rec."Shelf  No.")
                {
                }
                field("Covering Date From"; Rec."Covering Date From")
                {
                }
                field("Covering Date To"; Rec."Covering Date To")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                }
                field("Retention Period(Yrs)"; Rec."Retention Period(Yrs)")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Date Closed"; Rec."Date Closed")
                {
                }
                field("Disposal Action"; Rec."Disposal Action")
                {
                }
                field("Disposal Date"; Rec."Disposal Date")
                {
                }
                field("Reason for Closure"; Rec."Reason for Closure")
                {
                }
            }
            part(fileMove; "File Movement List")
            {
                Caption = 'File Movement Line';
                SubPageLink = "File Code" = FIELD("File Code");
            }
        }
        area(factboxes)
        {
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Advanced;
                ShowFilter = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Control22; Links)
            {
                Visible = false;
            }
            systempart(Control21; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Transfer.")
            {
                Caption = 'Transfer.';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to transfer this file?', true) = true then begin

                        CurrPage.fileMove.PAGE.GetfileMovement(fileMoveNo);
                        fileMovementRec.Reset;
                        fileMovementRec.SetRange("File Movement Code", fileMoveNo);
                        //FORM.RUN(51108,fileMovementRec);
                        if fileMovementRec.FindFirst = true then begin
                            if fileMovementRec."Returned?" = true then begin
                                Error('This File Request cannot be transfered.It is been marked as returned!');
                            end;

                            if fileMovementRec.Transfered = true then begin
                                Error('This File Request cannot be transfered.It is been marked as Transfered!');
                            end;

                            /*
                           Users.GET(USERID);
                           IF Users."Employee No."<>fileMovementRec."Officer issued file" THEN BEGIN
                           ERROR('%1%2%3','You cannot Transfer this file.','It can only be transfered by::',fileMovementRec."Officer Name");
                           //ERROR('%1%2','It can only be transfered by::',fileMovementRec."File Name");
                           END;
                           */
                        end;


                        fileMovementRec1.Init;
                        fileMovementRec1."File Code" := Rec."File Code";
                        fileMovementRec1.Volume := Rec.Volume;
                        fileMovementRec1."Prevoius Holder" := fileMoveNo;
                        fileMovementRec1.Insert(true);

                        //fileMovementRec.RESET;
                        //fileMovementRec.SETRANGE(fileMovementRec."File Movement Code",fileMoveNo);
                        PAGE.Run(51108, fileMovementRec1);

                    end;

                end;
            }
            action(Close)
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Close this file?', true) = true then begin
                        if Rec."Reason for Closure" = '' then
                            Error('Specify reason for closure');
                        Rec.TestField("File Status", Rec."File Status"::Open);
                        Rec."File Status" := Rec."File Status"::Closed;
                        Rec."Date Closed" := Today;
                        Rec.Modify;
                    end
                end;
            }
            action(Archive)
            {
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to archive  this file?', true) = true then begin

                        Rec."File Status" := Rec."File Status"::Archived;
                        Rec.Archived := true;
                        Rec.Modify;
                    end

                end;
            }
            action("DMS Link")
            {
                Caption = 'DMS Link';
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ResourceCentreSetup1.Get;
                    Link := ResourceCentreSetup1."File DMS Link" + Rec."File Code";
                    HyperLink(Link);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Creation Date" := Today;
        Rec."Creation Time" := Time;
    end;

    var
        fileMoveNo: Code[20];
        fileMovementRec: Record "File Movement Detail";
        Users: Record "User Setup";
        Emp: Record Employee;
        fileMovementRec1: Record "File Movement Detail";
        ResourceCentreSetup1: Record "Resource Centre Setup";
        Link: Text;
}

