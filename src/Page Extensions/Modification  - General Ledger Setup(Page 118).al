// pageextension 60038 pageextension60038 extends "General Ledger Setup" 
// {
//     layout
//     {
//         modify("Bank Account Nos.")
//         {
//             Visible = false;
//         }
//         addafter("Allow Posting To")
//         {
//             field("Bank Account Nos.";"Bank Account Nos.")
//             {
//             }
//         }
//     }
// }

