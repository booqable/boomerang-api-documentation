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
      "id": "cb1bd46b-eefb-4f9b-9dce-d7f2c1914989",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-11T09:27:56.048009+00:00",
        "updated_at": "2024-11-11T09:27:56.048009+00:00",
        "number": "http://bqbl.it/cb1bd46b-eefb-4f9b-9dce-d7f2c1914989",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-261.lvh.me:/barcodes/cb1bd46b-eefb-4f9b-9dce-d7f2c1914989/image",
        "owner_id": "33dc0731-791b-4d98-ad4f-cc976731b98b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3fec859b-3f38-408b-be60-c0e2ad8f96af&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3fec859b-3f38-408b-be60-c0e2ad8f96af",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-11T09:27:55.411569+00:00",
        "updated_at": "2024-11-11T09:27:55.411569+00:00",
        "number": "http://bqbl.it/3fec859b-3f38-408b-be60-c0e2ad8f96af",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-260.lvh.me:/barcodes/3fec859b-3f38-408b-be60-c0e2ad8f96af/image",
        "owner_id": "ac0db166-0a5d-42e1-81c9-5eca73c787ba",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "ac0db166-0a5d-42e1-81c9-5eca73c787ba"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ac0db166-0a5d-42e1-81c9-5eca73c787ba",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-11T09:27:55.369973+00:00",
        "updated_at": "2024-11-11T09:27:55.413654+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-68@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYThmYzI4MmUtMGEzZS00NGZmLWIyYmQtM2NiMmIzODk0N2Yy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a8fc282e-0a3e-44ff-b2bd-3cb2b38947f2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-11T09:27:57.121066+00:00",
        "updated_at": "2024-11-11T09:27:57.121066+00:00",
        "number": "http://bqbl.it/a8fc282e-0a3e-44ff-b2bd-3cb2b38947f2",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-262.lvh.me:/barcodes/a8fc282e-0a3e-44ff-b2bd-3cb2b38947f2/image",
        "owner_id": "9e422e73-6923-4482-b3d9-172bbd352986",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "9e422e73-6923-4482-b3d9-172bbd352986"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9e422e73-6923-4482-b3d9-172bbd352986",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-11T09:27:57.082182+00:00",
        "updated_at": "2024-11-11T09:27:57.122675+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-71@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2c762dc7-630d-40d2-a80e-fded24518e57?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c762dc7-630d-40d2-a80e-fded24518e57",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-11T09:27:59.639649+00:00",
      "updated_at": "2024-11-11T09:27:59.639649+00:00",
      "number": "http://bqbl.it/2c762dc7-630d-40d2-a80e-fded24518e57",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-266.lvh.me:/barcodes/2c762dc7-630d-40d2-a80e-fded24518e57/image",
      "owner_id": "7ca6fb8e-56ab-46da-b1ee-676dcdff3d6b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "7ca6fb8e-56ab-46da-b1ee-676dcdff3d6b"
        }
      }
    }
  },
  "included": [
    {
      "id": "7ca6fb8e-56ab-46da-b1ee-676dcdff3d6b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-11T09:27:59.594473+00:00",
        "updated_at": "2024-11-11T09:27:59.641601+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-76@doe.test",
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
          "owner_id": "f6b37d08-612e-4705-98d7-73c7cad3d313",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "59e1e8fc-8842-4995-8aad-11a00b1221f6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-11T09:27:59.041516+00:00",
      "updated_at": "2024-11-11T09:27:59.041516+00:00",
      "number": "http://bqbl.it/59e1e8fc-8842-4995-8aad-11a00b1221f6",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-265.lvh.me:/barcodes/59e1e8fc-8842-4995-8aad-11a00b1221f6/image",
      "owner_id": "f6b37d08-612e-4705-98d7-73c7cad3d313",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/da7633d9-71ba-4e96-8dae-82e7a1959709' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "da7633d9-71ba-4e96-8dae-82e7a1959709",
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
    "id": "da7633d9-71ba-4e96-8dae-82e7a1959709",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-11T09:27:58.306395+00:00",
      "updated_at": "2024-11-11T09:27:58.375449+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-264.lvh.me:/barcodes/da7633d9-71ba-4e96-8dae-82e7a1959709/image",
      "owner_id": "6203590a-4250-47c4-bf5d-69e97b2177f5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5f4eaf84-39ee-4651-b87c-f66693cd14c1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f4eaf84-39ee-4651-b87c-f66693cd14c1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-11T09:27:57.614215+00:00",
      "updated_at": "2024-11-11T09:27:57.614215+00:00",
      "number": "http://bqbl.it/5f4eaf84-39ee-4651-b87c-f66693cd14c1",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-263.lvh.me:/barcodes/5f4eaf84-39ee-4651-b87c-f66693cd14c1/image",
      "owner_id": "2a91a976-99c0-40d2-92ea-ab19995e2115",
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









