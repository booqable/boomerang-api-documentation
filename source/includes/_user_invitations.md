# User invitations

Creating a user will send an invitation to the user.
If that email message is lost or deleted, use this to resend the invitation email
so the user can confirm their email before the account is active.

## Fields
Every user invitation has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
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
          "user_id": "5e7a0c5c-4b95-4f7b-96e3-ac4f348a997a"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0678d8a5-1774-57d7-9d19-476a8f1514c1",
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