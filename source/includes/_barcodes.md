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
`PUT /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`GET /api/boomerang/barcodes`

`DELETE /api/boomerang/barcodes/{id}`

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


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/9e103cda-7d6c-4cae-965d-2628902c4a70' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9e103cda-7d6c-4cae-965d-2628902c4a70",
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
    "id": "9e103cda-7d6c-4cae-965d-2628902c4a70",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-03-04T09:19:15+00:00",
      "updated_at": "2024-03-04T09:19:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-255.lvh.me:/barcodes/9e103cda-7d6c-4cae-965d-2628902c4a70/image",
      "owner_id": "3f42ee37-5a14-41ef-93d9-147eeb8a74c3",
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
          "owner_id": "36da57d5-cd9b-49d2-b3b0-9c30b8ef1bc9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0416899c-75b6-4232-b0af-00ba691dd86e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-03-04T09:19:16+00:00",
      "updated_at": "2024-03-04T09:19:16+00:00",
      "number": "http://bqbl.it/0416899c-75b6-4232-b0af-00ba691dd86e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-256.lvh.me:/barcodes/0416899c-75b6-4232-b0af-00ba691dd86e/image",
      "owner_id": "36da57d5-cd9b-49d2-b3b0-9c30b8ef1bc9",
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






## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F08ed6f0d-1e0b-4774-91a7-f59e3de4d705&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "08ed6f0d-1e0b-4774-91a7-f59e3de4d705",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-03-04T09:19:16+00:00",
        "updated_at": "2024-03-04T09:19:16+00:00",
        "number": "http://bqbl.it/08ed6f0d-1e0b-4774-91a7-f59e3de4d705",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-257.lvh.me:/barcodes/08ed6f0d-1e0b-4774-91a7-f59e3de4d705/image",
        "owner_id": "3c14e51c-e264-4ee8-92de-3dc5855acab4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3c14e51c-e264-4ee8-92de-3dc5855acab4"
          },
          "data": {
            "type": "customers",
            "id": "3c14e51c-e264-4ee8-92de-3dc5855acab4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3c14e51c-e264-4ee8-92de-3dc5855acab4",
      "type": "customers",
      "attributes": {
        "created_at": "2024-03-04T09:19:16+00:00",
        "updated_at": "2024-03-04T09:19:16+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-74@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=3c14e51c-e264-4ee8-92de-3dc5855acab4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3c14e51c-e264-4ee8-92de-3dc5855acab4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3c14e51c-e264-4ee8-92de-3dc5855acab4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTkyYTA5YTgtMjVkMS00MDZlLTgyY2UtMjlkM2RiNTQ5OGIy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "192a09a8-25d1-406e-82ce-29d3db5498b2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-03-04T09:19:17+00:00",
        "updated_at": "2024-03-04T09:19:17+00:00",
        "number": "http://bqbl.it/192a09a8-25d1-406e-82ce-29d3db5498b2",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-258.lvh.me:/barcodes/192a09a8-25d1-406e-82ce-29d3db5498b2/image",
        "owner_id": "e5b97886-d71d-46fc-a6ed-3e85f2c24654",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e5b97886-d71d-46fc-a6ed-3e85f2c24654"
          },
          "data": {
            "type": "customers",
            "id": "e5b97886-d71d-46fc-a6ed-3e85f2c24654"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e5b97886-d71d-46fc-a6ed-3e85f2c24654",
      "type": "customers",
      "attributes": {
        "created_at": "2024-03-04T09:19:17+00:00",
        "updated_at": "2024-03-04T09:19:17+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-76@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=e5b97886-d71d-46fc-a6ed-3e85f2c24654&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e5b97886-d71d-46fc-a6ed-3e85f2c24654&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e5b97886-d71d-46fc-a6ed-3e85f2c24654&filter[owner_type]=customers"
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
      "id": "283d92d1-dafa-441a-81db-b57055e08f7a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-03-04T09:19:17+00:00",
        "updated_at": "2024-03-04T09:19:17+00:00",
        "number": "http://bqbl.it/283d92d1-dafa-441a-81db-b57055e08f7a",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-259.lvh.me:/barcodes/283d92d1-dafa-441a-81db-b57055e08f7a/image",
        "owner_id": "f5fee39c-8a64-4022-9ef2-22cea7bd3f01",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f5fee39c-8a64-4022-9ef2-22cea7bd3f01"
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/5a6aa25f-1945-4dc7-9665-a4224c92e3c6' \
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
## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/1fac9385-ef87-4b5a-8761-3d280fae79a8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1fac9385-ef87-4b5a-8761-3d280fae79a8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-03-04T09:19:18+00:00",
      "updated_at": "2024-03-04T09:19:18+00:00",
      "number": "http://bqbl.it/1fac9385-ef87-4b5a-8761-3d280fae79a8",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-261.lvh.me:/barcodes/1fac9385-ef87-4b5a-8761-3d280fae79a8/image",
      "owner_id": "31246abe-1352-4246-afd8-26332356d9ce",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/31246abe-1352-4246-afd8-26332356d9ce"
        },
        "data": {
          "type": "customers",
          "id": "31246abe-1352-4246-afd8-26332356d9ce"
        }
      }
    }
  },
  "included": [
    {
      "id": "31246abe-1352-4246-afd8-26332356d9ce",
      "type": "customers",
      "attributes": {
        "created_at": "2024-03-04T09:19:18+00:00",
        "updated_at": "2024-03-04T09:19:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-79@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=31246abe-1352-4246-afd8-26332356d9ce&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=31246abe-1352-4246-afd8-26332356d9ce&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=31246abe-1352-4246-afd8-26332356d9ce&filter[owner_type]=customers"
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





