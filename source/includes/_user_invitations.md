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
          "user_id": "00dfe5da-59f5-446b-b0a5-30ec2d1cde78"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0798f629-65e3-585f-a1fb-46d520571b28",
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