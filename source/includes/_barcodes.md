# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "cd5af5aa-48e0-4016-afd9-45461addd0f1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-25T13:40:31+00:00",
        "updated_at": "2021-11-25T13:40:31+00:00",
        "number": "http://bqbl.it/cd5af5aa-48e0-4016-afd9-45461addd0f1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9c61d864aba8254d776eab249abd7bc4/barcode/image/cd5af5aa-48e0-4016-afd9-45461addd0f1/90948ba8-86f8-4fc0-aa0a-83ae771ccce8.svg",
        "owner_id": "60f0b34d-ad87-4428-8c38-51da9c6514e1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/60f0b34d-ad87-4428-8c38-51da9c6514e1"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3e03a300-47c5-45fb-b01a-5f9b51014b78&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3e03a300-47c5-45fb-b01a-5f9b51014b78",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-25T13:40:32+00:00",
        "updated_at": "2021-11-25T13:40:32+00:00",
        "number": "http://bqbl.it/3e03a300-47c5-45fb-b01a-5f9b51014b78",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bf5d7ccdfa94b672d1b980fb7e7a427c/barcode/image/3e03a300-47c5-45fb-b01a-5f9b51014b78/7a9407de-b87e-4a37-a370-bf3b53d90bda.svg",
        "owner_id": "14f6d8c5-e056-4803-809f-efc2a63cb427",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/14f6d8c5-e056-4803-809f-efc2a63cb427"
          },
          "data": {
            "type": "customers",
            "id": "14f6d8c5-e056-4803-809f-efc2a63cb427"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "14f6d8c5-e056-4803-809f-efc2a63cb427",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-25T13:40:32+00:00",
        "updated_at": "2021-11-25T13:40:32+00:00",
        "number": 1,
        "name": "Rutherford LLC",
        "email": "llc.rutherford@williamson.name",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=14f6d8c5-e056-4803-809f-efc2a63cb427&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=14f6d8c5-e056-4803-809f-efc2a63cb427&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=14f6d8c5-e056-4803-809f-efc2a63cb427&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3e03a300-47c5-45fb-b01a-5f9b51014b78&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3e03a300-47c5-45fb-b01a-5f9b51014b78&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F3e03a300-47c5-45fb-b01a-5f9b51014b78&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-25T13:40:19Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/087698f4-03f7-42d0-b100-3760600731e8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "087698f4-03f7-42d0-b100-3760600731e8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-25T13:40:32+00:00",
      "updated_at": "2021-11-25T13:40:32+00:00",
      "number": "http://bqbl.it/087698f4-03f7-42d0-b100-3760600731e8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5198ff397ac4e9c108d30e546c57c27d/barcode/image/087698f4-03f7-42d0-b100-3760600731e8/2688e7ef-e6ce-4a1a-b151-abf6893a889f.svg",
      "owner_id": "49e34e61-006a-4421-86c0-4cc107d0dc6e",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/49e34e61-006a-4421-86c0-4cc107d0dc6e"
        },
        "data": {
          "type": "customers",
          "id": "49e34e61-006a-4421-86c0-4cc107d0dc6e"
        }
      }
    }
  },
  "included": [
    {
      "id": "49e34e61-006a-4421-86c0-4cc107d0dc6e",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-25T13:40:32+00:00",
        "updated_at": "2021-11-25T13:40:32+00:00",
        "number": 1,
        "name": "Waelchi-Von",
        "email": "waelchi_von@schmitt-schmitt.com",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=49e34e61-006a-4421-86c0-4cc107d0dc6e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=49e34e61-006a-4421-86c0-4cc107d0dc6e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=49e34e61-006a-4421-86c0-4cc107d0dc6e&filter[owner_type]=customers"
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
          "owner_id": "a3367143-ad1c-49bd-8265-3a55eb489450",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "37a93049-7970-426a-9622-53eea8774004",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-25T13:40:33+00:00",
      "updated_at": "2021-11-25T13:40:33+00:00",
      "number": "http://bqbl.it/37a93049-7970-426a-9622-53eea8774004",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4848ccfb615313d545359afc155f1954/barcode/image/37a93049-7970-426a-9622-53eea8774004/ac79a08e-4782-4608-8a99-649775a002a9.svg",
      "owner_id": "a3367143-ad1c-49bd-8265-3a55eb489450",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=a3367143-ad1c-49bd-8265-3a55eb489450&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=a3367143-ad1c-49bd-8265-3a55eb489450&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=a3367143-ad1c-49bd-8265-3a55eb489450&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b3386a36-85e3-42eb-b76a-b45a46291dd3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b3386a36-85e3-42eb-b76a-b45a46291dd3",
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
    "id": "b3386a36-85e3-42eb-b76a-b45a46291dd3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-25T13:40:34+00:00",
      "updated_at": "2021-11-25T13:40:34+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b588f4acce20b30997ecc96fce004dbe/barcode/image/b3386a36-85e3-42eb-b76a-b45a46291dd3/af09c130-0732-4379-8a7b-285e49415107.svg",
      "owner_id": "63ca8146-456d-4fee-879f-8ec852077d80",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/48f57fe0-94aa-40ec-9388-e262c549a33f' \
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