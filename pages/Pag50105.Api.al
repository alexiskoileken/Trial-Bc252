namespace TrialVersion.TrialVersion;

page 50105 "Api "
{
    ApplicationArea = All;
    Caption = 'Api ';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Api;
    CardPageId = "Api card";

    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field(Id; Rec.Id)
                {
                    ToolTip = 'Specifies the value of the Id field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Api)
            {
                ApplicationArea = All;
                Caption = 'API', comment = 'NLB="YourLanguageCaption"';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Client: HttpClient;
                    HttpResponseMsg: HttpResponseMessage;
                    Content: HttpContent;
                    Data: Text;
                begin
                    if not Client.Get('https://fake-json-api.mock.beeceptor.com/users', HttpResponseMsg) then
                        Error('No Api of Type is Found');

                    if HttpResponseMsg.IsSuccessStatusCode then begin
                        HttpResponseMsg.Content().ReadAs(Data);
                        Message(Data);
                    end else
                        Error('Failed to get a successful response from the API');
                end;
            }
        }
    }
}
