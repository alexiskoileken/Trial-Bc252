/// <summary>
/// TableExtension customerExt (ID 50100) extends Record Customer.
/// </summary>
tableextension 50100 customerExt extends Customer
{
    fields
    {
        field(50100; "Ai model"; Enum "AI Models")
        {
            Caption = 'Ai model';
            DataClassification = ToBeClassified;
        }
        field(50120; "Customer Type"; Enum "Customer Type")
        {
            Caption = 'Customer Type';
            DataClassification = ToBeClassified;
        }
        field(50110; "Car Type";  Enum "Company vehicles")
        {
            DataClassification = ToBeClassified;
        }
    }
}
