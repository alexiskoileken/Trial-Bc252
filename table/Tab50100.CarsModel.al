/// <summary>
/// Table Cars Model (ID 50100).
/// </summary>
table 50100 "Cars Model"
{
    Caption = 'Cars Model';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Car Id"; Code[20])
        {
            Caption = 'Car Id';
        }
        field(2; "Car model Type "; Enum "Company vehicles")
        {
            Caption = 'Car model Type ';
        }
    }
    keys
    {
        key(PK; "Car Id","Car model Type ")
        {
            Clustered = true;
        }
    }
}
