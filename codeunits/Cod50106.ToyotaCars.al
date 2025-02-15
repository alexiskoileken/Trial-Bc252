namespace TrialVersion.TrialVersion;

codeunit 50106 ToyotaCars implements "Company cars Type"
{

    procedure IfIsToyota()
    var
        CarsModel: Record "Cars Model";
        CompCars: Page "Company Cars";
    begin
        CarsModel.SetRange("Car Model", CarsModel."Car Model"::Toyota);
        if CarsModel.FindSet() then begin
            CompCars.SetTableView(CarsModel);
            CompCars.Run();
        end;
    end;

    procedure IfIsPorsche(): Text
    begin
    end;

    procedure IfIsAudi(): Text
    begin
    end;

    procedure IfIsJeep(): Text
    begin
    end;

    procedure IfIsMercedenc(): Text
    begin
    end;

}
