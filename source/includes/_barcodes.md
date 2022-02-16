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
      "id": "a668abf2-a47b-40fa-972d-91cea40a0e30",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-16T10:49:05+00:00",
        "updated_at": "2022-02-16T10:49:05+00:00",
        "number": "http://bqbl.it/a668abf2-a47b-40fa-972d-91cea40a0e30",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4580ad667c92474cd62e93c1bd953a92/barcode/image/a668abf2-a47b-40fa-972d-91cea40a0e30/63f30cee-a9e0-4783-805a-f73cae557316.svg",
        "owner_id": "829a99b6-bc9b-42c2-aeb0-53bea0160731",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/829a99b6-bc9b-42c2-aeb0-53bea0160731"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff4419d75-6d27-4bdd-a1f6-5e40eaa86708&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f4419d75-6d27-4bdd-a1f6-5e40eaa86708",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-16T10:49:06+00:00",
        "updated_at": "2022-02-16T10:49:06+00:00",
        "number": "http://bqbl.it/f4419d75-6d27-4bdd-a1f6-5e40eaa86708",
        "barcode_type": "qr_code",
        "image_url": "/uploads/de551fd7af4c78577a6e3a867aa96f92/barcode/image/f4419d75-6d27-4bdd-a1f6-5e40eaa86708/4687a134-0b03-4bfe-a30f-9f128013747a.svg",
        "owner_id": "3b894298-09fb-4e31-9b6f-31a7d648731f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3b894298-09fb-4e31-9b6f-31a7d648731f"
          },
          "data": {
            "type": "customers",
            "id": "3b894298-09fb-4e31-9b6f-31a7d648731f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3b894298-09fb-4e31-9b6f-31a7d648731f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-16T10:49:06+00:00",
        "updated_at": "2022-02-16T10:49:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Stiedemann, Veum and Hirthe",
        "email": "hirthe.stiedemann.and.veum@little-champlin.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=3b894298-09fb-4e31-9b6f-31a7d648731f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3b894298-09fb-4e31-9b6f-31a7d648731f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3b894298-09fb-4e31-9b6f-31a7d648731f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDExYjAxY2MtNmVhMS00YjNlLTk1ZWUtMTYzOTMyZTIwYjYw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "011b01cc-6ea1-4b3e-95ee-163932e20b60",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-02-16T10:49:07+00:00",
        "updated_at": "2022-02-16T10:49:07+00:00",
        "number": "http://bqbl.it/011b01cc-6ea1-4b3e-95ee-163932e20b60",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8a0dbd833e996c6f812546839326b7d2/barcode/image/011b01cc-6ea1-4b3e-95ee-163932e20b60/09bb5209-fa71-4e13-a465-895903215056.svg",
        "owner_id": "21b93945-617a-4df3-b2d8-c326c6d48ea7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/21b93945-617a-4df3-b2d8-c326c6d48ea7"
          },
          "data": {
            "type": "customers",
            "id": "21b93945-617a-4df3-b2d8-c326c6d48ea7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "21b93945-617a-4df3-b2d8-c326c6d48ea7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-16T10:49:07+00:00",
        "updated_at": "2022-02-16T10:49:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Greenholt, Hackett and Waters",
        "email": "waters.greenholt.hackett.and@mayert.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=21b93945-617a-4df3-b2d8-c326c6d48ea7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=21b93945-617a-4df3-b2d8-c326c6d48ea7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=21b93945-617a-4df3-b2d8-c326c6d48ea7&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-16T10:48:53Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/95379661-47b0-4ef9-8d83-b033978bb2d3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "95379661-47b0-4ef9-8d83-b033978bb2d3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-16T10:49:07+00:00",
      "updated_at": "2022-02-16T10:49:07+00:00",
      "number": "http://bqbl.it/95379661-47b0-4ef9-8d83-b033978bb2d3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eeeb2cf891f6294925a7bbb7c88e949b/barcode/image/95379661-47b0-4ef9-8d83-b033978bb2d3/f666874d-aadd-48e2-b7dc-eb7ea80104b7.svg",
      "owner_id": "861b2dba-336f-4062-a03a-6c626e4c3cb8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/861b2dba-336f-4062-a03a-6c626e4c3cb8"
        },
        "data": {
          "type": "customers",
          "id": "861b2dba-336f-4062-a03a-6c626e4c3cb8"
        }
      }
    }
  },
  "included": [
    {
      "id": "861b2dba-336f-4062-a03a-6c626e4c3cb8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-02-16T10:49:07+00:00",
        "updated_at": "2022-02-16T10:49:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Mosciski, Schroeder and Smith",
        "email": "mosciski_and_schroeder_smith@abshire-ferry.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=861b2dba-336f-4062-a03a-6c626e4c3cb8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=861b2dba-336f-4062-a03a-6c626e4c3cb8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=861b2dba-336f-4062-a03a-6c626e4c3cb8&filter[owner_type]=customers"
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
          "owner_id": "11cda074-6de0-425b-a416-b01fadfe777f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "177fef65-990f-49d3-99a4-ffdd3d3801fc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-16T10:49:08+00:00",
      "updated_at": "2022-02-16T10:49:08+00:00",
      "number": "http://bqbl.it/177fef65-990f-49d3-99a4-ffdd3d3801fc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8b27a663b20a34e66044bf5b44bf7639/barcode/image/177fef65-990f-49d3-99a4-ffdd3d3801fc/a309cb9c-27dc-402a-9466-e5574fc67cb9.svg",
      "owner_id": "11cda074-6de0-425b-a416-b01fadfe777f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3d97eb2d-249a-4c72-93c2-68ac2019ad4e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3d97eb2d-249a-4c72-93c2-68ac2019ad4e",
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
    "id": "3d97eb2d-249a-4c72-93c2-68ac2019ad4e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-02-16T10:49:09+00:00",
      "updated_at": "2022-02-16T10:49:09+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8ab86033471b99757c4aa2309ad05fb9/barcode/image/3d97eb2d-249a-4c72-93c2-68ac2019ad4e/ebf41b15-20eb-48c2-b372-05cf80814959.svg",
      "owner_id": "c75f02c0-59b5-4f38-87b5-bc116f457c9f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c4109531-4215-4a43-998f-31ad07bb5a0b' \
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