namespace TrialVersion.TrialVersion;

page 50115 "Posting DatePage"
{
    ApplicationArea = All;
    Caption = 'Posting DatePage';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(PostingDate; PostingDate)
            {
                ApplicationArea = all;
            }
        }
    }
    var
        PostingDate: Date;

    /// <summary>
    /// fnGetPostngDte.
    /// </summary>
    /// <returns>Return value of type Date.</returns>
    procedure fnGetPostngDte(): Date
    var
        myInt: Integer;
    begin
        exit(PostingDate);
    end;
}
