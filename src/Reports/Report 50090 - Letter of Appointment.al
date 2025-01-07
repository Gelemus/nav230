report 50090 "Letter of Appointment"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Letter of Appointment.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
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
            column(DateToday; Format(Today, 0, 4))
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(FullName_Employee; Employee."Full Name")
            {
            }
            column(FullName; FullName)
            {
            }
            column(Age_Employee; Employee."Age-d")
            {
            }
            column(Gender_Employee; Employee.Gender)
            {
            }
            column(JobTitle_Employee; Employee.Title)
            {
            }
            column(CityTown_Employee; Employee.City)
            {
            }
            column(Address_Employee; Employee.Address)
            {
            }
            column(EmploymentDate; Format("Employment Date", 0, 4))
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
            column(JobGrade; Employee."Job Grade-d")
            {
            }
            dataitem("HR Job Responsibilities"; "HR Job Responsibilities")
            {
                DataItemLink = "Job No." = FIELD("Job No.-d");
                column("Code"; "HR Job Responsibilities"."Responsibility Code")
                {
                }
                column(Description; "HR Job Responsibilities".Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    FullName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";


                    MaximumBasicPay := 0;

                    JobGradeLevels.Reset;
                    JobGradeLevels.SetRange("Job Grade", Employee."Job Grade-d");
                    JobGradeLevels.SetRange("Job Grade Level", Employee."HR Salary Notch");
                    if JobGradeLevels.FindFirst then begin
                        BasicAmount := JobGradeLevels."Basic Pay Amount";
                        FirstLevelSequence := JobGradeLevels.Sequence;
                        FirstLevelSequence := FirstLevelSequence + 1;
                    end;

                    JobGradeLevels.Reset;
                    JobGradeLevels.SetRange("Job Grade", Employee."Job Grade-d");
                    JobGradeLevels.SetCurrentKey(Sequence);
                    if JobGradeLevels.FindLast then begin
                        LastLevelSequence := JobGradeLevels.Sequence;
                        MaximumBasicPay := JobGradeLevels."Basic Pay Amount";
                    end;

                    //get basic pay notches
                    SalaryNotchString := '';
                    JobGradeLevels.Reset;
                    JobGradeLevels.SetRange("Job Grade", Employee."Job Grade-d");
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
                    JobGradeAllowances.SetRange("Job Grade", Employee."Job Grade-d");
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

            trigger OnAfterGetRecord()
            begin
                Lno := Lno + 1;
                DateToday := Today;
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
        HRJobResponsibilities: Record "HR Job Responsibilities";
        FullName: Text;
        BasicPay: Decimal;
        SalaryNotchString: Text;
        BasicAmount: Decimal;
        BasicAmountDifference: Decimal;
        FirstLevelSequence: Integer;
        LastLevelSequence: Integer;
        JobGradeAllowances: Record "HR Job Grade Allowances";
        AllowancesString: Text;
        LongAllowancesString: Text;
        MaximumBasicPay: Decimal;
        JobGradeLevels: Record "HR Job Grade Levels";
        Text0002: Label 'KES';
}

