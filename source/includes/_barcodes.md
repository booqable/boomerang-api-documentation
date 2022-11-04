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
      "id": "1581a0da-8d0c-4005-b517-c1de94bd3099",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-04T15:23:03+00:00",
        "updated_at": "2022-11-04T15:23:03+00:00",
        "number": "http://bqbl.it/1581a0da-8d0c-4005-b517-c1de94bd3099",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0624e49d7a80525bda39241859e027be/barcode/image/1581a0da-8d0c-4005-b517-c1de94bd3099/ce87bd29-19cb-4c01-b121-82b99b2e051b.svg",
        "owner_id": "3e304ba7-a807-4ff3-9ac0-0bac2ac0bc3d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3e304ba7-a807-4ff3-9ac0-0bac2ac0bc3d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F69c98c5b-468b-45da-a657-b2c830fc6351&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "69c98c5b-468b-45da-a657-b2c830fc6351",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-04T15:23:03+00:00",
        "updated_at": "2022-11-04T15:23:03+00:00",
        "number": "http://bqbl.it/69c98c5b-468b-45da-a657-b2c830fc6351",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c50810fea5634f13ca9ba993164bec6c/barcode/image/69c98c5b-468b-45da-a657-b2c830fc6351/456ae9c4-afdd-41e9-95b1-9fd04ca5a53b.svg",
        "owner_id": "dd54ecbc-a5fb-46c4-a299-3b16ef94815f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dd54ecbc-a5fb-46c4-a299-3b16ef94815f"
          },
          "data": {
            "type": "customers",
            "id": "dd54ecbc-a5fb-46c4-a299-3b16ef94815f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dd54ecbc-a5fb-46c4-a299-3b16ef94815f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-04T15:23:03+00:00",
        "updated_at": "2022-11-04T15:23:03+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=dd54ecbc-a5fb-46c4-a299-3b16ef94815f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dd54ecbc-a5fb-46c4-a299-3b16ef94815f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dd54ecbc-a5fb-46c4-a299-3b16ef94815f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvN2QyMTU4N2QtOGZkMy00NjNjLThjNjAtZGQ3MzA2ZDVlN2Vh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7d21587d-8fd3-463c-8c60-dd7306d5e7ea",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-04T15:23:04+00:00",
        "updated_at": "2022-11-04T15:23:04+00:00",
        "number": "http://bqbl.it/7d21587d-8fd3-463c-8c60-dd7306d5e7ea",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b07430fd5a217104ac8eec6f1cd1c77b/barcode/image/7d21587d-8fd3-463c-8c60-dd7306d5e7ea/b39d8d8c-06cf-4588-9cea-64763367e0bf.svg",
        "owner_id": "2b81246c-a105-4db4-8ed4-0b50557d736e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2b81246c-a105-4db4-8ed4-0b50557d736e"
          },
          "data": {
            "type": "customers",
            "id": "2b81246c-a105-4db4-8ed4-0b50557d736e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2b81246c-a105-4db4-8ed4-0b50557d736e",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-04T15:23:04+00:00",
        "updated_at": "2022-11-04T15:23:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2b81246c-a105-4db4-8ed4-0b50557d736e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2b81246c-a105-4db4-8ed4-0b50557d736e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2b81246c-a105-4db4-8ed4-0b50557d736e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0ee776cd-c9a8-4c86-93ed-e1a9d3dec5d4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0ee776cd-c9a8-4c86-93ed-e1a9d3dec5d4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-04T15:23:04+00:00",
      "updated_at": "2022-11-04T15:23:04+00:00",
      "number": "http://bqbl.it/0ee776cd-c9a8-4c86-93ed-e1a9d3dec5d4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9aab459a40fb38b0255523c6635862cb/barcode/image/0ee776cd-c9a8-4c86-93ed-e1a9d3dec5d4/400c09c3-671c-41ef-9273-98b653b8aeec.svg",
      "owner_id": "9730b343-d7e8-4732-b3dc-942a50e62201",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9730b343-d7e8-4732-b3dc-942a50e62201"
        },
        "data": {
          "type": "customers",
          "id": "9730b343-d7e8-4732-b3dc-942a50e62201"
        }
      }
    }
  },
  "included": [
    {
      "id": "9730b343-d7e8-4732-b3dc-942a50e62201",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-04T15:23:04+00:00",
        "updated_at": "2022-11-04T15:23:04+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9730b343-d7e8-4732-b3dc-942a50e62201&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9730b343-d7e8-4732-b3dc-942a50e62201&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9730b343-d7e8-4732-b3dc-942a50e62201&filter[owner_type]=customers"
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
          "owner_id": "32a7c76c-03a2-4654-abb7-0ad0591c4e7e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3607d7e6-6608-419f-953a-c1ab7b6ded02",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-04T15:23:05+00:00",
      "updated_at": "2022-11-04T15:23:05+00:00",
      "number": "http://bqbl.it/3607d7e6-6608-419f-953a-c1ab7b6ded02",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f96ebe06b0eb21bdbcb2e2df06847895/barcode/image/3607d7e6-6608-419f-953a-c1ab7b6ded02/af8424b4-75c4-4b51-9fe5-4bbb034effb4.svg",
      "owner_id": "32a7c76c-03a2-4654-abb7-0ad0591c4e7e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/51441de9-9205-4c2c-a049-11abce1b847b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "51441de9-9205-4c2c-a049-11abce1b847b",
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
    "id": "51441de9-9205-4c2c-a049-11abce1b847b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-04T15:23:05+00:00",
      "updated_at": "2022-11-04T15:23:06+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d5ec24154a9d6efed75663da2242a2b3/barcode/image/51441de9-9205-4c2c-a049-11abce1b847b/57cc9b17-1e44-476f-af05-95fe6aba9695.svg",
      "owner_id": "54935612-c320-44b3-b56e-14c40ae09524",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0bf38f3e-31de-4a23-bf66-be408104c77a' \
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