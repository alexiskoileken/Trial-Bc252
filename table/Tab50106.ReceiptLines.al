table 50106 "Receipt Lines"
{
    Caption = 'Receipt Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Doc No"; Code[20])
        {
            Caption = 'Doc No';
        }

        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Document Type"; Enum "Receipt DocType")
        {

        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Account Name" := '';
                "Currency Code" := '';
                "Account No." := '';
            end;
        }
        field(5; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting), Blocked = const(false))
            else if ("Account Type" = const(Customer)) Customer
            else if ("Account Type" = const(Vendor)) Vendor
            else if ("Account Type" = const("Bank Account")) "Bank Account"
            else if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else if ("Account Type" = const("IC Partner")) "IC Partner"
            else if ("Account Type" = const(Employee)) Employee;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Account Name" := '';
                "Currency Code" := '';
                Validate("Currency Code");
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        if GLAccount.Get("Account No.") then begin
                            "Account Name" := GLAccount.Name;
                            Validate("Currency Code", GLAccount."Source Currency Code");
                        end;
                    "Account Type"::"Bank Account":
                        IF BankAccount.get("Account No.") then begin
                            "Account Name" := BankAccount.Name;
                        end;
                    "Account Type"::Customer:
                        IF Customer.get("Account No.") then begin
                            "Account Name" := Customer.Name;
                        end;
                    "Account Type"::Employee:
                        IF Employee.get("Account No.") then begin
                            "Account Name" := Employee."First Name";
                        end;
                    "Account Type"::Vendor:
                        if Vendor.Get("Account No.") then
                            "Account Name" := Vendor.Name;
                end;

            end;
        }
        field(6; "Account Name"; Text[50])
        {
        }
        field(7; "Transaction Description"; Text[50])
        {
        }
        field(8; "Currency Code"; Code[20])
        {
        }
        field(9; "Currency Factor"; Decimal)
        {
        }
        field(10; Amount; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ReceiptHeader.Get("Doc No") then begin
                    if "Currency Code" = '' then
                        "Amount(LCY)" := Amount
                    else
                        "Amount(LCY)" := Round(
                            CurrExchRate.ExchangeAmtFCYToLCY(ReceiptHeader."Document Date", "Currency Code",
                           Amount, "Currency Factor")
                        )
                end;
            end;
        }
        field(11; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(12; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(13; "Applies-to Doc. No."; Code[20])
        {
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(25; "Transaction Type"; Code[20])
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
        }
        field(300; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Doc No", "Document Type", "Account No.")
        {
            Clustered = true;
        }
    }

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    var
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        Employee: Record Employee;
        DimMgt: Codeunit DimensionManagement;
        ReceiptHeader: Record "Receipt Header";
        CurrExchRate: Record "Currency Exchange Rate";
        VATEntry: Record "VAT Entry";
        Amt: Decimal;


}
