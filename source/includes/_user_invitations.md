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
          "user_id": "8a7b182c-6a34-4cb7-b807-4d7df847e8ad"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a39feb91-bbca-5635-b4c5-0ffde6826bee",
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