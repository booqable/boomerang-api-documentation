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
      "id": "37c4156e-98e3-4ea5-abec-05834b5ef84d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-07T09:33:46.423155+00:00",
        "updated_at": "2024-10-07T09:33:46.423155+00:00",
        "number": "http://bqbl.it/37c4156e-98e3-4ea5-abec-05834b5ef84d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-231.lvh.me:/barcodes/37c4156e-98e3-4ea5-abec-05834b5ef84d/image",
        "owner_id": "1caf3e0c-798c-43cc-b4e2-c510790c72ee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F742a61b6-1ffe-4c81-bf5d-3143e42fc472&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "742a61b6-1ffe-4c81-bf5d-3143e42fc472",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-07T09:33:44.512257+00:00",
        "updated_at": "2024-10-07T09:33:44.512257+00:00",
        "number": "http://bqbl.it/742a61b6-1ffe-4c81-bf5d-3143e42fc472",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-229.lvh.me:/barcodes/742a61b6-1ffe-4c81-bf5d-3143e42fc472/image",
        "owner_id": "51277907-7d34-41ee-b395-9a989ed93e4b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "51277907-7d34-41ee-b395-9a989ed93e4b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "51277907-7d34-41ee-b395-9a989ed93e4b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-07T09:33:44.446010+00:00",
        "updated_at": "2024-10-07T09:33:44.514343+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjhiMDg4ZTUtOTc1Yy00ZWE5LWFlOGYtMzNiZjU1MDJlMzA4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "28b088e5-975c-4ea9-ae8f-33bf5502e308",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-07T09:33:45.575302+00:00",
        "updated_at": "2024-10-07T09:33:45.575302+00:00",
        "number": "http://bqbl.it/28b088e5-975c-4ea9-ae8f-33bf5502e308",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-230.lvh.me:/barcodes/28b088e5-975c-4ea9-ae8f-33bf5502e308/image",
        "owner_id": "182d1ec8-dfa8-4314-bae0-596ad2c943c3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "182d1ec8-dfa8-4314-bae0-596ad2c943c3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "182d1ec8-dfa8-4314-bae0-596ad2c943c3",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-07T09:33:45.505666+00:00",
        "updated_at": "2024-10-07T09:33:45.578214+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-70@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3fa2908c-6122-4e3d-a9c4-e49c68762968?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3fa2908c-6122-4e3d-a9c4-e49c68762968",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-07T09:33:52.029879+00:00",
      "updated_at": "2024-10-07T09:33:52.029879+00:00",
      "number": "http://bqbl.it/3fa2908c-6122-4e3d-a9c4-e49c68762968",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-234.lvh.me:/barcodes/3fa2908c-6122-4e3d-a9c4-e49c68762968/image",
      "owner_id": "0fe45ea7-ec14-40dc-8366-0ca13d522f95",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "0fe45ea7-ec14-40dc-8366-0ca13d522f95"
        }
      }
    }
  },
  "included": [
    {
      "id": "0fe45ea7-ec14-40dc-8366-0ca13d522f95",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-07T09:33:51.987954+00:00",
        "updated_at": "2024-10-07T09:33:52.031727+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-75@doe.test",
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
          "owner_id": "dcce92fc-7da3-41df-83b1-64197aa09539",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e0965ba0-9d50-4f13-adcc-c8cec48e8a6e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-07T09:33:50.815686+00:00",
      "updated_at": "2024-10-07T09:33:50.815686+00:00",
      "number": "http://bqbl.it/e0965ba0-9d50-4f13-adcc-c8cec48e8a6e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-233.lvh.me:/barcodes/e0965ba0-9d50-4f13-adcc-c8cec48e8a6e/image",
      "owner_id": "dcce92fc-7da3-41df-83b1-64197aa09539",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0e645069-e070-456e-805f-238686b8bb4d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0e645069-e070-456e-805f-238686b8bb4d",
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
    "id": "0e645069-e070-456e-805f-238686b8bb4d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-07T09:33:43.623515+00:00",
      "updated_at": "2024-10-07T09:33:43.729637+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-228.lvh.me:/barcodes/0e645069-e070-456e-805f-238686b8bb4d/image",
      "owner_id": "1914ea15-8a2e-452f-8313-d33d34c9d3bf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/07c44121-58d9-4a8a-8c4b-b4774b2f074d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "07c44121-58d9-4a8a-8c4b-b4774b2f074d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-07T09:33:47.549038+00:00",
      "updated_at": "2024-10-07T09:33:47.549038+00:00",
      "number": "http://bqbl.it/07c44121-58d9-4a8a-8c4b-b4774b2f074d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-232.lvh.me:/barcodes/07c44121-58d9-4a8a-8c4b-b4774b2f074d/image",
      "owner_id": "071c0803-7345-413b-a5d5-dadb94b19cbc",
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









