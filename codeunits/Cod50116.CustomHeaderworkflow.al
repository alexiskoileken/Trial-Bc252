namespace TrialVersion.TrialVersion;
using System.Automation;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Utilities;
using Microsoft.Finance.GeneralLedger.Posting;

codeunit 50116 "Custom Header workflow"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin
        AddWorkflowEventsToLibrary();
    end;

    var
        //Global
        WorkflowSetup: Codeunit "Workflow Setup";
        WorkflowCategoryCode: TextConst ENU = 'CUSTM';
        WorkflowCategoryDescTxt: TextConst ENU = 'Custom Documents';
        WorkflowMgt: Codeunit "Workflow Management";
        UnsupportedRecordTypeErr: label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        NoWorkflowEnabledErr: label 'This record is not supported by related approval workflow.';
        //Consumer
        ConsumerApprovalWorkflowCodeTxt: TextConst ENU = 'CAPW';
        ConsumerApprovalWorkfowDescTxt: TextConst ENU = 'Consumer approval workflow';
        ConsumerTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="Consumer">%1</DataItem></DataItems></ReportParameters>';
        RunWorkflowOnSendConsumerForApprovalCode: label 'RUNWORKFLOWONSENDCONSUMERFORAPPROVAL';
        RunWorkflowOnCancelConsumerForApprovalCode: label 'RUNWORKFLOWONCANCELCONSUMERFORAPPROVAL';
        OnCancelConsumerApprovalRequestTxt: label 'An Approval of Consumer is cancelled';
        OnSendconsumerApprovalRequestTxt: label ' An Approval of Consumer is requested';
        //std
        StdApprovalWorkflowCodeTxt: TextConst ENU = 'SAPW';
        StdApprovalWorkfowDescTxt: TextConst ENU = 'Std Approval Workflow';
        StdTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="Std">%1</DataItem></DataItems></ReportParameters>';
        RunWorkflowOnSendStdForApprovalCode: label 'RUNWORKFLOWONSENDSTDFORAPPROVAL';
        RunWorkflowOnCancelStdForApprovalCode: label 'RUNWORKFLOWONCANCELSTDFORAPPROVAL';
        OnCancelstdRequestTxt: label 'An Approval of Std is cancelled';
        OnSendstdRequestTxt: label ' An Approval of Std is requested';
        //cars
        CarsApprovalWorkflowCodeTxt: TextConst ENU = 'CRAPW';
        CarsApprovalWorkfowDescTxt: TextConst ENU = 'Cars Approval Workflow';
        CarsTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="Cars">%1</DataItem></DataItems></ReportParameters>';
        RunWorkflowOnSendCarsForApprovalCode: label 'RUNWORKFLOWONSENDCARSFORAPPROVAL';
        RunWorkflowOnCancelCarsForApprovalCode: label 'RUNWORKFLOWONCANCELCARSFORAPPROVAL';
        OnCancelCarsApprovalRequestTxt: label 'An Approval of cars is cancelled';
        OnSendCarsApprovalRequestTxt: label ' An Approval of cars is requested';
        //receipt header
        RunWorkflowOnSendReceiptForApprovalCode: label 'RUNWORKFLOWONSENDRECEIPTFORAPPROVAL';
        RunWorkflowOnCancelReceiptForApprovalCode: label 'RUNWORKFLOWONCANCELRECEIPTFORAPPROVAL';
        OnCancelReceiptApprovalRequestTxt: label 'An Approval of Receipt is cancelled';
        OnSendReceiptApprovalRequestTxt: label ' An Approval of Receipt is requested';
        ReceiptApprovalWorkflowCodeTxt: TextConst ENU = 'RCPAPW';
        ReceiptApprovalWorkfowDescTxt: TextConst ENU = 'Receipt Approval Workflow';
        ReceiptTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="Receipt">%1</DataItem></DataItems></ReportParameters>';


    procedure CheckApprovalsWorkflowEnabled(var variant: Variant): Boolean
    var
        RecRef: RecordRef;
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
        RcptHdr: Record "Receipt Header";
    begin
        RecRef.GetTable(variant);
        case RecRef.Number of
            Database::Std:
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendStdForApprovalCode));
            Database::Consumer:
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendConsumerForApprovalCode));
            Database::"Cars Model":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendCarsForApprovalCode));
            Database::"Receipt Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendReceiptForApprovalCode))
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end

    end;

    local procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not WorkflowMgt.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure AddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStdForApprovalCode, Database::Std, OnSendstdRequestTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStdForApprovalCode, Database::Std, OnCancelstdRequestTxt, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendConsumerForApprovalCode, Database::Consumer, OnSendconsumerApprovalRequestTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelConsumerForApprovalCode, Database::Consumer, OnCancelConsumerApprovalRequestTxt, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCarsForApprovalCode, Database::"Cars Model", OnSendCarsApprovalRequestTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCarsForApprovalCode, Database::"Cars Model", OnCancelCarsApprovalRequestTxt, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendReceiptForApprovalCode, Database::"Receipt Header", OnSendReceiptApprovalRequestTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelReceiptForApprovalCode, Database::"Receipt Header", OnCancelReceiptApprovalRequestTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Header workflow", OnSendDocForApproval, '', false, false)]

    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::Std:
                WorkflowMgt.HandleEvent(RunWorkflowOnSendStdForApprovalCode, Variant);
            Database::Consumer:
                WorkflowMgt.HandleEvent(RunWorkflowOnSendConsumerForApprovalCode, Variant);
            Database::"Cars Model":
                WorkflowMgt.HandleEvent(RunWorkflowOnSendCarsForApprovalCode, Variant);
            Database::"Receipt Header":
                WorkflowMgt.HandleEvent(RunWorkflowOnSendReceiptForApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Header workflow", 'OnCancelDocApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::Std:
                WorkflowMgt.HandleEvent(RunWorkflowOnCancelStdForApprovalCode, Variant);
            Database::Consumer:
                WorkflowMgt.HandleEvent(RunWorkflowOnCancelConsumerForApprovalCode, Variant);
            Database::"Cars Model":
                WorkflowMgt.HandleEvent(RunWorkflowOnCancelCarsForApprovalCode, Variant);
            Database::"Receipt Header":
                WorkflowMgt.HandleEvent(RunWorkflowOnCancelReceiptForApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;


    //Open the Document

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
        RcptHdr: Record "Receipt Header";
    begin
        case RecRef.Number of
            database::Std:
                begin
                    RecRef.SetTable(Std);
                    Std.Validate(Status, Std.Status::Open);
                    Std.Modify(true);
                    Handled := true;
                end;
            database::Consumer:
                begin
                    RecRef.SetTable(Consumer);
                    Consumer.Validate(Status, Consumer.Status::Open);
                    Consumer.Modify(true);
                    Handled := true;
                end;
            database::"Cars Model":
                begin
                    RecRef.SetTable(CarsModel);
                    CarsModel.Validate(Status, CarsModel.Status::Open);
                    CarsModel.Modify(true);
                    Handled := true;
                end;
            database::"Receipt Header":
                begin
                    RecRef.SetTable(RcptHdr);
                    RcptHdr.Validate(Status, RcptHdr.Status::Open);
                    RcptHdr.Modify(true);
                    Handled := true;
                end;

        end
    end;

    // on set status to pending approval 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
        RcptHdr: Record "Receipt Header";
    begin
        case RecRef.Number of
            database::Std:
                begin
                    RecRef.SetTable(Std);
                    Std.Validate(Status, Std.Status::"Pending approval");
                    Std.Modify(true);
                    Variant := std;
                    IsHandled := true;
                end;
            database::Consumer:
                begin
                    RecRef.SetTable(Consumer);
                    Consumer.Validate(Status, Consumer.Status::"Pending approval");
                    Consumer.Modify(true);
                    Variant := Consumer;
                    IsHandled := true;
                end;
            database::"Cars Model":
                begin
                    RecRef.SetTable(CarsModel);
                    CarsModel.Validate(Status, CarsModel.Status::"Pending approval");
                    CarsModel.Modify(true);
                    Variant := CarsModel;
                    IsHandled := true;
                end;
            database::"Receipt Header":
                begin
                    RecRef.SetTable(RcptHdr);
                    RcptHdr.Validate(Status, RcptHdr.Status::"Pending approval");
                    RcptHdr.Modify(true);
                    Variant := RcptHdr;
                    IsHandled := true;
                end;
        end;
    end;

    // on populate approval entry

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
        RcptHdr: Record "Receipt Header";
    begin
        case RecRef.Number of
            database::Std:
                begin
                    RecRef.SetTable(Std);
                    ApprovalEntryArgument."Document No." := Std."std id";
                end;
            database::Consumer:
                begin
                    RecRef.SetTable(Consumer);
                    ApprovalEntryArgument."Document No." := Consumer.ID;
                end;
            database::"Cars Model":
                begin
                    RecRef.SetTable(CarsModel);
                    ApprovalEntryArgument."Document No." := CarsModel.CarId;
                end;
            database::"Receipt Header":
                begin
                    RecRef.SetTable(RcptHdr);
                    ApprovalEntryArgument."Document No." := RcptHdr."Document No.";
                    ApprovalEntryArgument.Amount := RcptHdr."Receipt Amount";
                    ApprovalEntryArgument."Amount (LCY)" := RcptHdr."Receipt Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := RcptHdr."Currency Code";
                end;
        end
    end;

    // on release document 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
        RcptHdr: Record "Receipt Header";
    begin
        case RecRef.Number of
            Database::Std:
                begin
                    RecRef.SetTable(Std);
                    Std.Validate(Status, Std.Status::Approved);
                    Std.Modify(true);
                    Handled := true;
                end;
            Database::Consumer:
                begin
                    RecRef.SetTable(Consumer);
                    Consumer.Validate(Status, Consumer.Status::Approved);
                    Consumer.Modify(true);
                    Handled := true;
                end;
            Database::"Cars Model":
                begin
                    RecRef.SetTable(CarsModel);
                    CarsModel.Validate(Status, CarsModel.Status::Approved);
                    CarsModel.Modify(true);
                    Handled := true;
                end;
            Database::"Receipt Header":
                begin
                    RecRef.SetTable(RcptHdr);
                    RcptHdr.Validate(Status, RcptHdr.Status::Approved);
                    RcptHdr.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    // on reject document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
        RcptHdr: Record "Receipt Header";
    begin
        case ApprovalEntry."Table ID" of
            database::Std:
                begin
                    if std.Get(ApprovalEntry."Document No.") then begin
                        std.Validate(Status, std.Status::Rejected);
                        std.Modify(true)
                    end
                end;
            database::Consumer:
                begin
                    if Consumer.Get(ApprovalEntry."Document No.") then begin
                        Consumer.Validate(Status, Consumer.Status::Rejected);
                        Consumer.Modify(true)
                    end
                end;
            database::"Cars Model":
                begin
                    if CarsModel.Get(ApprovalEntry."Document No.") then begin
                        CarsModel.Validate(Status, CarsModel.Status::Rejected);
                        CarsModel.Modify(true)
                    end
                end;
            database::"Receipt Header":
                begin
                    if RcptHdr.Get(ApprovalEntry."Document No.") then begin
                        RcptHdr.Validate(Status, RcptHdr.Status::Open);
                        RcptHdr.Modify(true)
                    end
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", OnAfterGetPageID, '', false, false)]
    local procedure OnAfterGetPageID(var RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetDefaultCardPageID(RecordRef);
    end;

    local procedure GetDefaultCardPageID(RecRef: RecordRef): Integer
    var
        myInt: Integer;
    begin
        case RecRef.Number of
            database::"Receipt Header":
                exit(Page::"Receipt Card")
        end;
    end;


    //Add workflow categories
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAddWorkflowCategoriesToLibrary, '', false, false)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        WorkflowSetup.InsertWorkflowCategory(WorkflowCategoryCode, WorkflowCategoryDescTxt);
    end;

    //add on after insert table relations to library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAfterInsertApprovalsTableRelations, '', false, false)]
    local procedure InsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(Database::Std, 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(Database::Consumer, 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(Database::"Cars Model", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        WorkflowSetup.InsertTableRelation(Database::"Receipt Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnInsertWorkflowTemplates, '', false, false)]
    local procedure InsertWorkflowTemplates()
    begin
        InsertStdWorkflowTemplates();
        InsertConsumerWorkflowTemplates();
        InsertCarsWorkflowTemplates();
        InsertReceiptWorkflowTemplates();
    end;

    local procedure InsertStdWorkflowTemplates()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, StdApprovalWorkflowCodeTxt, StdApprovalWorkfowDescTxt, WorkflowCategoryCode);
        InsertStdApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertConsumerWorkflowTemplates()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, ConsumerApprovalWorkflowCodeTxt, ConsumerApprovalWorkfowDescTxt, WorkflowCategoryCode);
        InsertConsumerApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertCarsWorkflowTemplates()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, CarsApprovalWorkflowCodeTxt, CarsApprovalWorkfowDescTxt, WorkflowCategoryCode);
        InsertCarsApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertReceiptWorkflowTemplates()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, ReceiptApprovalWorkflowCodeTxt, ReceiptApprovalWorkfowDescTxt, WorkflowCategoryCode);
        InsertReceiptApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertCarsApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        CarsModel: Record "Cars Model";
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildCarsModelTypeConditions(CarsModel.Status::Open), RunWorkflowOnSendCarsForApprovalCode,
        BuildCarsModelTypeConditions(CarsModel.Status::"Pending approval"), RunWorkflowOnCancelCarsForApprovalCode,
        WorkflowStepArgument, true);
    end;

    local procedure InsertStdApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        Std: Record Std;
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildStdTypeConditions(std.Status::Open), RunWorkflowOnSendStdForApprovalCode,
        BuildStdTypeConditions(Std.Status::"Pending approval"), RunWorkflowOnCancelStdForApprovalCode,
        WorkflowStepArgument, true);
    end;

    local procedure InsertConsumerApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        Consumer: Record Consumer;
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildConsumerTypeConditions(Consumer.Status::Open), RunWorkflowOnSendConsumerForApprovalCode, BuildConsumerTypeConditions(Consumer.Status::"Pending approval"), RunWorkflowOnCancelConsumerForApprovalCode, WorkflowStepArgument, true);
    end;

    local procedure InsertReceiptApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        Consumer: Record Consumer;
    begin
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildReceiptModelTypeConditions(Consumer.Status::Open), RunWorkflowOnSendReceiptForApprovalCode, BuildReceiptModelTypeConditions(Consumer.Status::"Pending approval"), RunWorkflowOnCancelReceiptForApprovalCode, WorkflowStepArgument, true);
    end;

    procedure BuildStdTypeConditions(StatusParam: Enum "Consumer status"): Text
    var
        Std: Record Std;
    begin
        Std.SetRange(Status, StatusParam);
        exit(StrSubstNo(StdTypeCondTxt, WorkflowSetup.Encode(Std.GetView(false))));
    end;

    procedure BuildConsumerTypeConditions(StatusParam: Enum "Consumer status"): Text
    var
        Consumer: Record Consumer;
    begin
        Consumer.SetRange(Status, StatusParam);
        exit(StrSubstNo(ConsumerTypeCondTxt, WorkflowSetup.Encode(Consumer.GetView(false))));
    end;

    procedure BuildCarsModelTypeConditions(StatusParam: Enum "Consumer status"): Text
    var
        CarsModel: Record "Cars Model";
    begin
        CarsModel.SetRange(Status, StatusParam);
        exit(StrSubstNo(CarsTypeCondTxt, WorkflowSetup.Encode(CarsModel.GetView(false))));
    end;

    procedure BuildReceiptModelTypeConditions(StatusParam: Enum "Consumer status"): Text
    var
        RcptHdr: Record "Receipt Header";
    begin
        RcptHdr.SetRange(Status, StatusParam);
        exit(StrSubstNo(CarsTypeCondTxt, WorkflowSetup.Encode(RcptHdr.GetView(false))));
    end;

}
