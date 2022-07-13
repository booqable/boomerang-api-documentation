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
      "id": "9c1b4ebc-82cd-4f3a-92f1-92d39eeeb2a1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T08:17:21+00:00",
        "updated_at": "2022-07-13T08:17:21+00:00",
        "number": "http://bqbl.it/9c1b4ebc-82cd-4f3a-92f1-92d39eeeb2a1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b61171e4034d40ac0fd944d2c8101a48/barcode/image/9c1b4ebc-82cd-4f3a-92f1-92d39eeeb2a1/102c7e27-7437-48c2-a3c6-76cccd9f0fb2.svg",
        "owner_id": "ef28ca96-63ae-47a7-ba30-cfc70dbb36f6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ef28ca96-63ae-47a7-ba30-cfc70dbb36f6"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa864d5d8-ecde-4d3b-a48d-5c8193acfffb&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a864d5d8-ecde-4d3b-a48d-5c8193acfffb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T08:17:21+00:00",
        "updated_at": "2022-07-13T08:17:21+00:00",
        "number": "http://bqbl.it/a864d5d8-ecde-4d3b-a48d-5c8193acfffb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b840c2434f9dea0052d235da6af15823/barcode/image/a864d5d8-ecde-4d3b-a48d-5c8193acfffb/692f1d0a-6b6f-4d21-9da4-d67961d6bf69.svg",
        "owner_id": "ab51f009-cf2f-415e-aead-8b3664f4a9d6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ab51f009-cf2f-415e-aead-8b3664f4a9d6"
          },
          "data": {
            "type": "customers",
            "id": "ab51f009-cf2f-415e-aead-8b3664f4a9d6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ab51f009-cf2f-415e-aead-8b3664f4a9d6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T08:17:21+00:00",
        "updated_at": "2022-07-13T08:17:21+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hodkiewicz-Fay",
        "email": "fay.hodkiewicz@kub-hammes.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=ab51f009-cf2f-415e-aead-8b3664f4a9d6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ab51f009-cf2f-415e-aead-8b3664f4a9d6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ab51f009-cf2f-415e-aead-8b3664f4a9d6&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDQ1ODkyN2YtNmUyOS00NDBmLWJmY2UtZjJhYTIwOTFmNWUz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4458927f-6e29-440f-bfce-f2aa2091f5e3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-13T08:17:22+00:00",
        "updated_at": "2022-07-13T08:17:22+00:00",
        "number": "http://bqbl.it/4458927f-6e29-440f-bfce-f2aa2091f5e3",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5706501173807f6e6d9b203695ebd96a/barcode/image/4458927f-6e29-440f-bfce-f2aa2091f5e3/73850b60-8dc7-466c-9fab-c1352a805727.svg",
        "owner_id": "93c36b77-aa88-42b6-9b0e-bd6357672672",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/93c36b77-aa88-42b6-9b0e-bd6357672672"
          },
          "data": {
            "type": "customers",
            "id": "93c36b77-aa88-42b6-9b0e-bd6357672672"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "93c36b77-aa88-42b6-9b0e-bd6357672672",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T08:17:22+00:00",
        "updated_at": "2022-07-13T08:17:22+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Dietrich-Torphy",
        "email": "torphy_dietrich@bauch.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=93c36b77-aa88-42b6-9b0e-bd6357672672&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=93c36b77-aa88-42b6-9b0e-bd6357672672&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=93c36b77-aa88-42b6-9b0e-bd6357672672&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T08:17:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e6d3b6ac-5ebc-4b5b-955e-b77afd1285a8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e6d3b6ac-5ebc-4b5b-955e-b77afd1285a8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T08:17:22+00:00",
      "updated_at": "2022-07-13T08:17:22+00:00",
      "number": "http://bqbl.it/e6d3b6ac-5ebc-4b5b-955e-b77afd1285a8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/97a9c0689be8388ba403645bda96128b/barcode/image/e6d3b6ac-5ebc-4b5b-955e-b77afd1285a8/1b8aaddd-26e5-4f70-ad46-386bf35c61cf.svg",
      "owner_id": "30173bdf-9b36-419c-a052-1a068f69a7f7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/30173bdf-9b36-419c-a052-1a068f69a7f7"
        },
        "data": {
          "type": "customers",
          "id": "30173bdf-9b36-419c-a052-1a068f69a7f7"
        }
      }
    }
  },
  "included": [
    {
      "id": "30173bdf-9b36-419c-a052-1a068f69a7f7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-13T08:17:22+00:00",
        "updated_at": "2022-07-13T08:17:22+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Schmeler-Swaniawski",
        "email": "swaniawski_schmeler@okeefe.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=30173bdf-9b36-419c-a052-1a068f69a7f7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=30173bdf-9b36-419c-a052-1a068f69a7f7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=30173bdf-9b36-419c-a052-1a068f69a7f7&filter[owner_type]=customers"
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
          "owner_id": "444b98d9-02b3-4262-a043-0432c33c4ee8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e45c0b1c-0d98-498d-9652-4deb918998c7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T08:17:23+00:00",
      "updated_at": "2022-07-13T08:17:23+00:00",
      "number": "http://bqbl.it/e45c0b1c-0d98-498d-9652-4deb918998c7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/04ea70fcaf5f8b166b84c9f11aef104d/barcode/image/e45c0b1c-0d98-498d-9652-4deb918998c7/481f0376-9a83-43fe-9c8d-9efd2d9723a2.svg",
      "owner_id": "444b98d9-02b3-4262-a043-0432c33c4ee8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/81567589-2b26-4ced-817b-3a48600e79c0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "81567589-2b26-4ced-817b-3a48600e79c0",
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
    "id": "81567589-2b26-4ced-817b-3a48600e79c0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-13T08:17:23+00:00",
      "updated_at": "2022-07-13T08:17:23+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7ab35e20efbf3aa88a4589e43c887536/barcode/image/81567589-2b26-4ced-817b-3a48600e79c0/d12bde5e-6c6b-433e-9f69-48b85dae73b7.svg",
      "owner_id": "bc1567d3-1437-4e30-bc5d-0fcb1963f382",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/75009a2c-c500-4e68-8137-e87825c7aeef' \
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