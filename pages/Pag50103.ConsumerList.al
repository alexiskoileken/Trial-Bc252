namespace TrialVersion.TrialVersion;

page 50103 "Consumer List"
{
    ApplicationArea = All;
    Caption = 'Consumer List';
    PageType = List;
    SourceTable = Consumer;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Description "; Rec."Description ")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
