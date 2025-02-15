namespace TrialVersion.TrialVersion;

enum 50102 "Company vehicles" implements "Company cars Type"
{
    Extensible = true;
    
    value(0; Toyota)
    {
        Caption = 'Toyota';
        Implementation="Company cars Type" =;
    }
    value(1; Audi)
    {
        Caption = 'Audi';
    }
    value(2; Porsche)
    {
        Caption = 'Porsche';
    }
    value(3; Jeep)
    {
        Caption = 'Jeep';
    }
    value(4; mercedenz)
    {
        Caption = 'mercedenz';
    }
}
