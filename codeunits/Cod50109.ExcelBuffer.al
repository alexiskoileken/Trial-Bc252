namespace TrialVersion.TrialVersion;
using Microsoft.Sales.Customer;
using System.IO;
using System.Text;
using System.Utilities;

codeunit 50109 CustomerExcelBuffer
{
    /// <summary>
    /// ConvertCustomerToBase64.
    /// </summary>
    procedure ConvertCustomerToBase64()
    var
        Customer: Record Customer;
        TmpExcelBuf: Record "Excel Buffer" temporary;
        Base64String: Text;
        Out: OutStream;
        instr: InStream;
        TempBlob: Codeunit "Temp Blob";
        sheetName: Text;
        BaseConvert: Codeunit "Base64 Convert";
    begin
        Clear(TmpExcelBuf);
        TmpExcelBuf.DeleteAll();
        TmpExcelBuf.NewRow();

        TmpExcelBuf.AddColumn(Customer.FieldCaption("No."), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Contact), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Balance), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption("Search Name"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        if Customer.FindSet() then begin
            repeat
                TmpExcelBuf.NewRow();
                Customer.CalcFields(Balance);
                TmpExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Contact, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Balance, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer."Search Name", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
            until Customer.Next() = 0;
        end;
        SheetName := 'Customer';
        TempBlob.CreateOutStream(Out);
        TmpExcelBuf.CreateNewBook(sheetName);
        TmpExcelBuf.WriteSheet(sheetName, CompanyName, UserId);
        TmpExcelBuf.CloseBook();
        TmpExcelBuf.SaveToStream(Out, false);
        TempBlob.CreateInStream(instr);
        Base64String := BaseConvert.ToBase64(instr);
        Message(Base64String);
    end;
}
