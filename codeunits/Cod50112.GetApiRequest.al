/// <summary>
/// Unknown TrialVersion.
/// </summary>
namespace TrialVersion.TrialVersion;

codeunit 50112 GetApiRequest
{
    /// <summary>
    /// GetLinkData.
    /// </summary>
    /// <param name="Var Api">Record Api.</param>
    procedure GetLinkData(Var Api: Record Api)
    var
        UsersJobjct: JsonObject;
        Result: Text;
        client: HttpClient;
        Httpresponse: HttpResponseMessage;
        JsnTkn: JsonToken;
        Content: HttpContent;
        UsersArray: JsonArray;
        i: Integer;
    begin
        client.Get('https://fake-json-api.mock.beeceptor.com/users' + Format(Api.Id), Httpresponse);
        if Httpresponse.IsSuccessStatusCode then begin
            Content := Httpresponse.Content;
            Content.ReadAs(Result);

            if UsersArray.ReadFrom(Result) then begin
                for i := 0 to UsersArray.Count() - 1 do begin
                    UsersArray.Get(i, JsnTkn);

                    if JsnTkn.IsObject() then begin
                        UsersJobjct := JsnTkn.AsObject();

                        UsersJobjct.Get('name', JsnTkn);
                        Api.Name := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('company', JsnTkn);
                        Api.Company := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('username', JsnTkn);
                        Api.UserName := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('email', JsnTkn);
                        Api.Email := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('address', JsnTkn);
                        Api.Address := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('zip', JsnTkn);
                        Api.Zip := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('state', JsnTkn);
                        Api.State := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('country', JsnTkn);
                        Api.Country := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('phone', JsnTkn);
                        Api.Phone := JsnTkn.AsValue().AsText();
                        UsersJobjct.Get('photo', JsnTkn);
                        Api.Photo := JsnTkn.AsValue().AsText();
                    end;
                end;
            end;
        end;
    end;
}
