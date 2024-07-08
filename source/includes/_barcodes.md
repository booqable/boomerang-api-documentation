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
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "a93d4b2f-7a38-4612-aabc-ddb48c8cda05",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-08T09:24:25.913183+00:00",
        "updated_at": "2024-07-08T09:24:25.913183+00:00",
        "number": "http://bqbl.it/a93d4b2f-7a38-4612-aabc-ddb48c8cda05",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-82.lvh.me:/barcodes/a93d4b2f-7a38-4612-aabc-ddb48c8cda05/image",
        "owner_id": "ead77beb-f651-419c-856a-cd1fdc7f2414",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9d4dd99b-8c60-4f4f-b97e-37051f2e0add&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9d4dd99b-8c60-4f4f-b97e-37051f2e0add",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-08T09:24:25.213660+00:00",
        "updated_at": "2024-07-08T09:24:25.213660+00:00",
        "number": "http://bqbl.it/9d4dd99b-8c60-4f4f-b97e-37051f2e0add",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-81.lvh.me:/barcodes/9d4dd99b-8c60-4f4f-b97e-37051f2e0add/image",
        "owner_id": "4f91beb0-7a56-4bd0-b941-537a1195f83b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "4f91beb0-7a56-4bd0-b941-537a1195f83b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4f91beb0-7a56-4bd0-b941-537a1195f83b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-08T09:24:25.147689+00:00",
        "updated_at": "2024-07-08T09:24:25.218130+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-17@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzkwZThkNjMtOTA4Yi00MDZhLThjY2MtNzQ5Y2Q2NmUyODc3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c90e8d63-908b-406a-8ccc-749cd66e2877",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-08T09:24:27.068621+00:00",
        "updated_at": "2024-07-08T09:24:27.068621+00:00",
        "number": "http://bqbl.it/c90e8d63-908b-406a-8ccc-749cd66e2877",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-83.lvh.me:/barcodes/c90e8d63-908b-406a-8ccc-749cd66e2877/image",
        "owner_id": "a4b60783-9569-489c-9669-2aea7de66975",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "a4b60783-9569-489c-9669-2aea7de66975"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a4b60783-9569-489c-9669-2aea7de66975",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-08T09:24:26.992708+00:00",
        "updated_at": "2024-07-08T09:24:27.072612+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-20@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6a0b6368-545b-4f0e-9e7e-818df06c3ac4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a0b6368-545b-4f0e-9e7e-818df06c3ac4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-08T09:24:24.533933+00:00",
      "updated_at": "2024-07-08T09:24:24.533933+00:00",
      "number": "http://bqbl.it/6a0b6368-545b-4f0e-9e7e-818df06c3ac4",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-80.lvh.me:/barcodes/6a0b6368-545b-4f0e-9e7e-818df06c3ac4/image",
      "owner_id": "592a7e5b-33fa-4621-b8f8-4dfa3b9ddce9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "592a7e5b-33fa-4621-b8f8-4dfa3b9ddce9"
        }
      }
    }
  },
  "included": [
    {
      "id": "592a7e5b-33fa-4621-b8f8-4dfa3b9ddce9",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-08T09:24:24.480210+00:00",
        "updated_at": "2024-07-08T09:24:24.536848+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-16@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
          "owner_id": "ca812d7e-2677-41b9-a11f-46166d359391",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c5f5279b-beb3-43c9-9342-482260a733c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-08T09:24:27.946551+00:00",
      "updated_at": "2024-07-08T09:24:27.946551+00:00",
      "number": "http://bqbl.it/c5f5279b-beb3-43c9-9342-482260a733c3",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-84.lvh.me:/barcodes/c5f5279b-beb3-43c9-9342-482260a733c3/image",
      "owner_id": "ca812d7e-2677-41b9-a11f-46166d359391",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/09b867d0-b019-442c-b88b-499fb46c7725' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "09b867d0-b019-442c-b88b-499fb46c7725",
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
    "id": "09b867d0-b019-442c-b88b-499fb46c7725",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-08T09:24:28.872398+00:00",
      "updated_at": "2024-07-08T09:24:29.050137+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-85.lvh.me:/barcodes/09b867d0-b019-442c-b88b-499fb46c7725/image",
      "owner_id": "5c10a939-872f-4ca3-b0af-6148a61d656f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fd9b2d81-b9a4-4e8e-92af-46ef998a2344' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fd9b2d81-b9a4-4e8e-92af-46ef998a2344",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-08T09:24:29.863571+00:00",
      "updated_at": "2024-07-08T09:24:29.863571+00:00",
      "number": "http://bqbl.it/fd9b2d81-b9a4-4e8e-92af-46ef998a2344",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-86.lvh.me:/barcodes/fd9b2d81-b9a4-4e8e-92af-46ef998a2344/image",
      "owner_id": "89ac8ca0-2661-4af6-9dec-b6b6f287e0d1",
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









