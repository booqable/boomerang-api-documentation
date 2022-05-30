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
      "id": "5b556c8e-4264-48b5-a726-7bafb1ed9658",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-30T12:17:37+00:00",
        "updated_at": "2022-05-30T12:17:37+00:00",
        "number": "http://bqbl.it/5b556c8e-4264-48b5-a726-7bafb1ed9658",
        "barcode_type": "qr_code",
        "image_url": "/uploads/077dd0cbcab6e945fd59c75c1963db92/barcode/image/5b556c8e-4264-48b5-a726-7bafb1ed9658/461f56ca-a376-4678-a4f4-0e64ca69094e.svg",
        "owner_id": "2353eabd-1cf3-43d6-9d7d-871ca9f59ee6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2353eabd-1cf3-43d6-9d7d-871ca9f59ee6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1169ab57-3bec-4f6c-aefe-a36258cbc68e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1169ab57-3bec-4f6c-aefe-a36258cbc68e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-30T12:17:38+00:00",
        "updated_at": "2022-05-30T12:17:38+00:00",
        "number": "http://bqbl.it/1169ab57-3bec-4f6c-aefe-a36258cbc68e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/58d79660fd9135aae076502ab66478a0/barcode/image/1169ab57-3bec-4f6c-aefe-a36258cbc68e/93307e68-d4ca-488d-99cb-7413eba5ab11.svg",
        "owner_id": "023d74ff-5dca-4764-b6e4-1b79a645be4f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/023d74ff-5dca-4764-b6e4-1b79a645be4f"
          },
          "data": {
            "type": "customers",
            "id": "023d74ff-5dca-4764-b6e4-1b79a645be4f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "023d74ff-5dca-4764-b6e4-1b79a645be4f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-30T12:17:38+00:00",
        "updated_at": "2022-05-30T12:17:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Nolan and Sons",
        "email": "and.sons.nolan@mcglynn-hickle.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=023d74ff-5dca-4764-b6e4-1b79a645be4f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=023d74ff-5dca-4764-b6e4-1b79a645be4f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=023d74ff-5dca-4764-b6e4-1b79a645be4f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzEwYjViMGItMzE3NC00MmU1LThlNWItNzU0YTdiMjI0NDRm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "710b5b0b-3174-42e5-8e5b-754a7b22444f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-30T12:17:39+00:00",
        "updated_at": "2022-05-30T12:17:39+00:00",
        "number": "http://bqbl.it/710b5b0b-3174-42e5-8e5b-754a7b22444f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/144fc61de07b3787b803bb7dac2a4d37/barcode/image/710b5b0b-3174-42e5-8e5b-754a7b22444f/b630f530-9e07-4f8c-9f1f-0489a8140a51.svg",
        "owner_id": "565e0a89-af3e-49ad-9d84-b4a4f6d00f63",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/565e0a89-af3e-49ad-9d84-b4a4f6d00f63"
          },
          "data": {
            "type": "customers",
            "id": "565e0a89-af3e-49ad-9d84-b4a4f6d00f63"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "565e0a89-af3e-49ad-9d84-b4a4f6d00f63",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-30T12:17:39+00:00",
        "updated_at": "2022-05-30T12:17:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Beer-Anderson",
        "email": "beer.anderson@schultz.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=565e0a89-af3e-49ad-9d84-b4a4f6d00f63&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=565e0a89-af3e-49ad-9d84-b4a4f6d00f63&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=565e0a89-af3e-49ad-9d84-b4a4f6d00f63&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-30T12:17:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/33d177a6-31bd-414a-a125-966a28101b23?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "33d177a6-31bd-414a-a125-966a28101b23",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-30T12:17:39+00:00",
      "updated_at": "2022-05-30T12:17:39+00:00",
      "number": "http://bqbl.it/33d177a6-31bd-414a-a125-966a28101b23",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2ed658eed482eb21ee3c2f13415ae3f9/barcode/image/33d177a6-31bd-414a-a125-966a28101b23/2eb32519-1881-4e59-bde2-2393e1a14f9e.svg",
      "owner_id": "3f0a0037-51f4-4469-a6c3-489775af040f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3f0a0037-51f4-4469-a6c3-489775af040f"
        },
        "data": {
          "type": "customers",
          "id": "3f0a0037-51f4-4469-a6c3-489775af040f"
        }
      }
    }
  },
  "included": [
    {
      "id": "3f0a0037-51f4-4469-a6c3-489775af040f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-30T12:17:39+00:00",
        "updated_at": "2022-05-30T12:17:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hagenes, Glover and Beatty",
        "email": "and_beatty_hagenes_glover@aufderhar-schroeder.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=3f0a0037-51f4-4469-a6c3-489775af040f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3f0a0037-51f4-4469-a6c3-489775af040f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3f0a0037-51f4-4469-a6c3-489775af040f&filter[owner_type]=customers"
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
          "owner_id": "f40d8255-4c9a-4644-8e21-f9488f465adb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7b22db71-c03c-48e9-a335-7655911ba912",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-30T12:17:40+00:00",
      "updated_at": "2022-05-30T12:17:40+00:00",
      "number": "http://bqbl.it/7b22db71-c03c-48e9-a335-7655911ba912",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f330637eb208613d34c60d310b6f8039/barcode/image/7b22db71-c03c-48e9-a335-7655911ba912/c8b4a742-27ce-4af3-a4f6-7a96e8aa94a3.svg",
      "owner_id": "f40d8255-4c9a-4644-8e21-f9488f465adb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/39ed318b-3c54-42e4-ae14-302b1a000b6d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "39ed318b-3c54-42e4-ae14-302b1a000b6d",
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
    "id": "39ed318b-3c54-42e4-ae14-302b1a000b6d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-30T12:17:40+00:00",
      "updated_at": "2022-05-30T12:17:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/96311bde646c5fdbe7f945c91805acd1/barcode/image/39ed318b-3c54-42e4-ae14-302b1a000b6d/05f6a842-176d-4347-a5ca-2697b857f5c8.svg",
      "owner_id": "ebf839bc-1bc9-4185-b000-75bf52aaf3f1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8c186408-ff39-4ed4-b908-ba45adb117fc' \
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