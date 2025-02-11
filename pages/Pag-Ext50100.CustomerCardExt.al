/// <summary>
/// PageExtension CustomerCardExt (ID 50100) extends Record Customer Card.
/// </summary>
pageextension 50100 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter("Name 2")
        {
            field("Ai model"; Rec."Ai model")
            {
                ApplicationArea = All;
                ToolTip = 'Select the AI model to use for this customer.';
            }
        }
    }
    actions
    {
        addafter(Approval)
        {
            group(Interfaces)
            {
                Caption = 'interface';
                action(Process)
                {
                    ApplicationArea = All;
                    Caption = 'process', comment = 'NLB="YourLanguageCaption"';
                    Image = Process;

                    trigger OnAction()
                    begin
                        Iatomate := Rec."Ai model";
                        Iatomate.Process();
                    end;
                }
                action(Belongsto)
                {
                    ApplicationArea = All;
                    Caption = 'Belongs to';
                    Image = Open;

                    trigger OnAction()
                    begin
                        Iatomate := Rec."Ai model";
                        Iatomate.Belongsto();
                    end;
                }
            }
        }
    }
    var
        Iatomate: Interface Iautomate;
}