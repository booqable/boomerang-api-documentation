# Ip addresses

Restrict access by specifying allowed IP addresses. IPv4 and IPv6 addresses are supported.

## Endpoints
`GET /api/boomerang/ip_addresses`

`GET /api/boomerang/ip_addresses/{id}`

`POST /api/boomerang/ip_addresses`

`PUT /api/boomerang/ip_addresses/{id}`

`DELETE /api/boomerang/ip_addresses/{id}`

## Fields
Every ip address has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`label` | **String** <br>Label for the restricted IP address.
`address` | **String** <br>Restricted IP address.


## Listing restricted IP addresses



> How to fetch a list of restricted IP addresses:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "99c08c74-eabc-4502-be55-ac22d38abdef",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2024-06-17T09:25:55.203729+00:00",
        "updated_at": "2024-06-17T09:25:55.203729+00:00",
        "label": "John's home office",
        "address": "192.168.0.1"
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/ip_addresses`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[ip_addresses]=created_at,updated_at,label`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`label` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`address` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching restricted IP address



> How to fetch a restricted IP address:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/95cf75ab-7469-4bc5-942f-c4d62cde19d2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "95cf75ab-7469-4bc5-942f-c4d62cde19d2",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-06-17T09:25:53.693135+00:00",
      "updated_at": "2024-06-17T09:25:53.693135+00:00",
      "label": "John's home office",
      "address": "192.168.0.1"
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/ip_addresses/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[ip_addresses]=created_at,updated_at,label`


### Includes

This request does not accept any includes
## Creating restricted IP address



> How to create a restricted IP address:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "ip_addresses",
        "attributes": {
          "label": "Leeuwarden office",
          "address": "192.168.0.2"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b96ee48d-a96a-4a85-8c61-926ab641652e",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-06-17T09:25:54.159391+00:00",
      "updated_at": "2024-06-17T09:25:54.159391+00:00",
      "label": "Leeuwarden office",
      "address": "192.168.0.2"
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/ip_addresses`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[ip_addresses]=created_at,updated_at,label`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][label]` | **String** <br>Label for the restricted IP address.
`data[attributes][address]` | **String** <br>Restricted IP address.


### Includes

This request does not accept any includes
## Updating restricted IP address



> How to update a restricted IP address:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/38214bc7-bd3f-4590-b424-ec421d2e9975' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "38214bc7-bd3f-4590-b424-ec421d2e9975",
        "type": "ip_addresses",
        "attributes": {
          "label": "Palo Alto office",
          "address": "192.168.0.3"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "38214bc7-bd3f-4590-b424-ec421d2e9975",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-06-17T09:25:54.652636+00:00",
      "updated_at": "2024-06-17T09:25:54.691567+00:00",
      "label": "Palo Alto office",
      "address": "192.168.0.3"
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/ip_addresses/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[ip_addresses]=created_at,updated_at,label`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][label]` | **String** <br>Label for the restricted IP address.
`data[attributes][address]` | **String** <br>Restricted IP address.


### Includes

This request does not accept any includes
## Deleting restricted IP address



> How to delete a restricted IP address:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/44140078-c2ed-4d24-b67e-9917d20287e4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44140078-c2ed-4d24-b67e-9917d20287e4",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-06-17T09:25:55.753077+00:00",
      "updated_at": "2024-06-17T09:25:55.753077+00:00",
      "label": "John's home office",
      "address": "192.168.0.1"
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/ip_addresses/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[ip_addresses]=created_at,updated_at,label`


### Includes

This request does not accept any includes