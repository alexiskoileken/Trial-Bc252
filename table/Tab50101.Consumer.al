/// <summary>
/// Table Consumer (ID 50101).
/// </summary>
table 50101 Consumer
{
    Caption = 'Consumer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Description "; Text[100])
        {
            Caption = 'Description ';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
