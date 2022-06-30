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
      "id": "b1253cb1-482e-43b0-9638-637029963c07",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T12:40:38+00:00",
        "updated_at": "2022-06-30T12:40:38+00:00",
        "number": "http://bqbl.it/b1253cb1-482e-43b0-9638-637029963c07",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b3838ecbfc6b71aa16434b8474639883/barcode/image/b1253cb1-482e-43b0-9638-637029963c07/e180bae6-9754-4660-af40-0b9937b2236b.svg",
        "owner_id": "3614d3c9-c570-4cf3-ae66-fbdb0494524e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3614d3c9-c570-4cf3-ae66-fbdb0494524e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F860e76a8-9cd7-482d-8e11-d7d10a6e37d0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "860e76a8-9cd7-482d-8e11-d7d10a6e37d0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T12:40:38+00:00",
        "updated_at": "2022-06-30T12:40:38+00:00",
        "number": "http://bqbl.it/860e76a8-9cd7-482d-8e11-d7d10a6e37d0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e3b5585d938f24653e19f858587c834b/barcode/image/860e76a8-9cd7-482d-8e11-d7d10a6e37d0/06f53fda-f0d0-41ef-a1a7-67f625f59aed.svg",
        "owner_id": "1758c486-e9fe-4641-bb7f-b95befb6e8cb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1758c486-e9fe-4641-bb7f-b95befb6e8cb"
          },
          "data": {
            "type": "customers",
            "id": "1758c486-e9fe-4641-bb7f-b95befb6e8cb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1758c486-e9fe-4641-bb7f-b95befb6e8cb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T12:40:38+00:00",
        "updated_at": "2022-06-30T12:40:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "DuBuque, Gutkowski and Ziemann",
        "email": "ziemann.dubuque.and.gutkowski@johns-turner.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=1758c486-e9fe-4641-bb7f-b95befb6e8cb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1758c486-e9fe-4641-bb7f-b95befb6e8cb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1758c486-e9fe-4641-bb7f-b95befb6e8cb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGQ5Y2U2NDItNGFjNy00MDAxLWIyNmMtYzZmNWE3NmEyNzBm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4d9ce642-4ac7-4001-b26c-c6f5a76a270f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-30T12:40:39+00:00",
        "updated_at": "2022-06-30T12:40:39+00:00",
        "number": "http://bqbl.it/4d9ce642-4ac7-4001-b26c-c6f5a76a270f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1c9b4003b8d3c6691b950eeb8268324c/barcode/image/4d9ce642-4ac7-4001-b26c-c6f5a76a270f/d7c33304-cfed-4530-b6d3-6a8fbb296da0.svg",
        "owner_id": "fc005a9a-dbf6-427b-86f6-79cb15ba6150",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fc005a9a-dbf6-427b-86f6-79cb15ba6150"
          },
          "data": {
            "type": "customers",
            "id": "fc005a9a-dbf6-427b-86f6-79cb15ba6150"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fc005a9a-dbf6-427b-86f6-79cb15ba6150",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T12:40:39+00:00",
        "updated_at": "2022-06-30T12:40:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "VonRueden Inc",
        "email": "vonrueden.inc@hermann.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=fc005a9a-dbf6-427b-86f6-79cb15ba6150&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fc005a9a-dbf6-427b-86f6-79cb15ba6150&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fc005a9a-dbf6-427b-86f6-79cb15ba6150&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T12:40:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cbf03ce1-adf3-4cc9-ad87-a0673c051e68?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cbf03ce1-adf3-4cc9-ad87-a0673c051e68",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T12:40:39+00:00",
      "updated_at": "2022-06-30T12:40:39+00:00",
      "number": "http://bqbl.it/cbf03ce1-adf3-4cc9-ad87-a0673c051e68",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fe73f64579659e968c3b9517028637b8/barcode/image/cbf03ce1-adf3-4cc9-ad87-a0673c051e68/8a4e8cd3-9e74-443e-b6dd-3da2e7439f39.svg",
      "owner_id": "98e0cebd-148d-4875-bd71-ecbe4ebbe61e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/98e0cebd-148d-4875-bd71-ecbe4ebbe61e"
        },
        "data": {
          "type": "customers",
          "id": "98e0cebd-148d-4875-bd71-ecbe4ebbe61e"
        }
      }
    }
  },
  "included": [
    {
      "id": "98e0cebd-148d-4875-bd71-ecbe4ebbe61e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-30T12:40:39+00:00",
        "updated_at": "2022-06-30T12:40:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "McKenzie Group",
        "email": "mckenzie.group@kozey.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=98e0cebd-148d-4875-bd71-ecbe4ebbe61e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=98e0cebd-148d-4875-bd71-ecbe4ebbe61e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=98e0cebd-148d-4875-bd71-ecbe4ebbe61e&filter[owner_type]=customers"
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
          "owner_id": "1c30567e-47e1-49ea-a748-14001df828d1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "21f1b449-6301-499a-a62d-4a5b176dec99",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T12:40:40+00:00",
      "updated_at": "2022-06-30T12:40:40+00:00",
      "number": "http://bqbl.it/21f1b449-6301-499a-a62d-4a5b176dec99",
      "barcode_type": "qr_code",
      "image_url": "/uploads/99e5d73e4ac6ac3a674bb5438b09728a/barcode/image/21f1b449-6301-499a-a62d-4a5b176dec99/7e691059-8c22-410d-918b-3bb5f39bce7f.svg",
      "owner_id": "1c30567e-47e1-49ea-a748-14001df828d1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7cdb457d-a623-4a85-be8c-ad07556ade3f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7cdb457d-a623-4a85-be8c-ad07556ade3f",
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
    "id": "7cdb457d-a623-4a85-be8c-ad07556ade3f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-30T12:40:40+00:00",
      "updated_at": "2022-06-30T12:40:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2d6c91b0cfe2124c0b3f25f18d72a75a/barcode/image/7cdb457d-a623-4a85-be8c-ad07556ade3f/06ae92ee-971c-43bc-95f8-4ef7fc824808.svg",
      "owner_id": "f8f0baf6-e496-469c-9ad3-370162db3882",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/872a0cbf-7446-4f49-8a64-cb6626844978' \
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