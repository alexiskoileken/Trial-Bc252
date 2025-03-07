namespace TrialVersion.TrialVersion;
using System.Automation;

codeunit 50115 "custom workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure GetWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ' '));
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    // Add events to the library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        recref: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        recref.Open(Database::Consumer);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, recref), Database::Consumer,
        GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, recref), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, recref), Database::Consumer,
        GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, recref), 0, false);
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    // local procedure OnAddWorkflowEventsToLibrary()
    // var
    //     RecRef: RecordRef;
    //     WorkflowEventHandling: Codeunit "Workflow Event Handling";
    // begin
    //     RecRef.Open(Database::Consumer);
    //     WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::"Consumer",
    //       GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
    //     WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::"Consumer",
    //       GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    // end;
    // subscribe

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"custom workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"custom workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;

    // handle the document;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Consumer: Record "Consumer";
    begin
        case RecRef.Number of
            Database::"Consumer":
                begin
                    RecRef.SetTable(Consumer);
                    Consumer.Validate(Status, Consumer.Status::Open);
                    Consumer.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var

    begin
        case RecRef.Number of
            Database::"Consumer":
                begin
                    RecRef.SetTable(Consumer);
                    Consumer.Validate(Status, Consumer.Status::"Pending approval");
                    Consumer.Modify(true);
                    Variant := Consumer;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Consumer: Record "Consumer";
    begin
        case RecRef.Number of
            DataBase::"Consumer":
                begin
                    RecRef.SetTable(Consumer);
                    ApprovalEntryArgument."Document No." := Consumer.ID;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var

    begin
        case RecRef.Number of
            DataBase::"Consumer":
                begin
                    RecRef.SetTable(Consumer);
                    Consumer.Validate(Status, Consumer.Status::Approved);
                    Consumer.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;

    begin
        case ApprovalEntry."Table ID" of
            DataBase::"Consumer":
                begin
                    if Consumer.Get(ApprovalEntry."Document No.") then begin
                        Consumer.Validate(Status, Consumer.Status::Rejected);
                        Consumer.Modify(true);
                    end
                end;
        end;
    end;

    var

        WorkflowMgt: Codeunit "Workflow Management";

        RUNWORKFLOWONSENDFORAPPROVALCODE:
                Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE:
                Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr:
                Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt:
                Label ' An Approval of %1 is requested.';
        WorkflowCancelForApprovalEventDescTxt:
                Label 'An Approval of %1 is canceled.';
        Consumer:
                Record "Consumer";
}
