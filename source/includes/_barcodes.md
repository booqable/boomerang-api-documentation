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
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
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
      "id": "1fc47916-cce1-4404-8a26-09ed4a659497",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:20:21+00:00",
        "updated_at": "2023-02-16T09:20:21+00:00",
        "number": "http://bqbl.it/1fc47916-cce1-4404-8a26-09ed4a659497",
        "barcode_type": "qr_code",
        "image_url": "/uploads/aabeb7b08ff14cd5a4c6e34709b7295b/barcode/image/1fc47916-cce1-4404-8a26-09ed4a659497/e6e120bf-ea1d-43b4-a155-418fc86f67f9.svg",
        "owner_id": "8df334ec-8c00-4baf-82e0-f72143e88f9f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8df334ec-8c00-4baf-82e0-f72143e88f9f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb6ed46cc-3f97-47d6-a39b-9dc7caabca45&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b6ed46cc-3f97-47d6-a39b-9dc7caabca45",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:20:22+00:00",
        "updated_at": "2023-02-16T09:20:22+00:00",
        "number": "http://bqbl.it/b6ed46cc-3f97-47d6-a39b-9dc7caabca45",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3dd930f461137601f8e92c29fdd0cae7/barcode/image/b6ed46cc-3f97-47d6-a39b-9dc7caabca45/2048970e-cca5-4ddb-aa1d-208f844f8776.svg",
        "owner_id": "de39793b-d81b-4d91-ad66-469525e0b9f7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/de39793b-d81b-4d91-ad66-469525e0b9f7"
          },
          "data": {
            "type": "customers",
            "id": "de39793b-d81b-4d91-ad66-469525e0b9f7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "de39793b-d81b-4d91-ad66-469525e0b9f7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:20:22+00:00",
        "updated_at": "2023-02-16T09:20:22+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=de39793b-d81b-4d91-ad66-469525e0b9f7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=de39793b-d81b-4d91-ad66-469525e0b9f7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=de39793b-d81b-4d91-ad66-469525e0b9f7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTU4OTIxOGQtZGI2ZS00NzNlLTgyOTYtOGIxM2M5NzNhZDcz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9589218d-db6e-473e-8296-8b13c973ad73",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T09:20:22+00:00",
        "updated_at": "2023-02-16T09:20:22+00:00",
        "number": "http://bqbl.it/9589218d-db6e-473e-8296-8b13c973ad73",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d275f213d5ff85766956190d0deeaee0/barcode/image/9589218d-db6e-473e-8296-8b13c973ad73/71c93f52-a9ed-47d3-8be9-f8cd2eeb0275.svg",
        "owner_id": "d580aa8f-26cf-4405-847d-3246cf699768",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d580aa8f-26cf-4405-847d-3246cf699768"
          },
          "data": {
            "type": "customers",
            "id": "d580aa8f-26cf-4405-847d-3246cf699768"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d580aa8f-26cf-4405-847d-3246cf699768",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:20:22+00:00",
        "updated_at": "2023-02-16T09:20:22+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=d580aa8f-26cf-4405-847d-3246cf699768&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d580aa8f-26cf-4405-847d-3246cf699768&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d580aa8f-26cf-4405-847d-3246cf699768&filter[owner_type]=customers"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:20:00Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/c886e5dd-35bf-44cf-a806-93ae3d53cb2b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c886e5dd-35bf-44cf-a806-93ae3d53cb2b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:20:23+00:00",
      "updated_at": "2023-02-16T09:20:23+00:00",
      "number": "http://bqbl.it/c886e5dd-35bf-44cf-a806-93ae3d53cb2b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2ea5e7a117e8d98c7d1090f7286c7202/barcode/image/c886e5dd-35bf-44cf-a806-93ae3d53cb2b/9b360529-37d7-4eeb-8573-7ec35e820dd8.svg",
      "owner_id": "68c798eb-2bea-43a7-8e54-c0af3d2bdddc",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/68c798eb-2bea-43a7-8e54-c0af3d2bdddc"
        },
        "data": {
          "type": "customers",
          "id": "68c798eb-2bea-43a7-8e54-c0af3d2bdddc"
        }
      }
    }
  },
  "included": [
    {
      "id": "68c798eb-2bea-43a7-8e54-c0af3d2bdddc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T09:20:23+00:00",
        "updated_at": "2023-02-16T09:20:23+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-5@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=68c798eb-2bea-43a7-8e54-c0af3d2bdddc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=68c798eb-2bea-43a7-8e54-c0af3d2bdddc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=68c798eb-2bea-43a7-8e54-c0af3d2bdddc&filter[owner_type]=customers"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "8cbb95a3-29d2-4649-90f6-0ef9ba51c614",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fe7fc8c3-0536-4af1-9a61-7ce55b7154be",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:20:23+00:00",
      "updated_at": "2023-02-16T09:20:23+00:00",
      "number": "http://bqbl.it/fe7fc8c3-0536-4af1-9a61-7ce55b7154be",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fd5d1f7ea29e158444e09d378f1ab311/barcode/image/fe7fc8c3-0536-4af1-9a61-7ce55b7154be/825e1da8-2dcd-433e-a6bc-7a4aa5f948b1.svg",
      "owner_id": "8cbb95a3-29d2-4649-90f6-0ef9ba51c614",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/fbd70c77-5c0c-475b-9b4b-2c4e3ebc4ed4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fbd70c77-5c0c-475b-9b4b-2c4e3ebc4ed4",
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
    "id": "fbd70c77-5c0c-475b-9b4b-2c4e3ebc4ed4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T09:20:24+00:00",
      "updated_at": "2023-02-16T09:20:25+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/39198108f78d940d613ce53e11b19561/barcode/image/fbd70c77-5c0c-475b-9b4b-2c4e3ebc4ed4/a6b62dc7-892d-4381-a547-dd6c9ae5b7d3.svg",
      "owner_id": "3df21b73-d279-4938-827c-408c1627959d",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/fe204f99-dff6-4dae-b14e-fc53fb50b08d' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes