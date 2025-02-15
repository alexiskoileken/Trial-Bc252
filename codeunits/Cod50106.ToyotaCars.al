codeunit 50106 ToyotaCars implements "Company cars Type"
{

    procedure GetCarModel()
    var
        CarsModel: Record "Cars Model";
        CompCars: Page "Company Car";
    begin
        CarsModel.SetRange("Car Model", CarsModel."Car Model"::Toyota);
        if CarsModel.FindSet() then begin
            CompCars.SetTableView(CarsModel);
            CompCars.Run();
        end;
    end;
}
codeunit 50107 AudiCars implements "Company cars Type"
{

    procedure GetCarModel()
    var
        CarsModel: Record "Cars Model";
        CompCars: Page "Company Car";
    begin
        CarsModel.SetRange("Car Model", CarsModel."Car Model"::Audi);
        if CarsModel.FindSet() then begin
            CompCars.SetTableView(CarsModel);
            CompCars.Run();
        end;
    end;
}
codeunit 50108 PorscheCars implements "Company cars Type"
{

    procedure GetCarModel()
    var
        CarsModel: Record "Cars Model";
        CompCars: Page "Company Car";
    begin
        CarsModel.SetRange("Car Model", CarsModel."Car Model"::Porsche);
        if CarsModel.FindSet() then begin
            CompCars.SetTableView(CarsModel);
            CompCars.Run();
        end;
    end;
}
codeunit 50110 jeepsCars implements "Company cars Type"
{

    procedure GetCarModel()
    var
        CarsModel: Record "Cars Model";
        CompCars: Page "Company Car";
    begin
        CarsModel.SetRange("Car Model", CarsModel."Car Model"::Jeep);
        if CarsModel.FindSet() then begin
            CompCars.SetTableView(CarsModel);
            CompCars.Run();
        end;
    end;
}
codeunit 50111 mercedenzCars implements "Company cars Type"
{

    procedure GetCarModel()
    var
        CarsModel: Record "Cars Model";
        CompCars: Page "Company Car";
    begin
        CarsModel.SetRange("Car Model", CarsModel."Car Model"::mercedenz);
        if CarsModel.FindSet() then begin
            CompCars.SetTableView(CarsModel);
            CompCars.Run();
        end;
    end;
}


