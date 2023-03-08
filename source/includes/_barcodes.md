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
      "id": "f5071890-21cf-477c-95ca-12ab92e8434b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T09:17:50+00:00",
        "updated_at": "2023-03-08T09:17:50+00:00",
        "number": "http://bqbl.it/f5071890-21cf-477c-95ca-12ab92e8434b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bbc0d377e5197d3da5b72c026aff33dd/barcode/image/f5071890-21cf-477c-95ca-12ab92e8434b/393de9b6-473a-436a-aa1a-da1802f154f7.svg",
        "owner_id": "7b6acfd4-3ca5-48bd-9a51-c4a4f90b4e65",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7b6acfd4-3ca5-48bd-9a51-c4a4f90b4e65"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd8b1b5c5-ecd1-4002-8345-ac48361899d1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d8b1b5c5-ecd1-4002-8345-ac48361899d1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T09:17:50+00:00",
        "updated_at": "2023-03-08T09:17:50+00:00",
        "number": "http://bqbl.it/d8b1b5c5-ecd1-4002-8345-ac48361899d1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f33108df5fb816756fd942edc031d259/barcode/image/d8b1b5c5-ecd1-4002-8345-ac48361899d1/0b60c501-05c0-469d-b602-f802db44a4c7.svg",
        "owner_id": "c9017371-a9b5-44cd-8ded-97cee557e49f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c9017371-a9b5-44cd-8ded-97cee557e49f"
          },
          "data": {
            "type": "customers",
            "id": "c9017371-a9b5-44cd-8ded-97cee557e49f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c9017371-a9b5-44cd-8ded-97cee557e49f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T09:17:50+00:00",
        "updated_at": "2023-03-08T09:17:50+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c9017371-a9b5-44cd-8ded-97cee557e49f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c9017371-a9b5-44cd-8ded-97cee557e49f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c9017371-a9b5-44cd-8ded-97cee557e49f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODZiZTY3NjUtMmFjOS00NmFhLWExMWItOTc2MWU4MDA2ZDE4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "86be6765-2ac9-46aa-a11b-9761e8006d18",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-08T09:17:51+00:00",
        "updated_at": "2023-03-08T09:17:51+00:00",
        "number": "http://bqbl.it/86be6765-2ac9-46aa-a11b-9761e8006d18",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ae8ae763f4217abe9ba70fe53546da35/barcode/image/86be6765-2ac9-46aa-a11b-9761e8006d18/81f13a9a-1cde-4141-b0da-80aefcb42981.svg",
        "owner_id": "9e6cf220-674b-4fcf-8557-801c1fb9b51e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9e6cf220-674b-4fcf-8557-801c1fb9b51e"
          },
          "data": {
            "type": "customers",
            "id": "9e6cf220-674b-4fcf-8557-801c1fb9b51e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9e6cf220-674b-4fcf-8557-801c1fb9b51e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T09:17:51+00:00",
        "updated_at": "2023-03-08T09:17:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9e6cf220-674b-4fcf-8557-801c1fb9b51e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9e6cf220-674b-4fcf-8557-801c1fb9b51e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9e6cf220-674b-4fcf-8557-801c1fb9b51e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:17:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/baa7c9b6-1452-48b5-a8a7-6a35e1d891b0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "baa7c9b6-1452-48b5-a8a7-6a35e1d891b0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T09:17:51+00:00",
      "updated_at": "2023-03-08T09:17:51+00:00",
      "number": "http://bqbl.it/baa7c9b6-1452-48b5-a8a7-6a35e1d891b0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/37c47bfb527980e1d44f410a4f21d776/barcode/image/baa7c9b6-1452-48b5-a8a7-6a35e1d891b0/e3dfd96d-c88b-40ad-8281-c06b29e16c56.svg",
      "owner_id": "8a7eb3f4-e9d5-49a6-8650-735021e55dd8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8a7eb3f4-e9d5-49a6-8650-735021e55dd8"
        },
        "data": {
          "type": "customers",
          "id": "8a7eb3f4-e9d5-49a6-8650-735021e55dd8"
        }
      }
    }
  },
  "included": [
    {
      "id": "8a7eb3f4-e9d5-49a6-8650-735021e55dd8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-08T09:17:51+00:00",
        "updated_at": "2023-03-08T09:17:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=8a7eb3f4-e9d5-49a6-8650-735021e55dd8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a7eb3f4-e9d5-49a6-8650-735021e55dd8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a7eb3f4-e9d5-49a6-8650-735021e55dd8&filter[owner_type]=customers"
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
          "owner_id": "c635a9f7-3381-4074-b240-567bd1d501df",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "63a72ff0-6308-4155-9af8-859758d536f3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T09:17:52+00:00",
      "updated_at": "2023-03-08T09:17:52+00:00",
      "number": "http://bqbl.it/63a72ff0-6308-4155-9af8-859758d536f3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e3fd1da0d2e4c08f6090f125221e1487/barcode/image/63a72ff0-6308-4155-9af8-859758d536f3/6b97cec0-619a-43db-9fc0-dac446d4c50f.svg",
      "owner_id": "c635a9f7-3381-4074-b240-567bd1d501df",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/751fb7ff-f70a-4eab-815e-27c200a194da' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "751fb7ff-f70a-4eab-815e-27c200a194da",
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
    "id": "751fb7ff-f70a-4eab-815e-27c200a194da",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-08T09:17:53+00:00",
      "updated_at": "2023-03-08T09:17:53+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/af959dd245ed3ed4aaff59e49d2a0d69/barcode/image/751fb7ff-f70a-4eab-815e-27c200a194da/0d555461-1992-44b0-b131-d5e84fe73d2e.svg",
      "owner_id": "5b2549bb-816e-40c2-9f92-d4b6446a2c6c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2509bce6-e77f-4c84-a749-046209c09a69' \
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