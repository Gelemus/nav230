pageextension 60650 pageextension60650 extends "Job Card"
{
    layout
    {

        //Unsupported feature: Property Modification (ImplicitType) on "Description(Control 4)".


        //Unsupported feature: Property Modification (ImplicitType) on ""Search Description"(Control 10)".

        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
            }
            field(Location; Rec.Location)
            {
            }
        }
        addafter("Project Manager")
        {
            field(Contractor; Rec.Contractor)
            {
            }
            field("Contractor Phone No"; Rec."Contractor Phone No")
            {
            }
            field("Contractor Location"; Rec."Contractor Location")
            {
            }
            field("Budget G/L"; Rec."Budget G/L")
            {
            }
            field("Budget G/L Name"; Rec."Budget G/L Name")
            {
            }
            field("Project Status"; Rec."Project Status")
            {
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
            }
        }
        moveafter(Description; "Project Manager")
    }
}

