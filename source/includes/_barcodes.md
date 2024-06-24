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
      "id": "8ede70e1-b2e4-4130-8fde-b7bce329b4cf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-24T09:50:13.470658+00:00",
        "updated_at": "2024-06-24T09:50:13.470658+00:00",
        "number": "http://bqbl.it/8ede70e1-b2e4-4130-8fde-b7bce329b4cf",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-110.lvh.me:/barcodes/8ede70e1-b2e4-4130-8fde-b7bce329b4cf/image",
        "owner_id": "7b943e15-a7ee-426d-a70f-869c3453e485",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7b943e15-a7ee-426d-a70f-869c3453e485"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff0ee8f7b-f2b4-4451-88b8-03357734bcab&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f0ee8f7b-f2b4-4451-88b8-03357734bcab",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-24T09:50:11.620678+00:00",
        "updated_at": "2024-06-24T09:50:11.620678+00:00",
        "number": "http://bqbl.it/f0ee8f7b-f2b4-4451-88b8-03357734bcab",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-108.lvh.me:/barcodes/f0ee8f7b-f2b4-4451-88b8-03357734bcab/image",
        "owner_id": "56f266fe-40ee-4f67-959f-af7fef98f389",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/56f266fe-40ee-4f67-959f-af7fef98f389"
          },
          "data": {
            "type": "customers",
            "id": "56f266fe-40ee-4f67-959f-af7fef98f389"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "56f266fe-40ee-4f67-959f-af7fef98f389",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-24T09:50:11.594539+00:00",
        "updated_at": "2024-06-24T09:50:11.624599+00:00",
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
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=56f266fe-40ee-4f67-959f-af7fef98f389&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=56f266fe-40ee-4f67-959f-af7fef98f389&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=56f266fe-40ee-4f67-959f-af7fef98f389&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDBmNDFiZTMtZGMwMi00NGQyLWJlY2UtOTEyYjZmZDNjNmMw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "00f41be3-dc02-44d2-bece-912b6fd3c6c0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-24T09:50:12.429868+00:00",
        "updated_at": "2024-06-24T09:50:12.429868+00:00",
        "number": "http://bqbl.it/00f41be3-dc02-44d2-bece-912b6fd3c6c0",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-109.lvh.me:/barcodes/00f41be3-dc02-44d2-bece-912b6fd3c6c0/image",
        "owner_id": "217d0c64-dcee-4680-85d8-b6ba64c9a968",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/217d0c64-dcee-4680-85d8-b6ba64c9a968"
          },
          "data": {
            "type": "customers",
            "id": "217d0c64-dcee-4680-85d8-b6ba64c9a968"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "217d0c64-dcee-4680-85d8-b6ba64c9a968",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-24T09:50:12.392721+00:00",
        "updated_at": "2024-06-24T09:50:12.435269+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-19@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=217d0c64-dcee-4680-85d8-b6ba64c9a968&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=217d0c64-dcee-4680-85d8-b6ba64c9a968&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=217d0c64-dcee-4680-85d8-b6ba64c9a968&filter[owner_type]=customers"
          }
        }
      }
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e25285ad-991c-4c24-b898-0fddc6ba4d60?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e25285ad-991c-4c24-b898-0fddc6ba4d60",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:50:17.182914+00:00",
      "updated_at": "2024-06-24T09:50:17.182914+00:00",
      "number": "http://bqbl.it/e25285ad-991c-4c24-b898-0fddc6ba4d60",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-114.lvh.me:/barcodes/e25285ad-991c-4c24-b898-0fddc6ba4d60/image",
      "owner_id": "ea70cc9d-5418-4244-9366-3a2ca853a6b4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ea70cc9d-5418-4244-9366-3a2ca853a6b4"
        },
        "data": {
          "type": "customers",
          "id": "ea70cc9d-5418-4244-9366-3a2ca853a6b4"
        }
      }
    }
  },
  "included": [
    {
      "id": "ea70cc9d-5418-4244-9366-3a2ca853a6b4",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-24T09:50:17.164187+00:00",
        "updated_at": "2024-06-24T09:50:17.185599+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-25@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=ea70cc9d-5418-4244-9366-3a2ca853a6b4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ea70cc9d-5418-4244-9366-3a2ca853a6b4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ea70cc9d-5418-4244-9366-3a2ca853a6b4&filter[owner_type]=customers"
          }
        }
      }
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
          "owner_id": "bc59392f-4964-4aba-8154-7dbed63565b4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a4c94ab7-8a33-4e98-aec3-420211916ed5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:50:15.592722+00:00",
      "updated_at": "2024-06-24T09:50:15.592722+00:00",
      "number": "http://bqbl.it/a4c94ab7-8a33-4e98-aec3-420211916ed5",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-112.lvh.me:/barcodes/a4c94ab7-8a33-4e98-aec3-420211916ed5/image",
      "owner_id": "bc59392f-4964-4aba-8154-7dbed63565b4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/abf78bfe-bc49-49d8-8412-3ffc57ea988c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "abf78bfe-bc49-49d8-8412-3ffc57ea988c",
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
    "id": "abf78bfe-bc49-49d8-8412-3ffc57ea988c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:50:14.512398+00:00",
      "updated_at": "2024-06-24T09:50:14.571838+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-111.lvh.me:/barcodes/abf78bfe-bc49-49d8-8412-3ffc57ea988c/image",
      "owner_id": "4a69d342-1352-47dc-8f80-d533d6c6763a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f4bf792e-88ae-47cf-8af4-4162a06384c5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f4bf792e-88ae-47cf-8af4-4162a06384c5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:50:16.535360+00:00",
      "updated_at": "2024-06-24T09:50:16.535360+00:00",
      "number": "http://bqbl.it/f4bf792e-88ae-47cf-8af4-4162a06384c5",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-113.lvh.me:/barcodes/f4bf792e-88ae-47cf-8af4-4162a06384c5/image",
      "owner_id": "808b5098-2905-4c3e-a903-4d453290825b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/808b5098-2905-4c3e-a903-4d453290825b"
        }
      }
    }
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









