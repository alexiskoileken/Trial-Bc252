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
            field("Car Type"; Rec."Car Type")
            {
                ApplicationArea = All;
                ToolTip = 'Select the type of company cars.';
            }
        }
        addlast("General")
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;
                ToolTip = 'Select the type of customer.';
            }
            // usercontrol(companyLogo;companyLogo)
            // {

            //     trigger MyTrigger()
            //     begin

            //     end;
            // }
        }
        addbefore("Attached Documents List")
        {
            part(powerbi; "Power BI Embedded Report Part")
            {
                ApplicationArea = all;
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
                action(Cars)
                {
                    ApplicationArea = All;
                    Caption = 'Cars', comment = 'NLB="YourLanguageCaption"';
                    Image = FixedAssets;

                    trigger OnAction()
                    begin
                        CompanycarsType := Rec."Car Type";
                        CompanycarsType.GetCarModel();
                    end;
                }
            }
        }
    }
    var
        Iatomate: Interface Iautomate;
        CompanycarsType: Interface "Company cars Type";
}