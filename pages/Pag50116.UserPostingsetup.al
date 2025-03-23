namespace TrialVersion.TrialVersion;

page 50116 "User Posting setup"
{
    ApplicationArea = All;
    Caption = 'User Posting setup';
    PageType = List;
    SourceTable = "Gen.User Posting Setup ";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(UserId; Rec.UserId)
                {
                    ToolTip = 'Specifies the value of the UserId field.', Comment = '%';
                }
                field("Receipts Posting Template"; Rec."Receipts Posting Template")
                {
                    ToolTip = 'Specifies the value of the Receipts Posting Template field.', Comment = '%';
                }
                field("Receipts Posting Batch"; Rec."Receipts Posting Batch")
                {
                    ToolTip = 'Specifies the value of the Receipts Posting Batch field.', Comment = '%';
                }
            }
        }
    }
}
