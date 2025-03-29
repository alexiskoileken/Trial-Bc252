namespace TrialVersion.TrialVersion;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;

codeunit 50115 "Custom posting Routine"
{
    //clear the general journal line 
    //create the general lines 
    //create the posting
    //clear the patch
    //clear template

    local procedure ClearGnJrnlLine(JTemplate: Text; JBatch: text): Boolean
    var
        GenJnlLn: Record "Gen. Journal Line";
    begin
        GenJnlLn.Reset();
        GenJnlLn.SetRange("Journal Template Name", JTemplate);
        GenJnlLn.SetRange("Journal Batch Name", JBatch);
        if GenJnlLn.FindSet() then
            GenJnlLn.DeleteAll();
        exit(true)
    end;

    local procedure FnGjrnlinePostBatch(JTemplate: Text; Jbatch: Text) Ok: Boolean
    var
        GenJnlLn: Record "Gen. Journal Line";
    begin
        ok := false;
        GenJnlLn.Reset();
        GenJnlLn.SetRange("Journal Template Name", JTemplate);
        GenJnlLn.SetRange("Journal Batch Name", Jbatch);
        if GenJnlLn.FindFirst() then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch"
            , GenJnlLn);
            ok := true;
        end;
        exit(Ok)

    end;

    local procedure FnCreateGjrnlLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; Dimension1: Code[40]; Dimension2: Code[40]; DimSetID: Integer; ExternalDocumentNo: Code[50]; TransactionDescription: Text; Currency: Code[10]; AppliesToDocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; AppliesToDocNo: Code[50]; CurrencyFactor: Decimal)
    var
        GenJnlLn: Record "Gen. Journal Line";
    begin
        GenJnlLn.Init();
        GenJnlLn."Journal Template Name" := TemplateName;
        GenJnlLn."Journal Batch Name" := BatchName;
        GenJnlLn."Document No." := DocumentNo;
        GenJnlLn."Line No." := LineNo;
        GenJnlLn."Account Type" := AccountType;
        GenJnlLn."Account No." := AccountNo;
        GenJnlLn.Validate("Account No.");
        GenJnlLn."Posting Date" := TransactionDate;
        GenJnlLn."Currency Code" := Currency;
        if GenJnlLn."Currency Code" <> '' then
            GenJnlLn.Validate("Currency Code");
        GenJnlLn.Description := TransactionDescription;
        GenJnlLn.Amount := TransactionAmount;
        GenJnlLn."External Document No." := ExternalDocumentNo;
        GenJnlLn.VALIDATE(GenJnlLn.Amount);
        GenJnlLn."Shortcut Dimension 1 Code" := Dimension1;
        GenJnlLn."Shortcut Dimension 2 Code" := Dimension2;
        GenJnlLn."Dimension Set ID" := DimSetID;
        GenJnlLn.VALIDATE(GenJnlLn."Shortcut Dimension 1 Code");
        GenJnlLn.VALIDATE(GenJnlLn."Shortcut Dimension 2 Code");
        GenJnlLn."Applies-to Doc. Type" := AppliesToDocType;
        GenJnlLn."Applies-to Doc. No." := AppliesToDocNo;
        GenJnlLn."Currency Factor" := CurrencyFactor;
        GenJnlLn.VALIDATE(Amount);
        IF GenJnlLn.Amount <> 0 THEN
            GenJnlLn.INSERT;
    end;

    procedure PostReceiptJrnl(ReceiptHeader: Record "Receipt Header")
    var
        RcptHdr: Record "Receipt Header";
        RcptLines: Record "Receipt Lines";
        lineNo: Integer;
    begin
        JTemplate := '';
        JBatch := '';
        RcptHdr.Reset();
        RcptHdr.SetRange("Document No.", ReceiptHeader."Document No.");
        RcptHdr.SetRange(Posted, false);
        if RcptHdr.FindSet() then begin
            RcptHdr.CalcFields("Receipt Amount");
            if RcptHdr."Receipt Amount" > 0 then begin
                if GenUserPostSetup.Get(UserId) then begin
                    JTemplate := GenUserPostSetup."Receipts Posting Template";
                    JBatch := GenUserPostSetup."Receipts Posting Batch";
                end else
                    Error(userStpErr, format(UserId));
                //clear the general journal line 
                ClearGnJrnlLine(JTemplate, JBatch);
                //create the general line

                lineNo := lineNo + 1;
                //credit
                FnCreateGjrnlLine(JTemplate, JBatch, RcptHdr."Document No.", LineNo, RcptHdr."Account Type ", RcptHdr."Account No",
                            RcptHdr."Posting Date", RcptHdr."Receipt Amount" * -1, RcptHdr."Global Dimension 1 Code", RcptHdr."Global Dimension 2 Code",
                            RcptHdr."Dimension Set ID", RcptHdr."Cheque No", RcptHdr."Transaction Description", RcptHdr."Currency Code", RcptHdr."Account Type "::"G/L Account",
                            '', RcptHdr."Currency Factor");

                RcptLines.Reset();
                RcptLines.SetRange("Doc No", RcptHdr."Document No.");
                if RcptLines.FindSet() then
                    repeat
                        //debit
                        lineNo := lineNo + 1;
                        FnCreateGjrnlLine(JTemplate, JBatch, RcptLines."Doc No", LineNo, RcptLines."Account Type", RcptLines."Account No.",
                                        RcptHdr."Posting Date", RcptLines.Amount, RcptLines."Global Dimension 1 Code", RcptLines."Global Dimension 2 Code",
                                        RcptLines."Dimension Set ID", RcptHdr."Cheque No", RcptLines."Transaction Description", RcptHdr."Currency Code", RcptHdr."Account Type "::"G/L Account", '', RcptHdr."Currency Factor");
                    until RcptLines.Next() = 0;

                if FnGjrnlinePostBatch(JTemplate, JBatch) then begin
                    RcptHdr.Posted := true;
                    RcptHdr."Posted By" := UserId;
                    RcptHdr."Posted Time" := Time;
                    RcptHdr."Posting Date" := Today;
                    RcptHdr.Modify()
                end;


            end;
        end;

    end;

    var
        userStpErr: Label 'please contact the system administator to setup user %1 under user posting setup';
        JTemplate: Code[20];
        JBatch: Code[20];
        GenUserPostSetup: Record "Gen.User Posting Setup ";


}
