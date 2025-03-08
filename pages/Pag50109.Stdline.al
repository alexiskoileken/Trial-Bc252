namespace TrialVersion.TrialVersion;

page 50109 "Std line"
{
    ApplicationArea = All;
    Caption = 'Std line';
    PageType = ListPart;
    SourceTable = "std sales line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Gl Type"; Rec."Gl Type")
                {
                    ToolTip = 'Specifies the value of the Gl Type field.', Comment = '%';
                }
                field("Acount No."; Rec."Acount No.")
                {
                    ToolTip = 'Specifies the value of the Acount No. field.', Comment = '%';
                }
                field(name; Rec.name)
                {

                }
            }
        }
    }
}
