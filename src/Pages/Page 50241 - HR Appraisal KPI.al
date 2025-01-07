page 50241 "HR Appraisal KPI"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal KPI";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                    Visible = false;
                }
                field(Objectives; Rec.Description)
                {
                    Caption = 'Objectives';
                }
                field("Set Target"; Rec."Set Target")
                {
                }
                field("Key Indicators/Perfomance Obje"; Rec."Key Indicators/Perfomance Obje")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("KPI Weight"; Rec."KPI Weight")
                {

                    trigger OnValidate()
                    begin
                        Rec.Target := Rec."KPI Weight";
                    end;
                }
                field("Status Previous Year"; Rec."Status Previous Year")
                {
                }
                field(Target; Rec.Target)
                {
                }
                field("Apprasee Marks"; Rec."Apprasee Marks")
                {
                    Caption = 'Self Rating';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        /*IF "Apprasee Marks" > "KPI Weight" THEN
                          ERROR('Self Rating Must be less than KPI Weight');
                        */
                        Rec.Actual := Rec."Apprasee Marks";

                    end;
                }
                field(Actual; Rec.Actual)
                {
                    Caption = 'Actual Performance';

                    trigger OnValidate()
                    begin
                        /*IF Actual > "KPI Weight" THEN
                          ERROR('Consensus Rate Must be less than KPI Weight');
                        */

                    end;
                }
                field("Maintaining Last Year Score"; Rec."Maintaining Last Year Score")
                {
                }
                field("Curreny Year Increase/Decline"; Rec."Curreny Year Increase/Decline")
                {
                }
                field("Agreed Marks"; Rec."Agreed Marks")
                {
                    Caption = 'Total';
                }
                field("Actual Output Description"; Rec."Actual Output Description")
                {
                    Caption = 'Comments';
                }
                field("Appraiser Marks"; Rec."Appraiser Marks")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Unit of Measure" := '%';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Unit of Measure" := '%';
    end;

    trigger OnOpenPage()
    begin
        Rec."Unit of Measure" := '%';
    end;
}

