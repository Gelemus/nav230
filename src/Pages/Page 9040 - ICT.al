// page 9040 ICT
// {
//     Caption = 'IT Manager', Comment = '{Dependency=Match,"ProfileDescription_ITMANAGER"}';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control1900724808)
//             {
//                 ShowCaption = false;
//                 part(Control1904484608; "IT Operations Activities")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 part(Control58; "CRM Synch. Job Status Part")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//                 part(Control52; "Service Connections Part")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//             }
//             group(Control1900724708)
//             {
//                 ShowCaption = false;
//                 part(Control36; "Report Inbox Part")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 part(Control32; "My Job Queue")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//                 systempart(Control1901377608; MyNotes)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(reporting)
//         {
//             action("Check on Ne&gative Inventory")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Check on Ne&gative Inventory';
//                 Image = "Report";
//                 RunObject = Report "Items with Negative Inventory";
//                 ToolTip = 'View a list of items with negative inventory and open warehouse documents for a location.';
//             }
//         }
//         area(embedding)
//         {
//             ToolTip = 'Set up users and cross-product values, such as number series and post codes.';
//             action("Inventory User Setup")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Inventory User Setup';
//                 Image = UserSetup;
//                 RunObject = Page "Inventory User Setup";
//                 ToolTip = 'Inventory User Setup';
//             }
//             action(Users)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Users';
//                 Image = UserSetup;
//                 RunObject = Page Users;
//                 ToolTip = 'Set up users and define their permissions.';
//             }
//             action("User Setup")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'User Setup';
//                 Image = UserSetup;
//                 RunObject = Page "User Setup";
//                 ToolTip = 'Set up users and define their permissions.';
//                 Visible = false;
//             }
//             action(Employees)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Employees';
//                 Image = UserInterface;
//                 RunObject = Page Employees;
//                 ToolTip = 'Set up users and define their permissions.';
//                 Visible = true;
//             }
//             action("Approval User Setup")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approval User Setup';
//                 RunObject = Page "Approval User Setup";
//                 ToolTip = 'View or edit information about workflow users who are involved in approval processes, such as approval amount limits for specific types of requests and substitute approvers to whom approval requests are delegated when the original approver is absent.';
//                 Visible = false;
//             }
//             action("Workflow User Groups")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Workflow User Groups';
//                 Image = Users;
//                 RunObject = Page "Workflow User Groups";
//                 ToolTip = 'View or edit the list of users that take part in workflows and which workflow user groups they belong to.';
//                 Visible = false;
//             }
//             action("User Personalization List")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'User Personalization List';
//                 Image = Users;
//                 RunObject = Page "User Personalization List";
//                 ToolTip = 'User Personalization List';
//                 Visible = false;
//             }
//             action("Job Queue Entries")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Job Queue Entries';
//                 RunObject = Page "Job Queue Entries";
//                 ToolTip = 'View or edit the tasks that are set up to run business processes automatically at user-defined intervals.';
//             }
//             action("Cases - Dynamics 365 for Customer Service")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cases - Dynamics 365 for Customer Service';
//                 RunObject = Page "CRM Case List";
//                 ToolTip = 'View a list of Microsoft Dynamics 365 for Customer Service cases.';
//             }
//             action("No. Series")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'No. Series';
//                 RunObject = Page "No. Series";
//                 ToolTip = 'Set up the number series from which a new number is automatically assigned to new cards and documents, such as item cards and sales invoices.';
//             }
//             action("Data Templates List")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Data Templates List';
//                 RunObject = Page "Config. Template List";
//                 ToolTip = 'View or edit template that are being used for data migration.';
//             }
//             action("Base Calendar List")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Base Calendar List';
//                 RunObject = Page "Base Calendar List";
//                 ToolTip = 'View the list of calendars that exist for your company and your business partners to define the agreed working days.';
//             }
//             action("Post Codes")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Post Codes';
//                 RunObject = Page "Post Codes";
//                 ToolTip = 'Set up the post codes of cities where your business partners are located.';
//             }
//             action("Reason Codes")
//             {
//                 ApplicationArea = Suite;
//                 Caption = 'Reason Codes';
//                 RunObject = Page "Reason Codes";
//                 ToolTip = 'View or set up codes that specify reasons why entries were created, such as Return, to specify why a purchase credit memo was posted.';
//             }
//             action("Extended Text")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Extended Text';
//                 RunObject = Page "Extended Text List";
//                 ToolTip = 'View or edit additional text for the descriptions of items. Extended text can be inserted under the Description field on document lines for the item.';
//             }
//         }
//         area(sections)
//         {
//             group("Employee Self Service")
//             {
//                 Caption = 'Employee Self Service';
//                 action(" Imprest List")
//                 {
//                     Caption = ' Imprest List';
//                     RunObject = Page "Imprest List";
//                 }
//                 action("Imprest List Status")
//                 {
//                     Caption = 'Imprest List Status';
//                     RunObject = Page "Imprest List Status";
//                 }
//                 action("Imprest Surrender List")
//                 {
//                     Caption = 'Imprest Surrender List';
//                     RunObject = Page "Imprest Surrender List";
//                     Visible = false;
//                 }
//                 action("HR Employee Appraisals")
//                 {
//                     Caption = 'HR Employee Appraisals';
//                     RunObject = Page "HR Employee Appraisals";
//                 }
//                 action("HR Employee Appraisals Status")
//                 {
//                     Caption = 'HR Employee Appraisals Status';
//                     RunObject = Page "HR Employee Appraisals Status";
//                 }
//                 action("Petty Cash list")
//                 {
//                     Caption = 'Petty Cash list';
//                     RunObject = Page "Petty Cash list";
//                 }
//                 action("Petty Cash list Status")
//                 {
//                     Caption = 'Petty Cash list Status';
//                     RunObject = Page "Petty Cash list S";
//                 }
//                 action(Action139)
//                 {
//                     Caption = 'Imprest Surrender List';
//                     RunObject = Page "Imprest Surrender List";
//                 }
//                 action("Approved Imprest Surrender")
//                 {
//                     Caption = 'Approved Imprest Surrender';
//                     RunObject = Page "Approved Imprest Surrender";
//                 }
//                 action("Petty Cash Surrender list")
//                 {
//                     Caption = 'Petty Cash Surrender list';
//                     RunObject = Page "Petty Cash Surrender List";
//                 }
//                 action("Approved Petty Cash Surrender")
//                 {
//                     Caption = 'Approved Petty Cash Surrender';
//                     RunObject = Page "Approved Petty Cash Surrender";
//                 }
//                 action("Store Requisitions List")
//                 {
//                     Caption = 'Store Requisitions List';
//                     RunObject = Page "Store Requisitions List";
//                 }
//                 action("Store Requisitions List Status")
//                 {
//                     Caption = 'Store Requisitions List Status';
//                     RunObject = Page "Store Requisitions List Status";
//                 }
//                 action("Purchase Requisition List")
//                 {
//                     Caption = 'Purchase Requisition List';
//                     RunObject = Page "Requisition List";
//                 }
//                 action("Status Purchase Requisition List")
//                 {
//                     Caption = 'Status Purchase Requisition List';
//                     RunObject = Page "Purchase Requisition List S";
//                 }
//                 action("Leave Application")
//                 {
//                     Caption = 'Leave Application';
//                     RunObject = Page "Leave Applications";
//                 }
//                 action(" Leave Applications Status")
//                 {
//                     Caption = ' Leave Applications Status';
//                     RunObject = Page "Leave Applications Status";
//                 }
//                 action("Leave Reimbursements")
//                 {
//                     Caption = 'Leave Reimbursements';
//                     RunObject = Page "Leave Reimbursements";
//                 }
//                 action(Action100)
//                 {
//                     Caption = 'HR Employee Appraisals';
//                     RunObject = Page "HR Employee Appraisals";
//                 }
//                 action(Action92)
//                 {
//                     Caption = 'HR Employee Appraisals Status';
//                     RunObject = Page "HR Employee Appraisals Status";
//                 }
//                 action("Transport Request List")
//                 {
//                     Caption = 'Transport Request List';
//                     RunObject = Page "Transport Request List";
//                 }
//                 action("Vehicle Allocations List")
//                 {
//                     Caption = 'Vehicle Allocations List';
//                     RunObject = Page "Vehicle Allocations List";
//                 }
//                 action("Allocated Vehicle List")
//                 {
//                     Caption = 'Allocated Vehicle List';
//                     RunObject = Page "Allocated Vehicle List";
//                 }
//                 action("Safari Notice List")
//                 {
//                     Caption = 'Safari Notice List';
//                     RunObject = Page "Safari Notice List";
//                 }
//                 action("Safari Notice List - Status")
//                 {
//                     Caption = 'Safari Notice List - Status';
//                     RunObject = Page "Safari Notice List - Status";
//                 }
//                 action("Salary Advance Applications")
//                 {
//                     Caption = 'Salary Advance Applications';
//                     RunObject = Page "Salary Advance Applications";
//                 }
//                 action("Casual Requisitions")
//                 {
//                     Caption = 'Casual Requisitions';
//                     RunObject = Page "Casual Requisitions";
//                 }
//                 action("Page Casuals Payment List")
//                 {
//                     Caption = 'Page Casuals Payment List';
//                     RunObject = Page "Casuals Payment List";
//                     Visible = false;
//                 }
//                 action("Casual Requisitions Pending")
//                 {
//                     Caption = 'Casual Requisitions Pending';
//                     RunObject = Page "Casual Requisitions Pending";
//                 }
//                 action("Casual Requisitions Approved")
//                 {
//                     Caption = 'Casual Requisitions Approved';
//                     RunObject = Page "Casual Requisitions Approved";
//                 }
//                 action("Casuals Payment List")
//                 {
//                     Caption = 'Casuals Payment List';
//                     RunObject = Page "Casuals Payment List";
//                 }
//                 action("Pending Approval Casual Payment List")
//                 {
//                     Caption = 'Pending Approval Casual Payment List';
//                     RunObject = Page "Pending Ap Casual Payment List";
//                 }
//                 action("Approved Casual Payment List")
//                 {
//                     Caption = 'Approved Casual Payment List';
//                     RunObject = Page "Approved Casual Payment List";
//                 }
//             }
//             group("Job Queue")
//             {
//                 Caption = 'Job Queue';
//                 Image = ExecuteBatch;
//                 ToolTip = 'Specify how reports, batch jobs, and codeunits are run.';
//                 action(JobQueue_JobQueueEntries)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Job Queue Entries';
//                     RunObject = Page "Job Queue Entries";
//                     ToolTip = 'View or edit the tasks that are set up to run business processes automatically at user-defined intervals.';
//                 }
//                 action("Job Queue Category List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Job Queue Category List';
//                     RunObject = Page "Job Queue Category List";
//                     ToolTip = 'View or edit the task categories that are set up to run business processes automatically at user-defined intervals.';
//                 }
//                 action("Job Queue Log Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Job Queue Log Entries';
//                     RunObject = Page "Job Queue Log Entries";
//                     ToolTip = 'View information for job queue entries that have run or have not run due to errors including job queue entries that have the status On Hold.';
//                 }
//             }
//             group(Workflow)
//             {
//                 Caption = 'Workflow';
//                 Enabled = false;
//                 ToolTip = 'Set up workflow and approval users, and create workflows that govern how the users interact in processes.';
//                 Visible = false;
//                 action(Workflows)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Workflows';
//                     Image = ApprovalSetup;
//                     RunObject = Page Workflows;
//                     ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
//                 }
//                 action("Workflow Templates")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Workflow Templates';
//                     Image = Setup;
//                     RunObject = Page "Workflow Templates";
//                     ToolTip = 'View the list of workflow templates that exist in the standard version of Business Central for supported scenarios. The codes for workflow templates that are added by Microsoft are prefixed with MS-. You cannot modify a workflow template, but you use it to create a workflow.';
//                 }
//                 action(ApprovalUserSetup)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approval User Setup';
//                     RunObject = Page "Approval User Setup";
//                     ToolTip = 'View or edit information about workflow users who are involved in approval processes, such as approval amount limits for specific types of requests and substitute approvers to whom approval requests are delegated when the original approver is absent.';
//                 }
//                 action(WorkflowUserGroups)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Workflow User Groups';
//                     Image = Users;
//                     RunObject = Page "Workflow User Groups";
//                     ToolTip = 'View or edit the list of users that take part in workflows and which workflow user groups they belong to.';
//                 }
//             }
//             group(Intrastat)
//             {
//                 Caption = 'Intrastat';
//                 Image = Intrastat;
//                 ToolTip = 'Set up Intrastat reporting values, such as tariff numbers.';
//                 Visible = false;
//                 action("Tariff Numbers")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Tariff Numbers';
//                     RunObject = Page "Tariff Numbers";
//                     ToolTip = 'View or edit the list of tariff numbers for item that your company buys and sells in the EU. The numbers are used to report Intrastat. The tax and customs authorities publish tariff numbers, which are eight-digit item codes, for a large number of products.';
//                 }
//                 action("Transaction Types")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Transaction Types';
//                     RunObject = Page "Transaction Types";
//                     ToolTip = 'View information that all EU businesses must report for their trade with other EU countries/regions for Intrastat reporting.';
//                 }
//                 action("Transaction Specifications")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Transaction Specifications';
//                     RunObject = Page "Transaction Specifications";
//                     ToolTip = 'View additional information about Intrastat reporting.';
//                 }
//                 action("Transport Methods")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Transport Methods';
//                     RunObject = Page "Transport Methods";
//                     ToolTip = 'View information about how your items are transported between EU country/regions, for Intrastat reporting.';
//                 }
//                 action("Entry/Exit Points")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Entry/Exit Points';
//                     RunObject = Page "Entry/Exit Points";
//                     ToolTip = 'View or edit codes for the location to which items from abroad are shipped or from which you ship items abroad. The information is used when reporting to Intrastat.';
//                 }
//                 action(Areas)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Areas';
//                     RunObject = Page Areas;
//                     ToolTip = 'View or edit information about the areas that you have set up for your configuration. The information includes a count of how many tables fall within each category.';
//                 }
//             }
//             group("VAT Registration Numbers")
//             {
//                 Caption = 'VAT Registration Numbers';
//                 Image = Bank;
//                 ToolTip = 'Set up and maintain VAT registration number formats.';
//                 Visible = false;
//                 action("VAT Registration No. Formats")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'VAT Registration No. Formats';
//                     RunObject = Page "VAT Registration No. Formats";
//                     ToolTip = 'View the formats for VAT registration number in different countries/regions.';
//                 }
//             }
//             group("Analysis View")
//             {
//                 Caption = 'Analysis View';
//                 Image = AnalysisView;
//                 ToolTip = 'Set up views for analysis of sales, purchases, and inventory.';
//                 Visible = false;
//                 action("Sales Analysis View List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Sales Analysis View List';
//                     RunObject = Page "Analysis View List Sales";
//                     ToolTip = 'View the list of views that you use to analyze the dynamics of your sales volumes. You can also use the report to analyze your customer''s performance.';
//                 }
//                 action("Purchase Analysis View List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Purchase Analysis View List';
//                     RunObject = Page "Analysis View List Purchase";
//                     ToolTip = 'View the list of views that you use to analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
//                 }
//                 action("Inventory Analysis View List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Inventory Analysis View List';
//                     RunObject = Page "Analysis View List Inventory";
//                     ToolTip = 'View or edit your predefined views of items at a specified location per their combination of dimensions.';
//                 }
//             }
//             group("Data Privacy")
//             {
//                 Caption = 'Data Privacy';
//                 Image = HumanResources;
//                 ToolTip = 'Manage data privacy classifications, and respond to requests from data subjects.';
//                 action("Page Data Classifications")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Data Classifications';
//                     RunObject = Page "Data Classification Worksheet";
//                     ToolTip = 'View your current data classifications';
//                 }
//                 action(Classified)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Classified Fields';
//                     RunObject = Page "Data Classification Worksheet";
//                     RunPageView = WHERE("Data Sensitivity" = FILTER(<> Unclassified));
//                     ToolTip = 'View only classified fields';
//                 }
//                 action(Unclassified)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Unclassified Fields';
//                     RunObject = Page "Data Classification Worksheet";
//                     RunPageView = WHERE("Data Sensitivity" = CONST(Unclassified));
//                     ToolTip = 'View only unclassified fields';
//                 }
//                 action("Page Data Subjects")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Data Subjects';
//                     RunObject = Page "Data Subject";
//                     ToolTip = 'View your potential data subjects';
//                 }
//                 action("Page Change Log Entries")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Change Log Entries';
//                     RunObject = Page "Change Log Entries";
//                     ToolTip = 'View the log with all the changes in your system';
//                 }
//             }
//         }
//         area(creation)
//         {
//             action("Purchase &Order")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Purchase &Order';
//                 Image = Document;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;
//                 RunObject = Page "Purchase Order";
//                 RunPageMode = Create;
//                 ToolTip = 'Create a new purchase order.';
//             }
//         }
//         area(processing)
//         {
//             separator(Tasks)
//             {
//                 Caption = 'Tasks';
//                 IsHeader = true;
//             }
//             action("Com&pany Information")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Com&pany Information';
//                 Image = CompanyInformation;
//                 RunObject = Page "Company Information";
//                 ToolTip = 'Specify basic information about your company, which designates a complete set of accounting information and financial statements for a business entity. You enter information such as name, addresses, and shipping information. The information in the Company Information window is printed on documents, such as sales invoices.';
//             }
//             action("&Manage Style Sheets")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = '&Manage Style Sheets';
//                 Image = StyleSheet;
//                 RunObject = Page "Manage Style Sheets - Pages";
//                 ToolTip = 'Change the formatting of data files that you import and export as Excel files.';
//             }
//             action("Migration O&verview")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Migration O&verview';
//                 Image = Migration;
//                 RunObject = Page "Config. Package Card";
//                 ToolTip = 'Show the data migration overview.';
//             }
//             action("Relocate &Attachments")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Relocate &Attachments';
//                 Image = ChangeTo;
//                 RunObject = Report "Relocate Attachments";
//                 ToolTip = 'Specify where to store attachments.';
//             }
//             action("Create Warehouse &Location")
//             {
//                 ApplicationArea = Warehouse;
//                 Caption = 'Create Warehouse &Location';
//                 Image = NewWarehouse;
//                 RunObject = Report "Create Warehouse Location";
//                 ToolTip = 'Enable an existing inventory location to use zones and bins to operate as a warehouse location. The batch job creates initial warehouse entries for the warehouse adjustment bin for all items that have inventory in the location. It is necessary to perform a physical inventory after this batch job is finished so that these initial entries can be balanced by posting warehouse physical inventory entries.';
//             }
//             action("C&hange Log Setup")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'C&hange Log Setup';
//                 Image = LogSetup;
//                 RunObject = Page "Change Log Setup";
//                 ToolTip = 'Define which contract changes are logged.';
//             }
//             separator(Separator30)
//             {
//             }
//             group("&Change Setup")
//             {
//                 Caption = '&Change Setup';
//                 Image = Setup;
//                 action("Setup &Questionnaire")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Setup &Questionnaire';
//                     Image = QuestionaireSetup;
//                     RunObject = Page "Config. Questionnaire";
//                     ToolTip = 'Create a new questionnaires that the customer will fill in to structure and document the solution needs and setup data.';
//                 }
//                 action("&General Ledger Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = '&General Ledger Setup';
//                     Image = Setup;
//                     RunObject = Page "General Ledger Setup";
//                     ToolTip = 'Define your accounting policies, such as invoice rounding details, the currency code for your local currency, address formats, and whether you want to use an additional reporting currency.';
//                 }
//                 action("Sales && Re&ceivables Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Sales && Re&ceivables Setup';
//                     Image = Setup;
//                     RunObject = Page "Sales & Receivables Setup";
//                     ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
//                 }
//                 action("Purchase && &Payables Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Purchase && &Payables Setup';
//                     Image = ReceivablesPayablesSetup;
//                     RunObject = Page "Purchases & Payables Setup";
//                     ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
//                 }
//                 action("Fixed &Asset Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Fixed &Asset Setup';
//                     Image = Setup;
//                     RunObject = Page "Fixed Asset Setup";
//                     ToolTip = 'Configure your company''s policies for managing fixed assets.';
//                 }
//                 action("Mar&keting Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Mar&keting Setup';
//                     Image = MarketingSetup;
//                     RunObject = Page "Marketing Setup";
//                     ToolTip = 'Configure your company''s policies for marketing.';
//                 }
//                 action("Or&der Promising Setup")
//                 {
//                     ApplicationArea = OrderPromising;
//                     Caption = 'Or&der Promising Setup';
//                     Image = OrderPromisingSetup;
//                     RunObject = Page "Order Promising Setup";
//                     ToolTip = 'Configure your company''s policies for calculating delivery dates.';
//                 }
//                 action("Catalog &Item Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Catalog &Item Setup';
//                     Image = NonStockItemSetup;
//                     RunObject = Page "Catalog Item Setup";
//                     ToolTip = 'Configure your company''s policies for items that you sell but do keep on inventory.';
//                 }
//                 action("Interaction &Template Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Interaction &Template Setup';
//                     Image = InteractionTemplateSetup;
//                     RunObject = Page "Interaction Template Setup";
//                     ToolTip = 'Configure how you use templates to create interactions.';
//                 }
//                 action("Inve&ntory Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Inve&ntory Setup';
//                     Image = InventorySetup;
//                     RunObject = Page "Inventory Setup";
//                     ToolTip = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.';
//                 }
//                 action("&Warehouse Setup")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = '&Warehouse Setup';
//                     Image = WarehouseSetup;
//                     RunObject = Page "Warehouse Setup";
//                     ToolTip = 'Configure your company''s warehouse policies, such as whether to require picking and putting away at locations by default.';
//                 }
//                 action("Mini&forms")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Mini&forms';
//                     Image = MiniForm;
//                     RunObject = Page Miniforms;
//                     ToolTip = 'View or edit special pages for users of hand-held devices. ';
//                 }
//                 action("Man&ufacturing Setup")
//                 {
//                     ApplicationArea = Manufacturing;
//                     Caption = 'Man&ufacturing Setup';
//                     Image = ProductionSetup;
//                     RunObject = Page "Manufacturing Setup";
//                     ToolTip = 'Define company policies for manufacturing, such as the default safety lead time and whether warnings are displayed in the planning worksheet.';
//                 }
//                 action("Res&ources Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Res&ources Setup';
//                     Image = ResourceSetup;
//                     RunObject = Page "Resources Setup";
//                     ToolTip = 'Configure your company''s policies for resource planning, such as which time sheets to use.';
//                 }
//                 action("&Service Setup")
//                 {
//                     ApplicationArea = Service;
//                     Caption = '&Service Setup';
//                     Image = ServiceSetup;
//                     RunObject = Page "Service Mgt. Setup";
//                     ToolTip = 'Configure your company policies for service management.';
//                 }
//                 action("&Human Resource Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = '&Human Resource Setup';
//                     Image = HRSetup;
//                     RunObject = Page "Human Resources Setup";
//                     ToolTip = 'Define your policies for human resource management, such as number series for employees and units of measure.';
//                 }
//                 action("&Service Order Status Setup")
//                 {
//                     ApplicationArea = Service;
//                     Caption = '&Service Order Status Setup';
//                     Image = ServiceOrderSetup;
//                     RunObject = Page "Service Order Status Setup";
//                     ToolTip = 'View or edit different service order status options and the level of priority assigned to each one.';
//                 }
//                 action("&Repair Status Setup")
//                 {
//                     ApplicationArea = Service;
//                     Caption = '&Repair Status Setup';
//                     Image = ServiceSetup;
//                     RunObject = Page "Repair Status Setup";
//                     ToolTip = 'View or edit the different repair status options that you can assign to service items. You can use repair status to identify the progress of repair and maintenance of service items.';
//                 }
//                 action(Action77)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'C&hange Log Setup';
//                     Image = LogSetup;
//                     RunObject = Page "Change Log Setup";
//                     ToolTip = 'Define which contract changes are logged.';
//                 }
//                 action("&MapPoint Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = '&MapPoint Setup';
//                     Image = MapSetup;
//                     RunObject = Page "Online Map Setup";
//                     ToolTip = 'Configure an online map service to show addresses on a map.';
//                 }
//                 action("SMTP Mai&l Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'SMTP Mai&l Setup';
//                     Image = MailSetup;
//                     RunObject = Page "SMTP Mail Setup";
//                     ToolTip = 'Set up the integration and security of the mail server at your site that handles email.';
//                 }
//                 action("Profile Quest&ionnaire Setup")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Profile Quest&ionnaire Setup';
//                     Image = QuestionaireSetup;
//                     RunObject = Page "Profile Questionnaire Setup";
//                     ToolTip = 'Set up profile questionnaires that you want to use when entering information about your contacts'' profiles. Within each questionnaire, you can set up the different questions you intend to ask your contacts. You can also run the questionnaire to answer some of the questions based on contact, customer, or vendor data automatically.';
//                 }
//             }
//             group("&Report Selection")
//             {
//                 Caption = '&Report Selection';
//                 Image = SelectReport;
//                 action("Report Selection - &Bank Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Report Selection - &Bank Account';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Bank Acc.";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with bank accounts.';
//                 }
//                 action("Report Selection - &Reminder && Finance Charge")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Report Selection - &Reminder && Finance Charge';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Reminder";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with reminders and finance charges.';
//                 }
//                 action("Report Selection - &Sales")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Report Selection - &Sales';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Sales";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with sales.';
//                 }
//                 action("Report Selection - &Purchase")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Report Selection - &Purchase';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Purchase";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with purchasing.';
//                 }
//                 action("Report Selection - &Inventory")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Report Selection - &Inventory';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Inventory";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with inventory.';
//                 }
//                 action("Report Selection - &Warehouse")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Report Selection - &Warehouse';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Warehouse";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with warehouse.';
//                 }
//                 action("Report Selection - Prod. &Order")
//                 {
//                     ApplicationArea = Manufacturing;
//                     Caption = 'Report Selection - Prod. &Order';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Prod. Order";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with manufacturing.';
//                 }
//                 action("Report Selection - S&ervice")
//                 {
//                     ApplicationArea = Service;
//                     Caption = 'Report Selection - S&ervice';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Service";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with service management.';
//                 }
//                 action("Report Selection - Cash Flow")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Report Selection - Cash Flow';
//                     Image = SelectReport;
//                     RunObject = Page "Report Selection - Cash Flow";
//                     ToolTip = 'View or edit the list of reports that can be printed when you work with cash flow.';
//                 }
//             }
//             group("&Date Compression")
//             {
//                 Caption = '&Date Compression';
//                 Image = Compress;
//                 action("Date Compress &G/L Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &G/L Entries';
//                     Image = GeneralLedger;
//                     RunObject = Report "Date Compress General Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &VAT Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &VAT Entries';
//                     Image = VATStatement;
//                     RunObject = Report "Date Compress VAT Entries";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress Bank &Account Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress Bank &Account Ledger Entries';
//                     Image = BankAccount;
//                     RunObject = Report "Date Compress Bank Acc. Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress G/L &Budget Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress G/L &Budget Entries';
//                     Image = LedgerBudget;
//                     RunObject = Report "Date Compr. G/L Budget Entries";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &Customer Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &Customer Ledger Entries';
//                     Image = Customer;
//                     RunObject = Report "Date Compress Customer Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress V&endor Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress V&endor Ledger Entries';
//                     Image = Vendor;
//                     RunObject = Report "Date Compress Vendor Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &Resource Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &Resource Ledger Entries';
//                     Image = Resource;
//                     RunObject = Report "Date Compress Resource Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &FA Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &FA Ledger Entries';
//                     Image = FixedAssets;
//                     RunObject = Report "Date Compress FA Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &Maintenance Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &Maintenance Ledger Entries';
//                     Image = Tools;
//                     RunObject = Report "Date Compress Maint. Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &Insurance Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Date Compress &Insurance Ledger Entries';
//                     Image = Insurance;
//                     RunObject = Report "Date Compress Insurance Ledger";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//                 action("Date Compress &Warehouse Entries")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Date Compress &Warehouse Entries';
//                     Image = Bin;
//                     RunObject = Report "Date Compress Whse. Entries";
//                     ToolTip = 'Save database space by combining related entries in one new entry. You can compress entries from closed fiscal years only.';
//                 }
//             }
//             separator(Separator264)
//             {
//             }
//             group("Con&tacts")
//             {
//                 Caption = 'Con&tacts';
//                 Image = CustomerContact;
//                 action("Create Contacts from &Customer")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Create Contacts from &Customer';
//                     Image = CustomerContact;
//                     RunObject = Report "Create Conts. from Customers";
//                     ToolTip = 'Create a contact card from information about the customer''s contact person.';
//                 }
//                 action("Create Contacts from &Vendor")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Create Contacts from &Vendor';
//                     Image = VendorContact;
//                     RunObject = Report "Create Conts. from Vendors";
//                     ToolTip = 'Create a contact card from information about the vendor''s contact person.';
//                 }
//                 action("Create Contacts from &Bank Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Create Contacts from &Bank Account';
//                     Image = BankContact;
//                     RunObject = Report "Create Conts. from Bank Accs.";
//                     ToolTip = 'Create a contact card from information about the bank account''s contact person.';
//                 }
//                 action("Task &Activities")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Task &Activities';
//                     Image = TaskList;
//                     RunObject = Page Activity;
//                 }
//             }
//             separator(Separator47)
//             {
//             }
//             action("Service Trou&bleshooting")
//             {
//                 ApplicationArea = Service;
//                 Caption = 'Service Trou&bleshooting';
//                 Image = Troubleshoot;
//                 RunObject = Page Troubleshooting;
//                 ToolTip = 'View or edit information about technical problems with a service item.';
//             }
//             group("&Import")
//             {
//                 Caption = '&Import';
//                 Image = Import;
//                 action("Import IRIS to &Area/Symptom Code")
//                 {
//                     ApplicationArea = Service;
//                     Caption = 'Import IRIS to &Area/Symptom Code';
//                     Image = Import;
//                     RunObject = XMLport "Imp. IRIS to Area/Symptom Code";
//                     ToolTip = 'Import the International Repair Coding System to define area/symptom codes for service items.';
//                 }
//                 action("Import IRIS to &Fault Codes")
//                 {
//                     ApplicationArea = Service;
//                     Caption = 'Import IRIS to &Fault Codes';
//                     Image = Import;
//                     RunObject = XMLport "Import IRIS to Fault Codes";
//                     ToolTip = 'Import the International Repair Coding System to define fault codes for service items.';
//                 }
//                 action("Import IRIS to &Resolution Codes")
//                 {
//                     ApplicationArea = Service;
//                     Caption = 'Import IRIS to &Resolution Codes';
//                     Image = Import;
//                     RunObject = XMLport "Import IRIS to Resol. Codes";
//                     ToolTip = 'Import the International Repair Coding System to define resolution codes for service items.';
//                 }
//             }
//             separator(Separator263)
//             {
//             }
//             group("&Sales Analysis")
//             {
//                 Caption = '&Sales Analysis';
//                 Image = Segment;
//                 action(SalesAnalysisLineTmpl)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Sales Analysis &Line Templates';
//                     Image = SetupLines;
//                     RunObject = Page "Analysis Line Templates";
//                     RunPageView = SORTING("Analysis Area", Name)
//                                   WHERE("Analysis Area" = CONST(Sales));
//                     ToolTip = 'Define the layout of your views to analyze the dynamics of your sales volumes.';
//                 }
//                 action(SalesAnalysisColumnTmpl)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Sales Analysis &Column Templates';
//                     Image = SetupColumns;
//                     RunObject = Page "Analysis Column Templates";
//                     RunPageView = SORTING("Analysis Area", Name)
//                                   WHERE("Analysis Area" = CONST(Sales));
//                     ToolTip = 'Define the layout of your views to analyze the dynamics of your sales volumes.';
//                 }
//             }
//             group("P&urchase Analysis")
//             {
//                 Caption = 'P&urchase Analysis';
//                 Image = Purchasing;
//                 action(PurchaseAnalysisLineTmpl)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Purchase &Analysis Line Templates';
//                     Image = SetupLines;
//                     RunObject = Page "Analysis Line Templates";
//                     RunPageView = SORTING("Analysis Area", Name)
//                                   WHERE("Analysis Area" = CONST(Purchase));
//                     ToolTip = 'Define the layout of your views to analyze the dynamics of your purchase volumes.';
//                 }
//                 action(PurchaseAnalysisColumnTmpl)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Purchase Analysis &Column Templates';
//                     Image = SetupColumns;
//                     RunObject = Page "Analysis Column Templates";
//                     RunPageView = SORTING("Analysis Area", Name)
//                                   WHERE("Analysis Area" = CONST(Purchase));
//                     ToolTip = 'Define the layout of your views to analyze the dynamics of your purchase volumes.';
//                 }
//             }
//         }
//     }
// }

