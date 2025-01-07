codeunit 50074 "Invst. Page Management"
{

    trigger OnRun()
    begin
    end;

    var
        DataTypeManagement: Codeunit "Data Type Management";

    [Scope('Personalization')]
    procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of
          // DATABASE::Table50298:
          //   exit(PAGE::Page50469);
          // DATABASE::Table50303:
          //   exit(PAGE::Page50478);
          // DATABASE::Table50304:
          //   exit(PAGE::Page50479);
          // DATABASE::Table50306:
          //   exit(PAGE::Page50482);
          // DATABASE::Table50307:
          //   exit(PAGE::Page50516);
          // DATABASE::Table50308:
          //   exit(PAGE::Page50483);
          // DATABASE::"Meeting Attendance":
          //   exit(PAGE::Page50489);
          // DATABASE::"Tender Questions":
          //   exit(PAGE::Page50503);
          // DATABASE::Table50339:
          //   exit(PAGE::Page50523);
          // DATABASE::Table50345:
          //   exit(PAGE::Page50530);
          // DATABASE::Table50335:
          //   exit(PAGE::Page52137700);
        end;
        exit(0);
    end;
}

