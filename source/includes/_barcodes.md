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

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`PUT /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

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
      "id": "97477a6a-cd91-4746-8525-0133ef521924",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-29T09:24:12+00:00",
        "updated_at": "2024-04-29T09:24:12+00:00",
        "number": "http://bqbl.it/97477a6a-cd91-4746-8525-0133ef521924",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-54.lvh.me:/barcodes/97477a6a-cd91-4746-8525-0133ef521924/image",
        "owner_id": "980a5c00-aa17-4bfc-9623-c3c20819849d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/980a5c00-aa17-4bfc-9623-c3c20819849d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fc2c711cc-04c6-45e1-a74c-5e8cf56eaf63&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c2c711cc-04c6-45e1-a74c-5e8cf56eaf63",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-29T09:24:13+00:00",
        "updated_at": "2024-04-29T09:24:13+00:00",
        "number": "http://bqbl.it/c2c711cc-04c6-45e1-a74c-5e8cf56eaf63",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-55.lvh.me:/barcodes/c2c711cc-04c6-45e1-a74c-5e8cf56eaf63/image",
        "owner_id": "2011fc9f-0a47-4443-ab1c-175ea74656ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2011fc9f-0a47-4443-ab1c-175ea74656ec"
          },
          "data": {
            "type": "customers",
            "id": "2011fc9f-0a47-4443-ab1c-175ea74656ec"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2011fc9f-0a47-4443-ab1c-175ea74656ec",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-29T09:24:13+00:00",
        "updated_at": "2024-04-29T09:24:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-15@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=2011fc9f-0a47-4443-ab1c-175ea74656ec&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2011fc9f-0a47-4443-ab1c-175ea74656ec&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2011fc9f-0a47-4443-ab1c-175ea74656ec&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2Y1NTVkZjktNjJlZS00ZGVhLThjZmEtMjcyZmIwZTNkMjY2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3f555df9-62ee-4dea-8cfa-272fb0e3d266",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-04-29T09:24:14+00:00",
        "updated_at": "2024-04-29T09:24:14+00:00",
        "number": "http://bqbl.it/3f555df9-62ee-4dea-8cfa-272fb0e3d266",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-56.lvh.me:/barcodes/3f555df9-62ee-4dea-8cfa-272fb0e3d266/image",
        "owner_id": "f1ccf65c-221f-4a2a-a33f-a90695bb1adc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f1ccf65c-221f-4a2a-a33f-a90695bb1adc"
          },
          "data": {
            "type": "customers",
            "id": "f1ccf65c-221f-4a2a-a33f-a90695bb1adc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f1ccf65c-221f-4a2a-a33f-a90695bb1adc",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-29T09:24:14+00:00",
        "updated_at": "2024-04-29T09:24:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-17@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=f1ccf65c-221f-4a2a-a33f-a90695bb1adc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1ccf65c-221f-4a2a-a33f-a90695bb1adc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1ccf65c-221f-4a2a-a33f-a90695bb1adc&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4264c8dc-2b09-4cba-a053-80d92dc97ec2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4264c8dc-2b09-4cba-a053-80d92dc97ec2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-29T09:24:14+00:00",
      "updated_at": "2024-04-29T09:24:14+00:00",
      "number": "http://bqbl.it/4264c8dc-2b09-4cba-a053-80d92dc97ec2",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-57.lvh.me:/barcodes/4264c8dc-2b09-4cba-a053-80d92dc97ec2/image",
      "owner_id": "01a044bd-41b5-4f62-bc4a-50065576e4cc",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/01a044bd-41b5-4f62-bc4a-50065576e4cc"
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

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b75eb383-d269-4f96-bb88-b9512a874c3e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b75eb383-d269-4f96-bb88-b9512a874c3e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-29T09:24:15+00:00",
      "updated_at": "2024-04-29T09:24:15+00:00",
      "number": "http://bqbl.it/b75eb383-d269-4f96-bb88-b9512a874c3e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-58.lvh.me:/barcodes/b75eb383-d269-4f96-bb88-b9512a874c3e/image",
      "owner_id": "aea78d2c-f946-4c48-865f-7a1a035baff6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/aea78d2c-f946-4c48-865f-7a1a035baff6"
        },
        "data": {
          "type": "customers",
          "id": "aea78d2c-f946-4c48-865f-7a1a035baff6"
        }
      }
    }
  },
  "included": [
    {
      "id": "aea78d2c-f946-4c48-865f-7a1a035baff6",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-29T09:24:15+00:00",
        "updated_at": "2024-04-29T09:24:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-19@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=aea78d2c-f946-4c48-865f-7a1a035baff6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aea78d2c-f946-4c48-865f-7a1a035baff6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aea78d2c-f946-4c48-865f-7a1a035baff6&filter[owner_type]=customers"
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd8c3fb1-e279-4e45-bd0c-9f3c83cc0ee9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dd8c3fb1-e279-4e45-bd0c-9f3c83cc0ee9",
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
    "id": "dd8c3fb1-e279-4e45-bd0c-9f3c83cc0ee9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-29T09:24:16+00:00",
      "updated_at": "2024-04-29T09:24:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-59.lvh.me:/barcodes/dd8c3fb1-e279-4e45-bd0c-9f3c83cc0ee9/image",
      "owner_id": "ff5f5a42-f125-451a-b955-77c93160ed24",
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
          "owner_id": "04affaa8-8882-4900-99fb-71e4d7956599",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9f8397bf-3001-401a-9f89-72703ab10c30",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-04-29T09:24:16+00:00",
      "updated_at": "2024-04-29T09:24:16+00:00",
      "number": "http://bqbl.it/9f8397bf-3001-401a-9f89-72703ab10c30",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-60.lvh.me:/barcodes/9f8397bf-3001-401a-9f89-72703ab10c30/image",
      "owner_id": "04affaa8-8882-4900-99fb-71e4d7956599",
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





