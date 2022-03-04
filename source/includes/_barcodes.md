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
      "id": "37ecd615-d997-4a61-9cfc-1f2c393f23c1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-01T09:34:34+00:00",
        "updated_at": "2022-03-01T09:34:34+00:00",
        "number": "http://bqbl.it/37ecd615-d997-4a61-9cfc-1f2c393f23c1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4deaca6acef60f86db13bb4c3648d6e8/barcode/image/37ecd615-d997-4a61-9cfc-1f2c393f23c1/4a6c78b4-9d00-4f07-a943-200f0ba44114.svg",
        "owner_id": "d71bf277-34c2-4025-b0f3-31e93c0c4925",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d71bf277-34c2-4025-b0f3-31e93c0c4925"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4bf4426e-8bc9-4178-bd95-f0717d1514f4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4bf4426e-8bc9-4178-bd95-f0717d1514f4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-01T09:34:35+00:00",
        "updated_at": "2022-03-01T09:34:35+00:00",
        "number": "http://bqbl.it/4bf4426e-8bc9-4178-bd95-f0717d1514f4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63a9010872b23bb207bc34d6c8d45c25/barcode/image/4bf4426e-8bc9-4178-bd95-f0717d1514f4/f60caeea-7265-4c9a-91d7-d1cf55ed3dd3.svg",
        "owner_id": "e9dd1010-8e52-4f90-996e-d424d4a8aa9a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e9dd1010-8e52-4f90-996e-d424d4a8aa9a"
          },
          "data": {
            "type": "customers",
            "id": "e9dd1010-8e52-4f90-996e-d424d4a8aa9a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e9dd1010-8e52-4f90-996e-d424d4a8aa9a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-01T09:34:35+00:00",
        "updated_at": "2022-03-01T09:34:35+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Skiles-Hilpert",
        "email": "hilpert_skiles@abshire-blanda.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=e9dd1010-8e52-4f90-996e-d424d4a8aa9a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e9dd1010-8e52-4f90-996e-d424d4a8aa9a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e9dd1010-8e52-4f90-996e-d424d4a8aa9a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjIwNThlYTMtYWQ1MS00ZjUwLTlkOGUtNzU1ZjIwMWM2Yjll&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f2058ea3-ad51-4f50-9d8e-755f201c6b9e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-01T09:34:36+00:00",
        "updated_at": "2022-03-01T09:34:36+00:00",
        "number": "http://bqbl.it/f2058ea3-ad51-4f50-9d8e-755f201c6b9e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b399fda6742331bf36a5629bbc52a665/barcode/image/f2058ea3-ad51-4f50-9d8e-755f201c6b9e/c3027eb1-a0b2-40a5-badd-84f5e198c21b.svg",
        "owner_id": "255811a1-3206-45dc-97cb-e61193a9b3f6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/255811a1-3206-45dc-97cb-e61193a9b3f6"
          },
          "data": {
            "type": "customers",
            "id": "255811a1-3206-45dc-97cb-e61193a9b3f6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "255811a1-3206-45dc-97cb-e61193a9b3f6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-01T09:34:36+00:00",
        "updated_at": "2022-03-01T09:34:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Bartell Group",
        "email": "bartell.group@skiles-lowe.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=255811a1-3206-45dc-97cb-e61193a9b3f6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=255811a1-3206-45dc-97cb-e61193a9b3f6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=255811a1-3206-45dc-97cb-e61193a9b3f6&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-01T09:34:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/13e90897-0906-47e5-92b3-cd90bf57c39c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13e90897-0906-47e5-92b3-cd90bf57c39c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-01T09:34:36+00:00",
      "updated_at": "2022-03-01T09:34:36+00:00",
      "number": "http://bqbl.it/13e90897-0906-47e5-92b3-cd90bf57c39c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/22fb640788be70b29800ecb6a4b46b00/barcode/image/13e90897-0906-47e5-92b3-cd90bf57c39c/3dcc9c0b-d004-466a-a54c-520e7c615b60.svg",
      "owner_id": "ac27a08a-dc2d-4e00-bb5e-8c151ff420f5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ac27a08a-dc2d-4e00-bb5e-8c151ff420f5"
        },
        "data": {
          "type": "customers",
          "id": "ac27a08a-dc2d-4e00-bb5e-8c151ff420f5"
        }
      }
    }
  },
  "included": [
    {
      "id": "ac27a08a-dc2d-4e00-bb5e-8c151ff420f5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-01T09:34:36+00:00",
        "updated_at": "2022-03-01T09:34:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hansen LLC",
        "email": "hansen.llc@zulauf-ohara.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=ac27a08a-dc2d-4e00-bb5e-8c151ff420f5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ac27a08a-dc2d-4e00-bb5e-8c151ff420f5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ac27a08a-dc2d-4e00-bb5e-8c151ff420f5&filter[owner_type]=customers"
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
          "owner_id": "30d9649a-1f36-45d4-b931-ed49d6176135",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e7d4ba10-e34c-4bc7-8b47-e62a10cc7753",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-01T09:34:37+00:00",
      "updated_at": "2022-03-01T09:34:37+00:00",
      "number": "http://bqbl.it/e7d4ba10-e34c-4bc7-8b47-e62a10cc7753",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f675c40319636d5cd624415d083c7d25/barcode/image/e7d4ba10-e34c-4bc7-8b47-e62a10cc7753/36f5b92c-3b24-40e5-abc0-679f2478addd.svg",
      "owner_id": "30d9649a-1f36-45d4-b931-ed49d6176135",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e1f37316-4413-4bea-86cb-20319a69b0bf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e1f37316-4413-4bea-86cb-20319a69b0bf",
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
    "id": "e1f37316-4413-4bea-86cb-20319a69b0bf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-01T09:34:38+00:00",
      "updated_at": "2022-03-01T09:34:38+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5cac0a8cb881bca999eb5378c85cee6b/barcode/image/e1f37316-4413-4bea-86cb-20319a69b0bf/3d6fb340-178c-488a-a9b6-b4a9536e702e.svg",
      "owner_id": "41a3fe9a-a5e0-45c2-a65d-6eea4694a4e7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e7b6c347-2dd4-4a47-b9fa-bac5f9b3417a' \
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