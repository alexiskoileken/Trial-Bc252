namespace TrialVersion.TrialVersion;

page 50110 cars
{
    ApplicationArea = All;
    Caption = 'cars';
    PageType = List;
    SourceTable = "Cars Model";
    UsageCategory = Lists;
    CardPageId = car;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Car Model"; Rec."Car Model")
                {
                    ToolTip = 'Specifies the value of the Car Id field.', Comment = '%';
                }
                field("Car Name"; Rec."Car Name")
                {
                    ToolTip = 'Specifies the value of the Car Name field.', Comment = '%';
                }
                field(CarId; Rec.CarId)
                {
                    ToolTip = 'Specifies the value of the Car Id field.', Comment = '%';
                }
            }
        }
    }
}
