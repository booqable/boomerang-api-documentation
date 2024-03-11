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

`GET /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

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


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/2575a906-23cc-473b-aca9-0a93e7127129' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2575a906-23cc-473b-aca9-0a93e7127129",
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
    "id": "2575a906-23cc-473b-aca9-0a93e7127129",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-03-11T09:15:21+00:00",
      "updated_at": "2024-03-11T09:15:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-88.lvh.me:/barcodes/2575a906-23cc-473b-aca9-0a93e7127129/image",
      "owner_id": "9742c957-a6d9-42dc-8ac6-39302c21d936",
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






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/74b88b79-4b7f-44a3-a23c-b191c8f178ad?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "74b88b79-4b7f-44a3-a23c-b191c8f178ad",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-03-11T09:15:22+00:00",
      "updated_at": "2024-03-11T09:15:22+00:00",
      "number": "http://bqbl.it/74b88b79-4b7f-44a3-a23c-b191c8f178ad",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-89.lvh.me:/barcodes/74b88b79-4b7f-44a3-a23c-b191c8f178ad/image",
      "owner_id": "2360c607-8dc9-4b96-b0e0-a4e47eeb0339",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2360c607-8dc9-4b96-b0e0-a4e47eeb0339"
        },
        "data": {
          "type": "customers",
          "id": "2360c607-8dc9-4b96-b0e0-a4e47eeb0339"
        }
      }
    }
  },
  "included": [
    {
      "id": "2360c607-8dc9-4b96-b0e0-a4e47eeb0339",
      "type": "customers",
      "attributes": {
        "created_at": "2024-03-11T09:15:22+00:00",
        "updated_at": "2024-03-11T09:15:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2360c607-8dc9-4b96-b0e0-a4e47eeb0339&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2360c607-8dc9-4b96-b0e0-a4e47eeb0339&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2360c607-8dc9-4b96-b0e0-a4e47eeb0339&filter[owner_type]=customers"
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b596a3e3-149a-4685-b174-7afe868503a1' \
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
          "owner_id": "b2436ac7-f69c-4227-870b-1c63e5b454c1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "67f5e949-d5f1-4607-834f-d3075f41e43d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-03-11T09:15:24+00:00",
      "updated_at": "2024-03-11T09:15:24+00:00",
      "number": "http://bqbl.it/67f5e949-d5f1-4607-834f-d3075f41e43d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-91.lvh.me:/barcodes/67f5e949-d5f1-4607-834f-d3075f41e43d/image",
      "owner_id": "b2436ac7-f69c-4227-870b-1c63e5b454c1",
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
      "id": "771cc1d2-098f-484a-8702-294f6aa2179e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-03-11T09:15:24+00:00",
        "updated_at": "2024-03-11T09:15:24+00:00",
        "number": "http://bqbl.it/771cc1d2-098f-484a-8702-294f6aa2179e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-92.lvh.me:/barcodes/771cc1d2-098f-484a-8702-294f6aa2179e/image",
        "owner_id": "d503c359-cc5f-4d68-ad5c-b5bdb3af2b32",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d503c359-cc5f-4d68-ad5c-b5bdb3af2b32"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fca403e32-5dd7-430a-bf99-960394987a63&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ca403e32-5dd7-430a-bf99-960394987a63",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-03-11T09:15:25+00:00",
        "updated_at": "2024-03-11T09:15:25+00:00",
        "number": "http://bqbl.it/ca403e32-5dd7-430a-bf99-960394987a63",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-93.lvh.me:/barcodes/ca403e32-5dd7-430a-bf99-960394987a63/image",
        "owner_id": "fc6e2094-fb03-425d-a987-3311235027a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fc6e2094-fb03-425d-a987-3311235027a0"
          },
          "data": {
            "type": "customers",
            "id": "fc6e2094-fb03-425d-a987-3311235027a0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "fc6e2094-fb03-425d-a987-3311235027a0",
      "type": "customers",
      "attributes": {
        "created_at": "2024-03-11T09:15:25+00:00",
        "updated_at": "2024-03-11T09:15:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=fc6e2094-fb03-425d-a987-3311235027a0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fc6e2094-fb03-425d-a987-3311235027a0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=fc6e2094-fb03-425d-a987-3311235027a0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2E2ZThmZjYtNjlmOS00ZjllLTlhMjUtM2NiMDg2NjZhNjMy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3a6e8ff6-69f9-4f9e-9a25-3cb08666a632",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-03-11T09:15:26+00:00",
        "updated_at": "2024-03-11T09:15:26+00:00",
        "number": "http://bqbl.it/3a6e8ff6-69f9-4f9e-9a25-3cb08666a632",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-94.lvh.me:/barcodes/3a6e8ff6-69f9-4f9e-9a25-3cb08666a632/image",
        "owner_id": "cd148238-c07f-457a-bf56-61ba72bc7718",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cd148238-c07f-457a-bf56-61ba72bc7718"
          },
          "data": {
            "type": "customers",
            "id": "cd148238-c07f-457a-bf56-61ba72bc7718"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cd148238-c07f-457a-bf56-61ba72bc7718",
      "type": "customers",
      "attributes": {
        "created_at": "2024-03-11T09:15:26+00:00",
        "updated_at": "2024-03-11T09:15:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-12@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=cd148238-c07f-457a-bf56-61ba72bc7718&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cd148238-c07f-457a-bf56-61ba72bc7718&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cd148238-c07f-457a-bf56-61ba72bc7718&filter[owner_type]=customers"
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





