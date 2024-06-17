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
    "id": "13fe3335-2a67-4735-a902-55a3c08b5d22",
    "type": "device_tokens",
    "attributes": {
      "created_at": "2024-06-17T09:24:40.817210+00:00",
      "updated_at": "2024-06-17T09:24:40.817210+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/device_tokens/f2f1c295-a98d-44fc-bf32-2d807f85e36e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f2f1c295-a98d-44fc-bf32-2d807f85e36e",
    "type": "device_tokens",
    "attributes": {
      "created_at": "2024-06-17T09:24:41.314270+00:00",
      "updated_at": "2024-06-17T09:24:41.314270+00:00",
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