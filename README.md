## Features

This example covers the following use cases:

* Azure Container App to Azure API Management authentication using a Managed Identity.
* Azure API Management to Azure Container App authentication using a Managed Identity.


curl -X POST -d "client_id=YOUR_CLIENT_ID&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&code=AUTHORIZATION_CODE&redirect_uri=https%3A%2F%2Fyourapp.com%2Fcallback&grant_type=authorization_code&client_secret=YOUR_CLIENT_SECRET" https://login.microsoftonline.com/common/oauth2/v2.0/token


``` python

import msal

api_scopes = ["api://234324/.default"]
tenant_id = ""
client_id = ""
client_secret = ""

redirect_uri = "http://localhost"
app = msal.ConfidentialClientApplication(
    client_id=client_id,
    client_credential=client_secret,
    authority=f"https://login.microsoftonline.com/{tenant_id}"
)

result = app.acquire_token_for_client(scopes=api_scopes)
print(result["access_token"])

```

``` powershell
using Microsoft.Identity.Client;

var apiScopes = new[] { "api:///.default" };
//var appScopes = new[] { "api:///App01Call" };

var tenantId = "";
var clientId = "";
var clientSecret = "";

//var url = "htts://";

string redirectUri = "http://localhost";
var app = ConfidentialClientApplicationBuilder.Create(clientId)
    .WithClientSecret(clientSecret)
    .WithRedirectUri(redirectUri)
    .WithTenantId(tenantId)
    .Build();


var result = await app.AcquireTokenForClient(apiScopes).ExecuteAsync();
Console.WriteLine(result.AccessToken);
```
