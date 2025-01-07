page 50170 "Closed Job Application Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE(Status = CONST(Shortlisted));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the  document number.';
                }
                field("Employee Requisition No."; Rec."Employee Requisition No.")
                {
                    ToolTip = 'Specifies the  Employee Requisition Number.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the Employee Job No.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the  Job Title.';
                }
                field("Emp. Requisition Description"; Rec."Emp. Requisition Description")
                {
                    ToolTip = 'Specifies the  Job description.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the  Job Grade.';
                }
                field(Description; Rec.Description)
                {
                    Description = 'Specifies the  approvals.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the  Global Dimension 1 Code.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the  Global Dimension 2 Code.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the  status of the document.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the  User ID that raised the document.';
                }
            }
            group("Applicant Information")
            {
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the  Surname.';
                }
                field(Firstname; Rec.Firstname)
                {
                    ToolTip = 'Specifies the  Firstname.';
                }
                field(Middlename; Rec.Middlename)
                {
                    ToolTip = 'Specifies the Middle Name';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the  Gender.';
                }
                field("Person Living With Disability"; Rec."Person Living With Disability")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the  Date of Birth.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the  Age.';
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ToolTip = 'Specifies the  Address.';
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ToolTip = 'Specifies Address 2.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the  Post Code.';
                }
                field("City/Town"; Rec."City/Town")
                {
                    ToolTip = 'Specifies the  City.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the County Code.';
                }
                field("County Name"; Rec."County Name")
                {
                    ToolTip = 'Specifies the County Name.';
                }
                field(SubCounty; Rec.SubCounty)
                {
                    ToolTip = 'Specifies the  SubCounty Code.';
                }
                field("SubCounty Name"; Rec."SubCounty Name")
                {
                    ToolTip = 'Specifies the  Subcounty Name.';
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the  Country.';
                }
                field("Alternative Phone No."; Rec."Alternative Phone No.")
                {
                    ToolTip = 'Specifies the  Home Phone No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies Mobile Phone No.';
                }
                field("Personal Email Address"; Rec."Personal Email Address")
                {
                    ToolTip = 'Specifies Personal Email address';
                }
                field("Birth Certificate No."; Rec."Birth Certificate No.")
                {
                    ToolTip = 'Specifies the  Birth Certificate Number.';
                }
                field("National ID No."; Rec."National ID No.")
                {
                    ToolTip = 'Specifies the National ID No.';
                }
                field("Huduma No."; Rec."Huduma No.")
                {
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ToolTip = 'Specifies Passport No.';
                }
                field("PIN  No."; Rec."PIN  No.")
                {
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                }
                field("Driving Licence No."; Rec."Driving Licence No.")
                {
                    ToolTip = 'Specifies driving Licence No.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the  Marital Status.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies Citizenship.';
                }
                field("Ethnic Group"; Rec."Ethnic Group")
                {
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies Religion.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Job Qualifications")
            {
                Image = BulletList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Qualifications";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Specifies the  Job Qualifications.';
            }
            action("Job Requirements")
            {
                Image = BusinessRelation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Specifies Job requirements';
            }
            action("Job Responsibilities")
            {
                Image = ResourceSkills;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job No." = FIELD("Job No.");
                ToolTip = 'Specifies the  Job responsibilities.';
            }
        }
        area(processing)
        {
            action("Job Application Qualifications")
            {
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Job Applicant Qualification";
                RunPageLink = "Job Application No." = FIELD("No.");
                ToolTip = 'Specifies the  Job Application qualifications.';
            }
            action("HR Applicant Employment Hist.")
            {
                Caption = 'HR Applicant Employment Hist.';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Applicant Employment Hist.";
            }
        }
    }
}

