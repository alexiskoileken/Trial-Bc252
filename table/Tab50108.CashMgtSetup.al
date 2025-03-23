table 50108 "Cash Mgt Setup"
{
    Caption = 'Cash Mgt Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Setup no"; Code[20])
        {
            Caption = 'Setup no';
            
        }
        field(2; "Receipt Nos"; Code[20])
        {
            Caption = 'Receipt Nos';
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; "Setup no")
        {
            Clustered = true;
        }
    }
}
