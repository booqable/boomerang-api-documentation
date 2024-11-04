# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

Note that when using URLs as numbers, it's advised to base64 encode the number before filtering.

## Endpoints
`GET /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
-- | --
`owner` | **Customer, Product, Order, Stock item** <br>Associated Owner


## Listing barcodes



> How to fetch a list of barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4e09cfe1-17ad-4f10-8495-00d57fe78297",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-04T09:24:46.575526+00:00",
        "updated_at": "2024-11-04T09:24:46.575526+00:00",
        "number": "http://bqbl.it/4e09cfe1-17ad-4f10-8495-00d57fe78297",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-87.lvh.me:/barcodes/4e09cfe1-17ad-4f10-8495-00d57fe78297/image",
        "owner_id": "775dd370-8032-4d0f-a755-3194c7208259",
        "owner_type": "customers"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fda6a0c1d-f7d5-4252-8824-c56908b2af7c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "da6a0c1d-f7d5-4252-8824-c56908b2af7c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-04T09:24:47.778409+00:00",
        "updated_at": "2024-11-04T09:24:47.778409+00:00",
        "number": "http://bqbl.it/da6a0c1d-f7d5-4252-8824-c56908b2af7c",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-89.lvh.me:/barcodes/da6a0c1d-f7d5-4252-8824-c56908b2af7c/image",
        "owner_id": "62a02ede-4d63-4fd9-b794-bff070662c10",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "62a02ede-4d63-4fd9-b794-bff070662c10"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "62a02ede-4d63-4fd9-b794-bff070662c10",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-04T09:24:47.735102+00:00",
        "updated_at": "2024-11-04T09:24:47.780266+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-39@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTZjYzc2NDgtMmI2Ni00OTE2LTk0OGMtZGFhNjBjNDZhYmIy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "16cc7648-2b66-4916-948c-daa60c46abb2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-04T09:24:47.229243+00:00",
        "updated_at": "2024-11-04T09:24:47.229243+00:00",
        "number": "http://bqbl.it/16cc7648-2b66-4916-948c-daa60c46abb2",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-88.lvh.me:/barcodes/16cc7648-2b66-4916-948c-daa60c46abb2/image",
        "owner_id": "b0b53144-0150-43a6-b687-b24deabd121c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "b0b53144-0150-43a6-b687-b24deabd121c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b0b53144-0150-43a6-b687-b24deabd121c",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-04T09:24:47.179542+00:00",
        "updated_at": "2024-11-04T09:24:47.230804+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-38@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
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
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/15246ca4-80a8-4622-80fb-55c158eecaab?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15246ca4-80a8-4622-80fb-55c158eecaab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-04T09:24:48.992499+00:00",
      "updated_at": "2024-11-04T09:24:48.992499+00:00",
      "number": "http://bqbl.it/15246ca4-80a8-4622-80fb-55c158eecaab",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-91.lvh.me:/barcodes/15246ca4-80a8-4622-80fb-55c158eecaab/image",
      "owner_id": "bcffaf08-d3bc-48c8-8bb1-5a4bb28cdf2a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "bcffaf08-d3bc-48c8-8bb1-5a4bb28cdf2a"
        }
      }
    }
  },
  "included": [
    {
      "id": "bcffaf08-d3bc-48c8-8bb1-5a4bb28cdf2a",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-04T09:24:48.954840+00:00",
        "updated_at": "2024-11-04T09:24:48.994352+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-41@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Creating a barcode



> How to create a barcode:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/barcodes' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "barcodes",
        "attributes": {
          "barcode_type": "qr_code",
          "owner_id": "7f6aef02-8826-4efe-94f5-ba1c98761ae0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "36ba6a7a-403f-4f73-93d0-2b045214f90d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-04T09:24:46.027391+00:00",
      "updated_at": "2024-11-04T09:24:46.027391+00:00",
      "number": "http://bqbl.it/36ba6a7a-403f-4f73-93d0-2b045214f90d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-86.lvh.me:/barcodes/36ba6a7a-403f-4f73-93d0-2b045214f90d/image",
      "owner_id": "7f6aef02-8826-4efe-94f5-ba1c98761ae0",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/54e1ece9-4e1c-43e7-af07-e6d5b95d453d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "54e1ece9-4e1c-43e7-af07-e6d5b95d453d",
        "type": "barcodes",
        "attributes": {
          "number": "https://myfancysite.com"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "54e1ece9-4e1c-43e7-af07-e6d5b95d453d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-04T09:24:45.265813+00:00",
      "updated_at": "2024-11-04T09:24:45.342445+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-85.lvh.me:/barcodes/54e1ece9-4e1c-43e7-af07-e6d5b95d453d/image",
      "owner_id": "da8d3c4e-7d24-401d-90b8-8fc52bd364b9",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/d6691100-214b-4a00-9a83-e54340e9b3b6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d6691100-214b-4a00-9a83-e54340e9b3b6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-04T09:24:48.344067+00:00",
      "updated_at": "2024-11-04T09:24:48.344067+00:00",
      "number": "http://bqbl.it/d6691100-214b-4a00-9a83-e54340e9b3b6",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-90.lvh.me:/barcodes/d6691100-214b-4a00-9a83-e54340e9b3b6/image",
      "owner_id": "47608ec2-19bf-4078-be40-6c2cbfd1729c",
      "owner_type": "customers"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`









