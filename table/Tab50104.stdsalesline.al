table 50104 "std sales line"
{
    Caption = 'std sales line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LineNo; Code[50])
        {
            Caption = 'Line No';
        }
        field(2; "Gl Type"; Enum "Gl type")
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Acount No." := '';
                name := '';
            end;
        }
        field(3; "Acount No."; Code[50])
        {
            Caption = 'Acount No.';
            TableRelation =
            if ("Gl Type" = const("Gl type"::Customer)) Customer."No."
            else if ("Gl Type" = const("Gl type"::Vendor)) Vendor."No."
            else if ("Gl Type" = const("Gl type"::Bank)) "Bank Account"."No.";
            trigger OnValidate()
            var
                Vend: Record Vendor;
                Cust: Record Customer;
                BankAcc: Record "Bank Account";
            begin
                case "Gl Type" of
                    "Gl Type"::Customer:
                        if Cust.get("Acount No.") then
                            name := Cust.Name;
                    "Gl Type"::Vendor:
                        if Vend.get("Acount No.") then
                            name := Vend.Name;
                    "Gl Type"::Bank:
                        if BankAcc.get("Acount No.") then
                            name := BankAcc.Name;
                end
            end;
        }
        field(4; No; Code[20])
        {
            Caption = 'No';
        }
        field(5; name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'name';
        }

    }

    keys
    {
        key(PK; LineNo, No)
        {
            Clustered = true;
        }
    }

}
