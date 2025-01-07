report 50214 "ProjectsList"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Layouts/ProjectsList.rdl';

    dataset
    {
        dataitem("Transport Request"; "Transport Request")
        {
            RequestFilterFields = "Request No.";
            column(Name; CompanyInfo.Name)
            {
            }
            column(Description_TransportRequest; "Transport Request".Description)
            {
            }
            column(ProjectFinancierClient_TransportRequest; "Transport Request"."Project Financier")
            {
            }
            column(Contractor_TransportRequest; "Transport Request".Contractor)
            {
            }
            column(ReportingPeriodStart_TransportRequest; "Transport Request"."Reporting Period - Start")
            {
            }
            column(ReportingPeriodEnd_TransportRequest; "Transport Request"."Reporting Period - End")
            {
            }
            column(ConstructionStartdate_TransportRequest; "Transport Request"."Construction Start date")
            {
            }
            column(ConstructionCompletiondate_TransportRequest; "Transport Request"."Construction Completion date")
            {
            }
            column(ProjectStatus_TransportRequest; "Transport Request"."Project Status")
            {
            }
            column(RequestNo_TransportRequest; "Transport Request"."Request No.")
            {
            }
            column(EmployeeNo_TransportRequest; "Transport Request"."Employee No.")
            {
            }
            column(EmployeeName_TransportRequest; "Transport Request"."Employee Name")
            {
            }
            column(ofworksdoneperbillitem_TransportRequest; "Transport Request"."% of works done per bill item")
            {
            }
            dataitem("Bill Item"; "Bill Item")
            {
                DataItemLink = "Job ID" = FIELD("Request No.");
                RequestFilterFields = "Start Date";
                column(JobID_BillItem; "Bill Item"."Job ID")
                {
                }
                column(LineNo_BillItem; "Bill Item"."Line No")
                {
                }
                column(BillItemNo_BillItem; "Bill Item"."Bill Item No.")
                {
                }
                column(Description_BillItem; "Bill Item".Description)
                {
                }
                column(Summaryworksdone_BillItem; "Bill Item"."Summary works done")
                {
                }
                column(BillItemType_BillItem; "Bill Item"."Bill Item Type")
                {
                }
                column(WIPTotal_BillItem; "Bill Item"."WIP-Total")
                {
                }
                column(StartDate_BillItem; "Bill Item"."Start Date")
                {
                }
                column(EndDate_BillItem; "Bill Item"."End Date")
                {
                }
                column(Indentation_BillItem; "Bill Item".Indentation)
                {
                }
                column(Remarks_BillItem; "Bill Item".Remarks)
                {
                }
                column(Components_BillItem; "Bill Item".Components)
                {
                }
                column(ofworksdoneperbillitem_BillItem; "Bill Item"."% of works done per bill item")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                //if CompanyInfo.Get then

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

    var
        CompanyInfo: Record "Company Information";
}

