# Ip addresses

Restrict access by specifying allowed IP addresses.
Both IPv4 and IPv6 addresses are supported.

<aside class="notice">
  Availability of IP restrictions depends on the current pricing plan.
</aside>

## Fields

 Name | Description
-- | --
`address` | **string** <br>Restricted IP address.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`label` | **string** <br>Label for the restricted IP address.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List restricted IP addresses


> How to fetch a list of restricted IP addresses:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/ip_addresses'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "56891a67-25ab-4a95-8ecf-e0e0e5bc05e3",
        "type": "ip_addresses",
        "attributes": {
          "created_at": "2020-05-02T21:57:09.000000+00:00",
          "updated_at": "2020-05-02T21:57:09.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[ip_addresses]=created_at,updated_at,label`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`address` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`label` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch restricted IP address


> How to fetch a restricted IP address:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/ip_addresses/fa72089f-0fe9-40f4-8c62-f6b1933a6621'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "fa72089f-0fe9-40f4-8c62-f6b1933a6621",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2028-01-24T23:24:01.000000+00:00",
        "updated_at": "2028-01-24T23:24:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[ip_addresses]=created_at,updated_at,label`


### Includes

This request does not accept any includes
## Create restricted IP address


> How to create a restricted IP address:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/ip_addresses'
       --header 'content-type: application/json'
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
      "id": "b283adb6-46d4-4b2c-8ba3-067006a0ab84",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2023-04-04T06:12:01.000000+00:00",
        "updated_at": "2023-04-04T06:12:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[ip_addresses]=created_at,updated_at,label`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address]` | **string** <br>Restricted IP address.
`data[attributes][label]` | **string** <br>Label for the restricted IP address.


### Includes

This request does not accept any includes
## Update restricted IP address


> How to update a restricted IP address:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/ip_addresses/c5fee425-e443-4e0a-8fb7-7ec6a623c577'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "c5fee425-e443-4e0a-8fb7-7ec6a623c577",
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
      "id": "c5fee425-e443-4e0a-8fb7-7ec6a623c577",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2023-11-07T01:02:01.000000+00:00",
        "updated_at": "2023-11-07T01:02:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[ip_addresses]=created_at,updated_at,label`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address]` | **string** <br>Restricted IP address.
`data[attributes][label]` | **string** <br>Label for the restricted IP address.


### Includes

This request does not accept any includes
## Delete restricted IP address


> How to delete a restricted IP address:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/ip_addresses/d0fa7dac-507f-4565-8815-4323b15d02ba'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "d0fa7dac-507f-4565-8815-4323b15d02ba",
      "type": "ip_addresses",
      "attributes": {
        "created_at": "2028-12-18T15:52:01.000000+00:00",
        "updated_at": "2028-12-18T15:52:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[ip_addresses]=created_at,updated_at,label`


### Includes

This request does not accept any includes