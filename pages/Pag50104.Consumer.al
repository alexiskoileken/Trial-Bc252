/// <summary>
/// Unknown TrialVersion.
/// </summary>
namespace TrialVersion.TrialVersion;

page 50104 Consumer
{
    APIGroup = 'MasterData';
    APIPublisher = 'Alexis';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'consumer';
    DelayedInsert = true;
    EntityName = 'Consumers';
    EntitySetName = 'Consumer';
    PageType = API;
    SourceTable = Consumer;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec."Description ")
                {
                    Caption = 'Description';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
