namespace TrialVersion.TrialVersion;

enum 50102 "Company vehicles" implements "Company cars Type"
{
    Extensible = true;

    value(0; Toyota)
    {
        Caption = 'Toyota';
        Implementation = "Company cars Type" = ToyotaCars;
    }
    value(1; Audi)
    {
        Caption = 'Audi';
        Implementation = "Company cars Type" = ToyotaCars;
    }
    value(2; Porsche)
    {
        Caption = 'Porsche';
        Implementation = "Company cars Type" = ToyotaCars;
    }
    value(3; Jeep)
    {
        Caption = 'Jeep';
        Implementation = "Company cars Type" = ToyotaCars;
    }
    value(4; mercedenz)
    {
        Caption = 'mercedenz';
        Implementation = "Company cars Type" = ToyotaCars;
    }
}
