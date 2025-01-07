// tableextension 60387 tableextension60387 extends "Human Resource Comment Line"
// {
//     fields
//     {
//         modify("No.")
//         {
//             TableRelation = IF ("Table Name" = CONST(Employee)) Employee."No."
//             ELSE IF ("Table Name" = CONST("Alternative Address")) "Alternative Address"."Employee No."
//             ELSE IF ("Table Name" = CONST("Employee Qualification")) "Employee Qualification"."Employee No."
//             ELSE IF ("Table Name" = CONST("Misc. Article Information")) "Misc. Article Information"."Employee No."
//             ELSE IF ("Table Name" = CONST("Confidential Information")) "Confidential Information"."Employee No."
//             ELSE IF ("Table Name" = CONST("Employee Absence")) "Employee Absence"."Employee No."
//             ELSE IF ("Table Name" = CONST("Employee Relative")) pay."Employee No.";
//         }
//     }

//     //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 1)".

// }

