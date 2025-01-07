report 50062 "Campaign Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/Campaign Report.rdl';

    dataset
    {
        dataitem(Campaign; Campaign)
        {
            // RequestFilterFields = "No.",Field52137003,Field52137004,Field52137000,Field52137001,Field52137002;
            column(LN1; LN1)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Web; CompanyInfo."Home Page")
            {
            }
            column(No_Campaign; Campaign."No.")
            {
            }
            column(Description_Campaign; Campaign.Description)
            {
            }
            column(StartingDate_Campaign; Campaign."Starting Date")
            {
            }
            column(EndingDate_Campaign; Campaign."Ending Date")
            {
            }
            column(SalespersonCode_Campaign; Campaign."Salesperson Code")
            {
            }
            column(Comment_Campaign; Campaign.Comment)
            {
            }
            column(Budget_Campaign; Campaign.Comment)
            {
            }
            column(BudgetAmount_Campaign; Campaign.Comment)
            {
            }
            column(TaskEstimatedAmount_Campaign; Campaign.Comment)
            {
            }
            column(Status_Campaign; Campaign.Comment)
            {
            }
            column(DocumentDate_Campaign; Campaign.Comment)
            {
            }
            column(UserID_Campaign; Campaign.Comment)
            {
            }
            column(IncomingDocumentEntryNo_Campaign; Campaign.Comment)
            {
            }
            dataitem("To-do"; "To-do")
            {
                DataItemLink = "Campaign No." = FIELD("No.");
                column(No_Todo; "To-do"."No.")
                {
                }
                column(TeamCode_Todo; "To-do"."Team Code")
                {
                }
                column(SalespersonCode_Todo; "To-do"."Salesperson Code")
                {
                }
                column(CampaignNo_Todo; "To-do"."Campaign No.")
                {
                }
                column(ContactNo_Todo; "To-do"."Contact No.")
                {
                }
                column(OpportunityNo_Todo; "To-do"."Opportunity No.")
                {
                }
                column(SegmentNo_Todo; "To-do"."Segment No.")
                {
                }
                column(Type_Todo; "To-do".Type)
                {
                }
                column(Date_Todo; "To-do".Date)
                {
                }
                column(Status_Todo; "To-do".Status)
                {
                }
                column(Priority_Todo; "To-do".Priority)
                {
                }
                column(Description_Todo; "To-do".Description)
                {
                }
                column(Closed_Todo; "To-do".Closed)
                {
                }
                column(DateClosed_Todo; "To-do"."Date Closed")
                {
                }
                column(NoSeries_Todo; "To-do"."No. Series")
                {
                }
                column(Comment_Todo; "To-do".Comment)
                {
                }
                column(Canceled_Todo; "To-do".Canceled)
                {
                }
                column(ContactName_Todo; "To-do"."Contact Name")
                {
                }
                column(TeamName_Todo; "To-do"."Team Name")
                {
                }
                column(SalespersonName_Todo; "To-do"."Salesperson Name")
                {
                }
                column(CampaignDescription_Todo; "To-do"."Campaign Description")
                {
                }
                column(ContactCompanyNo_Todo; "To-do"."Contact Company No.")
                {
                }
                column(ContactCompanyName_Todo; "To-do"."Contact Company Name")
                {
                }
                column(Recurring_Todo; "To-do".Recurring)
                {
                }
                column(RecurringDateInterval_Todo; "To-do"."Recurring Date Interval")
                {
                }
                column(CalcDueDateFrom_Todo; "To-do"."Calc. Due Date From")
                {
                }
                column(OpportunityDescription_Todo; "To-do"."Opportunity Description")
                {
                }
                column(StartTime_Todo; "To-do"."Start Time")
                {
                }
                column(Duration_Todo; "To-do".Duration)
                {
                }
                column(OpportunityEntryNo_Todo; "To-do"."Opportunity Entry No.")
                {
                }
                column(LastDateModified_Todo; "To-do"."Last Date Modified")
                {
                }
                column(LastTimeModified_Todo; "To-do"."Last Time Modified")
                {
                }
                column(AllDayEvent_Todo; "To-do"."All Day Event")
                {
                }
                column(Location_Todo; "To-do".Location)
                {
                }
                column(OrganizerTodoNo_Todo; "To-do"."Organizer To-do No.")
                {
                }
                column(InteractionTemplateCode_Todo; "To-do"."Interaction Template Code")
                {
                }
                column(LanguageCode_Todo; "To-do"."Language Code")
                {
                }
                column(AttachmentNo_Todo; "To-do"."Attachment No.")
                {
                }
                column(Subject_Todo; "To-do".Subject)
                {
                }
                column(UnitCostLCY_Todo; "To-do"."Unit Cost (LCY)")
                {
                }
                column(UnitDurationMin_Todo; "To-do"."Unit Duration (Min.)")
                {
                }
                column(NoofAttendees_Todo; "To-do"."No. of Attendees")
                {
                }
                column(AttendeesAcceptedNo_Todo; "To-do"."Attendees Accepted No.")
                {
                }
                column(SystemTodoType_Todo; "To-do"."System To-do Type")
                {
                }
                column(CompletedBy_Todo; "To-do"."Completed By")
                {
                }
                column(EndingDate_Todo; "To-do"."Ending Date")
                {
                }
                column(EndingTime_Todo; "To-do"."Ending Time")
                {
                }
                column(WizardStep_Todo; "To-do"."Wizard Step")
                {
                }
                column(TeamTodo_Todo; "To-do"."Team To-do")
                {
                }
                column(Sendonfinish_Todo; "To-do"."Send on finish")
                {
                }
                column(SegmentDescription_Todo; "To-do"."Segment Description")
                {
                }
                column(TeamMeetingOrganizer_Todo; "To-do"."Team Meeting Organizer")
                {
                }
                column(ActivityCode_Todo; "To-do"."Activity Code")
                {
                }
                column(WizardContactName_Todo; "To-do"."Wizard Contact Name")
                {
                }
                column(WizardCampaignDescription_Todo; "To-do"."Wizard Campaign Description")
                {
                }
                column(WizardOpportunityDescription_Todo; "To-do"."Wizard Opportunity Description")
                {
                }
                column(EstimatedCost_Todo; "To-do"."Wizard Opportunity Description")
                {
                }
            }
            dataitem("Employee Interest Accrual"; "Employee Interest Accrual")
            {
                DataItemLink = "Account No." = FIELD("No.");
                column(DocumentNo_MarketingActivities; "Employee Interest Accrual"."Account No.")
                {
                }
                column(LineNo_MarketingActivities; "Employee Interest Accrual"."Accrual Type")
                {
                }
                column(ActivityDate_MarketingActivities; "Employee Interest Accrual"."Accrual Date")
                {
                }
                column(ActivityDescription_MarketingActivities; "Employee Interest Accrual"."Accrual Date")
                {
                }
                column(Type_MarketingActivities; "Employee Interest Accrual"."Accrual Date")
                {
                }
                column(EmployeeID_MarketingActivities; "Employee Interest Accrual"."Posted to Customer Account")
                {
                }
                column(UserID_MarketingActivities; "Employee Interest Accrual".Received)
                {
                }
                column(DateCreated_MarketingActivities; "Employee Interest Accrual"."Accrual Date")
                {
                }
                column(TimeCreated_MarketingActivities; "Employee Interest Accrual"."Accrual Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                LN1 := LN1 + 1;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        CompanyInfo: Record "Company Information";
        LN1: Integer;
}

