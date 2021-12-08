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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`label` | **String**<br>Label for the restricted IP address.
`address` | **String**<br>Restricted IP address.


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
      "id": "8146bfbc-f4fb-4baa-833c-773d42c512fe",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2021-12-08T12:34:34+00:00",
        "updated_at": "2021-12-08T12:34:34+00:00",
        "label": "John's home office",
        "address": "192.168.0.1"
      }
    }
  ],
  "links": {
    "self": "api/boomerang/ip_addresses?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/ip_addresses?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/ip_addresses?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/ip_addresses`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[ip_addresses]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`label` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`address` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching restricted IP address



> How to fetch a restricted IP address:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/aea91367-940b-4cba-b718-c21caaaaf50e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aea91367-940b-4cba-b718-c21caaaaf50e",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2021-12-08T12:34:34+00:00",
      "updated_at": "2021-12-08T12:34:34+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[ip_addresses]=id,created_at,updated_at`


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
    "id": "5a797b13-99c4-40be-9e31-52220af5816e",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2021-12-08T12:34:35+00:00",
      "updated_at": "2021-12-08T12:34:35+00:00",
      "label": "Leeuwarden office",
      "address": "192.168.0.2"
    }
  },
  "links": {
    "self": "api/boomerang/ip_addresses?data%5Battributes%5D%5Baddress%5D=192.168.0.2&data%5Battributes%5D%5Blabel%5D=Leeuwarden+office&data%5Btype%5D=ip_addresses&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/ip_addresses?data%5Battributes%5D%5Baddress%5D=192.168.0.2&data%5Battributes%5D%5Blabel%5D=Leeuwarden+office&data%5Btype%5D=ip_addresses&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/ip_addresses?data%5Battributes%5D%5Baddress%5D=192.168.0.2&data%5Battributes%5D%5Blabel%5D=Leeuwarden+office&data%5Btype%5D=ip_addresses&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/ip_addresses`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[ip_addresses]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][label]` | **String**<br>Label for the restricted IP address.
`data[attributes][address]` | **String**<br>Restricted IP address.


### Includes

This request does not accept any includes
## Updating restricted IP address



> How to update a restricted IP address:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/2d60a1cf-d461-43e6-921c-9a4e8634d0ef' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d60a1cf-d461-43e6-921c-9a4e8634d0ef",
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
    "id": "2d60a1cf-d461-43e6-921c-9a4e8634d0ef",
    "type": "ip_addresses",
    "attributes": {
      "created_at": "2021-12-08T12:34:35+00:00",
      "updated_at": "2021-12-08T12:34:35+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[ip_addresses]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][label]` | **String**<br>Label for the restricted IP address.
`data[attributes][address]` | **String**<br>Restricted IP address.


### Includes

This request does not accept any includes
## Deleting restricted IP address



> How to delete a restricted IP address:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/ip_addresses/fd417e91-263b-4b4f-8786-e69972279727' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/ip_addresses/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[ip_addresses]=id,created_at,updated_at`


### Includes

This request does not accept any includes