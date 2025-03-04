/// <summary>
/// Unknown TrialVersion.
/// </summary>
namespace TrialVersion.TrialVersion;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Receivables;

codeunit 50114 "Sales Order Validation"
{
    /// <summary>
    /// ValidateSalesOrder.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    procedure ValidateSalesOrder(SalesHeader: Record "Sales Header")
    //
    var
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        OutStandingBalance: Decimal;
    begin
        if Cust.get(SalesHeader."Sell-to Customer No.") then begin
            OutStandingBalance := 0;
            CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
            CustLedgEntry.SetRange(Open, true);
            if CustLedgEntry.FindSet() then
                repeat
                    OutStandingBalance += CustLedgEntry."Remaining Amount";
                until CustLedgEntry.Next() = 0;
            if OutStandingBalance < Cust."Credit Limit (LCY)" then
                Error('Customer %1 has exceeded their credit limit of %2. Current outstanding balance: %3. Sales order cannot be created.',
                    Cust.Name, Cust."Credit Limit (LCY)", OutStandingBalance);
        end;
    end;

}
