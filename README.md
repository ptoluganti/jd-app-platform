## Features

This example covers the following use cases:

* Azure Container App to Azure API Management authentication using a Managed Identity.
* Azure API Management to Azure Container App authentication using a Managed Identity.


curl -X POST -d "client_id=YOUR_CLIENT_ID&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&code=AUTHORIZATION_CODE&redirect_uri=https%3A%2F%2Fyourapp.com%2Fcallback&grant_type=authorization_code&client_secret=YOUR_CLIENT_SECRET" https://login.microsoftonline.com/common/oauth2/v2.0/token
