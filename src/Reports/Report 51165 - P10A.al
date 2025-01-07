report 51165 P10A
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/P10A.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            column(UPPERCASE_PayrollSetup__Employer_PIN_No___; UpperCase(PayrollSetup."Employer PIN No."))
            {
            }
            column(EMPLOYER__S_NAME______UPPERCASE_PayrollSetup__Employer_Name__; 'EMPLOYER''S NAME  ' + UpperCase(PayrollSetup."Employer Name"))
            {
            }
            column(STRSUBSTNO__P_A_Y_E___SUPPORTING_LIST_FOR_END_YEAR_CERTIFICATE__YEAR__1___Year_; StrSubstNo('P.A.Y.E - SUPPORTING LIST FOR END YEAR CERTIFICATE: YEAR %1', Year))
            {
            }
            column(ColumnL; ColumnL)
            {
            }
            column(ColumnD; ColumnD)
            {
            }
            column(ColumnL__INT_PENALTY_; ColumnL + "INT/PENALTY")
            {
            }
            column(INT_PENALTY_; "INT/PENALTY")
            {
            }
            column(TAX_DEDUCTED_KSHSCaption; TAX_DEDUCTED_KSHSCaptionLbl)
            {
            }
            column(TOTAL_EMOLUMENTS_KSHSCaption; TOTAL_EMOLUMENTS_KSHSCaptionLbl)
            {
            }
            column(EMPLOYEE__S_NAMECaption; EMPLOYEE__S_NAMECaptionLbl)
            {
            }
            column(EMPLOYEE__S_PIN_Caption; EMPLOYEE__S_PIN_CaptionLbl)
            {
            }
            column(INCOME_TAX_DEPARTMENTCaption; INCOME_TAX_DEPARTMENTCaptionLbl)
            {
            }
            column(P10ACaption; P10ACaptionLbl)
            {
            }
            column(KENYA_REVENUE_AUTHORITYCaption; KENYA_REVENUE_AUTHORITYCaptionLbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE_P10Caption; ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE_P10CaptionLbl)
            {
            }
            column(NOTE_TO_EMPLOYER_Caption; NOTE_TO_EMPLOYER_CaptionLbl)
            {
            }
            column(TAX_ON_LUMPSUM_AUDIT_TAX_INTEREST_PENALTYCaption; TAX_ON_LUMPSUM_AUDIT_TAX_INTEREST_PENALTYCaptionLbl)
            {
            }
            column(TOTAL_TAX_DEDUCTED___TOTAL_C_F_TO_NEXT_LISTCaption; TOTAL_TAX_DEDUCTED___TOTAL_C_F_TO_NEXT_LISTCaptionLbl)
            {
            }
            column(DELETE_AS_APPROPRIATECaption; DELETE_AS_APPROPRIATECaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            dataitem("Payroll Header"; "Payroll Header")
            {
                DataItemLink = "Employee no." = FIELD("No.");
                DataItemTableView = SORTING("Payroll ID", "Employee no.") ORDER(Ascending);
                column(gvPinNo; gvPinNo)
                {
                }
                column(Employee__First_Name__________Employee__Middle_Name_________Employee__Last_Name_; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                }
                column(ColumnDPayrollHeader; ColumnD)
                {
                }
                column(ColumnLPayrollHeader; ColumnL)
                {
                }
                column(Payroll_Header__Payroll_Code_; "Payroll Code")
                {
                }
                column(Payroll_Header__Payroll_Year_; "Payroll Year")
                {
                }
                column(Payroll_Header__D__LCY__; "D (LCY)")
                {
                }
                column(Payroll_Header_Payroll_ID; "Payroll ID")
                {
                }
                column(Payroll_Header_Employee_no_; "Employee no.")
                {
                }
                column(ColumnTotalL; ColumnTotalL)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ColumnD := ColumnD + "D (LCY)";

                    //AMI 190208 Original lines commented. Don't include the negative lines in the sum
                    //ColumnL := ColumnL + "M (LCY)";

                    if "M (LCY)" > 0 then ColumnL := ColumnL + "M (LCY)";

                    //+++++ End AMI

                    if ColumnL < 0 then ColumnL := 0; //skm110208 show zero is L is negative

                    //csm
                    if "M (LCY)" > 0 then
                        ColumnTotalL := "M (LCY)"
                    else
                        ColumnTotalL := 0;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                    SetRange("Payroll Year", Year);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ColumnD := 0;
                ColumnL := 0;
                ColumnTotalL := 0;
                //  AKK START
                SetFilter("ED Code Filter", PayrollSetup."PAYE ED Code");
                CalcFields("Membership No.");
                //gvPinNo := "Membership No.";
                gvPinNo := Employee.PIN;
                // AKK END
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");
                CurrReport.CreateTotals(ColumnD, ColumnL);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102754001)
                {
                    ShowCaption = false;
                    field(Year; Year)
                    {
                        Caption = 'Year';
                        TableRelation = Year.Year;
                    }
                    field("INT/PENALTY"; "INT/PENALTY")
                    {
                        Caption = 'TAX ON LUMPSUM/AUDIT TAX/ INTEREST/PENALTY';
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
        gsSegmentPayrollData;

        PayrollSetup.Get(gvAllowedPayrolls."Payroll Code");
        PayrollSetup.TestField("Employer PIN No.");
        PayrollSetup.TestField("Employer Name");

        if Year = 0 then Error('You must specify the Year on the options tab.');
    end;

    var
        Year: Integer;
        YearRec: Record Year;
        PayrollHeader: Record "Payroll Header";
        ColumnD: Decimal;
        ColumnL: Decimal;
        PayrollSetup: Record "Payroll Setups";
        "INT/PENALTY": Decimal;
        gvAllowedPayrolls: Record "Allowed Payrolls";
        MembershipNumbers: Record "Membership Numbers";
        gvPinNo: Code[20];
        TAX_DEDUCTED_KSHSCaptionLbl: Label 'TAX DEDUCTED KSHS';
        TOTAL_EMOLUMENTS_KSHSCaptionLbl: Label 'TOTAL EMOLUMENTS KSHS';
        EMPLOYEE__S_NAMECaptionLbl: Label 'EMPLOYEE''''S NAME';
        EMPLOYEE__S_PIN_CaptionLbl: Label 'EMPLOYEE''''S PIN ';
        INCOME_TAX_DEPARTMENTCaptionLbl: Label 'INCOME TAX DEPARTMENT';
        P10ACaptionLbl: Label 'P10A';
        KENYA_REVENUE_AUTHORITYCaptionLbl: Label 'KENYA REVENUE AUTHORITY';
        TOTALSCaptionLbl: Label 'TOTALS';
        ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE_P10CaptionLbl: Label 'ATTACH TWO COPIES OF THIS LIST TO END OF YEAR CERTIFICATE P10';
        NOTE_TO_EMPLOYER_CaptionLbl: Label 'NOTE TO EMPLOYER:';
        TAX_ON_LUMPSUM_AUDIT_TAX_INTEREST_PENALTYCaptionLbl: Label 'TAX ON LUMPSUM/AUDIT TAX/INTEREST/PENALTY';
        TOTAL_TAX_DEDUCTED___TOTAL_C_F_TO_NEXT_LISTCaptionLbl: Label '*TOTAL TAX DEDUCTED/* TOTAL C/F TO NEXT LIST';
        DELETE_AS_APPROPRIATECaptionLbl: Label '*DELETE AS APPROPRIATE';
        ColumnTotalL: Decimal;

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

