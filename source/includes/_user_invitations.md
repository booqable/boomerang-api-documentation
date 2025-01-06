# User invitations

Creating a user will send an invitation to the user.
If that email message is lost or deleted, use this to resend the invitation email
so the user can confirm their email before the account is active.

## Relationships
Name | Description
-- | --
`user` | **[User](#users)** `required`<br>The user to send the invitation to.


Check matching attributes under [Fields](#user-invitations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`user_id` | **uuid** <br>The user to send the invitation to.


## Re-invite a user


> How to re-invite a user:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/user_invitations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "user_invitations",
           "attributes": {
             "user_id": "c8075239-a5b3-4523-8ca2-84e0023813d1"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "32dbf20f-66cb-4977-88ec-8ec42fbddc6a",
      "type": "user_invitations",
      "attributes": {
        "user_id": "c8075239-a5b3-4523-8ca2-84e0023813d1"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/user_invitations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[user_invitations]=user_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][user_id]` | **uuid** <br>The user to send the invitation to.


### Includes

This request does not accept any includes