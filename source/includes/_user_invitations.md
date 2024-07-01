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
          "user_id": "cff4f93e-71e8-4cc1-ba1d-1e8aff3fbf45"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d3107b0f-de9d-5005-958b-27a98fc8dadf",
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