report 50088 "HR Job Offer Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/HR Job Offer Letter.rdl';

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            RequestFilterFields = "No.", Status, ShortListed, "Committee Shortlisted", "Employee Requisition No.", "To be Interviewed";
            column(CI_Name; CI.Name)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address; CI."Address 2")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(Country; CI."Country/Region Code")
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CI_TelephoneNo; CI."Telephone No.")
            {
            }
            column(CI_Email; CI."E-Mail")
            {
            }
            column(CI_Website; CI."Home Page")
            {
            }
            column(CI_Vision; Text0001)
            {
            }
            column(Lno; Lno)
            {
            }
            column(PostalAddress_HRJobApplications; "HR Job Applications"."Postal Address")
            {
            }
            column(CityTown_HRJobApplications; "HR Job Applications"."City/Town")
            {
            }
            column(No_HRJobApplications; "HR Job Applications"."No.")
            {
            }
            column(EmployeeRequisitionNo_HRJobApplications; "Employee Requisition No.")
            {
            }
            column(JobNo_HRJobApplications; "HR Job Applications"."Job No.")
            {
            }
            column(JobTitle_HRJobApplications; "HR Job Applications"."Job Title")
            {
            }
            column(Surname_HRJobApplications; "HR Job Applications".Surname)
            {
            }
            column(Firstname_HRJobApplications; "HR Job Applications".Firstname)
            {
            }
            column(Middlename_HRJobApplications; "HR Job Applications".Middlename)
            {
            }
            column(FullName; FullName)
            {
            }
            column(Gender_HRJobApplications; "HR Job Applications".Gender)
            {
            }
            column(Age_HRJobApplications; "HR Job Applications".Age)
            {
            }
            column(DateToday; Format(Today, 0, 4))
            {
            }
            column(BasicAmount; BasicAmount)
            {
            }
            column(SalaryNotchString; SalaryNotchString)
            {
            }
            column(LongAllowancesString; LongAllowancesString)
            {
            }
            column(MaximumBasicPay; MaximumBasicPay)
            {
            }
            column(JobGrade; HRJobApplications."Job Grade")
            {
            }
            dataitem("HR Job Grade Levels"; "HR Job Grade Levels")
            {
                DataItemLink = "Job Grade" = FIELD("Job Grade");
                column(JobGrade_HRJobGradeLevels; "HR Job Grade Levels"."Job Grade")
                {
                }
                column(JobGradeLevel_HRJobGradeLevels; "HR Job Grade Levels"."Job Grade Level")
                {
                }
                column(BasicPayAmount_HRJobGradeLevels; "HR Job Grade Levels"."Basic Pay Amount")
                {
                }
                column(AllowanceCode_HRJobGradeLevels; "HR Job Grade Levels"."Allowance Code")
                {
                }
                column(AllowanceDescription_HRJobGradeLevels; "HR Job Grade Levels"."Allowance Description")
                {
                }
                column(AllowanceAmount_HRJobGradeLevels; "HR Job Grade Levels"."Allowance Amount")
                {
                }
                column(AllowanceSetup_HRJobGradeLevels; "HR Job Grade Levels"."Allowance Setup")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
                DateToday := Today;

                FullName := "HR Job Applications".Firstname + '  ' + "HR Job Applications".Middlename + '  ' + "HR Job Applications".Surname;

                MinimumBasicPay := 0;
                MaximumBasicPay := 0;

                JobGradeLevels.Reset;
                JobGradeLevels.SetRange("Job Grade", "HR Job Applications"."Job Grade");
                JobGradeLevels.SetRange("Job Grade Level", "HR Job Applications"."Salary Notch");
                if JobGradeLevels.FindFirst then begin
                    BasicAmount := JobGradeLevels."Basic Pay Amount";
                    FirstLevelSequence := JobGradeLevels.Sequence;
                    FirstLevelSequence := FirstLevelSequence + 1;
                end;

                JobGradeLevels.Reset;
                JobGradeLevels.SetRange("Job Grade", "HR Job Applications"."Job Grade");
                JobGradeLevels.SetCurrentKey(Sequence);
                if JobGradeLevels.FindLast then begin
                    LastLevelSequence := JobGradeLevels.Sequence;
                    MaximumBasicPay := JobGradeLevels."Basic Pay Amount";
                end;

                //get basic pay notches
                SalaryNotchString := '';
                JobGradeLevels.Reset;
                JobGradeLevels.SetRange("Job Grade", "HR Job Applications"."Job Grade");
                JobGradeLevels.SetRange(Sequence, FirstLevelSequence, LastLevelSequence);
                if JobGradeLevels.FindSet then begin
                    repeat
                        SalaryNotchString := SalaryNotchString + ' ' + Format(JobGradeLevels."Basic Pay Amount") + ' * ' + Format(JobGradeLevels."Basic Pay Difference") + ' - ';
                    until JobGradeLevels.Next = 0;
                end;
                SalaryNotchString := SalaryNotchString + ' p.m';
                SalaryNotchString := DelChr(SalaryNotchString, '<>', '- p.m');
                SalaryNotchString := SalaryNotchString + ' p.m';

                AllowancesString := '';
                //get allowances
                JobGradeAllowances.Reset;
                JobGradeAllowances.SetRange("Job Grade", "HR Job Applications"."Job Grade");
                if JobGradeAllowances.FindSet then begin
                    repeat
                        AllowancesString := '';
                        AllowancesString := JobGradeAllowances."Allowance Description" + ' of ' + Text0002 + ' ' + Format(+JobGradeAllowances."Allowance Amount");
                        LongAllowancesString := LongAllowancesString + ' ' + AllowancesString + ' and '
                    until JobGradeAllowances.Next = 0;
                end;
                LongAllowancesString := LongAllowancesString + '.';
                LongAllowancesString := DelChr(LongAllowancesString, '<>', 'and .');
                LongAllowancesString := LongAllowancesString + '.';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        CI: Record "Company Information";
        Lno: Integer;
        Text0001: Label '"Empowered Healthy Communities"';
        DateToday: Date;
        JobGradeLevels: Record "HR Job Grade Levels";
        MinimumRange: Decimal;
        MaximumRange: Decimal;
        Employee: Record Employee;
        FullName: Text;
        HRJobApplications: Record "HR Job Applications";
        BasicPay: Decimal;
        SalaryNotchString: Text;
        BasicAmount: Decimal;
        BasicAmountDifference: Decimal;
        FirstLevelSequence: Integer;
        LastLevelSequence: Integer;
        JobGradeAllowances: Record "HR Job Grade Allowances";
        AllowancesString: Text;
        LongAllowancesString: Text;
        Text0002: Label 'Ksh';
        MinimumBasicPay: Decimal;
        MaximumBasicPay: Decimal;
}

