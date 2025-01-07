report 51193 "Payroll Expense Alloc."
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Payroll Expense Alloc.rdl';

    dataset
    {
        dataitem("Payroll Exp Allocation Matrix"; "Payroll Exp Allocation Matrix")
        {
            DataItemTableView = SORTING("Employee No", "ED Code", "Posting Date");
            RequestFilterFields = "Employee No", "ED Code";
            column(MonthYear; MonthText + ' ' + Format(Year))
            {
            }
            column(OtherFilters; "Payroll Exp Allocation Matrix".GetFilters)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(PostingDate; "Payroll Exp Allocation Matrix"."Posting Date")
            {
            }
            column(EmployeeNo; "Payroll Exp Allocation Matrix"."Employee No")
            {
                IncludeCaption = true;
            }
            column(EDcode; "Payroll Exp Allocation Matrix"."ED Code")
            {
                IncludeCaption = true;
            }
            column(DimCode1; "Payroll Exp Allocation Matrix"."Dimension Code1")
            {
                IncludeCaption = true;
            }
            column(DimCodeValue1; "Payroll Exp Allocation Matrix"."Dimension Value Code1")
            {
                IncludeCaption = true;
            }
            column(DimCode2; "Payroll Exp Allocation Matrix"."Dimension Code2")
            {
                IncludeCaption = true;
            }
            column(DimCodeValue2; "Payroll Exp Allocation Matrix"."Dimension Value Code2")
            {
                IncludeCaption = true;
            }
            column(DimCode3; "Payroll Exp Allocation Matrix"."Dimension Code3")
            {
                IncludeCaption = true;
            }
            column(DimCodeValue3; "Payroll Exp Allocation Matrix"."Dimension Value Code3")
            {
                IncludeCaption = true;
            }
            column(DimCode4; "Payroll Exp Allocation Matrix"."Dimension Code4")
            {
                IncludeCaption = true;
            }
            column(DimCodeValue4; "Payroll Exp Allocation Matrix"."Dimension Value Code4")
            {
                IncludeCaption = true;
            }
            column(Allocated; "Payroll Exp Allocation Matrix".Allocated)
            {
                IncludeCaption = true;
            }

            trigger OnPreDataItem()
            begin
                "Payroll Exp Allocation Matrix".SetRange("Posting Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Month; Month)
                    {
                        Caption = 'Month';
                    }
                    field(Year; Year)
                    {
                        BlankZero = true;
                        Caption = 'Year';
                        Width = 4;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if Month = Month::" " then Error('Month must be selected on request page');
        if Year = 0 then Error('Year must be selected on request page');
        StartDate := DMY2Date(1, Month, Year);
        EndDate := CalcDate('CM', StartDate);
        MonthText := ' ,January,February,March,April,May,June,July,August,September,October,November,December';
        MonthText := SelectStr(Month, MonthText);
    end;

    var
        Month: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        Year: Integer;
        StartDate: Date;
        EndDate: Date;
        MonthText: Text[100];
}

