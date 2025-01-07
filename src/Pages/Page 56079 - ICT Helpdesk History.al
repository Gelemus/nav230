page 56079 "ICT Helpdesk History"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "ICT Helpdesk";
    SourceTableView = WHERE(Status = FILTER(Closed));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Assigned To"; Rec."Assigned To")
                {
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    Caption = 'Date';
                }
                field("Assigned Time"; Rec."Assigned Time")
                {
                    Caption = 'Time';
                }
            }
            group("Part 1: User Information")
            {
                field("Job No."; Rec."Job No.")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Physical Station"; Rec."Physical Station")
                {
                }
                field("Nature of Service"; Rec."Nature of Service")
                {
                }
                field(EXT; Rec.EXT)
                {
                }
                field("Requesting Officer"; Rec."Requesting Officer")
                {
                }
                field("Requesting Officer Name"; Rec."Requesting Officer Name")
                {
                }
                field(Phone; Rec.Phone)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Request Time"; Rec."Request Time")
                {
                }
            }
            group("Part 2.1: Hardware Issues")
            {
                field("Computer not Starting up"; Rec."Computer not Starting up")
                {
                }
                field("Keyboard, Mouse Failure"; Rec."Keyboard, Mouse Failure")
                {
                }
                field("Printer Failure"; Rec."Printer Failure")
                {
                }
                field("UPS Failure"; Rec."UPS Failure")
                {
                }
                field("LCD /Monitor Failure"; Rec."LCD /Monitor Failure")
                {
                }
                field("Storage Device Failure"; Rec."Storage Device Failure")
                {
                }
                field("Hardware Installation"; Rec."Hardware Installation")
                {
                }
                field("Others, specify HW"; Rec."Others, specify HW")
                {
                    RowSpan = 3;
                }
            }
            group("Part 2.2: Software Issues")
            {
                field("Computer Running /Loading Slow"; Rec."Computer Running /Loading Slow")
                {
                }
                field("Network Access Problems"; Rec."Network Access Problems")
                {
                }
                field("Antivirus Inefficiency"; Rec."Antivirus Inefficiency")
                {
                }
                field(Applications; Rec.Applications)
                {
                    Caption = 'Applications Software (MS Word, MS Excel, MS Access, MS PowerPoint etc)';
                }
                field("Software Installation"; Rec."Software Installation")
                {
                }
                field("Others, specify SW"; Rec."Others, specify SW")
                {
                    RowSpan = 3;
                }
                field("ERP Issue"; Rec."ERP Issue")
                {
                }
            }
            group("Attend to the Issue")
            {
                field(Diagnosis; Rec.Diagnosis)
                {
                }
                field("Action Taken"; Rec."Action Taken")
                {
                }
                field("Attended By"; Rec."Attended By")
                {
                }
                field("Attended Date"; Rec."Attended Date")
                {
                    Caption = 'Date';
                }
                field("Attended Time"; Rec."Attended Time")
                {
                    Caption = 'Time';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange("Job No.", Rec."Job No.");
                    REPORT.Run(56238, true, true, Rec)
                end;
            }
        }
    }
}

