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
      "id": "452a56c0-9873-49ec-8194-ccbafa18c166",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-05T09:26:23.093312+00:00",
        "updated_at": "2024-08-05T09:26:23.093312+00:00",
        "number": "http://bqbl.it/452a56c0-9873-49ec-8194-ccbafa18c166",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-200.lvh.me:/barcodes/452a56c0-9873-49ec-8194-ccbafa18c166/image",
        "owner_id": "c3ab386c-9eea-4557-a1cb-d07a8dfa91d1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa35072ca-79c7-4387-aefe-233d991b7972&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a35072ca-79c7-4387-aefe-233d991b7972",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-05T09:26:22.335807+00:00",
        "updated_at": "2024-08-05T09:26:22.335807+00:00",
        "number": "http://bqbl.it/a35072ca-79c7-4387-aefe-233d991b7972",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-199.lvh.me:/barcodes/a35072ca-79c7-4387-aefe-233d991b7972/image",
        "owner_id": "4809b028-9b7f-4475-989e-6b94f9a4d396",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "4809b028-9b7f-4475-989e-6b94f9a4d396"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4809b028-9b7f-4475-989e-6b94f9a4d396",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-05T09:26:22.259506+00:00",
        "updated_at": "2024-08-05T09:26:22.338918+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDllMDlhMmEtODA0NC00MTFhLWE5MzAtMzYwNTU2N2RkNDEx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "49e09a2a-8044-411a-a930-3605567dd411",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-05T09:26:21.573920+00:00",
        "updated_at": "2024-08-05T09:26:21.573920+00:00",
        "number": "http://bqbl.it/49e09a2a-8044-411a-a930-3605567dd411",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-198.lvh.me:/barcodes/49e09a2a-8044-411a-a930-3605567dd411/image",
        "owner_id": "a257fe64-eb2d-4519-8661-3686508bcd56",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "a257fe64-eb2d-4519-8661-3686508bcd56"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a257fe64-eb2d-4519-8661-3686508bcd56",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-05T09:26:21.530598+00:00",
        "updated_at": "2024-08-05T09:26:21.575792+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-67@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1a6482ad-841c-41c8-a61a-1a61c8507652?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1a6482ad-841c-41c8-a61a-1a61c8507652",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-05T09:26:23.748453+00:00",
      "updated_at": "2024-08-05T09:26:23.748453+00:00",
      "number": "http://bqbl.it/1a6482ad-841c-41c8-a61a-1a61c8507652",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-201.lvh.me:/barcodes/1a6482ad-841c-41c8-a61a-1a61c8507652/image",
      "owner_id": "735b95b2-2202-4931-8b46-e0d3832e93cb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "735b95b2-2202-4931-8b46-e0d3832e93cb"
        }
      }
    }
  },
  "included": [
    {
      "id": "735b95b2-2202-4931-8b46-e0d3832e93cb",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-05T09:26:23.695025+00:00",
        "updated_at": "2024-08-05T09:26:23.750592+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
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
          "owner_id": "adfc78cb-a98d-400f-a93c-005242e395f4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "49adeb6a-1617-47f7-8e80-28dfa330e016",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-05T09:26:19.956547+00:00",
      "updated_at": "2024-08-05T09:26:19.956547+00:00",
      "number": "http://bqbl.it/49adeb6a-1617-47f7-8e80-28dfa330e016",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-196.lvh.me:/barcodes/49adeb6a-1617-47f7-8e80-28dfa330e016/image",
      "owner_id": "adfc78cb-a98d-400f-a93c-005242e395f4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/891b5030-479f-4102-9d68-6a8b8d84acf7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "891b5030-479f-4102-9d68-6a8b8d84acf7",
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
    "id": "891b5030-479f-4102-9d68-6a8b8d84acf7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-05T09:26:18.764014+00:00",
      "updated_at": "2024-08-05T09:26:18.903063+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-195.lvh.me:/barcodes/891b5030-479f-4102-9d68-6a8b8d84acf7/image",
      "owner_id": "2bfdaa89-8126-4b95-93d0-677baf9db233",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8e22d55c-7caa-4b1c-8985-41de84b9bf1b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8e22d55c-7caa-4b1c-8985-41de84b9bf1b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-05T09:26:20.837683+00:00",
      "updated_at": "2024-08-05T09:26:20.837683+00:00",
      "number": "http://bqbl.it/8e22d55c-7caa-4b1c-8985-41de84b9bf1b",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-197.lvh.me:/barcodes/8e22d55c-7caa-4b1c-8985-41de84b9bf1b/image",
      "owner_id": "e2ae1305-7e0d-4f87-830d-129c0964b079",
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









