codeunit 50034 "HR Employee Management"
{

    trigger OnRun()
    begin
    end;

    var
        Employee: Record Employee;
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";
        EmployeePortalServices: Codeunit "Employee Portal Services Mgt.";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTP: Record "SMTP Mail Setup";
        UserSetup: Record "User Setup";
        BCSetup: Record "Budget Control Setup";
        BudgetGL: Code[20];
        RequestforQuotationHeader: Record "Request for Quotation Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        budgetCommittment: Record "Budget Committment";
        GlName: Text;
        Txt_001: Label 'Empty Purchase Requisition Line';
        Txt_002: Label 'Empty Request for Quotation Line';
        Text0001: Label 'You Have exceeded the Budget by ';
        Text0002: Label 'Do you want to Continue?';
        Text0003: Label 'There is no Budget to Check against do you wish to continue?';
        Text0004: Label 'The Current Date %1 In The Casual Requisition  Does Not Fall Within Budget Dates %2 - %3';
        Text0005: Label 'The Current Date %1 In The Casual Requisition Does Not Fall Within Budget Dates %2 - %3';
        Text0006: Label 'No Budget To Check Against';
        Text0007: Label 'Item Does not Exist';
        Text0008: Label 'Ensure Fixed Asset No %1 has the Maintenance G/L Account';
        Text0009: Label 'Ensure Fixed Asset No %1 has the Acquisition G/L Account';
        Text0010: Label 'No Budget To Check Against';
        Text0011: Label 'The amount on casual requisition number %1    Exceeds The Budget By %4';

    procedure CreateEmployeeDirectory("EmployeeNo.": Code[20])
    var
        CompanyDataDirectory: Text;
        EmployeeDataDirectory: Text;
       // [RunOnClient]
        //DirectoryHelper: DotNet Directory;
        DirectoryPath: Label '%1\%2\%3';
        EmployeeDirectoryPath: Text;
    begin
        CompanyInformation.Get;
        HumanResourcesSetup.Get;
        CompanyInformation.TestField(CompanyInformation."Company Data Directory Path");
        HumanResourcesSetup.TestField(HumanResourcesSetup."Employee Data Directory Name");
        CompanyDataDirectory:=CompanyInformation."Company Data Directory Path";
        EmployeeDataDirectory:=HumanResourcesSetup."Employee Data Directory Name";

        EmployeeDirectoryPath:=StrSubstNo(DirectoryPath,CompanyDataDirectory,EmployeeDataDirectory,EmployeePortalServices.GetCleanedEmployeeNo("EmployeeNo."));

        // if not DirectoryHelper.Exists(EmployeeDirectoryPath) then begin
        //   DirectoryHelper.CreateDirectory(EmployeeDirectoryPath);
        // end;
    end;

    procedure TransferAsset(AssetTransferLines: Record "HR Asset Transfer Lines")
    var
        FA: Record "Fixed Asset";
    begin
        FA.Reset;
        FA.SetRange("No.",AssetTransferLines."Asset No.");
        if FA.FindSet then begin
         FA."Responsible Employee":=AssetTransferLines."New Responsible Employee Code";
         FA."Employee Name":=AssetTransferLines."New Responsible Employee Name";
         FA."FA Location Code":=AssetTransferLines."New Asset Location";
         FA."Serial No.":=AssetTransferLines."Asset Serial No";
         FA."FA Tag No.":=AssetTransferLines."Asset Tag No.";
         FA."Global Dimension 1 Code":=AssetTransferLines."New Global Dimension 1 Code";
         FA."Global Dimension 2 Code":=AssetTransferLines."New Global Dimension 2 Code";
         FA."Shortcut Dimension 3 Code":=AssetTransferLines."New Shortcut Dimension 3 Code";
         FA."Shortcut Dimension 4 Code":=AssetTransferLines."New Shortcut Dimension 4 Code";
         FA."Shortcut Dimension 5 Code":=AssetTransferLines."New Shortcut Dimension 5 Code";
         FA."Shortcut Dimension 6 Code":=AssetTransferLines."New Shortcut Dimension 6 Code";
         FA.Modify;
         end;

    end;

    procedure SendEmailNotificationToICT(EmpNo: Code[20])
    var
        Employee: Record Employee;
        HREmployee: Record Employee;
    begin
        //Send Email Notification to ICT upon Onboarding of a new Employee
        //SMTP.Get;
        UserSetup.Reset;
            UserSetup.SetRange(UserSetup."Receive ICT Notifications",true);
            if UserSetup.FindSet then begin
              repeat
                  Employee.Reset;
                  Employee.SetRange(Employee."No.",EmpNo);
                  if Employee.FindFirst then begin
                   // SMTPMail.CreateMessage(SMTP."Sender Name",SMTP."Sender Email Address",UserSetup."E-Mail",'New Staff Account Creation and Setup ','',true);
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."User ID",UserSetup."User ID");
                    if HREmployee.FindFirst then begin
                      // SMTPMail.AppendBody('Dear'+' '+HREmployee."First Name"+',');
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('You are notified of a new staff, who has joined the Organization.');
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('Employee No: '+Employee."No.");
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('Employee Name: '+Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name");
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('Job Title: '+Employee.Title);
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('Please create for Him/Her an account and setup with the relevant Rolecentre and Permission set.');
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('Thank you.');
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('Regards,');
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody(SMTP."Sender Name");
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('<br><br>');
                      // SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this Email');
                      // SMTPMail.Send;
                    end;
                  end;
              until UserSetup.Next=0;
           end;
    end;

    procedure commitCasualGLBudget(var EmployeeRequisition: Record "HR Employee Requisitions") Ok: Boolean
    var
        ImprestLine: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (EmployeeRequisition."Start Date"< BCSetup."Current Budget Start Date") or (EmployeeRequisition."End Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,EmployeeRequisition."Start Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;

        EmployeeRequisition.TestField(Voted,false);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");



            BudgetGL:=EmployeeRequisition."Budget GL";


            FirstDay:=DMY2Date(1,Date2DMY(EmployeeRequisition."Document Date",2),Date2DMY(EmployeeRequisition."Document Date",3));
            CurrMonth:=Date2DMY(EmployeeRequisition."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(EmployeeRequisition."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(EmployeeRequisition."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
             GLAccount.Reset;
            GLAccount.SetFilter(GLAccount."Date Filter",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            GLAccount.SetRange("No.",BudgetGL);
            GLAccount.CalcFields("Net Change");
            ActualsAmount:=GLAccount."Net Change";


            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;

            //get the committments

            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");

              Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;

            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);

              //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + EmployeeRequisition."Estimated Total Cost of Work") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              EmployeeRequisition."No.",EmployeeRequisition."Document Type" ,EmployeeRequisition."Budget GL",
              Format(Abs(BudgetAmount-(CommitmentAmount+EmployeeRequisition."Estimated Total Cost of Work"))));
            end else begin

            //Commit Amounts

            Commitments.Init;
            Commitments.Date:=Today;
            Commitments."Posting Date":=Today;
            Commitments."Document Type":=Commitments."Document Type"::Casuals;;
            Commitments."Document No.":=EmployeeRequisition."No.";
            Commitments.Amount:=EmployeeRequisition."Estimated Total Cost of Work";
            Commitments."Month Budget":=BudgetAmount;
           // Commitments."Month Actual":=ActualsAmount;
             Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;
            Commitments."G/L Account No.":=BudgetGL;
            // Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=EmployeeRequisition."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=EmployeeRequisition."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=EmployeeRequisition."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=EmployeeRequisition."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            //Commitments."Employee Name":=EmployeeRequisition."Employee Name";
            Commitments.Description:=EmployeeRequisition.Description;
            if GLAccount.Get(Commitments."G/L Account No.")then
              Commitments."Gl Name":=GLAccount.Name;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work");
            Commitments.Committed:=true;
           if  Commitments.Insert(true) then begin
          // EmployeeRequisition."Committed Budget":=TRUE;
           //EmployeeRequisition."Budget Balance" := BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work");
          // EmployeeRequisition."Amount Committed" := EmployeeRequisition."Estimated Total Cost of Work";
           //EmployeeRequisition."Total Commitment Before" := CommitmentAmount;
           EmployeeRequisition.Modify;
           end;

        EmployeeRequisition.Voted:=true;
        EmployeeRequisition.Modify;

        end;
    end;

    procedure ReverseCasualRequisitions(var EmployeeRequisition: Record "HR Employee Requisitions")
    var
        ImprestLine: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (EmployeeRequisition."Document Date"< BCSetup."Current Budget Start Date") or (EmployeeRequisition."Document Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,EmployeeRequisition."Document Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        end;

        EmployeeRequisition.TestField(Voted,true);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");



            BudgetGL:=EmployeeRequisition."Budget GL";


            FirstDay:=DMY2Date(1,Date2DMY(EmployeeRequisition."Document Date",2),Date2DMY(EmployeeRequisition."Document Date",3));
            CurrMonth:=Date2DMY(EmployeeRequisition."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(EmployeeRequisition."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(EmployeeRequisition."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;

            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;

            //get the committments

            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");

              Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;

            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);

              //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + EmployeeRequisition."Estimated Total Cost of Work") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              EmployeeRequisition."No.",EmployeeRequisition."Document Type" ,EmployeeRequisition."Budget GL",
              Format(Abs(BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work"))));
            end else begin

            //Commit Amounts

            Commitments.Init;
            Commitments.Date:=Today;
            Commitments."Posting Date":=Today;
            Commitments."Document Type":=Commitments."Document Type"::Casuals;;
            Commitments."Document No.":=EmployeeRequisition."No.";
            Commitments.Amount:=-EmployeeRequisition."Estimated Total Cost of Work";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."G/L Account No.":=Commitments."G/L Account No.";
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;
            //Commitments."G/L Account No.":=Commitments."G/L Account No.";
            //Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=EmployeeRequisition."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=EmployeeRequisition."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=EmployeeRequisition."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=EmployeeRequisition."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments.Cancelled:=true;
            Commitments."Cancelled By":=UserId;
            Commitments."Cancelled Date":=Today;
            Commitments."Cancelled Time":=Time;
            //Commitments."Employee Name":=EmployeeRequisition."Employee Name";
            Commitments.Description:=EmployeeRequisition.Description;
            if GLAccount.Get(Commitments."G/L Account No.") then
             Commitments."G/L Name":=GLAccount.Name;
                Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work");
            Commitments.Committed:=true;
           if  Commitments.Insert(true) then begin
          // EmployeeRequisition."Committed Budget":=TRUE;
           //EmployeeRequisition."Budget Balance" := BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work");
           //EmployeeRequisition."Amount Committed" := EmployeeRequisition."Estimated Total Cost of Work";
           //EmployeeRequisition."Total Commitment Before" := CommitmentAmount;
           EmployeeRequisition.Modify;
           end;

        EmployeeRequisition.Voted:=false;
        EmployeeRequisition.Modify;

        end;
    end;

    procedure ReverseCasualRequisitionsii(var EmployeeRequisition: Record "HR Employee Requisitions")
    var
        PurchaseLineRec: Record "Purchase Line";
        PurchaseRequisitions: Record "Purchase Requisitions";
        ImprestLine: Record "Payment Line";
        Commitments: Record "Budget Committment";
        Amount: Decimal;
        GLAccount: Record "G/L Account";
        Items: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssets: Record "Fixed Asset";
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        dimSetEntry: Record "Dimension Set Entry";
        CommitmentsCopy: Record "Budget Committment";
    begin
        BCSetup.Get;
        //check if the dates are within the specified range
        if (EmployeeRequisition."Document Date"< BCSetup."Current Budget Start Date") or (EmployeeRequisition."Document Date"> BCSetup."Current Budget End Date") then begin
          Error(Text0004,EmployeeRequisition."Document Date",
          BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
        EmployeeRequisition.TestField(Voted,true);
        CheckIfGLAccountBlocked(BCSetup."Current Budget Code");
        
        
        
            BudgetGL:=EmployeeRequisition."Budget GL";
        
        
            FirstDay:=DMY2Date(1,Date2DMY(EmployeeRequisition."Document Date",2),Date2DMY(EmployeeRequisition."Document Date",3));
            CurrMonth:=Date2DMY(EmployeeRequisition."Document Date",2);
            if CurrMonth=12 then begin
              LastDay:=DMY2Date(1,1,Date2DMY(EmployeeRequisition."Document Date",3) +1);
              LastDay:=CalcDate('-1D',LastDay);
            end else begin
              CurrMonth:=CurrMonth +1;
              LastDay:=DMY2Date(1,CurrMonth,Date2DMY(EmployeeRequisition."Document Date",3));
              LastDay:=CalcDate('-1D',LastDay);
            end;
        
            BudgetAmount:=0;
            Budget.Reset;
            Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
            Budget.SetFilter(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
            Budget.SetRange(Budget."G/L Account No.",BudgetGL);
            if Budget.FindSet then begin
             Budget.CalcSums(Amount);
             BudgetAmount:=Budget.Amount;
            end;
        
            //get the committments
        
            CommitmentAmount:=0;
            Commitments.Reset;
            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
            Commitments.SetFilter(Commitments."Posting Date",'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              Commitments.CalcSums(Commitments.Amount);
            CommitmentAmount:= Commitments.Amount;
        
            //check if there is any budget
            if (BudgetAmount<=0) then
             Error(Text0010);
        
              //check if the actuals plus the amount is greater than the budget amount
            if ((CommitmentAmount + EmployeeRequisition."Estimated Total Cost of Work") > BudgetAmount) and (BCSetup."Allow OverExpenditure"=false) then begin
              Error(Text0011,
              EmployeeRequisition."No.",EmployeeRequisition."Document Type" ,EmployeeRequisition."Budget GL",
              Format(Abs(BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work"))));
            end else begin
        
            //Commit Amounts
        
            Commitments.Init;
            Commitments.Date:=Today;
            Commitments."Posting Date":=Today;
            Commitments."Document Type":=Commitments."Document Type"::Casuals;;
            Commitments."Document No.":=EmployeeRequisition."No.";
            Commitments.Amount:=-EmployeeRequisition."Estimated Total Cost of Work";
            Commitments."Month Budget":=BudgetAmount;
            Commitments.Committed:=true;
            Commitments."Committed By":=UserId;
            Commitments."Committed Date":=Today;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Committed Time":=Time;
            Commitments."Shortcut Dimension 1 Code":=EmployeeRequisition."Global Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code":=EmployeeRequisition."Global Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code":=EmployeeRequisition."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code":=EmployeeRequisition."Shortcut Dimension 4 Code";
            Commitments.Budget:=BCSetup."Current Budget Code";
            Commitments.Type:=Commitments.Type::" ";
            Commitments.Cancelled:=true;
            Commitments."Cancelled By":=UserId;
            Commitments."Cancelled Date":=Today;
            Commitments."Cancelled Time":=Time;
           // Commitments."Employee Name":=EmployeeRequisition."Employee Name";
            Commitments.Description:=EmployeeRequisition.Description;
            if GLAccount.Get(Commitments."G/L Account No.") then
            Commitments."G/L Name":=GLAccount.Name;
            Commitments."G/L Account No.":=BudgetGL;
            Commitments."Budget Balance":=BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work");
            Commitments.Committed:=true;
           if  Commitments.Insert(true) then begin
          // EmployeeRequisition."Committed Budget":=TRUE;
           /*EmployeeRequisition."Budget Balance" := BudgetAmount-(CommitmentAmount +EmployeeRequisition."Estimated Total Cost of Work");
           EmployeeRequisition."Amount Committed" := EmployeeRequisition."Estimated Total Cost of Work";
           EmployeeRequisition."Total Commitment Before" := CommitmentAmount;*/
           EmployeeRequisition.Modify;
           end;
        
        EmployeeRequisition.Voted:=false;
        EmployeeRequisition.Modify;
        end;
        end;

    end;

    procedure CheckIfGLAccountBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked,false);
    end;
}

