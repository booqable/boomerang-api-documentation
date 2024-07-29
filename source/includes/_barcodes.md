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
      "id": "9476b119-98c6-44a4-ac89-c7a1b704e0ec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-29T09:27:44.887909+00:00",
        "updated_at": "2024-07-29T09:27:44.887909+00:00",
        "number": "http://bqbl.it/9476b119-98c6-44a4-ac89-c7a1b704e0ec",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-223.lvh.me:/barcodes/9476b119-98c6-44a4-ac89-c7a1b704e0ec/image",
        "owner_id": "151d0512-d8e0-4074-a27f-41b0edfb4a6d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe20ed2ff-81a9-4dfa-ae64-aff5d9e1aff9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e20ed2ff-81a9-4dfa-ae64-aff5d9e1aff9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-29T09:27:45.463001+00:00",
        "updated_at": "2024-07-29T09:27:45.463001+00:00",
        "number": "http://bqbl.it/e20ed2ff-81a9-4dfa-ae64-aff5d9e1aff9",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-224.lvh.me:/barcodes/e20ed2ff-81a9-4dfa-ae64-aff5d9e1aff9/image",
        "owner_id": "ec86cc4c-0a21-4db3-8e10-7c2a6b373408",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "ec86cc4c-0a21-4db3-8e10-7c2a6b373408"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ec86cc4c-0a21-4db3-8e10-7c2a6b373408",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-29T09:27:45.422111+00:00",
        "updated_at": "2024-07-29T09:27:45.465989+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-69@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTFjZmQxNGUtZjNmMS00Yjg5LWFjZTQtM2U1ZGZmYzVmNWZm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "51cfd14e-f3f1-4b89-ace4-3e5dffc5f5ff",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-29T09:27:44.306670+00:00",
        "updated_at": "2024-07-29T09:27:44.306670+00:00",
        "number": "http://bqbl.it/51cfd14e-f3f1-4b89-ace4-3e5dffc5f5ff",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-222.lvh.me:/barcodes/51cfd14e-f3f1-4b89-ace4-3e5dffc5f5ff/image",
        "owner_id": "12d35651-2e07-4b4e-92c7-8f9f0db4e78b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "12d35651-2e07-4b4e-92c7-8f9f0db4e78b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "12d35651-2e07-4b4e-92c7-8f9f0db4e78b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-29T09:27:44.266502+00:00",
        "updated_at": "2024-07-29T09:27:44.308478+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/76263e89-4928-4705-958e-506dbdf38b3a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "76263e89-4928-4705-958e-506dbdf38b3a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-29T09:27:46.852429+00:00",
      "updated_at": "2024-07-29T09:27:46.852429+00:00",
      "number": "http://bqbl.it/76263e89-4928-4705-958e-506dbdf38b3a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-226.lvh.me:/barcodes/76263e89-4928-4705-958e-506dbdf38b3a/image",
      "owner_id": "524332e6-7242-46ca-bbbe-6df81ac198fd",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "524332e6-7242-46ca-bbbe-6df81ac198fd"
        }
      }
    }
  },
  "included": [
    {
      "id": "524332e6-7242-46ca-bbbe-6df81ac198fd",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-29T09:27:46.809714+00:00",
        "updated_at": "2024-07-29T09:27:46.854425+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-72@doe.test",
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
          "owner_id": "8289d0c6-f015-4247-8e80-515bc5ec0786",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5e98051c-f936-4d5f-8b1d-95d8e1377dc6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-29T09:27:46.192347+00:00",
      "updated_at": "2024-07-29T09:27:46.192347+00:00",
      "number": "http://bqbl.it/5e98051c-f936-4d5f-8b1d-95d8e1377dc6",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-225.lvh.me:/barcodes/5e98051c-f936-4d5f-8b1d-95d8e1377dc6/image",
      "owner_id": "8289d0c6-f015-4247-8e80-515bc5ec0786",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/90a30cba-b92a-48fb-b287-b23ebcb37240' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "90a30cba-b92a-48fb-b287-b23ebcb37240",
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
    "id": "90a30cba-b92a-48fb-b287-b23ebcb37240",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-29T09:27:48.231287+00:00",
      "updated_at": "2024-07-29T09:27:48.307017+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-228.lvh.me:/barcodes/90a30cba-b92a-48fb-b287-b23ebcb37240/image",
      "owner_id": "a64de687-7d6f-47a0-908d-5d44089d27cb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b1ac2b78-2eea-4028-8459-8c3bce5b7ac5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b1ac2b78-2eea-4028-8459-8c3bce5b7ac5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-29T09:27:47.526194+00:00",
      "updated_at": "2024-07-29T09:27:47.526194+00:00",
      "number": "http://bqbl.it/b1ac2b78-2eea-4028-8459-8c3bce5b7ac5",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-227.lvh.me:/barcodes/b1ac2b78-2eea-4028-8459-8c3bce5b7ac5/image",
      "owner_id": "22f50f3f-7972-450e-8bc9-c44e063f2b73",
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









