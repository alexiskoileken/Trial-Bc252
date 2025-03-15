/// <summary>
/// Table Std (ID 50101).
/// </summary>
table 50101 Std
{
    Caption = 'Std';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "std id"; Code[20])
        {
            Caption = 'std id';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(6; Status; Enum "Consumer status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "std id")
        {
            Clustered = true;
        }
    }
}
