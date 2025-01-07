report 50112 "Case Management"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Case Management.rdl';

    dataset
    {
        dataitem("Payment Terms"; "Payment Terms")
        {
            column(CaseNo; "Payment Terms".Code)
            {
            }
            column(StartDate; "Payment Terms".Code)
            {
            }
            column(CaseTitle; "Payment Terms".Code)
            {
            }
            column(CaseType; "Payment Terms".Code)
            {
            }
            column(CourtType; "Payment Terms".Code)
            {
            }
            column(CourtName; "Payment Terms".Code)
            {
            }
            column(Courtcaseof; "Payment Terms".Code)
            {
            }
            column(Status; "Payment Terms".Code)
            {
            }
            column(JudgeName; "Payment Terms".Code)
            {
            }
            column(ClosingDate; "Payment Terms".Code)
            {
            }
            column(CompletionStatus; "Payment Terms".Code)
            {
            }
            column(CompletionPercentage; "Payment Terms".Code)
            {
            }
            column(Description_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(CaseDuration_CaseManagementHeader; "Payment Terms".Code)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            dataitem("File Types"; "File Types")
            {
                column(Attendancedate; "Payment Terms".Code)
                {
                }
                column(Details; "Payment Terms".Code)
                {
                }
                column(StartTime; "Payment Terms".Code)
                {
                }
                column(EndTime; "Payment Terms".Code)
                {
                }
                column(Duration; "Payment Terms".Code)
                {
                }
                column(LineStatus; "Payment Terms".Code)
                {
                }
            }
            dataitem(Counsel; "File Detail")
            {
                DataItemLink = "File Code" = FIELD(Code);
                DataItemTableView = WHERE("File Description" = FILTER('1' | '2'));
                column(Type; Counsel."File Description")
                {
                }
                column(CounselNames; Counsel."Max Size Recommended")
                {
                }
                column(CounselAddress; Counsel."Measure type for size")
                {
                }
                column(CounselEmailAddress; "Payment Terms".Code)
                {
                }
                column(CounselPhoneNo; Counsel."File Status")
                {
                }
                column(CounselLineNo; Counsel."Creation Date")
                {
                }
            }
            dataitem(Witnesses; "File Detail")
            {
                DataItemLink = "File Code" = FIELD(Code);
                DataItemTableView = WHERE("File Description" = CONST('3'));
                column(WitnessNames; Witnesses."Max Size Recommended")
                {
                }
                column(WitnessAddress; Witnesses."Measure type for size")
                {
                }
                column(WitnessEmailAddress; "Payment Terms".Code)
                {
                }
                column(WitnessPhoneNo; Witnesses."File Status")
                {
                }
                column(WitnessLineNo; Witnesses."Creation Date")
                {
                }
            }
            dataitem(Defendants; "File Detail")
            {
                DataItemLink = "File Code" = FIELD(Code);
                DataItemTableView = WHERE("File Description" = CONST('5'));
                column(DefendantsNames; Defendants."Max Size Recommended")
                {
                }
                column(DefendantsAddress; Defendants."Measure type for size")
                {
                }
                column(DefendantsEmailAddress; "Payment Terms".Code)
                {
                }
                column(DefendantsPhoneNo; Defendants."File Status")
                {
                }
                column(DefendantLineNo; Defendants."Creation Date")
                {
                }
            }
            dataitem(Experts; "File Detail")
            {
                DataItemLink = "File Code" = FIELD(Code);
                DataItemTableView = WHERE("File Description" = CONST('4'));
                column(ExpertsNames; Experts."Max Size Recommended")
                {
                }
                column(ExpertsAddress; Experts."Measure type for size")
                {
                }
                column(ExpertsEmailAddress; "Payment Terms".Code)
                {
                }
                column(ExpertsPhoneNo; Experts."File Status")
                {
                }
                column(ExpertLineNo; Experts."Creation Date")
                {
                }
            }
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
}

