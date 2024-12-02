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
`owner` | **[Customer](#customers), [Product](#products), [Order](#orders), [Stock item](#stock-items)** <br>Associated Owner


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
      "id": "457563de-d71a-4344-b9ca-5bf3b3ffbd59",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-12-02T09:22:55.786189+00:00",
        "updated_at": "2024-12-02T09:22:55.786189+00:00",
        "number": "http://bqbl.it/457563de-d71a-4344-b9ca-5bf3b3ffbd59",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-63.lvh.me:/barcodes/457563de-d71a-4344-b9ca-5bf3b3ffbd59/image",
        "owner_id": "3bcd113f-908d-4390-a1e0-0a2c6a4d6b48",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe1f19ddc-69a5-4ece-8806-2319d8787f15&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e1f19ddc-69a5-4ece-8806-2319d8787f15",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-12-02T09:22:56.323113+00:00",
        "updated_at": "2024-12-02T09:22:56.323113+00:00",
        "number": "http://bqbl.it/e1f19ddc-69a5-4ece-8806-2319d8787f15",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-64.lvh.me:/barcodes/e1f19ddc-69a5-4ece-8806-2319d8787f15/image",
        "owner_id": "5e728930-ae0c-40e0-b401-0f901be9d827",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "5e728930-ae0c-40e0-b401-0f901be9d827"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5e728930-ae0c-40e0-b401-0f901be9d827",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T09:22:56.283435+00:00",
        "updated_at": "2024-12-02T09:22:56.324978+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-10@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTI1ZmU2M2QtYjNlZi00NTc1LWFiNmUtODhiNzUwOWUyNTA3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e25fe63d-b3ef-4575-ab6e-88b7509e2507",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-12-02T09:22:56.941345+00:00",
        "updated_at": "2024-12-02T09:22:56.941345+00:00",
        "number": "http://bqbl.it/e25fe63d-b3ef-4575-ab6e-88b7509e2507",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-65.lvh.me:/barcodes/e25fe63d-b3ef-4575-ab6e-88b7509e2507/image",
        "owner_id": "143884f2-90d0-4a5e-b8ad-f7c43470342e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "143884f2-90d0-4a5e-b8ad-f7c43470342e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "143884f2-90d0-4a5e-b8ad-f7c43470342e",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T09:22:56.903142+00:00",
        "updated_at": "2024-12-02T09:22:56.942976+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-12@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/44c58349-c9fe-4f32-af71-75b1d30fe164?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44c58349-c9fe-4f32-af71-75b1d30fe164",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T09:22:58.637804+00:00",
      "updated_at": "2024-12-02T09:22:58.637804+00:00",
      "number": "http://bqbl.it/44c58349-c9fe-4f32-af71-75b1d30fe164",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-68.lvh.me:/barcodes/44c58349-c9fe-4f32-af71-75b1d30fe164/image",
      "owner_id": "675c5529-53c5-4698-b618-09a56add7aa4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "675c5529-53c5-4698-b618-09a56add7aa4"
        }
      }
    }
  },
  "included": [
    {
      "id": "675c5529-53c5-4698-b618-09a56add7aa4",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T09:22:58.597478+00:00",
        "updated_at": "2024-12-02T09:22:58.639372+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-15@doe.test",
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
          "owner_id": "961ffc9c-31c4-418c-a127-da7423d7f65e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d38252ff-4339-4334-bdfb-e19ebe35ce77",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T09:22:59.248842+00:00",
      "updated_at": "2024-12-02T09:22:59.248842+00:00",
      "number": "http://bqbl.it/d38252ff-4339-4334-bdfb-e19ebe35ce77",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-69.lvh.me:/barcodes/d38252ff-4339-4334-bdfb-e19ebe35ce77/image",
      "owner_id": "961ffc9c-31c4-418c-a127-da7423d7f65e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/62fb5ffa-02e7-463f-baa9-da5c99ca5dfb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "62fb5ffa-02e7-463f-baa9-da5c99ca5dfb",
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
    "id": "62fb5ffa-02e7-463f-baa9-da5c99ca5dfb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T09:22:57.507036+00:00",
      "updated_at": "2024-12-02T09:22:57.573868+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-66.lvh.me:/barcodes/62fb5ffa-02e7-463f-baa9-da5c99ca5dfb/image",
      "owner_id": "e5e07833-51ea-491d-83bd-68e147ce7d4a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8ef023eb-ce8e-4c86-9c91-ae3596857b62' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8ef023eb-ce8e-4c86-9c91-ae3596857b62",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T09:22:58.054950+00:00",
      "updated_at": "2024-12-02T09:22:58.054950+00:00",
      "number": "http://bqbl.it/8ef023eb-ce8e-4c86-9c91-ae3596857b62",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-67.lvh.me:/barcodes/8ef023eb-ce8e-4c86-9c91-ae3596857b62/image",
      "owner_id": "d45ecdaf-8ecd-48ad-95ee-a427dd5e24cc",
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









