FORMAT: 1A

# LintCI API

Provides access to lint results.

# Group Authentication

## Token [/api/v1/token]

A token is necessary to make other API calls.

### Create a token [POST]

Exchanges a Github access code for a LintCI token, which can be used to make other API calls.

+ Request Create JSON Message

  + Headers

    Accept: application/json

  + Body (application/json)

    {
      "code": "987654321"
    }

+ Response 200 (application/json)

    {
      "access_token": "123456789",
      "expires_in": 2592000,
      "user_id": 1
    }
