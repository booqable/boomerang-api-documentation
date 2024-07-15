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
      "id": "8620ffc9-774f-476f-a620-00d0787f363d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-15T09:30:34.485674+00:00",
        "updated_at": "2024-07-15T09:30:34.485674+00:00",
        "number": "http://bqbl.it/8620ffc9-774f-476f-a620-00d0787f363d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-294.lvh.me:/barcodes/8620ffc9-774f-476f-a620-00d0787f363d/image",
        "owner_id": "07c188af-8dd3-4bd1-aacd-05f52baf54cc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6f9f11b6-f2a6-4b25-a303-75aee8cca0b2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6f9f11b6-f2a6-4b25-a303-75aee8cca0b2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-15T09:30:35.195507+00:00",
        "updated_at": "2024-07-15T09:30:35.195507+00:00",
        "number": "http://bqbl.it/6f9f11b6-f2a6-4b25-a303-75aee8cca0b2",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-295.lvh.me:/barcodes/6f9f11b6-f2a6-4b25-a303-75aee8cca0b2/image",
        "owner_id": "e95cc0c9-2b21-4d7c-9632-7c44236ae72a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "e95cc0c9-2b21-4d7c-9632-7c44236ae72a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e95cc0c9-2b21-4d7c-9632-7c44236ae72a",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-15T09:30:35.147011+00:00",
        "updated_at": "2024-07-15T09:30:35.198277+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-80@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTNkNTY1ZjktOGU5NC00MWYwLTgzYjYtMGE2MDJlZDRhYWE0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "93d565f9-8e94-41f0-83b6-0a602ed4aaa4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-15T09:30:36.002174+00:00",
        "updated_at": "2024-07-15T09:30:36.002174+00:00",
        "number": "http://bqbl.it/93d565f9-8e94-41f0-83b6-0a602ed4aaa4",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-296.lvh.me:/barcodes/93d565f9-8e94-41f0-83b6-0a602ed4aaa4/image",
        "owner_id": "a3a8ef7a-f0e8-4d1d-8acd-30013476335d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "a3a8ef7a-f0e8-4d1d-8acd-30013476335d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a3a8ef7a-f0e8-4d1d-8acd-30013476335d",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-15T09:30:35.950292+00:00",
        "updated_at": "2024-07-15T09:30:36.004587+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-82@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4191c9a6-7b78-4408-a368-252d723206e6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4191c9a6-7b78-4408-a368-252d723206e6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-15T09:30:38.385655+00:00",
      "updated_at": "2024-07-15T09:30:38.385655+00:00",
      "number": "http://bqbl.it/4191c9a6-7b78-4408-a368-252d723206e6",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-299.lvh.me:/barcodes/4191c9a6-7b78-4408-a368-252d723206e6/image",
      "owner_id": "c4d19d77-c719-4e11-b2ef-dba438c0ccc7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "c4d19d77-c719-4e11-b2ef-dba438c0ccc7"
        }
      }
    }
  },
  "included": [
    {
      "id": "c4d19d77-c719-4e11-b2ef-dba438c0ccc7",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-15T09:30:38.322825+00:00",
        "updated_at": "2024-07-15T09:30:38.388848+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-86@doe.test",
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
          "owner_id": "839406be-3a60-44ad-879e-32d2f0b7005c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6ccbf60b-b33a-400e-91ef-fcba68036548",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-15T09:30:37.721123+00:00",
      "updated_at": "2024-07-15T09:30:37.721123+00:00",
      "number": "http://bqbl.it/6ccbf60b-b33a-400e-91ef-fcba68036548",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-298.lvh.me:/barcodes/6ccbf60b-b33a-400e-91ef-fcba68036548/image",
      "owner_id": "839406be-3a60-44ad-879e-32d2f0b7005c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/54baa13a-0dd0-490f-936d-caf9cb5a79cb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "54baa13a-0dd0-490f-936d-caf9cb5a79cb",
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
    "id": "54baa13a-0dd0-490f-936d-caf9cb5a79cb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-15T09:30:33.635209+00:00",
      "updated_at": "2024-07-15T09:30:33.745942+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-293.lvh.me:/barcodes/54baa13a-0dd0-490f-936d-caf9cb5a79cb/image",
      "owner_id": "5fac3d0b-cec3-48a5-a43f-f62c6c602e56",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d59cee03-ea70-4da3-a893-48cca16aff64' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d59cee03-ea70-4da3-a893-48cca16aff64",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-15T09:30:36.691200+00:00",
      "updated_at": "2024-07-15T09:30:36.691200+00:00",
      "number": "http://bqbl.it/d59cee03-ea70-4da3-a893-48cca16aff64",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-297.lvh.me:/barcodes/d59cee03-ea70-4da3-a893-48cca16aff64/image",
      "owner_id": "eeaf36c0-82cf-4c3e-8958-eeef0c304054",
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









