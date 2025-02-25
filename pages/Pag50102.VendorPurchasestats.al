namespace TrialVersion.TrialVersion;
using System.Integration;
using Microsoft.Purchases.Payables;
using Microsoft.Purchases.Vendor;
using System.Visualization;

page 50102 "Vendor Purchase stats"
{
    ApplicationArea = All;
    Caption = 'Vendor Purchase stats';
    PageType = CardPart;
    SourceTable = Vendor;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            usercontrol(Charts; BusinessChart)
            {
                ApplicationArea = all;

            }

        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        LoadChart();
    end;

    procedure LoadChart()
    var
        TmpBusChartBuf: Record "Business Chart Buffer" temporary;
        VendLedgEntry: Record "Vendor Ledger Entry";
        i: Integer;
    begin
        if Rec."No." = '' then
            exit;

        TmpBusChartBuf.Initialize();
        TmpBusChartBuf.AddMeasure('Amount', 1, TmpBusChartBuf."Data Type"::Decimal, TmpBusChartBuf."Chart Type"::Column);
        TmpBusChartBuf.SetXAxis('Document Type', TmpBusChartBuf."Data Type"::String);
        if VendLedgEntry.FindSet() then begin
            repeat
                VendLedgEntry.CalcFields("Amount (LCY)");
                TmpBusChartBuf.AddColumn(Format(VendLedgEntry."Document Type"));
                TmpBusChartBuf.SetValueByIndex(0, i, VendLedgEntry."Amount (LCY)");
                i += 1;
            until VendLedgEntry.Next() = 0;
        end;

        TmpBusChartBuf.UpdateChart(CurrPage.Charts);
    end;
}
