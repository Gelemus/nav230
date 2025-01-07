report 51159 "Check Payment List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Check Payment List.rdl';

    dataset
    {
        dataitem(Periods; Periods)
        {
            DataItemTableView = SORTING("Start Date") WHERE(Status = FILTER(Open | Posted));
            RequestFilterFields = "Period ID";
            column(TitleText; TitleText)
            {
            }
            column(Periods_Status; Status)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Period_Status_Caption; Period_Status_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Periods_Period_ID; "Period ID")
            {
            }
            column(Periods_Period_Month; "Period Month")
            {
            }
            column(Periods_Period_Year; "Period Year")
            {
            }
            column(Periods_Payroll_Code; "Payroll Code")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.") ORDER(Ascending);
                RequestFilterFields = "No.", "Statistics Group Code", "Global Dimension 1 Code", "Global Dimension 2 Code", Status, "Mode of Payment";
                column(Employee__No__; "No.")
                {
                }
                column(Employee_Name; Name)
                {
                }
                column(Employee_Amount; Amount)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(Employee_NameCaption; Employee_NameCaptionLbl)
                {
                }
                column(Employee_AmountCaption; Employee_AmountCaptionLbl)
                {
                }
                column(Employee__No__Caption; FieldCaption("No."))
                {
                }
                column(SignatureCaption; SignatureCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(TotalAmountCaption; TotalAmountCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Name := Employee.FullName;

                    if Header.Get(Periods."Period ID", Employee."No.") then begin
                        Header.CalcFields("Total Payable (LCY)", "Total Deduction (LCY)", "Total Rounding Pmts (LCY)", "Total Rounding Ded (LCY)");
                        Amount := Header."Total Payable (LCY)" + Header."Total Rounding Pmts (LCY)" - (Header."Total Deduction (LCY)" +
                          Header."Total Rounding Ded (LCY)");
                        TotalAmount := TotalAmount + Amount;
                    end else
                        CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    SetRange(Employee."Mode of Payment", ModeOfPayment);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TitleText := 'Cheque Payment List for ' + Periods.Description;
                TotalAmount := 0;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                //IF Periods.GETFILTER(Periods."Period ID")=''THEN ERROR('Specify the Period ID');
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
        Message('Select The Cheque Payment Option');
        if ACTION::LookupOK = PAGE.RunModal(PAGE::"Mode of Payment", gvPayment) then
            ModeOfPayment := gvPayment.Code
        else
            Error('Please Select a mode of payment');
    end;

    trigger OnPreReport()
    begin
        gsSegmentPayrollData;
    end;

    var
        Header: Record "Payroll Header";
        Name: Text[60];
        Amount: Decimal;
        TotalAmount: Decimal;
        TitleText: Text[70];
        gvAllowedPayrolls: Record "Allowed Payrolls";
        gvPayment: Record "Mode of Payment";
        ModeOfPayment: Code[20];
        Period_Status_CaptionLbl: Label 'Period Status:';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_NameCaptionLbl: Label 'Name';
        Employee_AmountCaptionLbl: Label 'Amount';
        SignatureCaptionLbl: Label 'Signature';
        EmptyStringCaptionLbl: Label '__________________________________';
        TotalAmountCaptionLbl: Label 'Total Amount';

    procedure gsSegmentPayrollData()
    var
        lvAllowedPayrolls: Record "Allowed Payrolls";
        lvPayrollUtilities: Codeunit "Payroll Posting";
        UsrID: Code[10];
        UsrID2: Code[10];
        StringLen: Integer;
        lvActiveSession: Record "Active Session";
    begin

        lvActiveSession.Reset;
        lvActiveSession.SetRange("Server Instance ID", ServiceInstanceId);
        lvActiveSession.SetRange("Session ID", SessionId);
        lvActiveSession.FindFirst;


        gvAllowedPayrolls.SetRange("User ID", lvActiveSession."User ID");
        gvAllowedPayrolls.SetRange("Last Active Payroll", true);
        if not gvAllowedPayrolls.FindFirst then
            Error('You are not allowed access to this payroll dataset.');
    end;
}

