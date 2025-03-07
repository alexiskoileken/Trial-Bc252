table 50104 "std sales line"
{
    Caption = 'std sales line';
    DataClassification = ToBeClassified;

    fields
    {
        field(3; No; Code[20]) { }
        field(1; "Gl Type"; Enum "Gl type")
        {
            Caption = 'Gl Type';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                
            end;
        }
        field(2; "Acount No."; Code[50])
        {
            Caption = 'Acount No.';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
