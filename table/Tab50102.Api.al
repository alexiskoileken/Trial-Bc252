/// <summary>
/// Table Api (ID 50102).
/// </summary>
table 50102 Api
{
    Caption = 'Api';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            trigger OnValidate()
            var
                GetApiRqst: Codeunit GetApiRequest;
            begin
                GetApiRqst.GetLinkData(Rec);
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Company; Text[100])
        {
            Caption = 'Company';
        }
        field(4; UserName; Text[100])
        {
            Caption = 'UserName';
        }
        field(5; Email; Text[100])
        {
            Caption = 'Email';
        }
        field(6; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(7; Zip; Text[100])
        {
            Caption = 'Zip';
        }
        field(8; State; Text[100])
        {
            Caption = 'State';
        }
        field(9; Country; Text[100])
        {
            Caption = 'Country';
        }
        field(10; Phone; Code[100])
        {
            Caption = 'Phone';
        }
        field(11; Photo; Text[100])
        {
            Caption = 'Photo';
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
}
