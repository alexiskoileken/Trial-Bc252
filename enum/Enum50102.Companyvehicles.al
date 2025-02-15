namespace TrialVersion.TrialVersion;

enum 50102 "Company vehicles" implements "Company cars Type"
{
    Extensible = true;
    DefaultImplementation = "Company cars Type" = ToyotaCars;
    value(0; "")
    {
        Caption = '';
    }
    value(1; Toyota)
    {
        Caption = 'Toyota';
        Implementation = "Company cars Type" = ToyotaCars;
    }
    value(2; Audi)
    {
        Caption = 'Audi';
        Implementation = "Company cars Type" = AudiCars;
    }
    value(3; Porsche)
    {
        Caption = 'Porsche';
        Implementation = "Company cars Type" = PorscheCars;
    }
    value(4; Jeep)
    {
        Caption = 'Jeep';
        Implementation = "Company cars Type" = jeepsCars;
    }
    value(5; mercedenz)
    {
        Caption = 'mercedenz';
        Implementation = "Company cars Type" = mercedenzCars;
    }
}
