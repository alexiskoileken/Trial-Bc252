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

    /// <summary>
    /// CustomApiSquare.
    /// </summary>
    procedure CustomApiSquare()
    // the get method
    var
        client: HttpClient;
        url: Text;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Result, FamilyName, Email, CompanyName, name : Text;
        JsonArr: JsonArray;
        jsonObj: JsonObject;
        jsnTkn: JsonToken;
        i: Integer;
        id: Code[100];

    begin
        url := 'https://connect.squareupsandbox.com/v2/customers';
        client.Clear();
        client.DefaultRequestHeaders.Add('Square-Version', '2025-02-20');
        client.DefaultRequestHeaders.Add('Authorization', 'Bearer EAAAl64L3yrYG7NxDC7GQMErH41EBxSvIDMJN0lKeayCO6Mn-wY9B-qLXCe0SmFn');
        client.Get(url, Response);
        if Response.IsSuccessStatusCode then begin
            Content := Response.Content;
            Content.ReadAs(Result);
            jsonObj.ReadFrom(Result);
            if jsonObj.Get('customers', jsnTkn) and jsnTkn.IsArray then begin
                JsonArr := jsnTkn.AsArray();
                for i := 0 to JsonArr.Count() - 1 do begin
                    JsonArr.Get(i, jsnTkn);
                    if jsnTkn.IsObject then begin
                        jsonObj := jsnTkn.AsObject();
                        Clear(jsnTkn);
                        jsonObj.Get('id', jsnTkn);
                        id := jsnTkn.AsValue().AsCode();
                        jsonObj.Get('given_name', jsnTkn);
                        name := jsnTkn.AsValue().AsText();
                        jsonObj.Get('company_name', jsnTkn);
                        CompanyName := jsnTkn.AsValue().AsText();
                        jsonObj.Get('email_address', jsnTkn);
                        Email := jsnTkn.AsValue().AsText();
                        jsonObj.Get('family_name', jsnTkn);
                        FamilyName := jsnTkn.AsValue().AsText();
                        Message('id: %1 name: %2 companyname: %3 email: %4 familyname: %5', id, name, CompanyName, Email, FamilyName);

                    end;
                end;
            end;
        end
        else
            Error('The Api link has  no data ');
    end;
     /// <summary>
     /// PostApiMethod.
     /// </summary>
     procedure PostApiMethod()
    //the post method
    var
        myInt: Integer;
    begin
        
    end;
}
