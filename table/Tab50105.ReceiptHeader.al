table 50105 "Receipt Header"
{
    Caption = 'Receipt Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnValidate();
            begin
                IF "Document No." <> xRec."Document No." THEN BEGIN
                    CashMgtSetup.GET;
                    NoSeriesCdt.TestManual(CashMgtSetup."Receipt Nos");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Document Type"; Enum "Receipt DocType")
        {
            Caption = 'Document Type';
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(5; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(6; "Created Time"; Time)
        {
            Caption = 'Created Time';
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
        }
        field(8; "Account Type "; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(9; "Account No"; Code[20])
        {
            Caption = 'Account No';
            TableRelation = if ("Account Type " = const("Bank Account")) "Bank Account";
            trigger OnValidate()
            var

            begin
                "Account Name" := '';
                case "Account Type " of
                    "Account Type "::"Bank Account":
                        begin
                            if BankAcc.get("Account No") then
                                "Account Name" := BankAcc.Name;
                        end;
                end;
            end;
        }
        field(10; "Account Name"; Text[50])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(11; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
        }
        field(12; "Currency factor"; Decimal)
        {
            Caption = 'Currency factor';
        }
        field(13; "Payment Mode"; Code[20])
        {
        }
        field(14; "Cheque Date"; Date)
        {
        }
        field(15; "Cheque No"; Code[20])
        {
        }
        field(16; "Received From"; Text[50])
        {
        }
        field(17; "Transaction Description"; Text[100])
        {
        }
        field(18; "Receipt Amount"; Decimal)
        {
            CalcFormula = Sum("Receipt Lines".Amount WHERE("Doc No" = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Receipt Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum("Receipt Lines"."Amount(LCY)" WHERE("Doc No" = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(22; Posted; Boolean)
        {
            Editable = false;
        }
        field(23; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(24; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(25; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Editable = false;
        }
        field(500; Status; Enum "Consumer status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        case "Document Type" of
            "Document Type"::Receipt:
                begin
                    "Created By" := UserId;
                    "Created Date" := Today;
                    "Created Time" := Time;
                    if "Document No." = '' then begin
                        CashMgtSetup.Get();
                        CashMgtSetup.TestField("Receipt Nos");
                        "Document No." := NoSeriesCdt.GetNextNo(CashMgtSetup."Receipt Nos")
                    end;
                end;

        end;
    end;

    trigger OnDelete()
    var
    
        myInt: Integer;
    begin
        if Posted then
            Error('you cannot delete a posted record');
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Receipt Header", "Document No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        //TESTFIELD("Check Printed",FALSE);
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ShowDimensions();
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', '', ''),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

     procedure GetStatusStyleexpr(): Text
    var
        myInt: Integer;
    begin
        if Status = Status::Open then
            exit('Favorable')
        else
            exit('Strong')
    end;



    var
        BankAcc: Record "Bank Account";
        CashMgtSetup: Record "Cash Mgt Setup";
        NoSeriesCdt: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
}
