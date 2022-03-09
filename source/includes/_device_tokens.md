# Device tokens

Use device tokens to register devices to receive push notifications.

## Endpoints
`POST /api/boomerang/device_tokens`

`DELETE /api/boomerang/device_tokens/{id}`

## Fields
Every device token has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`token` | **String** `writeonly`<br>The token to register
`kind` | **String**<br>Kind of token. One of `apn`, `fcm`
`environment` | **String**<br>The enviroment to use. One of `development`, `production`


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
    "id": "2ef6c4ba-1ede-4a20-9be4-7cf2e6d2bc37",
    "type": "device_tokens",
    "attributes": {
      "created_at": "2022-03-09T10:02:06+00:00",
      "updated_at": "2022-03-09T10:02:06+00:00",
      "kind": "apn",
      "environment": "production"
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/device_tokens`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[device_tokens]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][token]` | **String**<br>The token to register
`data[attributes][kind]` | **String**<br>Kind of token. One of `apn`, `fcm`
`data[attributes][environment]` | **String**<br>The enviroment to use. One of `development`, `production`


### Includes

This request does not accept any includes
## Deleting a device_token



> How to delete a device_token:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/device_tokens/6c839131-cb81-42d9-a10a-0e82b02cb143' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/device_tokens/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[device_tokens]=id,created_at,updated_at`


### Includes

This request does not accept any includes