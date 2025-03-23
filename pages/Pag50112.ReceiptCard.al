namespace TrialVersion.TrialVersion;

using System.Automation;
using Microsoft.Finance.Dimension;

page 50112 "Receipt Card"
{
    ApplicationArea = All;
    Caption = 'Receipt Card';
    PageType = Card;
    SourceTable = "Receipt Header";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval,Print';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsEditable;

                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin

                    end;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Account Type "; Rec."Account Type ")
                {
                    ToolTip = 'Specifies the value of the Account Type  field.', Comment = '%';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field("Currency factor"; Rec."Currency factor")
                {
                    ToolTip = 'Specifies the value of the Currency factor field.', Comment = '%';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field.', Comment = '%';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.', Comment = '%';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field.', Comment = '%';
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the value of the Received From field.', Comment = '%';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.', Comment = '%';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount field.', Comment = '%';
                }
                field("Receipt Amount(LCY)"; Rec."Receipt Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount(LCY) field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                "Dimension Value Type" = const(Standard),
                                                                 Blocked = const(false));
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                "Dimension Value Type" = const(Standard),
                                                                 Blocked = const(false));
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                                "Dimension Value Type" = const(Standard),
                                                                 Blocked = const(false));
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                                "Dimension Value Type" = const(Standard),
                                                                 Blocked = const(false));
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                                "Dimension Value Type" = const(Standard),
                                                                 Blocked = const(false));
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                                "Dimension Value Type" = const(Standard),
                                                                 Blocked = const(false));
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {

                }
            }
            part(RceiptLine; "Receipt Lines")
            {
                SubPageLink = "Doc No" = field("Document No."),
                              "Document Type" = field("Document Type");
                ApplicationArea = all;
                Editable = IsEditable;


            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {

                }
                field("Created Date"; Rec."Created Date")
                {

                }
                field("Created Time"; Rec."Created Time")
                {

                }
                field("Posted By"; Rec."Posted By")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Posted Time"; Rec."Posted Time")
                {

                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                    begin

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var

                    begin
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        // WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Purchase Header", "Document Type".AsInteger(), "Document No.");
                    end;
                }
                group(Flow)
                {
                    Caption = 'Power Automate';
                    Image = Flow;
                    action(CreateFlow)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create a flow';
                        Image = Flow;
                        Promoted = true;
                        PromotedCategory = Category9;
                        ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
                        Visible = false;

                        trigger OnAction()
                        var
                            FlowServiceManagement: Codeunit "Flow Service Management";
                        //  FlowTemplateSelector: Page "Flow Template Selector";
                        begin
                            // Opens page 6400 where the user can use filtered templates to create new flows.
                            // FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetPurchasingTemplateFilter);
                            // FlowTemplateSelector.Run;
                        end;
                    }
                    action(SeeFlows)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'See my flows';
                        Image = Flow;
                        Promoted = true;
                        PromotedCategory = Category9;
                        // RunObject = Page "Flow Selector";
                        ToolTip = 'View and configure Power Automate flows that you created.';
                    }
                }
            }

            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("Cancel Document")
            {
                Visible = false;
                Caption = 'Cancel Document';
                action(CancelDocument)
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Cancel the document and create a new one.';
                    ApplicationArea = All;

                    trigger OnAction();
                    var

                    begin
                        IF CONFIRM('The document will be Cancelled and archived. Do yoou wish to continue?') THEN BEGIN
                            //"Approval Status" := "Approval Status"::Cancelled;
                            //"Cancelled By" := USERID;
                            //"Cancelled Date" := TODAY;
                            // MODIFY;
                        END;
                    end;
                }
            }
            group("Post Trans")
            {
                action("Post And Print Voucher")
                {
                    Enabled = PostEnabled;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(PostDatePage);
                        PostDatePage.LOOKUPMODE(TRUE);
                        PostDatePage.RUNMODAL;
                        IF PostDatePage.fnGetPostngDte() <> 0D THEN BEGIN
                            rec."Posting Date" := PostDatePage.fnGetPostngDte();
                            rec.MODIFY;
                        END;

                        IF CONFIRM('Do you want to post and print Voucher No ' + Rec."Document No.", TRUE, TRUE) THEN BEGIN
                            // Codefactory.FnPostReceipt(Rec);

                            // RESET;
                            // SETRANGE("Document No.", "Document No.");
                            // REPORT.RUN(50002, TRUE, TRUE, Rec);
                            // RESET;

                        END;
                    end;
                }
                action(Post)
                {
                    Enabled = PostEnabled;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(PostDatePage);
                        PostDatePage.LOOKUPMODE(TRUE);
                        PostDatePage.RUNMODAL;
                        IF PostDatePage.fnGetPostngDte() <> 0D THEN BEGIN
                            Rec."Posting Date" := PostDatePage.fnGetPostngDte();
                            Rec.Modify();
                        END;

                        IF CONFIRM('Do you want to post Voucher No ' + Rec."Document No.", TRUE, TRUE) THEN BEGIN
                            CustomPostRout.PostReceiptJrnl(Rec);
                        END;
                    end;
                }
                action("Print Receipt")
                {
                    Caption = 'Print Receipt';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RESET;
                        Rec.SetRange("Document No.", Rec."Document No.");
                        //REPORT.RUN(Report::receipt, TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
            }
        }

    }





    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
        rec.ShowShortcutDimCode(ShortcutDimCode);

    end;

    trigger OnAfterGetRecord();
    begin

    end;

    trigger OnNewRecord(Belowxrec: Boolean)
    var
        myInt: Integer;
    begin
        rec."Document Type" := Rec."Document Type"::Receipt;
        Rec."Account Type " := Rec."Account Type "::"Bank Account";
    end;

    local procedure SetControlAppearance();
    begin


        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

        if not rec.Posted then begin
            PostEnabled := true;
            IsEditable := true;
        end

    end;


    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        PostEnabled: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        CustomHdrworkflow: Codeunit "Custom Header workflow";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        CardEditable: Boolean;
        ApproveVisible: Boolean;
        PostDatePage: Page "Posting DatePage";
        CustomPostRout: codeunit "Custom posting Routine";
        IsEditable: Boolean;
}

