# User invitations

Creating a user will send an invitation to the user.
If that email message is lost or deleted, use this to resend the invitation email
so the user can confirm their email before the account is active.

## Fields
Every user invitation has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`user_id` | **Uuid** `writeonly`<br>The user to send the invitation to.


## Re-inviting a user



> How to re-invite a user:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/user_invitations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "user_invitations",
        "attributes": {
          "user_id": "647c8124-c490-42c2-a923-b02958679488"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ee9f6622-057f-5148-bca1-49016386e25c",
    "type": "user_invitations"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/user_invitations`

### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][user_id]` | **Uuid** <br>The user to send the invitation to.


### Includes

This request does not accept any includes