namespace TrialVersion.TrialVersion;


page 50107 Std
{
    ApplicationArea = All;
    Caption = 'Std';
    PageType = List;
    SourceTable = Std;
    UsageCategory = Lists;
    CardPageId = "std card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("std id"; Rec."std id")
                {
                    ToolTip = 'Specifies the value of the std id field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the status field.', Comment = '%';
                }
            }
        }
    }

}
