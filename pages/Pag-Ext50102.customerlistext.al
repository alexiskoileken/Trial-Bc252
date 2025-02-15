namespace TrialVersion.TrialVersion;

using Microsoft.Sales.Customer;

pageextension 50102 "customer list ext" extends "Customer List"
{
    actions
    {
        addfirst(processing)
        {
            action(Base64)
            {
                ApplicationArea = All;
                Caption = 'Base64', comment = 'NLB="YourLanguageCaption"';
                Image = UnitConversions;

                trigger OnAction()
                var
                    CustExcelBuf: Codeunit CustomerExcelBuffer;
                begin
                    CustExcelBuf.ConvertCustomerToBase64();
                end;
            }
        }
    }
}
