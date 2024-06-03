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

`GET /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c9eadd41-3abc-4214-84e8-f0ba14545607' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c9eadd41-3abc-4214-84e8-f0ba14545607",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-03T09:26:32.652721+00:00",
      "updated_at": "2024-06-03T09:26:32.652721+00:00",
      "number": "http://bqbl.it/c9eadd41-3abc-4214-84e8-f0ba14545607",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-157.lvh.me:/barcodes/c9eadd41-3abc-4214-84e8-f0ba14545607/image",
      "owner_id": "732fdd24-fc62-4fc2-96a2-c9c874e68251",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/732fdd24-fc62-4fc2-96a2-c9c874e68251"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`










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
      "id": "d45cf081-8469-4469-80cf-bd77923c8dc3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-03T09:26:33.411470+00:00",
        "updated_at": "2024-06-03T09:26:33.411470+00:00",
        "number": "http://bqbl.it/d45cf081-8469-4469-80cf-bd77923c8dc3",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-158.lvh.me:/barcodes/d45cf081-8469-4469-80cf-bd77923c8dc3/image",
        "owner_id": "7d065d2c-e8d7-42e2-b378-9b501881bd37",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7d065d2c-e8d7-42e2-b378-9b501881bd37"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3266beca-bb3f-427c-9b7c-1c973de09ee8&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3266beca-bb3f-427c-9b7c-1c973de09ee8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-03T09:26:34.532941+00:00",
        "updated_at": "2024-06-03T09:26:34.532941+00:00",
        "number": "http://bqbl.it/3266beca-bb3f-427c-9b7c-1c973de09ee8",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-159.lvh.me:/barcodes/3266beca-bb3f-427c-9b7c-1c973de09ee8/image",
        "owner_id": "ec3a3337-b1db-4d94-ac34-058e69ba898d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ec3a3337-b1db-4d94-ac34-058e69ba898d"
          },
          "data": {
            "type": "customers",
            "id": "ec3a3337-b1db-4d94-ac34-058e69ba898d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ec3a3337-b1db-4d94-ac34-058e69ba898d",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-03T09:26:34.506846+00:00",
        "updated_at": "2024-06-03T09:26:34.537099+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-61@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=ec3a3337-b1db-4d94-ac34-058e69ba898d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ec3a3337-b1db-4d94-ac34-058e69ba898d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ec3a3337-b1db-4d94-ac34-058e69ba898d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjA5OGJiZTctNGM0MS00YzVhLThiMjgtMWZiZWFkY2NmNGI1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f098bbe7-4c41-4c5a-8b28-1fbeadccf4b5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-03T09:26:35.475378+00:00",
        "updated_at": "2024-06-03T09:26:35.475378+00:00",
        "number": "http://bqbl.it/f098bbe7-4c41-4c5a-8b28-1fbeadccf4b5",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-160.lvh.me:/barcodes/f098bbe7-4c41-4c5a-8b28-1fbeadccf4b5/image",
        "owner_id": "beff3339-84af-4735-aa22-eb86f6850458",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/beff3339-84af-4735-aa22-eb86f6850458"
          },
          "data": {
            "type": "customers",
            "id": "beff3339-84af-4735-aa22-eb86f6850458"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "beff3339-84af-4735-aa22-eb86f6850458",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-03T09:26:35.445328+00:00",
        "updated_at": "2024-06-03T09:26:35.480240+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-63@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=beff3339-84af-4735-aa22-eb86f6850458&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=beff3339-84af-4735-aa22-eb86f6850458&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=beff3339-84af-4735-aa22-eb86f6850458&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/995feb61-56f8-44c6-8c34-57ea32ef7ddd?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "995feb61-56f8-44c6-8c34-57ea32ef7ddd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-03T09:26:36.330035+00:00",
      "updated_at": "2024-06-03T09:26:36.330035+00:00",
      "number": "http://bqbl.it/995feb61-56f8-44c6-8c34-57ea32ef7ddd",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-161.lvh.me:/barcodes/995feb61-56f8-44c6-8c34-57ea32ef7ddd/image",
      "owner_id": "2de16d91-8b00-4aec-b0ca-978eab7e186d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2de16d91-8b00-4aec-b0ca-978eab7e186d"
        },
        "data": {
          "type": "customers",
          "id": "2de16d91-8b00-4aec-b0ca-978eab7e186d"
        }
      }
    }
  },
  "included": [
    {
      "id": "2de16d91-8b00-4aec-b0ca-978eab7e186d",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-03T09:26:36.294321+00:00",
        "updated_at": "2024-06-03T09:26:36.335572+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-64@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=2de16d91-8b00-4aec-b0ca-978eab7e186d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2de16d91-8b00-4aec-b0ca-978eab7e186d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2de16d91-8b00-4aec-b0ca-978eab7e186d&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










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
          "owner_id": "2c59daea-5c42-4a2e-bb7d-f1a185892cd2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8be819b2-fb45-407b-97e5-c01b161d40ab",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-03T09:26:37.252298+00:00",
      "updated_at": "2024-06-03T09:26:37.252298+00:00",
      "number": "http://bqbl.it/8be819b2-fb45-407b-97e5-c01b161d40ab",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-162.lvh.me:/barcodes/8be819b2-fb45-407b-97e5-c01b161d40ab/image",
      "owner_id": "2c59daea-5c42-4a2e-bb7d-f1a185892cd2",
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

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/c2b1e78a-dae1-427a-84a6-021fcb91932d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c2b1e78a-dae1-427a-84a6-021fcb91932d",
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
    "id": "c2b1e78a-dae1-427a-84a6-021fcb91932d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-03T09:26:38.061573+00:00",
      "updated_at": "2024-06-03T09:26:38.145878+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-163.lvh.me:/barcodes/c2b1e78a-dae1-427a-84a6-021fcb91932d/image",
      "owner_id": "d86eae9b-edad-4109-b4ba-d46fa5c1f2a9",
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

`owner` => 
`photo`


`product` => 
`photo`









