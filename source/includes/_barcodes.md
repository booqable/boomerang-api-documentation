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
      "id": "e46e96d0-dc19-4a7f-b64b-81a98cbfab78",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-06T08:12:18+00:00",
        "updated_at": "2022-07-06T08:12:18+00:00",
        "number": "http://bqbl.it/e46e96d0-dc19-4a7f-b64b-81a98cbfab78",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6a5b2db27d0d603f1b4cc7963830839d/barcode/image/e46e96d0-dc19-4a7f-b64b-81a98cbfab78/0e1d3b82-1f2b-4f0d-98fe-5ef36a5c3a58.svg",
        "owner_id": "b8126a63-14a4-4915-8a07-dfefa9af63b3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b8126a63-14a4-4915-8a07-dfefa9af63b3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F943d6b8b-049e-4eee-aa60-d1801ead4102&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "943d6b8b-049e-4eee-aa60-d1801ead4102",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-06T08:12:19+00:00",
        "updated_at": "2022-07-06T08:12:19+00:00",
        "number": "http://bqbl.it/943d6b8b-049e-4eee-aa60-d1801ead4102",
        "barcode_type": "qr_code",
        "image_url": "/uploads/43610b77cedec6e088c903a823aa174b/barcode/image/943d6b8b-049e-4eee-aa60-d1801ead4102/01026c24-bf78-4ca3-8860-c23b97976b62.svg",
        "owner_id": "19e649d4-6baa-4c74-80cf-81725ef3f632",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/19e649d4-6baa-4c74-80cf-81725ef3f632"
          },
          "data": {
            "type": "customers",
            "id": "19e649d4-6baa-4c74-80cf-81725ef3f632"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "19e649d4-6baa-4c74-80cf-81725ef3f632",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-06T08:12:19+00:00",
        "updated_at": "2022-07-06T08:12:19+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Torp-Weimann",
        "email": "weimann.torp@johnson.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=19e649d4-6baa-4c74-80cf-81725ef3f632&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=19e649d4-6baa-4c74-80cf-81725ef3f632&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=19e649d4-6baa-4c74-80cf-81725ef3f632&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYzdjZjc0YzYtZDIxYy00YjllLTk3MGItNzJhZDRkYjgyMWQ1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c7cf74c6-d21c-4b9e-970b-72ad4db821d5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-06T08:12:20+00:00",
        "updated_at": "2022-07-06T08:12:20+00:00",
        "number": "http://bqbl.it/c7cf74c6-d21c-4b9e-970b-72ad4db821d5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3d51167d961f286ab2be2fa7dbc2350a/barcode/image/c7cf74c6-d21c-4b9e-970b-72ad4db821d5/8876da9d-37c9-4e4a-b459-1de0ccdc295e.svg",
        "owner_id": "b3c10d8d-31b3-44c5-bbff-af8aacbf6d61",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b3c10d8d-31b3-44c5-bbff-af8aacbf6d61"
          },
          "data": {
            "type": "customers",
            "id": "b3c10d8d-31b3-44c5-bbff-af8aacbf6d61"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b3c10d8d-31b3-44c5-bbff-af8aacbf6d61",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-06T08:12:20+00:00",
        "updated_at": "2022-07-06T08:12:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Kub, Rolfson and Carter",
        "email": "kub_carter_rolfson_and@yundt.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=b3c10d8d-31b3-44c5-bbff-af8aacbf6d61&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b3c10d8d-31b3-44c5-bbff-af8aacbf6d61&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b3c10d8d-31b3-44c5-bbff-af8aacbf6d61&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-06T08:12:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f11bc118-0d7f-4227-a5ab-e31f12c89f42?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f11bc118-0d7f-4227-a5ab-e31f12c89f42",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-06T08:12:20+00:00",
      "updated_at": "2022-07-06T08:12:20+00:00",
      "number": "http://bqbl.it/f11bc118-0d7f-4227-a5ab-e31f12c89f42",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ef39d774a614c0e463bd79876b349849/barcode/image/f11bc118-0d7f-4227-a5ab-e31f12c89f42/10ff90ea-9a5c-4521-a786-3b7018611a5c.svg",
      "owner_id": "47a888f9-ef54-496d-963f-53d121b5a609",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/47a888f9-ef54-496d-963f-53d121b5a609"
        },
        "data": {
          "type": "customers",
          "id": "47a888f9-ef54-496d-963f-53d121b5a609"
        }
      }
    }
  },
  "included": [
    {
      "id": "47a888f9-ef54-496d-963f-53d121b5a609",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-06T08:12:20+00:00",
        "updated_at": "2022-07-06T08:12:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Greenfelder and Sons",
        "email": "and.greenfelder.sons@auer-trantow.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=47a888f9-ef54-496d-963f-53d121b5a609&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=47a888f9-ef54-496d-963f-53d121b5a609&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=47a888f9-ef54-496d-963f-53d121b5a609&filter[owner_type]=customers"
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
          "owner_id": "e37c2346-6396-472e-81c9-9b25fd84da38",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "faa4d768-e44a-4fc0-8578-4086063d7367",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-06T08:12:21+00:00",
      "updated_at": "2022-07-06T08:12:21+00:00",
      "number": "http://bqbl.it/faa4d768-e44a-4fc0-8578-4086063d7367",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a8c3b1bec157a68f895acddc22d2fb59/barcode/image/faa4d768-e44a-4fc0-8578-4086063d7367/b9a13708-9131-4314-a467-9693cd939150.svg",
      "owner_id": "e37c2346-6396-472e-81c9-9b25fd84da38",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/96d7d6f2-2b8b-460f-820d-116bb3bf06b7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "96d7d6f2-2b8b-460f-820d-116bb3bf06b7",
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
    "id": "96d7d6f2-2b8b-460f-820d-116bb3bf06b7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-06T08:12:22+00:00",
      "updated_at": "2022-07-06T08:12:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/509848b0be4d6401fa8d015bc20ec6f7/barcode/image/96d7d6f2-2b8b-460f-820d-116bb3bf06b7/ed7b0baf-8f92-4f80-bece-934301b44b0b.svg",
      "owner_id": "9915e8ec-9f4a-4e59-a888-bc21025b2257",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/3bce4ea3-d11d-4d17-9bfe-f9fea636dd4a' \
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