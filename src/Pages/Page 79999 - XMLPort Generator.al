page 79999 "XMLPort Generator"
{
    // AP00001 WW 01/01/15 : XMLPort Generator Created

    PageType = List;
    SourceTable = "Field";

    layout
    {
        area(content)
        {
            group(Control1240060020)
            {
                ShowCaption = false;
                field(ExportPath; ExportPath)
                {
                    Caption = 'Export Path for Objects';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //"F:\Pepsi Upgrade\Objs\"
                        // ExportPath := FileMgmt.BrowseForFolderDialog('Open you folder..','',true);
                        ExportPath += '\';
                    end;
                }
                field(StartingObjectID; StartingObjectID)
                {
                    Caption = 'Starting Object ID';
                }
                field(XMLPortType; XMLPortType)
                {
                    Caption = 'XMLPort Field/Text';
                }
                field(FilterSelectedValues; FilterSelectedValues)
                {
                    Caption = 'Filter on Selected Values';
                }
                field(SplitObjectFiles; SplitObjectFiles)
                {
                    Caption = 'Split Object Files';
                }
                field(FieldSeparator; FieldSeparator)
                {
                    Caption = 'Field Separator';
                }
                field(FieldDelimeter; FieldDelimeter)
                {
                    Caption = 'Field Delimeter';
                }
            }
            repeater(Group)
            {
                field(TableNo; Rec.TableNo)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(TableName; Rec.TableName)
                {
                }
                field(FieldName; Rec.FieldName)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Len; Rec.Len)
                {
                }
                field(Class; Rec.Class)
                {
                }
                field(Enabled; Rec.Enabled)
                {
                }
                field("Type Name"; Rec."Type Name")
                {
                }
                field("Field Caption"; Rec."Field Caption")
                {
                }
                field(RelationTableNo; Rec.RelationTableNo)
                {
                }
                field(RelationFieldNo; Rec.RelationFieldNo)
                {
                }
                field(SQLDataType; Rec.SQLDataType)
                {
                }
                field(OptionString; Rec.OptionString)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate XMLPorts")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                // trigger OnAction()
                // begin
                //     GenerateXMLPort;
                // end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FieldSeparator := '<TAB>';
        FieldDelimeter := '<None>';
    end;

    var
        ExportPath: Text;
        StartingObjectID: Integer;
        XMLPortType: Option "Field",Text;
        FilterSelectedValues: Boolean;
        SplitObjectFiles: Boolean;
        FileMgmt: Codeunit "File Management";
        ObjectFile: File;
        NSTFileName: Text;
        ClientFileName: Text;
        TempClientFileName: Text;
        FileOpen: Boolean;
        FieldSeparator: Text[20];
        FieldDelimeter: Text[20];

    // procedure GenerateXMLPort()
    // var
    //     TempFields: Record "Field" temporary;
    //     TempFieldTables: Record "Field" temporary;
    // begin

    //     LoadFields(Rec, TempFields, TempFieldTables);

    //     Clear(TempFieldTables);

    //     if TempFieldTables.FindSet then begin
    //         repeat

    //             if SplitObjectFiles or not FileOpen then
    //                 StartFile;

    //             WriteXMLPortObjHeader(StartingObjectID, Format(RemChar(TempFieldTables.TableName) + '_' + Format(StartingObjectID)), TempFieldTables);

    //             Clear(TempFields);
    //             TempFields.SetRange(TableNo, TempFieldTables.TableNo);
    //             if TempFields.FindSet then begin
    //                 repeat
    //                     case XMLPortType of
    //                         XMLPortType::Field:
    //                             WriteXMLPortObjLineField(TempFields);
    //                         XMLPortType::Text:
    //                             WriteXMLPortObjLineText(TempFields);
    //                     end;
    //                 until TempFields.Next = 0;
    //             end;

    //             WriteXMLPortObjEnd(TempFieldTables.TableNo, TempFields);

    //             if SplitObjectFiles then
    //                 EndFile(ExportPath, 'XML' + Format(StartingObjectID) + '.txt');

    //             StartingObjectID += 1;

    //         until TempFieldTables.Next = 0;

    //         if not SplitObjectFiles then
    //             EndFile(ExportPath, 'AllObjects.txt');

    //     end;
    // end;

    procedure LoadFields(var pField: Record "Field"; var TempField: Record "Field" temporary; var TempFieldTables: Record "Field" temporary)
    var
        "Field": Record "Field";
    begin
        Field.CopyFilters(pField);
        if FilterSelectedValues then
            CurrPage.SetSelectionFilter(Field);
        if Field.FindSet then begin
            repeat
                Clear(TempFieldTables);
                TempFieldTables.SetRange(TableNo, Field.TableNo);
                if not TempFieldTables.FindFirst then begin
                    TempFieldTables := Field;
                    TempFieldTables.Insert;
                end;
                TempField := Field;
                TempField.Insert;
            until Field.Next = 0;
        end;
    end;

    procedure WriteXMLPortObjHeader(XMLPortID: Integer; XMLPortName: Text; var "Field": Record "Field")
    var
        "Key": Record "Key";
        KeyStringArray: array[1000] of Text;
        i: Integer;
    begin
        // ObjectFile.Write('OBJECT XMLport ' + Format(XMLPortID) + ' ' + Format(XMLPortName));
        // ObjectFile.Write('{');
        // ObjectFile.Write('  OBJECT-PROPERTIES');
        // ObjectFile.Write('  {');
        // ObjectFile.Write('    Date=' + Format(Today,8,1) + ';');
        // ObjectFile.Write('    Time=' + Format(Time) + ';');
        // ObjectFile.Write('    Modified=Yes;');
        // ObjectFile.Write('    Version List=AP XMLPort Generator;');
        // ObjectFile.Write('  }');
        // ObjectFile.Write('  PROPERTIES');
        // ObjectFile.Write('  {');
        // ObjectFile.Write('    Format=Variable Text;');
        // ObjectFile.Write('    FieldDelimiter=<None>;');
        // ObjectFile.Write('    FieldSeparator=' + FieldSeparator + ';');
        // ObjectFile.Write('  }');
        // ObjectFile.Write('  ELEMENTS');
        // ObjectFile.Write('  {');
        // ObjectFile.Write('    { [' + Format(CreateGuid) + '];  ;Root                ;Element ;Text     }');
        // ObjectFile.Write('');

        if XMLPortType = XMLPortType::Field then begin
            // ObjectFile.Write('    { [' + Format(CreateGuid) + '];1 ;' + RemChar(TableName) + '   ;Element ;Table   ;');
            // ObjectFile.Write('                                                  SourceTable=Table' + Format(Field.TableNo) +' }');
        end;

        if XMLPortType = XMLPortType::Text then begin
            // ObjectFile.Write('    { [' + Format(CreateGuid) + '];1 ;Integer    ;Element ;Table   ;');
            // ObjectFile.Write('                                                  SourceTable=Table2000000026;');
            // ObjectFile.Write('                                                  Import::OnBeforeInsertRecord=BEGIN');
            // ObjectFile.Write('');
            // ObjectFile.Write('                                                                                 CLEAR(' + RemChar(Field.TableName) + ');');
            // ObjectFile.Write('                                                                                 WITH ' + RemChar(Field.TableName) + ' DO BEGIN');

            // Key.Get(Field.TableNo, 1);
            // BuildArray(Key.Key, KeyStringArray);
            // for i := 1 to StrLen(Format(Key.Key)) - (StrLen(DelChr(Format(Key.Key), '=', ',')) - 1) do begin
            //  ObjectFile.Write('                                                                                   "' + KeyStringArray[i] + '" := V' + RemChar(KeyStringArray[i]) + ';');
        end;
        // ObjectFile.Write('                                                                                   IF NOT GET THEN BEGIN');
        // ObjectFile.Write('                                                                                     INSERT;');
        // ObjectFile.Write('                                                                                   END;');

    end;

    // ObjectFile.Write('');
    //  end;

    procedure WriteXMLPortObjLineField("Field": Record "Field")
    begin
        // ObjectFile.Write('    { [' + Format(CreateGuid) + '];2 ;' + 'V' + RemChar(Field.FieldName) + '       ;Element ;Field   ;');
        // ObjectFile.Write('                                                  DataType=' + Format(Field.Type) + ';');
        // ObjectFile.Write('                                                  SourceField=' + Field.TableName + '::' + Field.FieldName + '}');
        // ObjectFile.Write('');
    end;

    // procedure WriteXMLPortObjLineText(var "Field": Record "Field")
    // var
    //     OptionStringArray: array[1000] of Text;
    //     i: Integer;
    // begin
    //     if Field.Class = Field.Class::Normal then begin
    //         ObjectFile.Write('                                                                                   // Field.Type: ' + Format(Field."Type Name"));
    //         case Field.Type of
    //             Type::Text, Type::Code:
    //                 begin
    //                     ObjectFile.Write('                                                                                   //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                   VALIDATE("' + Field.FieldName + '",V' + RemChar(Field.FieldName) + ');');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::Integer:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempInteger,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempInteger := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempInteger);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::Decimal:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempDecimal,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempDecimal := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempDecimal);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::Boolean:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempBoolean,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempBoolean := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempBoolean);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::Time:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempTime,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempTime := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempTime);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::DateTime:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempDateTime,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempDecimal := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempDateTime);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::DateFormula:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempDateFormula,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempDateformula := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempDateFormula);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::Date:
    //                 begin
    //                     ObjectFile.Write('                                                                                   IF EVALUATE(TempDate,V' + RemChar(Field.FieldName) + ') THEN BEGIN');
    //                     ObjectFile.Write('                                                                                     //TempDate := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     //"' + Field.FieldName + '" := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                     VALIDATE("' + Field.FieldName + '",TempDate);');
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::Option:
    //                 begin
    //                     BuildArray(Field.OptionString, OptionStringArray);
    //                     ObjectFile.Write('                                                                                   CASE V' + RemChar(Field.FieldName) + ' OF');
    //                     for i := 1 to StrLen(Field.OptionString) - (StrLen(DelChr(Field.OptionString, '=', ',')) - 1) do begin
    //                         ObjectFile.Write('                                                                                     ''' + OptionStringArray[i] + ''' : "' + Field.FieldName + '" := "' + Field.FieldName + '"::"' + OptionStringArray[i] + '";');

    //                     end;
    //                     ObjectFile.Write('                                                                                   END;');
    //                     ObjectFile.Write('                                                                                   VALIDATE("' + Field.FieldName + '");');
    //                     ObjectFile.Write('');
    //                 end;
    //             Type::BLOB:
    //                 begin
    //                     ObjectFile.Write('                                                                                   //"' + Field.FieldName + '"  := V' + RemChar(Field.FieldName) + ';');
    //                     ObjectFile.Write('                                                                                   //');
    //                     ObjectFile.Write('');
    //                 end;
    //         end;
    //     end else begin
    //         //Flowfields/Flowfilters
    //         ObjectFile.Write('                                                                                   //' + Format(Field.Class) + ');');
    //         ObjectFile.Write('                                                                                   //"' + Field.FieldName + '"  := V' + RemChar(Field.FieldName) + ';');
    //         ObjectFile.Write('                                                                                   //');
    //         ObjectFile.Write('');
    //     end;
    // end;

    // procedure WriteXMLPortObjEnd(vTableNo: Integer; var "Field": Record "Field")
    // begin
    //     if XMLPortType = XMLPortType::Text then begin
    //         ObjectFile.Write('');
    //         //ObjectFile.WRITE('                                                                                  ' + RemChar(Field.TableName) + '.MODIFY;');
    //         ObjectFile.Write('                                                                                   MODIFY;');
    //         ObjectFile.Write('                                                                                 END;');
    //         ObjectFile.Write('');
    //         ObjectFile.Write('                                                                                 ResetVar();');
    //         ObjectFile.Write('');
    //         ObjectFile.Write('                                                                                 CurrXMLport.SKIP;');
    //         ObjectFile.Write('');
    //         ObjectFile.Write('                                                                               END;');
    //         ObjectFile.Write('                                                                                }');
    //         ObjectFile.Write('');

    //         Clear(Field);
    //         Field.SetRange(TableNo, vTableNo);
    //         if Field.FindSet then begin
    //             repeat
    //                 ObjectFile.Write('    { [' + Format(CreateGuid) + '];2 ;' + 'V' + RemChar(Field.FieldName) + '       ;Element ;Text   ;');
    //                 ObjectFile.Write('                                                  DataType=' + Format(Field.Type) + '}');
    //                 ObjectFile.Write('');
    //             until Field.Next = 0;
    //         end;
    //     end;

    //     ObjectFile.Write('  }');
    //     ObjectFile.Write('  EVENTS');
    //     ObjectFile.Write('  {');
    //     ObjectFile.Write('  }');
    //     ObjectFile.Write('  REQUESTPAGE');
    //     ObjectFile.Write('  {');
    //     ObjectFile.Write('    PROPERTIES');
    //     ObjectFile.Write('    {');
    //     ObjectFile.Write('    }');
    //     ObjectFile.Write('    CONTROLS');
    //     ObjectFile.Write('    {');
    //     ObjectFile.Write('    }');
    //     ObjectFile.Write('  }');
    //     ObjectFile.Write('  CODE');
    //     ObjectFile.Write('  {');

    //     if XMLPortType = XMLPortType::Text then begin
    //         ObjectFile.Write('    VAR');
    //         ObjectFile.Write('      ' + RemChar(TableName) + '@1240060000 : Record ' + Format(TableNo) + ';');
    //         ObjectFile.Write('       TempDecimal@1240060001 : Decimal;');
    //         ObjectFile.Write('       TempInteger@1240060002 : Integer;');
    //         ObjectFile.Write('       TempDate@1240060003 : Date;');
    //         ObjectFile.Write('       TempTime@1240060007 : Time;');
    //         ObjectFile.Write('       TempDateTime@1240060004 : DateTime;');
    //         ObjectFile.Write('       TempBoolean@1240060005 : Boolean;');
    //         ObjectFile.Write('       TempDateFormula@1240060006 : DateFormula;');
    //         ObjectFile.Write('');
    //         ObjectFile.Write('    PROCEDURE ResetVar@1240060200();');
    //         ObjectFile.Write('    BEGIN');
    //         ObjectFile.Write('');

    //         Clear(Field);
    //         Field.SetRange(TableNo, vTableNo);
    //         if Field.FindSet then begin
    //             repeat
    //                 ObjectFile.Write('      V' + RemChar(Field.FieldName) + ' := '''';');
    //             until Field.Next = 0;
    //         end;
    //         ObjectFile.Write('    END;');
    //     end;

    //     ObjectFile.Write('');
    //     ObjectFile.Write('    BEGIN');
    //     ObjectFile.Write('    {');
    //     ObjectFile.Write('      '); // <--  COMMENTS GO HERE --> //
    //     ObjectFile.Write('    }');
    //     ObjectFile.Write('    END.');
    //     ObjectFile.Write('  }');
    //     ObjectFile.Write('}');
    // end;

    // procedure WriteXMLPortObjVariables("Field": Record "Field")
    // begin
    //     ObjectFile.Write('    { [' + Format(CreateGuid) + '];2 ;' + 'V' + RemChar(Field.FieldName) + '       ;Element ;Text   ;');
    //     ObjectFile.Write('                                                  DataType=' + Format(Field.Type) + '}');
    //     ObjectFile.Write('');
    // end;

    // procedure StartFile()
    // begin
    //     Clear(ObjectFile);
    //     NSTFileName := FileMgmt.ServerTempFileName('txt');
    //     ObjectFile.TextMode(true);
    //     ObjectFile.WriteMode(true);
    //     ObjectFile.Create(NSTFileName);

    //     FileOpen := true;
    // end;

    // procedure EndFile(ExportFilePath: Text; ExportFileName: Text)
    // begin
    //     ClientFileName := ExportFilePath + ExportFileName;

    //     // ObjectFile.Close;
    //     // TempClientFileName := FileMgmt.ClientTempFileName('txt');
    //     // FileMgmt.DownloadToFile(NSTFileName,TempClientFileName);
    //     // FileMgmt.MoveFile(TempClientFileName,ClientFileName);

    //     FileOpen := false;
    // end;

    // procedure RemChar(InputString: Text): Text
    // begin
    //     //Remove Characters
    //     exit(DelChr(InputString, '=', ' ./()-_!@#$%^&*<>?|\[]+='));
    // end;

    // procedure BuildArray(InputString: Text; var OutputArray: array[1000] of Text)
    // var
    //     i: Integer;
    // begin
    //     for i := 1 to ArrayLen(OutputArray) do begin
    //         OutputArray[i] := '';
    //     end;

    //     i := 0;
    //     while StrLen(InputString) > 0 do begin
    //         i := i + 1;
    //         if StrPos(InputString, ',') <> 0 then begin
    //             OutputArray[i] := CopyStr(InputString, 1, StrPos(InputString, ',') - 1);
    //             InputString := CopyStr(InputString, StrPos(InputString, ',') + 1, StrLen(InputString));
    //         end else begin
    //             OutputArray[i] := InputString;
    //             InputString := '';
    //         end;
    //     end;
    // end;
}

