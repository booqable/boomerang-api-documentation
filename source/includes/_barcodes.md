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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


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
      "id": "0cdf8f0f-04b4-4749-b8bb-e7d2395aae3d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-17T10:02:20+00:00",
        "updated_at": "2022-03-17T10:02:20+00:00",
        "number": "http://bqbl.it/0cdf8f0f-04b4-4749-b8bb-e7d2395aae3d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/af65ff63e6519d5f86339680e10ad9ef/barcode/image/0cdf8f0f-04b4-4749-b8bb-e7d2395aae3d/d58d19fb-0e93-4e1e-ad4d-f67e0dada8bc.svg",
        "owner_id": "6436d5b9-bf97-4889-8a93-46c00c421ba4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6436d5b9-bf97-4889-8a93-46c00c421ba4"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F585bb9b1-1d49-405d-8e5e-1f52d955ff2c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "585bb9b1-1d49-405d-8e5e-1f52d955ff2c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-17T10:02:21+00:00",
        "updated_at": "2022-03-17T10:02:21+00:00",
        "number": "http://bqbl.it/585bb9b1-1d49-405d-8e5e-1f52d955ff2c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/7231703441c0ff5276a03163a08c04f3/barcode/image/585bb9b1-1d49-405d-8e5e-1f52d955ff2c/f2e3e37d-ffbf-4ae4-8996-e2b5296b7394.svg",
        "owner_id": "bf3a02b6-e3de-4b07-847d-31015f67c40a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bf3a02b6-e3de-4b07-847d-31015f67c40a"
          },
          "data": {
            "type": "customers",
            "id": "bf3a02b6-e3de-4b07-847d-31015f67c40a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bf3a02b6-e3de-4b07-847d-31015f67c40a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-17T10:02:21+00:00",
        "updated_at": "2022-03-17T10:02:21+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Bergnaum LLC",
        "email": "bergnaum_llc@murphy-kling.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=bf3a02b6-e3de-4b07-847d-31015f67c40a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bf3a02b6-e3de-4b07-847d-31015f67c40a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bf3a02b6-e3de-4b07-847d-31015f67c40a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGM0NzNkZDgtODUxNC00MzcwLWEzZjAtZWNhNjJhY2YwNDYy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8c473dd8-8514-4370-a3f0-eca62acf0462",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-17T10:02:21+00:00",
        "updated_at": "2022-03-17T10:02:21+00:00",
        "number": "http://bqbl.it/8c473dd8-8514-4370-a3f0-eca62acf0462",
        "barcode_type": "qr_code",
        "image_url": "/uploads/22aa05f43245867d8f75ef354557d5dc/barcode/image/8c473dd8-8514-4370-a3f0-eca62acf0462/20b2da51-d0a1-42dd-ab9e-8eeb6d21dcaa.svg",
        "owner_id": "f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5"
          },
          "data": {
            "type": "customers",
            "id": "f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-17T10:02:21+00:00",
        "updated_at": "2022-03-17T10:02:21+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Stamm, Lowe and Hahn",
        "email": "stamm_lowe_and_hahn@wintheiser-wolff.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f2cb8a84-0bc2-42d5-8af5-d1aab2b47bc5&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-17T10:02:08Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/357eb993-2cdb-4297-add8-512f72a367e9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "357eb993-2cdb-4297-add8-512f72a367e9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-17T10:02:22+00:00",
      "updated_at": "2022-03-17T10:02:22+00:00",
      "number": "http://bqbl.it/357eb993-2cdb-4297-add8-512f72a367e9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/28ae1b1fe17375d4d7974f72e8fd50c1/barcode/image/357eb993-2cdb-4297-add8-512f72a367e9/069e9766-5e84-4bc6-8b2e-6f7dffa65aea.svg",
      "owner_id": "f891e251-5637-438c-b2d3-83937b239202",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f891e251-5637-438c-b2d3-83937b239202"
        },
        "data": {
          "type": "customers",
          "id": "f891e251-5637-438c-b2d3-83937b239202"
        }
      }
    }
  },
  "included": [
    {
      "id": "f891e251-5637-438c-b2d3-83937b239202",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-17T10:02:22+00:00",
        "updated_at": "2022-03-17T10:02:22+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Runolfsdottir-Dare",
        "email": "dare_runolfsdottir@nienow.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=f891e251-5637-438c-b2d3-83937b239202&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f891e251-5637-438c-b2d3-83937b239202&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f891e251-5637-438c-b2d3-83937b239202&filter[owner_type]=customers"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`owner`






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
          "owner_id": "73738c0a-244d-41e3-b587-7e4f01a2fcda",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3abf275c-e5b8-4320-b044-f3f8f40dfe8e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-17T10:02:22+00:00",
      "updated_at": "2022-03-17T10:02:22+00:00",
      "number": "http://bqbl.it/3abf275c-e5b8-4320-b044-f3f8f40dfe8e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7242097caf59f53948cb2ba6766fdff4/barcode/image/3abf275c-e5b8-4320-b044-f3f8f40dfe8e/8044583d-e846-4606-8684-d1b360249369.svg",
      "owner_id": "73738c0a-244d-41e3-b587-7e4f01a2fcda",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/661c2b78-6224-4a13-84ee-3922e9c31ff8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "661c2b78-6224-4a13-84ee-3922e9c31ff8",
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
    "id": "661c2b78-6224-4a13-84ee-3922e9c31ff8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-17T10:02:23+00:00",
      "updated_at": "2022-03-17T10:02:23+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ffa99053375d84e7baea4b77a78e8b0c/barcode/image/661c2b78-6224-4a13-84ee-3922e9c31ff8/4b6b09dc-9f51-464a-a429-bf1701340396.svg",
      "owner_id": "1a8d2046-6b16-4d86-a457-c633b28ad3c2",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/5f9af649-6851-49b7-a121-3f6896962b94' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes