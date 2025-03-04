namespace TrialVersion.TrialVersion;

using Microsoft.Sales.Document;

pageextension 50104 "Custom Sales Order" extends "Sales Order"
{
    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                SalesOrdValidation: Codeunit "Sales Order Validation";
            begin
                SalesOrdValidation.ValidateSalesOrder(Rec);
            end;
        }
    }
}
