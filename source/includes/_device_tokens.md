# Device tokens

Use device tokens to register devices to receive push notifications.

## Endpoints
`POST /api/boomerang/device_tokens`

`DELETE /api/boomerang/device_tokens/{id}`

## Fields
Every device token has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`token` | **String** `writeonly`<br>The token to register
`kind` | **String** <br>Kind of token. One of `apn`, `fcm`
`environment` | **String** <br>The enviroment to use. One of `development`, `production`
`version` | **Integer** <br>The API version to use


## Creating a device_token



> How to create a device_token:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/device_tokens' \
    --header 'content-type: application/json' \
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
    "id": "2fbf5174-dff1-4bea-947b-cbceee724f9c",
    "type": "device_tokens",
    "attributes": {
      "created_at": "2024-10-28T09:31:10.219953+00:00",
      "updated_at": "2024-10-28T09:31:10.219953+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[device_tokens]=created_at,updated_at,kind`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][token]` | **String** <br>The token to register
`data[attributes][kind]` | **String** <br>Kind of token. One of `apn`, `fcm`
`data[attributes][environment]` | **String** <br>The enviroment to use. One of `development`, `production`
`data[attributes][version]` | **Integer** <br>The API version to use


### Includes

This request does not accept any includes
## Deleting a device_token



> How to delete a device_token:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/device_tokens/ce577368-a1d9-447b-a292-692e396f3b6d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ce577368-a1d9-447b-a292-692e396f3b6d",
    "type": "device_tokens",
    "attributes": {
      "created_at": "2024-10-28T09:31:09.254773+00:00",
      "updated_at": "2024-10-28T09:31:09.254773+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[device_tokens]=created_at,updated_at,kind`


### Includes

This request does not accept any includes