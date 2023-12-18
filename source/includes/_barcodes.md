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

`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

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



> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGI4NTM5OTgtMGQxZC00YTkzLTk5NDgtOGFlYTY4MTY1NzY0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "db853998-0d1d-4a93-9948-8aea68165764",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-18T09:19:58+00:00",
        "updated_at": "2023-12-18T09:19:58+00:00",
        "number": "http://bqbl.it/db853998-0d1d-4a93-9948-8aea68165764",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-229.shop.lvh.me:/barcodes/db853998-0d1d-4a93-9948-8aea68165764/image",
        "owner_id": "279d9418-e0a7-4ab6-a916-4ff374f6e70e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/279d9418-e0a7-4ab6-a916-4ff374f6e70e"
          },
          "data": {
            "type": "customers",
            "id": "279d9418-e0a7-4ab6-a916-4ff374f6e70e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "279d9418-e0a7-4ab6-a916-4ff374f6e70e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-18T09:19:58+00:00",
        "updated_at": "2023-12-18T09:19:58+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-66@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=279d9418-e0a7-4ab6-a916-4ff374f6e70e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=279d9418-e0a7-4ab6-a916-4ff374f6e70e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=279d9418-e0a7-4ab6-a916-4ff374f6e70e&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F800ee3b4-0890-4936-abac-f83fc7129519&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "800ee3b4-0890-4936-abac-f83fc7129519",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-18T09:19:59+00:00",
        "updated_at": "2023-12-18T09:19:59+00:00",
        "number": "http://bqbl.it/800ee3b4-0890-4936-abac-f83fc7129519",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-230.shop.lvh.me:/barcodes/800ee3b4-0890-4936-abac-f83fc7129519/image",
        "owner_id": "b3e361ad-98d5-4e03-9e6e-dd3732340ce3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b3e361ad-98d5-4e03-9e6e-dd3732340ce3"
          },
          "data": {
            "type": "customers",
            "id": "b3e361ad-98d5-4e03-9e6e-dd3732340ce3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b3e361ad-98d5-4e03-9e6e-dd3732340ce3",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-18T09:19:59+00:00",
        "updated_at": "2023-12-18T09:19:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-67@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=b3e361ad-98d5-4e03-9e6e-dd3732340ce3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b3e361ad-98d5-4e03-9e6e-dd3732340ce3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b3e361ad-98d5-4e03-9e6e-dd3732340ce3&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "50277602-7918-443d-9a80-323b341b4174",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-18T09:20:00+00:00",
        "updated_at": "2023-12-18T09:20:00+00:00",
        "number": "http://bqbl.it/50277602-7918-443d-9a80-323b341b4174",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-231.shop.lvh.me:/barcodes/50277602-7918-443d-9a80-323b341b4174/image",
        "owner_id": "96c2bf27-97bd-4319-a248-c4b170a7d049",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/96c2bf27-97bd-4319-a248-c4b170a7d049"
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/eefd9842-930d-433f-9c9d-94fb28197050' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eefd9842-930d-433f-9c9d-94fb28197050",
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
    "id": "eefd9842-930d-433f-9c9d-94fb28197050",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-18T09:20:00+00:00",
      "updated_at": "2023-12-18T09:20:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-232.shop.lvh.me:/barcodes/eefd9842-930d-433f-9c9d-94fb28197050/image",
      "owner_id": "63a257c5-5f37-49eb-b489-5464664a8f86",
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/67a0a5dd-78ac-42d3-be86-41c29a918e9d' \
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
          "owner_id": "923bdced-81e2-460d-9f0e-fdbd7b6dd8d7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dfbb6724-7172-428e-b6c5-8bba948dbebf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-18T09:20:02+00:00",
      "updated_at": "2023-12-18T09:20:02+00:00",
      "number": "http://bqbl.it/dfbb6724-7172-428e-b6c5-8bba948dbebf",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-234.shop.lvh.me:/barcodes/dfbb6724-7172-428e-b6c5-8bba948dbebf/image",
      "owner_id": "923bdced-81e2-460d-9f0e-fdbd7b6dd8d7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d8853474-8ba4-4b02-9e64-85ea56ff1363?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d8853474-8ba4-4b02-9e64-85ea56ff1363",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-18T09:20:03+00:00",
      "updated_at": "2023-12-18T09:20:03+00:00",
      "number": "http://bqbl.it/d8853474-8ba4-4b02-9e64-85ea56ff1363",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-235.shop.lvh.me:/barcodes/d8853474-8ba4-4b02-9e64-85ea56ff1363/image",
      "owner_id": "d3e48af5-0391-42fc-99a7-58401d16ea9f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d3e48af5-0391-42fc-99a7-58401d16ea9f"
        },
        "data": {
          "type": "customers",
          "id": "d3e48af5-0391-42fc-99a7-58401d16ea9f"
        }
      }
    }
  },
  "included": [
    {
      "id": "d3e48af5-0391-42fc-99a7-58401d16ea9f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-18T09:20:03+00:00",
        "updated_at": "2023-12-18T09:20:03+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-73@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=d3e48af5-0391-42fc-99a7-58401d16ea9f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d3e48af5-0391-42fc-99a7-58401d16ea9f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d3e48af5-0391-42fc-99a7-58401d16ea9f&filter[owner_type]=customers"
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





