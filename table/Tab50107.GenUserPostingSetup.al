table 50107 "Gen.User Posting Setup "
{
    Caption = 'User Posting Setup ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; UserId; Code[20])
        {
            Caption = 'UserId';
            // TableRelation = User."User Name";
        }
        field(18; "Receipts Posting Template"; Code[20])
        {
            Caption = 'Receipts Posting Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(19; "Receipts Posting Batch"; Code[20])
        {
            Caption = 'Receipts Posting Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipts Posting Template"));
        }
    }
    keys
    {
        key(PK; UserId)
        {
            Clustered = true;
        }
    }
}
