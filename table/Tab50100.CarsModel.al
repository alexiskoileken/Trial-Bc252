/// <summary>
/// Table Cars Model (ID 50100).
/// </summary>
table 50100 "Cars Model"
{
    Caption = 'Cars Model';
    DataClassification = ToBeClassified;

    fields
    {
        field(4; CarId; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Car Model"; Option)
        {
            Caption = 'Car Id';
            OptionMembers = ,"Toyota","Audi","Porsche","Jeep","mercedenz";
        }
        field(2; "Car Name"; Text[50])
        {
            Caption = 'Car Name';
        }
        field(3; CC; Integer)
        {
            Caption = ' Engine CC';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; CarId)
        {
            Clustered = true;
        }
    }
}
