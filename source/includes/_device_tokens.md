# Device tokens

Use device tokens to register devices to receive push notifications.

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`environment` | **enum** <br>The environment to use.<br> One of: `development`, `production`.
`id` | **uuid** `readonly`<br>Primary key.
`kind` | **enum** <br>Kind of token.<br> One of: `apn`, `fcm`.
`token` | **string** `writeonly`<br>The token to register. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`version` | **integer** <br>The API version to use. 


## Create a device_token


> How to create a device_token:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/device_tokens'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "device_tokens",
           "attributes": {
             "token": "1234",
             "kind": "apn",
             "environment": "production"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "dfe421d9-48b8-4f03-860d-2fa6d0f0e81f",
      "type": "device_tokens",
      "attributes": {
        "created_at": "2026-10-24T10:07:02.000000+00:00",
        "updated_at": "2026-10-24T10:07:02.000000+00:00",
        "kind": "apn",
        "environment": "production",
        "version": 3
      }
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/device_tokens`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[device_tokens]=created_at,updated_at,kind`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][environment]` | **enum** <br>The environment to use.<br> One of: `development`, `production`.
`data[attributes][kind]` | **enum** <br>Kind of token.<br> One of: `apn`, `fcm`.
`data[attributes][token]` | **string** <br>The token to register. 
`data[attributes][version]` | **integer** <br>The API version to use. 


### Includes

This request does not accept any includes
## Delete a device_token


> How to delete a device_token:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/device_tokens/ab5436fd-0efe-4f10-8a1d-f1feca62c9e9'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ab5436fd-0efe-4f10-8a1d-f1feca62c9e9",
      "type": "device_tokens",
      "attributes": {
        "created_at": "2014-03-05T17:32:03.000000+00:00",
        "updated_at": "2014-03-05T17:32:03.000000+00:00",
        "kind": "apn",
        "environment": "production",
        "version": 3
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/device_tokens/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[device_tokens]=created_at,updated_at,kind`


### Includes

This request does not accept any includes