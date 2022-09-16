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
      "id": "b66604ce-0a4e-45f0-b3f8-e8fd06cf65c9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T12:11:37+00:00",
        "updated_at": "2022-09-16T12:11:37+00:00",
        "number": "http://bqbl.it/b66604ce-0a4e-45f0-b3f8-e8fd06cf65c9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/584a20083f2d56361a774e6adcf62807/barcode/image/b66604ce-0a4e-45f0-b3f8-e8fd06cf65c9/9b061b95-7b88-40c0-8d28-5023bdf3708e.svg",
        "owner_id": "d771c9d9-a2c2-436d-939e-f8ce640160f2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d771c9d9-a2c2-436d-939e-f8ce640160f2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3938a4fe-d733-483d-b92a-65f044ff2fc6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3938a4fe-d733-483d-b92a-65f044ff2fc6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T12:11:37+00:00",
        "updated_at": "2022-09-16T12:11:37+00:00",
        "number": "http://bqbl.it/3938a4fe-d733-483d-b92a-65f044ff2fc6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5aa4aa7f22f8375aed4840182cbe546a/barcode/image/3938a4fe-d733-483d-b92a-65f044ff2fc6/c990f1ae-7319-4839-bcb3-46c96386c689.svg",
        "owner_id": "986b1658-01d1-46d0-b7d1-fe409c00889b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/986b1658-01d1-46d0-b7d1-fe409c00889b"
          },
          "data": {
            "type": "customers",
            "id": "986b1658-01d1-46d0-b7d1-fe409c00889b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "986b1658-01d1-46d0-b7d1-fe409c00889b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T12:11:37+00:00",
        "updated_at": "2022-09-16T12:11:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=986b1658-01d1-46d0-b7d1-fe409c00889b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=986b1658-01d1-46d0-b7d1-fe409c00889b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=986b1658-01d1-46d0-b7d1-fe409c00889b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTg5YTdiMWEtMDU5My00YmFhLWE4ODEtNGJjNjU4YjFhNjRj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e89a7b1a-0593-4baa-a881-4bc658b1a64c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T12:11:38+00:00",
        "updated_at": "2022-09-16T12:11:38+00:00",
        "number": "http://bqbl.it/e89a7b1a-0593-4baa-a881-4bc658b1a64c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e2a38d3e388ecc8c82df791d7795d9d2/barcode/image/e89a7b1a-0593-4baa-a881-4bc658b1a64c/8349008b-a517-4624-bf5d-bcecfe1628ca.svg",
        "owner_id": "37fb7404-98a7-4300-8e00-81d4d28a3685",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/37fb7404-98a7-4300-8e00-81d4d28a3685"
          },
          "data": {
            "type": "customers",
            "id": "37fb7404-98a7-4300-8e00-81d4d28a3685"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "37fb7404-98a7-4300-8e00-81d4d28a3685",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T12:11:37+00:00",
        "updated_at": "2022-09-16T12:11:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=37fb7404-98a7-4300-8e00-81d4d28a3685&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=37fb7404-98a7-4300-8e00-81d4d28a3685&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=37fb7404-98a7-4300-8e00-81d4d28a3685&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T12:11:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/99ccd49f-36f5-43c5-82d1-c8a19163e8f1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99ccd49f-36f5-43c5-82d1-c8a19163e8f1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T12:11:38+00:00",
      "updated_at": "2022-09-16T12:11:38+00:00",
      "number": "http://bqbl.it/99ccd49f-36f5-43c5-82d1-c8a19163e8f1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a7489c4d6c0807ff31ac741643a79b1b/barcode/image/99ccd49f-36f5-43c5-82d1-c8a19163e8f1/00e90add-403a-4036-a9d1-3cdfdba123f5.svg",
      "owner_id": "d9b1f4cf-72f5-4adf-b244-1376c298e622",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d9b1f4cf-72f5-4adf-b244-1376c298e622"
        },
        "data": {
          "type": "customers",
          "id": "d9b1f4cf-72f5-4adf-b244-1376c298e622"
        }
      }
    }
  },
  "included": [
    {
      "id": "d9b1f4cf-72f5-4adf-b244-1376c298e622",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T12:11:38+00:00",
        "updated_at": "2022-09-16T12:11:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=d9b1f4cf-72f5-4adf-b244-1376c298e622&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d9b1f4cf-72f5-4adf-b244-1376c298e622&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d9b1f4cf-72f5-4adf-b244-1376c298e622&filter[owner_type]=customers"
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
          "owner_id": "7c6de715-618b-4c42-8103-a9d21de9e3f0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "81474a68-f641-4da9-8d55-6bdccc76f489",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T12:11:39+00:00",
      "updated_at": "2022-09-16T12:11:39+00:00",
      "number": "http://bqbl.it/81474a68-f641-4da9-8d55-6bdccc76f489",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d0841bd1551b948e3e1ea3dda4acce13/barcode/image/81474a68-f641-4da9-8d55-6bdccc76f489/60c6d6b4-efe8-4977-b280-7618971e8d95.svg",
      "owner_id": "7c6de715-618b-4c42-8103-a9d21de9e3f0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/12c7b288-6c31-4aeb-9715-cb3cb5b4e471' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "12c7b288-6c31-4aeb-9715-cb3cb5b4e471",
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
    "id": "12c7b288-6c31-4aeb-9715-cb3cb5b4e471",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T12:11:39+00:00",
      "updated_at": "2022-09-16T12:11:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/811a7bc601d8e85b89e5b9e204e41a37/barcode/image/12c7b288-6c31-4aeb-9715-cb3cb5b4e471/e01aeec0-45de-4fcd-a4bd-b893a6a7d6ec.svg",
      "owner_id": "babe5067-0994-4678-b228-037b2a409916",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d3120feb-8c61-450f-bfef-bd16454a2a85' \
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