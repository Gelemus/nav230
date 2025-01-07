page 51165 "Lookup Table Lines"
{
    PageType = List;
    SourceTable = "Lookup Table Lines";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Lower Amount (LCY)"; Rec."Lower Amount (LCY)")
                {
                    Visible = "Lower Amount (LCY)Visible";
                }
                field("Upper Amount (LCY)"; Rec."Upper Amount (LCY)")
                {
                    Visible = "Upper Amount (LCY)Visible";
                }
                field(Month; Rec.Month)
                {
                    Visible = MonthVisible;
                }
                field("Extract Amount (LCY)"; Rec."Extract Amount (LCY)")
                {
                    Visible = "Extract Amount (LCY)Visible";
                }
                field(Percent; Rec.Percent)
                {
                    Visible = PercentVisible;
                }
                field(Deduct; Rec."Relief Amount")
                {
                    Caption = 'Deduct';
                }
                field("Cumulate (LCY)"; Rec."Cumulate (LCY)")
                {
                    Visible = "Cumulate (LCY)Visible";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        UpdatePercent;
    end;

    trigger OnInit()
    begin
        "Cumulate (LCY)Visible" := true;
        "Upper Amount (LCY)Visible" := true;
        PercentVisible := true;
        "Extract Amount (LCY)Visible" := true;
        "Lower Amount (LCY)Visible" := true;
        MonthVisible := true;
    end;

    trigger OnOpenPage()
    begin
        LookUpHeader.Get(Rec."Table ID");
        case LookUpHeader.Type of
            LookUpHeader.Type::Percentage:
                begin
                    MonthVisible := false;
                    "Lower Amount (LCY)Visible" := true;
                    "Extract Amount (LCY)Visible" := false;
                    PercentVisible := true;
                    "Upper Amount (LCY)Visible" := true;
                    "Cumulate (LCY)Visible" := true;
                end;
            LookUpHeader.Type::"Extract Amount":
                begin
                    "Lower Amount (LCY)Visible" := true;
                    MonthVisible := false;
                    "Extract Amount (LCY)Visible" := true;
                    PercentVisible := false;
                    "Upper Amount (LCY)Visible" := true;
                    "Cumulate (LCY)Visible" := false;
                end;
            LookUpHeader.Type::Month:
                begin
                    "Lower Amount (LCY)Visible" := false;
                    "Extract Amount (LCY)Visible" := true;
                    MonthVisible := true;
                    PercentVisible := false;
                    "Upper Amount (LCY)Visible" := false;
                    "Cumulate (LCY)Visible" := false;

                end;
        end;
    end;

    var
        LookUpHeader: Record "Lookup Table Header";
        [InDataSet]
        MonthVisible: Boolean;
        [InDataSet]
        "Lower Amount (LCY)Visible": Boolean;
        [InDataSet]
        "Extract Amount (LCY)Visible": Boolean;
        [InDataSet]
        PercentVisible: Boolean;
        [InDataSet]
        "Upper Amount (LCY)Visible": Boolean;
        [InDataSet]
        "Cumulate (LCY)Visible": Boolean;

    procedure UpdatePercent()
    begin
        LookUpHeader.Get(Rec."Table ID");
        if LookUpHeader.Type = LookUpHeader.Type::Percentage then begin
            Rec.SetRange("Table ID", LookUpHeader."Table ID");
            Rec.Find('-');
            repeat
                Rec.Validate(Percent);
                Rec.Modify;
            until Rec.Next = 0;
        end;
    end;
}

