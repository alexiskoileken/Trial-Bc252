namespace TrialVersion.TrialVersion;

enum 50103 "Consumer status"
{
    Extensible = true;
    
    value(0; "")
    {
        Caption = '';
    }
    value(1; Open)
    {
        Caption = 'Open';
    }
    value(2; "Pending approval")
    {
        Caption = 'Pending approval';
    }
    value(3; Approved)
    {
        Caption = 'Approved';
    }
    value(4; Rejected)
    {
        Caption = 'Rejected';
    }
}
