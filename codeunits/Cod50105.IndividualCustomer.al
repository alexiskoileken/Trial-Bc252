/// <summary>
/// Codeunit Individual Customer (ID 50105) implements Interface CustomerPaymentMethodAndTerms.
/// </summary>
codeunit 50105 "Individual Customer" implements CustomerPaymentMethod,CustomerPaymentTerms
{

    /// <summary>
    /// AssignPaymentMethod.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure AssignPaymentMethod(): Text
    begin
        exit('PayPal');
    end;

    /// <summary>
    /// AssignPaymentTerms.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure AssignPaymentTerms(): Text
    begin
        exit('30 days term');
    end;

}
