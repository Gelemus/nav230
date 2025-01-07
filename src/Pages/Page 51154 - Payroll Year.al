page 51154 "Payroll Year"
{
    PageType = List;
    Permissions = TableData Periods = rimd;
    SourceTable = Year;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Year; Rec.Year)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End date"; Rec."End date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Annual TAX Table"; Rec."Annual TAX Table")
                {
                }
                field("Annual TAX Relief Table"; Rec."Annual TAX Relief Table")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Init Periods")
            {
                Caption = '&Init Periods';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payroll Periods";
                RunPageLink = "Period Year" = FIELD(Year);

                trigger OnAction()
                var
                    lvPeriods: Record Periods;
                    lvIndex: Integer;
                begin
                    //skm230409 revised to support multiple payrolls in one db

                    gvPayrollUtilities.sGetActivePayroll(gvAllowedPayrolls);
                    lvPeriods.SetRange("Period Year", Rec.Year);
                    lvPeriods.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                    if lvPeriods.Find('-') then Error('Payroll period(s) exists for year %1', Rec.Year);

                    for lvIndex := 1 to 12 do begin
                        lvPeriods.Init;
                        lvPeriods."Period ID" := StrSubstNo('%1-%2', lvIndex, Rec.Year);
                        lvPeriods."Period Month" := lvIndex;
                        lvPeriods."Period Year" := Rec.Year;
                        lvPeriods."Start Date" := DMY2Date(1, lvIndex, Rec.Year);

                        case lvIndex of
                            1:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('January %1', Rec.Year);
                                end;

                            2:
                                begin
                                    lvPeriods."End Date" := DMY2Date(28, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('February %1', Rec.Year);
                                end;

                            3:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('March %1', Rec.Year);
                                end;

                            4:
                                begin
                                    lvPeriods."End Date" := DMY2Date(30, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('April %1', Rec.Year);
                                end;

                            5:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('May %1', Rec.Year);
                                end;

                            6:
                                begin
                                    lvPeriods."End Date" := DMY2Date(30, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('June %1', Rec.Year);
                                end;

                            7:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('July %1', Rec.Year);
                                end;

                            8:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('August %1', Rec.Year);
                                end;

                            9:
                                begin
                                    lvPeriods."End Date" := DMY2Date(30, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('September %1', Rec.Year);
                                end;

                            10:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('October %1', Rec.Year);
                                end;

                            11:
                                begin
                                    lvPeriods."End Date" := DMY2Date(30, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('November %1', Rec.Year);
                                end;

                            12:
                                begin
                                    lvPeriods."End Date" := DMY2Date(31, lvIndex, Rec.Year);
                                    lvPeriods.Description := StrSubstNo('December %1', Rec.Year);
                                end;
                        end; //Case

                        lvPeriods."Posting Date" := lvPeriods."End Date";
                        lvPeriods."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                        lvPeriods.Insert;
                    end; //For
                end;
            }
            action("&Init Periods (Weeks)")
            {
                Caption = '&Init Periods (Weeks)';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payroll Periods";
                RunPageLink = "Period Year" = FIELD(Year);

                trigger OnAction()
                var
                    lvPeriods: Record Periods;
                    lvIndex: Integer;
                begin
                    //skm230409 revised to support multiple payrolls in one db

                    gvPayrollUtilities.sGetActivePayroll(gvAllowedPayrolls);
                    lvPeriods.SetRange("Period Year", Rec.Year);
                    lvPeriods.SetRange("Payroll Code", gvAllowedPayrolls."Payroll Code");

                    if lvPeriods.Find('-') then Error('Payroll period(s) exists for year %1', Rec.Year);

                    for lvIndex := 1 to 52 do begin
                        lvPeriods.Init;
                        lvPeriods."Period ID" := StrSubstNo('%1-%2', lvIndex, Rec.Year);
                        lvPeriods."Period Month" := lvIndex;
                        lvPeriods."Period Year" := Rec.Year;
                        lvPeriods."Start Date" := DWY2Date(1, lvIndex, Rec.Year);

                        case lvIndex of
                            1:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 1 %1', Rec.Year);
                                end;

                            2:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 2 %1', Rec.Year);
                                end;

                            3:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 3 %1', Rec.Year);
                                end;

                            4:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 4 %1', Rec.Year);
                                end;

                            5:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 5 %1', Rec.Year);
                                end;

                            6:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 6 %1', Rec.Year);
                                end;

                            7:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 7 %1', Rec.Year);
                                end;

                            8:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 8 %1', Rec.Year);
                                end;

                            9:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 9 %1', Rec.Year);
                                end;

                            10:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 10 %1', Rec.Year);
                                end;

                            11:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 11 %1', Rec.Year);
                                end;

                            12:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 12 %1', Rec.Year);
                                end;
                            13:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 13 %1', Rec.Year);
                                end;

                            14:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 14 %1', Rec.Year);
                                end;

                            15:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 15 %1', Rec.Year);
                                end;

                            16:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 16 %1', Rec.Year);
                                end;

                            17:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 17 %1', Rec.Year);
                                end;

                            18:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 18 %1', Rec.Year);
                                end;

                            19:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 19 %1', Rec.Year);
                                end;

                            20:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 20 %1', Rec.Year);
                                end;

                            21:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 21 %1', Rec.Year);
                                end;

                            22:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 22 %1', Rec.Year);
                                end;

                            23:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 23 %1', Rec.Year);
                                end;

                            24:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 24 %1', Rec.Year);
                                end;
                            25:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 25 %1', Rec.Year);
                                end;

                            26:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 26 %1', Rec.Year);
                                end;

                            27:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 27 %1', Rec.Year);
                                end;

                            28:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 28 %1', Rec.Year);
                                end;

                            29:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 29 %1', Rec.Year);
                                end;

                            30:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 30 %1', Rec.Year);
                                end;

                            31:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 31 %1', Rec.Year);
                                end;

                            32:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 32 %1', Rec.Year);
                                end;

                            33:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 33 %1', Rec.Year);
                                end;

                            34:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 34 %1', Rec.Year);
                                end;

                            35:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 35 %1', Rec.Year);
                                end;

                            36:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 36 %1', Rec.Year);
                                end;
                            37:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 37 %1', Rec.Year);
                                end;

                            38:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 38 %1', Rec.Year);
                                end;

                            39:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 39 %1', Rec.Year);
                                end;

                            40:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 40 %1', Rec.Year);
                                end;

                            41:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 41 %1', Rec.Year);
                                end;

                            42:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 42 %1', Rec.Year);
                                end;

                            43:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 43 %1', Rec.Year);
                                end;

                            44:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 44 %1', Rec.Year);
                                end;

                            45:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 45 %1', Rec.Year);
                                end;

                            46:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 46 %1', Rec.Year);
                                end;

                            47:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 47 %1', Rec.Year);
                                end;

                            48:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 48 %1', Rec.Year);
                                end;
                            49:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 49 %1', Rec.Year);
                                end;

                            50:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 50 %1', Rec.Year);
                                end;

                            51:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 51 %1', Rec.Year);
                                end;

                            52:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 52 %1', Rec.Year);
                                end;

                            53:
                                begin
                                    lvPeriods."End Date" := CalcDate('<1W>', lvPeriods."Start Date");
                                    lvPeriods.Description := StrSubstNo('Week 53 %1', Rec.Year);
                                end;
                        end; //Case

                        lvPeriods."Posting Date" := lvPeriods."End Date";
                        lvPeriods."Payroll Code" := gvAllowedPayrolls."Payroll Code";
                        lvPeriods.Insert;
                    end; //For
                end;
            }
            action("&Periods")
            {
                Caption = '&Periods';
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payroll Periods";
                RunPageLink = "Period Year" = FIELD(Year);
            }
        }
    }

    var
        gvPayrollUtilities: Codeunit "Payroll Posting";
        gvAllowedPayrolls: Record "Allowed Payrolls";
}

