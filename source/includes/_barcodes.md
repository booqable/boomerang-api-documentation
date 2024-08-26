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
      "id": "841665cd-f938-4b02-afef-7a2452afceca",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-26T09:29:03.348682+00:00",
        "updated_at": "2024-08-26T09:29:03.348682+00:00",
        "number": "http://bqbl.it/841665cd-f938-4b02-afef-7a2452afceca",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-265.lvh.me:/barcodes/841665cd-f938-4b02-afef-7a2452afceca/image",
        "owner_id": "d2604b0b-e316-4b2a-a9e0-ffd665764e2f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F33dc7b9a-2427-4a9b-b0d0-24943dabbec5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "33dc7b9a-2427-4a9b-b0d0-24943dabbec5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-26T09:29:03.914529+00:00",
        "updated_at": "2024-08-26T09:29:03.914529+00:00",
        "number": "http://bqbl.it/33dc7b9a-2427-4a9b-b0d0-24943dabbec5",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-266.lvh.me:/barcodes/33dc7b9a-2427-4a9b-b0d0-24943dabbec5/image",
        "owner_id": "b88de5e5-b4c9-4bac-90f9-63382dc73e28",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "b88de5e5-b4c9-4bac-90f9-63382dc73e28"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b88de5e5-b4c9-4bac-90f9-63382dc73e28",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-26T09:29:03.876314+00:00",
        "updated_at": "2024-08-26T09:29:03.916190+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-74@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzY4YmI5MmItODAzYi00MjY5LTliMjQtMjE1MTY2ZWZhYTkz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c68bb92b-803b-4269-9b24-215166efaa93",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-26T09:29:04.539623+00:00",
        "updated_at": "2024-08-26T09:29:04.539623+00:00",
        "number": "http://bqbl.it/c68bb92b-803b-4269-9b24-215166efaa93",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-267.lvh.me:/barcodes/c68bb92b-803b-4269-9b24-215166efaa93/image",
        "owner_id": "93983494-87de-4ddd-9d9f-bdbb1ef885d7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "93983494-87de-4ddd-9d9f-bdbb1ef885d7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "93983494-87de-4ddd-9d9f-bdbb1ef885d7",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-26T09:29:04.504873+00:00",
        "updated_at": "2024-08-26T09:29:04.541186+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a902cec8-4d97-4d3d-b4c9-a00401be27fc?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a902cec8-4d97-4d3d-b4c9-a00401be27fc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-26T09:29:06.403515+00:00",
      "updated_at": "2024-08-26T09:29:06.403515+00:00",
      "number": "http://bqbl.it/a902cec8-4d97-4d3d-b4c9-a00401be27fc",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-270.lvh.me:/barcodes/a902cec8-4d97-4d3d-b4c9-a00401be27fc/image",
      "owner_id": "675224d9-418f-4b1e-aed3-cb8c84468815",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "675224d9-418f-4b1e-aed3-cb8c84468815"
        }
      }
    }
  },
  "included": [
    {
      "id": "675224d9-418f-4b1e-aed3-cb8c84468815",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-26T09:29:06.361040+00:00",
        "updated_at": "2024-08-26T09:29:06.405271+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
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
          "owner_id": "19fa5844-597f-4374-a8fb-e5730a606700",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c85ed13b-59cb-4ad4-b8e4-59c70a311133",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-26T09:29:07.141235+00:00",
      "updated_at": "2024-08-26T09:29:07.141235+00:00",
      "number": "http://bqbl.it/c85ed13b-59cb-4ad4-b8e4-59c70a311133",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-271.lvh.me:/barcodes/c85ed13b-59cb-4ad4-b8e4-59c70a311133/image",
      "owner_id": "19fa5844-597f-4374-a8fb-e5730a606700",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0850a2a-f581-42ed-b95e-bd62e18f8f7c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a0850a2a-f581-42ed-b95e-bd62e18f8f7c",
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
    "id": "a0850a2a-f581-42ed-b95e-bd62e18f8f7c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-26T09:29:05.779010+00:00",
      "updated_at": "2024-08-26T09:29:05.869975+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-269.lvh.me:/barcodes/a0850a2a-f581-42ed-b95e-bd62e18f8f7c/image",
      "owner_id": "4ee1c9df-5dee-4e4f-ac85-f3d4088017dc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6776141f-41f7-4d2d-a40d-b4bdd5d05fbb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6776141f-41f7-4d2d-a40d-b4bdd5d05fbb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-26T09:29:05.169304+00:00",
      "updated_at": "2024-08-26T09:29:05.169304+00:00",
      "number": "http://bqbl.it/6776141f-41f7-4d2d-a40d-b4bdd5d05fbb",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-268.lvh.me:/barcodes/6776141f-41f7-4d2d-a40d-b4bdd5d05fbb/image",
      "owner_id": "bf532c48-3b2c-414d-ae9b-e1c4e7ad250d",
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









