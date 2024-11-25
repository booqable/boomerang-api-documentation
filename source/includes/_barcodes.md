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
      "id": "09376e9f-3027-4c8d-9f80-a0304fb2abad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-25T09:27:34.634376+00:00",
        "updated_at": "2024-11-25T09:27:34.634376+00:00",
        "number": "http://bqbl.it/09376e9f-3027-4c8d-9f80-a0304fb2abad",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-116.lvh.me:/barcodes/09376e9f-3027-4c8d-9f80-a0304fb2abad/image",
        "owner_id": "c69b1ca8-0971-489d-81ca-f134a66d3402",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc87df48a-be2c-44b8-b6e3-c139bba12917&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c87df48a-be2c-44b8-b6e3-c139bba12917",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-25T09:27:33.888903+00:00",
        "updated_at": "2024-11-25T09:27:33.888903+00:00",
        "number": "http://bqbl.it/c87df48a-be2c-44b8-b6e3-c139bba12917",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-115.lvh.me:/barcodes/c87df48a-be2c-44b8-b6e3-c139bba12917/image",
        "owner_id": "2363d50c-5fb9-4955-a365-a24463df86f1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "2363d50c-5fb9-4955-a365-a24463df86f1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2363d50c-5fb9-4955-a365-a24463df86f1",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-25T09:27:33.837393+00:00",
        "updated_at": "2024-11-25T09:27:33.892146+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-31@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjc4MWNjOWMtMGVhYy00NWRmLTkzNWYtMjUzOWVjNzg5ZTcw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f781cc9c-0eac-45df-935f-2539ec789e70",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-25T09:27:35.516138+00:00",
        "updated_at": "2024-11-25T09:27:35.516138+00:00",
        "number": "http://bqbl.it/f781cc9c-0eac-45df-935f-2539ec789e70",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-117.lvh.me:/barcodes/f781cc9c-0eac-45df-935f-2539ec789e70/image",
        "owner_id": "4f8ff125-e1df-4351-adbd-5f9c59afd560",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "4f8ff125-e1df-4351-adbd-5f9c59afd560"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4f8ff125-e1df-4351-adbd-5f9c59afd560",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-25T09:27:35.464069+00:00",
        "updated_at": "2024-11-25T09:27:35.518359+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-34@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/64b914cf-fdf4-43fe-af8c-4e6f951e3e7d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "64b914cf-fdf4-43fe-af8c-4e6f951e3e7d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-25T09:27:32.327283+00:00",
      "updated_at": "2024-11-25T09:27:32.327283+00:00",
      "number": "http://bqbl.it/64b914cf-fdf4-43fe-af8c-4e6f951e3e7d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-113.lvh.me:/barcodes/64b914cf-fdf4-43fe-af8c-4e6f951e3e7d/image",
      "owner_id": "508c4097-b6df-42df-b893-45f9bf0db6d1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "508c4097-b6df-42df-b893-45f9bf0db6d1"
        }
      }
    }
  },
  "included": [
    {
      "id": "508c4097-b6df-42df-b893-45f9bf0db6d1",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-25T09:27:32.270184+00:00",
        "updated_at": "2024-11-25T09:27:32.329571+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-29@doe.test",
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
          "owner_id": "9f64e6f5-3b50-4c9c-841d-ad1f42ef7309",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7d47d5c5-8e1f-4169-ad87-4ce656e68922",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-25T09:27:37.231321+00:00",
      "updated_at": "2024-11-25T09:27:37.231321+00:00",
      "number": "http://bqbl.it/7d47d5c5-8e1f-4169-ad87-4ce656e68922",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-119.lvh.me:/barcodes/7d47d5c5-8e1f-4169-ad87-4ce656e68922/image",
      "owner_id": "9f64e6f5-3b50-4c9c-841d-ad1f42ef7309",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8fbaccf8-bea6-4807-b7f1-83ba68e63cc1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8fbaccf8-bea6-4807-b7f1-83ba68e63cc1",
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
    "id": "8fbaccf8-bea6-4807-b7f1-83ba68e63cc1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-25T09:27:36.271452+00:00",
      "updated_at": "2024-11-25T09:27:36.385599+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-118.lvh.me:/barcodes/8fbaccf8-bea6-4807-b7f1-83ba68e63cc1/image",
      "owner_id": "57be6fe1-b664-40c2-9ce1-2a3031d04dbd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1d50acb5-2b77-4ab0-ae1c-c4ab35aa4df0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1d50acb5-2b77-4ab0-ae1c-c4ab35aa4df0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-25T09:27:33.124225+00:00",
      "updated_at": "2024-11-25T09:27:33.124225+00:00",
      "number": "http://bqbl.it/1d50acb5-2b77-4ab0-ae1c-c4ab35aa4df0",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-114.lvh.me:/barcodes/1d50acb5-2b77-4ab0-ae1c-c4ab35aa4df0/image",
      "owner_id": "1983db00-d6b8-4c9f-81d5-4d8eeb4c5ea1",
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









