// page 5241 "Personal Attribute Required"
// {
//     ApplicationArea = BasicHR;
//     Caption = 'Qualifications';
//     PageType = List;
//     SourceTable = Qualification;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = BasicHR;
//                     Editable = false;
//                     ToolTip = 'Specifies a qualification code.';
//                     Visible = false;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = BasicHR;
//                     ToolTip = 'Specifies a description for the qualification.';
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control1900383207; Links)
//             {
//                 ApplicationArea = RecordLinks;
//                 Visible = false;
//             }
//             systempart("\"; Notes)
//             {
//                 ApplicationArea = Notes;
//                 Visible = false;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Q&ualification")
//             {
//                 Caption = 'Q&ualification';
//                 Image = Certificate;
//                 action("Q&ualification Overview")
//                 {
//                     ApplicationArea = BasicHR;
//                     Caption = 'Q&ualification Overview';
//                     Image = QualificationOverview;
//                     RunObject = Page "Qualification Overview";
//                     ToolTip = 'View qualifications that are registered for the employee.';
//                 }
//             }
//         }
//     }
// }

