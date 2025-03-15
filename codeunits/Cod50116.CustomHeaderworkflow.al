namespace TrialVersion.TrialVersion;
using System.Automation;
using Microsoft.Utilities;

codeunit 50116 "Custom Header workflow"
{
    //check if workflow is enabled 
    //Get workflow code 
    //publish events
    //add event to the library 
    //handle the document
    //check workflow enabled
    //codeunit 1502 workflowtemplate enable setup
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

    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    var
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, recref)) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //dynamic workflow code
    procedure RunWorkflowRecordForApprovalCode(WorkflowCode: Code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ''));
    end;
    // publish the events
    [IntegrationEvent(false, false)]
    procedure OnSendRecordForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelApprovalRecord(var RecRef: RecordRef)
    begin
    end;
    // add events to the library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::Std);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::Std
        , GetDescriptionTxt(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::Std
       , GetDescriptionTxt(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddCarWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::"Cars Model");
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::"Cars Model"
        , GetDescriptionTxt(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::"Cars Model"
       , GetDescriptionTxt(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;
    //dynamic workflow description text
    local procedure GetDescriptionTxt(DescriptionTxt: Text[250]; RecRef: RecordRef): Text
    var
    //RecRef: RecordRef;
    begin
        exit(StrSubstNo(DescriptionTxt, RecRef.Name))
    end;
    // subscribing to the raised events

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Header workflow", OnSendRecordForApproval, '', false, false)]
    local procedure SendRecordForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)
        , RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Header workflow", OnCancelApprovalRecord, '', false, false)]
    local procedure CancelApprovalRequest(Var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowRecordForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef),
        RecRef);
    end;

    //Open the Document

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Std: Record Std;
    begin
        case RecRef.Number of
            database::Std:
                begin
                    RecRef.SetTable(Std);
                    Std.Validate(Status, Std.Status::Open);
                    Std.Modify(true);
                    Handled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenCarsModelDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CarsModel: Record "Cars Model";
    begin
        case RecRef.Number of
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
        end;
    end;
    // on populate approval entry

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Std: Record Std;
    begin
        case RecRef.Number of
            database::Std:
                begin
                    RecRef.SetTable(Std);
                    ApprovalEntryArgument."Document No." := Std."std id";
                end;
        end
    end;
    // on release document 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Std: Record Std;
    begin
        case RecRef.Number of
            Database::Std:
                begin
                    RecRef.SetTable(Std);
                    Std.Validate(Status, Std.Status::Approved);
                    Std.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    // on reject document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        std: Record Std;
    begin
        case ApprovalEntry."Table ID" of
            database::Std:
                begin
                    if std.Get(ApprovalEntry."Document No.") then begin
                        std.Validate(Status, std.Status::Rejected);
                        std.Modify(true)
                    end
                end;
        end;
    end;
}
