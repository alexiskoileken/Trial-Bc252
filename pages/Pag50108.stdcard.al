namespace TrialVersion.TrialVersion;

page 50108 "std card"
{
    ApplicationArea = All;
    Caption = 'std card';
    PageType = Card;
    SourceTable = Std;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("std id"; Rec."std id")
                {
                    ToolTip = 'Specifies the value of the std id field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
            }
            part(lines; "Std line")
            {
                ApplicationArea = all;
                SubPageLink = No = field("std id");
            }
        }
    }
}
