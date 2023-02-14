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
      "id": "81f063e4-ebd9-4317-b758-2408fdeab411",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:03:39+00:00",
        "updated_at": "2023-02-14T11:03:39+00:00",
        "number": "http://bqbl.it/81f063e4-ebd9-4317-b758-2408fdeab411",
        "barcode_type": "qr_code",
        "image_url": "/uploads/66f3d72c5cdd0639c68fde7a23b31122/barcode/image/81f063e4-ebd9-4317-b758-2408fdeab411/b5c1d41b-d6e1-4839-8c4c-e9264d81782c.svg",
        "owner_id": "d278a668-aeeb-428e-a4cc-98be4e418a27",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d278a668-aeeb-428e-a4cc-98be4e418a27"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F58776e71-575b-42fe-acc3-bf6ba6e97b53&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "58776e71-575b-42fe-acc3-bf6ba6e97b53",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:03:39+00:00",
        "updated_at": "2023-02-14T11:03:39+00:00",
        "number": "http://bqbl.it/58776e71-575b-42fe-acc3-bf6ba6e97b53",
        "barcode_type": "qr_code",
        "image_url": "/uploads/28ba12097d06e4e5774421f4603a29c9/barcode/image/58776e71-575b-42fe-acc3-bf6ba6e97b53/e7433545-65e7-479d-87ee-57b5b3602368.svg",
        "owner_id": "b4fb6c80-a704-40b3-a959-77ac41a26d21",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b4fb6c80-a704-40b3-a959-77ac41a26d21"
          },
          "data": {
            "type": "customers",
            "id": "b4fb6c80-a704-40b3-a959-77ac41a26d21"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b4fb6c80-a704-40b3-a959-77ac41a26d21",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:03:39+00:00",
        "updated_at": "2023-02-14T11:03:39+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b4fb6c80-a704-40b3-a959-77ac41a26d21&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b4fb6c80-a704-40b3-a959-77ac41a26d21&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b4fb6c80-a704-40b3-a959-77ac41a26d21&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOTEzYmYyMDItNWVlNy00ZGZhLWJiY2UtNWE4ZTAyZTBjYjM1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "913bf202-5ee7-4dfa-bbce-5a8e02e0cb35",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T11:03:40+00:00",
        "updated_at": "2023-02-14T11:03:40+00:00",
        "number": "http://bqbl.it/913bf202-5ee7-4dfa-bbce-5a8e02e0cb35",
        "barcode_type": "qr_code",
        "image_url": "/uploads/20a545a9530e520b4cef478e586aa200/barcode/image/913bf202-5ee7-4dfa-bbce-5a8e02e0cb35/9553edfe-bf8f-48ec-9787-cd50fe6bf437.svg",
        "owner_id": "04d8caf9-dce0-4d77-ac11-e4c17953fc41",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/04d8caf9-dce0-4d77-ac11-e4c17953fc41"
          },
          "data": {
            "type": "customers",
            "id": "04d8caf9-dce0-4d77-ac11-e4c17953fc41"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "04d8caf9-dce0-4d77-ac11-e4c17953fc41",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:03:40+00:00",
        "updated_at": "2023-02-14T11:03:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=04d8caf9-dce0-4d77-ac11-e4c17953fc41&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=04d8caf9-dce0-4d77-ac11-e4c17953fc41&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=04d8caf9-dce0-4d77-ac11-e4c17953fc41&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:03:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/66e28732-4d87-4b94-a201-e9dc85aec202?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "66e28732-4d87-4b94-a201-e9dc85aec202",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:03:40+00:00",
      "updated_at": "2023-02-14T11:03:40+00:00",
      "number": "http://bqbl.it/66e28732-4d87-4b94-a201-e9dc85aec202",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d18eff3298877b6cdef030a18ff6281c/barcode/image/66e28732-4d87-4b94-a201-e9dc85aec202/c6976b75-1698-472c-ba7e-28e2d33f5b67.svg",
      "owner_id": "a743f4a5-1db0-42ca-bf54-dd3b137d8c94",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a743f4a5-1db0-42ca-bf54-dd3b137d8c94"
        },
        "data": {
          "type": "customers",
          "id": "a743f4a5-1db0-42ca-bf54-dd3b137d8c94"
        }
      }
    }
  },
  "included": [
    {
      "id": "a743f4a5-1db0-42ca-bf54-dd3b137d8c94",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T11:03:40+00:00",
        "updated_at": "2023-02-14T11:03:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a743f4a5-1db0-42ca-bf54-dd3b137d8c94&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a743f4a5-1db0-42ca-bf54-dd3b137d8c94&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a743f4a5-1db0-42ca-bf54-dd3b137d8c94&filter[owner_type]=customers"
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
          "owner_id": "4f87d608-17d3-4ab6-bcd2-8f12385505c0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "252376da-1abc-4dd7-bc48-7f97ed68f344",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:03:41+00:00",
      "updated_at": "2023-02-14T11:03:41+00:00",
      "number": "http://bqbl.it/252376da-1abc-4dd7-bc48-7f97ed68f344",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ebc77d2da2498b68fa4b6e3bc0413e1b/barcode/image/252376da-1abc-4dd7-bc48-7f97ed68f344/837d1398-7fa6-4761-bb90-6fb248b1ebcd.svg",
      "owner_id": "4f87d608-17d3-4ab6-bcd2-8f12385505c0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1cfd0bf9-1167-4447-add8-96be12878389' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1cfd0bf9-1167-4447-add8-96be12878389",
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
    "id": "1cfd0bf9-1167-4447-add8-96be12878389",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T11:03:42+00:00",
      "updated_at": "2023-02-14T11:03:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7744500a16c7d8b22a235f3f3dae0d0e/barcode/image/1cfd0bf9-1167-4447-add8-96be12878389/df47d742-d847-408d-8209-b43b3dc9d517.svg",
      "owner_id": "96c45b3c-ddc6-4898-9754-39769c63e5ad",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4dbd15d7-09e5-4ea1-902b-ea5a7257ad01' \
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