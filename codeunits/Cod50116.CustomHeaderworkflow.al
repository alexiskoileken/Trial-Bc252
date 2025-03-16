namespace TrialVersion.TrialVersion;
using System.Automation;
using Microsoft.Utilities;

codeunit 50116 "Custom Header workflow"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin
        AddWorkflowEventsToLibrary();
    end;

    var
        WorkflowMgt: Codeunit "Workflow Management";
        UnsupportedRecordTypeErr: label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        NoWorkflowEnabledErr: label 'This record is not supported by related approval workflow.';
        //Consumer
        RunWorkflowOnSendConsumerForApprovalCode: label 'RUNWORKFLOWONSENDCONSUMERFORAPPROVAL';
        RunWorkflowOnCancelConsumerForApprovalCode: label 'RUNWORKFLOWONCANCELCONSUMERFORAPPROVAL';
        OnCancelConsumerApprovalRequestTxt: label 'An Approval of Consumer is cancelled';
        OnSendconsumerApprovalRequestTxt: label ' An Approval of Consumer is requested';
        //std
        RunWorkflowOnSendStdForApprovalCode: label 'RUNWORKFLOWONSENDSTDFORAPPROVAL';
        RunWorkflowOnCancelStdForApprovalCode: label 'RUNWORKFLOWONCANCELSTDFORAPPROVAL';
        OnCancelstdRequestTxt: label 'An Approval of Std is cancelled';
        OnSendstdRequestTxt: label ' An Approval of Std is requested';
        //cars
        RunWorkflowOnSendCarsForApprovalCode: label 'RUNWORKFLOWONSENDCARSFORAPPROVAL';
        RunWorkflowOnCancelCarsForApprovalCode: label 'RUNWORKFLOWONCANCELCARSFORAPPROVAL';
        OnCancelCarsApprovalRequestTxt: label 'An Approval of cars is cancelled';
        OnSendCarsApprovalRequestTxt: label ' An Approval of cars is requested';

    procedure CheckApprovalsWorkflowEnabled(var variant: Variant): Boolean
    var
        RecRef: RecordRef;
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
    begin
        RecRef.GetTable(variant);
        case RecRef.Number of
            Database::Std:
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendStdForApprovalCode));
            Database::Consumer:
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendConsumerForApprovalCode));
            Database::"Cars Model":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendCarsForApprovalCode));
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end

    end;

    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
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

        end
    end;

    // on set status to pending approval 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
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
        end;
    end;

    // on populate approval entry

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
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
        end
    end;

    // on release document 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
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
        end;
    end;

    // on reject document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        std: Record Std;
        Consumer: Record Consumer;
        CarsModel: Record "Cars Model";
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
        end;
    end;


}
