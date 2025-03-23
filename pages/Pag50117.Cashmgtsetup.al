namespace TrialVersion.TrialVersion;

page 50117 "Cash mgt setup"
{
    ApplicationArea = All;
    Caption = 'Cash mgt setup';
    PageType = List;
    SourceTable = "Cash Mgt Setup";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    ToolTip = 'Specifies the value of the Receipt Nos field.', Comment = '%';
                }
            }
        }
    }
}
