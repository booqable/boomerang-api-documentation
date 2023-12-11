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
`DELETE /api/boomerang/barcodes/{id}`

`PUT /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

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


## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b30f5dee-e12d-4181-b182-46031ace314a' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes
## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/77d741d3-973f-491b-93f1-6bccffbf4f8f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "77d741d3-973f-491b-93f1-6bccffbf4f8f",
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
    "id": "77d741d3-973f-491b-93f1-6bccffbf4f8f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-11T15:28:46+00:00",
      "updated_at": "2023-12-11T15:28:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-79.shop.lvh.me:/barcodes/77d741d3-973f-491b-93f1-6bccffbf4f8f/image",
      "owner_id": "b0991e4d-8063-484c-bad3-4a033e52e259",
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
          "owner_id": "2cf5b22d-445e-4096-8eca-502d09684ec2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f119e04b-6f91-43d3-91ae-bb43ab11dbaa",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-11T15:28:47+00:00",
      "updated_at": "2023-12-11T15:28:47+00:00",
      "number": "http://bqbl.it/f119e04b-6f91-43d3-91ae-bb43ab11dbaa",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-80.shop.lvh.me:/barcodes/f119e04b-6f91-43d3-91ae-bb43ab11dbaa/image",
      "owner_id": "2cf5b22d-445e-4096-8eca-502d09684ec2",
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

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f066ada-88c0-4dfa-a906-44b003d7f7b7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9f066ada-88c0-4dfa-a906-44b003d7f7b7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-11T15:28:47+00:00",
      "updated_at": "2023-12-11T15:28:47+00:00",
      "number": "http://bqbl.it/9f066ada-88c0-4dfa-a906-44b003d7f7b7",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-81.shop.lvh.me:/barcodes/9f066ada-88c0-4dfa-a906-44b003d7f7b7/image",
      "owner_id": "fade6969-a459-4a0e-a1b5-ee4a1b7ca033",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fade6969-a459-4a0e-a1b5-ee4a1b7ca033"
        },
        "data": {
          "type": "customers",
          "id": "fade6969-a459-4a0e-a1b5-ee4a1b7ca033"
        }
      }
    }
  },
  "included": [
    {
      "id": "fade6969-a459-4a0e-a1b5-ee4a1b7ca033",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-11T15:28:47+00:00",
        "updated_at": "2023-12-11T15:28:47+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-6@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=fade6969-a459-4a0e-a1b5-ee4a1b7ca033&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fade6969-a459-4a0e-a1b5-ee4a1b7ca033&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fade6969-a459-4a0e-a1b5-ee4a1b7ca033&filter[owner_type]=customers"
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

`owner`






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
      "id": "18af549b-2861-4f61-b2e3-669973765f6e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-11T15:28:48+00:00",
        "updated_at": "2023-12-11T15:28:48+00:00",
        "number": "http://bqbl.it/18af549b-2861-4f61-b2e3-669973765f6e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-82.shop.lvh.me:/barcodes/18af549b-2861-4f61-b2e3-669973765f6e/image",
        "owner_id": "39f92917-5b6a-4025-8ec3-d3028126d76b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/39f92917-5b6a-4025-8ec3-d3028126d76b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDk1MDVmY2YtMTBhOC00MTRhLWE4MTQtOTRkZmRmNGIyYmRl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "49505fcf-10a8-414a-a814-94dfdf4b2bde",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-11T15:28:49+00:00",
        "updated_at": "2023-12-11T15:28:49+00:00",
        "number": "http://bqbl.it/49505fcf-10a8-414a-a814-94dfdf4b2bde",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-83.shop.lvh.me:/barcodes/49505fcf-10a8-414a-a814-94dfdf4b2bde/image",
        "owner_id": "476e5e8b-26c9-4e3e-8936-5f4b548ae74c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/476e5e8b-26c9-4e3e-8936-5f4b548ae74c"
          },
          "data": {
            "type": "customers",
            "id": "476e5e8b-26c9-4e3e-8936-5f4b548ae74c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "476e5e8b-26c9-4e3e-8936-5f4b548ae74c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-11T15:28:49+00:00",
        "updated_at": "2023-12-11T15:28:49+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-9@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=476e5e8b-26c9-4e3e-8936-5f4b548ae74c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=476e5e8b-26c9-4e3e-8936-5f4b548ae74c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=476e5e8b-26c9-4e3e-8936-5f4b548ae74c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F6673e6c3-e50f-465b-9564-598886066859&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6673e6c3-e50f-465b-9564-598886066859",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-11T15:28:49+00:00",
        "updated_at": "2023-12-11T15:28:49+00:00",
        "number": "http://bqbl.it/6673e6c3-e50f-465b-9564-598886066859",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-84.shop.lvh.me:/barcodes/6673e6c3-e50f-465b-9564-598886066859/image",
        "owner_id": "cac7d99a-df7f-4df8-8956-92a91168cca5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cac7d99a-df7f-4df8-8956-92a91168cca5"
          },
          "data": {
            "type": "customers",
            "id": "cac7d99a-df7f-4df8-8956-92a91168cca5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cac7d99a-df7f-4df8-8956-92a91168cca5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-11T15:28:49+00:00",
        "updated_at": "2023-12-11T15:28:49+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-10@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=cac7d99a-df7f-4df8-8956-92a91168cca5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cac7d99a-df7f-4df8-8956-92a91168cca5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cac7d99a-df7f-4df8-8956-92a91168cca5&filter[owner_type]=customers"
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

`owner`





