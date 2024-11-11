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
      "id": "6e8c8529-fd54-4a37-a242-ac6836168599",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2024-11-11T09:25:28.982034+00:00",
        "updated_at": "2024-11-11T09:25:28.982034+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/1905bc35-0f2b-4eba-9e49-e72693905ad4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1905bc35-0f2b-4eba-9e49-e72693905ad4",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-11-11T09:25:30.641297+00:00",
      "updated_at": "2024-11-11T09:25:30.641297+00:00",
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
    "id": "d6317431-78b2-4887-9b01-1bbfc8de24b6",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-11-11T09:25:30.096276+00:00",
      "updated_at": "2024-11-11T09:25:30.096276+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/fc66f7b8-b461-451f-a551-c1a0071bd0fc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fc66f7b8-b461-451f-a551-c1a0071bd0fc",
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
    "id": "fc66f7b8-b461-451f-a551-c1a0071bd0fc",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-11-11T09:25:28.423312+00:00",
      "updated_at": "2024-11-11T09:25:28.450198+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/c7c3c984-aafb-4253-ae23-b5ada5b4f5db' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c7c3c984-aafb-4253-ae23-b5ada5b4f5db",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2024-11-11T09:25:29.526636+00:00",
      "updated_at": "2024-11-11T09:25:29.526636+00:00",
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