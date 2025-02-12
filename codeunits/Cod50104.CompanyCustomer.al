/// <summary>
/// Codeunit Company Customer (ID 50104) implements Interface CustomerPaymentMethodAndTerms.
/// </summary>
codeunit 50104 "Company Customer" implements CustomerPaymentMethod,CustomerPaymentTerms
{

    /// <summary>
    /// AssignPaymentMethod.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure AssignPaymentMethod(): Text
    begin
        exit('Credit Card');
    end;

    /// <summary>
    /// AssignPaymentTerms.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure AssignPaymentTerms(): Text
    begin
        exit('Net 30');
    end;

}
