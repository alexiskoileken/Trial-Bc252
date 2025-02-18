namespace TrialVersion.TrialVersion;
using System.Integration;
using Microsoft.Sales.Customer;
using System.Visualization;

page 50101 "Charts "
{
    ApplicationArea = All;
    Caption = 'Charts ';
    PageType = Card;

    layout
    {
        area(Content)
        {
            usercontrol(charts; BusinessChart)
            {
                trigger AddInReady()
                var
                    TmpBusChartBuf: Record "Business Chart Buffer" temporary;
                    Cust: Record Customer;
                    i: Integer;
                begin
                    TmpBusChartBuf.Initialize();
                    TmpBusChartBuf.AddMeasure('Sales', 1, TmpBusChartBuf."Data Type"::Decimal, TmpBusChartBuf."Chart Type"::Column);
                    TmpBusChartBuf.SetXAxis('Customer', TmpBusChartBuf."Data Type"::String);

                    if Cust.FindSet() then
                        repeat
                            Cust.CalcFields("Sales (LCY)");
                            if Cust."Sales (LCY)" <> 0 then begin
                                TmpBusChartBuf.AddColumn(Cust.Name);
                                TmpBusChartBuf.SetValueByIndex(0, i, Cust."Sales (LCY)");
                                i += 1
                            end;
                        until Cust.Next() = 0;
                    TmpBusChartBuf.UpdateChart(CurrPage.charts);
                end;
            }
        }
    }
}
