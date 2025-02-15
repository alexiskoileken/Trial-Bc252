/// <summary>
/// PageExtension Sales Order Ext (ID 50101) extends Record Sales Order.
/// </summary>
namespace trialversion;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using trialversion.TrialVersion;
pageextension 50101 "Sales Order Ext" extends "Sales Order"
{
    actions
    {
        addlast(processing)
        {
            action(CustomInterface)
            {
                ApplicationArea = All;
                Caption = ' Interface';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Cust: Record Customer;
                    CustomerPaymentMethod: Interface CustomerPaymentMethod;
                    CustomerPaymentTerms: Interface CustomerPaymentTerms;
                    IndividualCust: Codeunit "Individual Customer";
                    CompanyCust: Codeunit "Company Customer";
                begin
                    Clear(Cust);
                    if Cust.get(Rec."Sell-to Customer No.") then begin
                        Cust.CalcFields("Balance (LCY)");
                        CustomerPaymentMethod := Cust."Customer Type";
                        Message(CustomerPaymentMethod.AssignPaymentMethod());
                        if Cust."Customer Type" = Cust."Customer Type"::Person then begin
                            if Cust."Balance (LCY)" > 1000 then
                                CustomerPaymentTerms := IndividualCust
                            else
                                CustomerPaymentTerms := CompanyCust;
                        end
                        else
                            CustomerPaymentTerms := CompanyCust;
                        Message(CustomerPaymentTerms.AssignPaymentTerms());
                    end;
                end;
            }
        }
    }
}
