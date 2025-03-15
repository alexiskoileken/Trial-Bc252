namespace TrialVersion.TrialVersion;

using System.Automation;

codeunit 50117 "Workflow setup ext"
{
    var
        RUNWORKFLOWONSENDFORAPPROVALCODE:
                Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE:
                Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        WorkflowSetup: Codeunit "Workflow Setup";
        WorkflowCategoryCode: TextConst ENU = 'CUSTM';
        WorkflowCategoryDescTxt: TextConst ENU = 'Custom Documents';
        StdApprovalWorkflowCodeTxt: TextConst ENU = 'SAPW';
        ConsumerApprovalWorkflowCodeTxt: TextConst ENU = 'CAPW';
        StdApprovalWorkfowDescTxt: TextConst ENU = 'Std Approval Workflow';
        ConsumerApprovalWorkfowDescTxt: TextConst ENU = 'Consumer approval workflow';
        StdTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="Std">%1</DataItem></DataItems></ReportParameters>';
        ConsumerTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="Consumer">%1</DataItem></DataItems></ReportParameters>';
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
    end;

    //on insert workflow templates

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnInsertWorkflowTemplates, '', false, false)]
    local procedure InsertWorkflowTemplates()
    begin
        InsertStdWorkflowTemplates();
        InsertConsumerWorkflowTemplate()
    end;

    //local procedure insert workflow template
    local procedure InsertStdWorkflowTemplates()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, StdApprovalWorkflowCodeTxt, StdApprovalWorkfowDescTxt, WorkflowCategoryCode);
        InsertStdApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertConsumerWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, ConsumerApprovalWorkflowCodeTxt, ConsumerApprovalWorkfowDescTxt, WorkflowCategoryCode);
        InsertConsumerApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertStdApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        std: Record std;
        CustomHdrworkflow: Codeunit "Custom Header workflow";
        RecRef: RecordRef;
    begin
        RecRef.Open(Database::Std);
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildStdTypeConditions(std.Status::Open), CustomHdrworkflow.RunWorkflowRecordForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef),
        BuildStdTypeConditions(std.Status::"Pending approval"), CustomHdrworkflow.RunWorkflowRecordForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef),
        WorkflowStepArgument, true);
    end;

    local procedure InsertConsumerApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        Consumer: Record Consumer;
        customworkflow: Codeunit "custom workflow";
        RecRef: RecordRef;
    begin
        RecRef.Open(Database::Consumer);
        WorkflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(Workflow, BuildConsumerTypeConditions(Consumer.Status::Open), customworkflow.GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef),
        BuildConsumerTypeConditions(Consumer.Status::"Pending approval"), customworkflow.GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef),
        WorkflowStepArgument, true);
    end;

    //build condition type
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
        exit(StrSubstNo(StdTypeCondTxt, WorkflowSetup.Encode(Consumer.GetView(false))));
    end;


}
