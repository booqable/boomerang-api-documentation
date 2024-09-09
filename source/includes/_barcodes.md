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
      "id": "9ffeb4bd-621c-408b-a477-a473a1dbb58e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-09T09:25:59.551267+00:00",
        "updated_at": "2024-09-09T09:25:59.551267+00:00",
        "number": "http://bqbl.it/9ffeb4bd-621c-408b-a477-a473a1dbb58e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-181.lvh.me:/barcodes/9ffeb4bd-621c-408b-a477-a473a1dbb58e/image",
        "owner_id": "fda50629-b298-401b-9246-158666433a42",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F823d5689-a2dc-4f05-ba22-4de490a70674&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "823d5689-a2dc-4f05-ba22-4de490a70674",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-09T09:26:00.788456+00:00",
        "updated_at": "2024-09-09T09:26:00.788456+00:00",
        "number": "http://bqbl.it/823d5689-a2dc-4f05-ba22-4de490a70674",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-183.lvh.me:/barcodes/823d5689-a2dc-4f05-ba22-4de490a70674/image",
        "owner_id": "601f29da-1d21-4ab4-820a-88560e9d9dc7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "601f29da-1d21-4ab4-820a-88560e9d9dc7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "601f29da-1d21-4ab4-820a-88560e9d9dc7",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-09T09:26:00.746283+00:00",
        "updated_at": "2024-09-09T09:26:00.790181+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-80@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMGZmYjU4YjMtY2IwYy00OWJmLTg0NzYtMDA3MGI4YWNhOTlm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0ffb58b3-cb0c-49bf-8476-0070b8aca99f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-09-09T09:26:00.221126+00:00",
        "updated_at": "2024-09-09T09:26:00.221126+00:00",
        "number": "http://bqbl.it/0ffb58b3-cb0c-49bf-8476-0070b8aca99f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-182.lvh.me:/barcodes/0ffb58b3-cb0c-49bf-8476-0070b8aca99f/image",
        "owner_id": "82e1dfb2-4d4a-4bb8-9e3d-1c155b87cf93",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "82e1dfb2-4d4a-4bb8-9e3d-1c155b87cf93"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "82e1dfb2-4d4a-4bb8-9e3d-1c155b87cf93",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-09T09:26:00.188622+00:00",
        "updated_at": "2024-09-09T09:26:00.222570+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-79@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/54fdd798-4a04-4e5d-84fd-0b058f715b29?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "54fdd798-4a04-4e5d-84fd-0b058f715b29",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-09T09:25:58.977558+00:00",
      "updated_at": "2024-09-09T09:25:58.977558+00:00",
      "number": "http://bqbl.it/54fdd798-4a04-4e5d-84fd-0b058f715b29",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-180.lvh.me:/barcodes/54fdd798-4a04-4e5d-84fd-0b058f715b29/image",
      "owner_id": "e73e8fad-ee9f-4fb4-9ce2-0b0e8530c768",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "e73e8fad-ee9f-4fb4-9ce2-0b0e8530c768"
        }
      }
    }
  },
  "included": [
    {
      "id": "e73e8fad-ee9f-4fb4-9ce2-0b0e8530c768",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-09T09:25:58.941645+00:00",
        "updated_at": "2024-09-09T09:25:58.985204+00:00",
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
          "owner_id": "352e6b81-88b8-483c-9e5b-e2b9042cb373",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "79a8f410-6dd6-4e60-a31c-ba9937731a66",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-09T09:26:01.413157+00:00",
      "updated_at": "2024-09-09T09:26:01.413157+00:00",
      "number": "http://bqbl.it/79a8f410-6dd6-4e60-a31c-ba9937731a66",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-184.lvh.me:/barcodes/79a8f410-6dd6-4e60-a31c-ba9937731a66/image",
      "owner_id": "352e6b81-88b8-483c-9e5b-e2b9042cb373",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/814d768f-05e9-4080-ae2b-3e0ffc253747' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "814d768f-05e9-4080-ae2b-3e0ffc253747",
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
    "id": "814d768f-05e9-4080-ae2b-3e0ffc253747",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-09T09:25:58.254836+00:00",
      "updated_at": "2024-09-09T09:25:58.346623+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-179.lvh.me:/barcodes/814d768f-05e9-4080-ae2b-3e0ffc253747/image",
      "owner_id": "c0d22c16-c13a-4422-b8fc-5a935610cbcf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f4c01010-4d96-4f86-aeaf-2a96dd7d658a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f4c01010-4d96-4f86-aeaf-2a96dd7d658a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-09-09T09:26:01.926684+00:00",
      "updated_at": "2024-09-09T09:26:01.926684+00:00",
      "number": "http://bqbl.it/f4c01010-4d96-4f86-aeaf-2a96dd7d658a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-185.lvh.me:/barcodes/f4c01010-4d96-4f86-aeaf-2a96dd7d658a/image",
      "owner_id": "55588b17-532a-4ce2-9db4-c151c3c490a9",
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









