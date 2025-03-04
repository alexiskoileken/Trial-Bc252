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
                ApplicationArea = basic, suite;
                Caption = 'Base64', comment = 'NLB="YourLanguageCaption"';
                Image = UnitConversions;
                Promoted = true;
                PromotedCategory = Category4;


                trigger OnAction()
                var
                    CustExcelBuf: Codeunit CustomerExcelBuffer;
                begin
                    CustExcelBuf.ConvertCustomerToBase64();
                end;
            }
            action("update customer")
            {
                ApplicationArea = basic, suite;
                Caption = 'update customer', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = Refresh;

                trigger OnAction()
                var
                    GetApiRqst: Codeunit GetApiRequest;
                begin
                    GetApiRqst.CustomApiSquare();
                end;
            }

        }
    }
}
