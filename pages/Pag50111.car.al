namespace TrialVersion.TrialVersion;

using System.Automation;

page 50111 car
{
    ApplicationArea = All;
    Caption = 'car';
    PageType = Card;
    SourceTable = "Cars Model";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Car Model"; Rec."Car Model")
                {
                    ToolTip = 'Specifies the value of the Car Id field.', Comment = '%';
                }
                field("Car Name"; Rec."Car Name")
                {
                    ToolTip = 'Specifies the value of the Car Name field.', Comment = '%';
                }
                field(CC; Rec.CC)
                {
                    ToolTip = 'Specifies the value of the Engine CC field.', Comment = '%';
                }
                field(CarId; Rec.CarId)
                {
                    ToolTip = 'Specifies the value of the Car Id field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Approval Requests")
            {
                caption = 'Approval Requests';
                action(SendApprovalRequest)
                {
                    Caption = 'Send ApprovalRequest';
                    ApplicationArea = basic, suite;
                    Image = SendApprovalRequest;
                    Tooltip = 'Request approval for the book to borrow.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = Not OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    var
                        RecVariant:Variant;
                        CustomHdrworkflow: Codeunit "Custom Header workflow";
                    begin
                        RecVariant := Rec;
                        if CustomHdrworkflow.CheckApprovalsWorkflowEnabled(RecVariant) then
                            CustomHdrworkflow.OnSendDocForApproval(RecVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel ApprovalRequest';
                    ApplicationArea = basic, suite;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()
                    var
                        Recvariant: Variant;
                        CustomHdrworkflow: Codeunit "Custom Header workflow";
                    begin
                        Recvariant := Rec;
                        CustomHdrworkflow.OnCancelDocApprovalRequest(Recvariant);
                    end;
                }
            }
        }
        area(Creation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approval requests.';
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
    end;

    var
        OpenApprovalEntriesExistCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord
        , HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}
