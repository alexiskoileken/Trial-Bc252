/// <summary>
/// Enum CustomerType (ID 50101).
/// </summary>
enum 50101 "Customer Type" implements CustomerPaymentMethod
{
    Extensible = true;
    value(1; Company)
    {
        Caption = 'Company';
        Implementation = CustomerPaymentMethod = "Company Customer";
    }
    value(2; Person)
    {
        Caption = 'Person';
        Implementation = CustomerPaymentMethod = "Individual Customer";
    }

}

