namespace TrialVersion.TrialVersion;
using Microsoft.Sales.Receivables;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Customer;
using System.Email;

codeunit 50113 "Customer overdue detection"
{
    /// <summary>
    /// CustomerOverDue.
    /// </summary>
    trigger OnRun()
    var
        myInt: Integer;
    begin
        CustomerOverDueInvoice();
    end;

    procedure CustomerOverDueInvoice()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        CustLedgEntries: Page "Customer Ledger Entries";
        EmailMsg: Codeunit "Email Message";
        CustomerEmail: Text;
        EmailBody: Text;
        Subject: Text;
        Email: Codeunit Email;
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SetRange("Due Date", Today);
        CustLedgEntry.SetFilter("Remaining Amount", '<>0');
        if CustLedgEntry.FindSet() then begin
            repeat
                if Cust.get(CustLedgEntry."Customer No.") then begin
                    CustomerEMail := Cust."E-Mail";
                    if Cust."E-Mail" <> '' then begin
                        EmailBody := StrSubstNo('Dear %1,%2Your invoice %3 of amount %4 is overdue since %5.%2Please make the payment as soon as possible.',
                        Cust.Name, '<br>', CustLedgEntry."Document No.", Format(CustLedgEntry."Remaining Amount"), Format(CustLedgEntry."Due Date"), '<br>')
                    end;
                    Subject := 'Payment Reminder: Overdue Invoice' + CustLedgEntry."Document No.";
                    EmailMsg.Create(CustomerEmail, Subject, EmailBody);
                    Email.Send(EmailMsg)
                end
            until CustLedgEntry.Next() = 0;
        end;
    end;
}
