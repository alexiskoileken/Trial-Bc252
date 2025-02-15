namespace TrialVersion.TrialVersion;

page 50100 "Company Cars"
{
    ApplicationArea = All;
    Caption = 'Company Cars';
    PageType = List;
    SourceTable = "Cars Model";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CarId; Rec.CarId)
                {
                    ToolTip = 'Specifies the value of the Car Id field.', Comment = '%';
                }
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
            }
        }
    }
}
