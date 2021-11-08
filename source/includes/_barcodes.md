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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


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
      "id": "d1736631-022f-489c-843f-8e85fef46fa9",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/d1736631-022f-489c-843f-8e85fef46fa9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c6e077762d34d8255738fbbec0edcb5d/barcode/image/d1736631-022f-489c-843f-8e85fef46fa9/a0e11245-2430-410b-ae42-708ce18a15cb.svg",
        "owner_id": "4ef77559-1168-42c0-bd64-c18df0d133a0",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4ef77559-1168-42c0-bd64-c18df0d133a0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0bd9ec89-b4f9-4451-a060-9d7e8f25a972&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0bd9ec89-b4f9-4451-a060-9d7e8f25a972",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/0bd9ec89-b4f9-4451-a060-9d7e8f25a972",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e311c9907c447d565ed87790ffb4904b/barcode/image/0bd9ec89-b4f9-4451-a060-9d7e8f25a972/2f9da796-1e4d-495e-a79b-df752aea373f.svg",
        "owner_id": "f3e8d67c-ad1f-44f8-8685-478359abbead",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f3e8d67c-ad1f-44f8-8685-478359abbead"
          },
          "data": {
            "type": "customers",
            "id": "f3e8d67c-ad1f-44f8-8685-478359abbead"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f3e8d67c-ad1f-44f8-8685-478359abbead",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Corwin, Effertz and Swaniawski",
        "email": "swaniawski_effertz_corwin_and@donnelly-flatley.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=f3e8d67c-ad1f-44f8-8685-478359abbead&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f3e8d67c-ad1f-44f8-8685-478359abbead"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=f3e8d67c-ad1f-44f8-8685-478359abbead&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0bd9ec89-b4f9-4451-a060-9d7e8f25a972&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0bd9ec89-b4f9-4451-a060-9d7e8f25a972&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0bd9ec89-b4f9-4451-a060-9d7e8f25a972&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-08T12:27:12Z`
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
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1ae9826b-6b87-4dcc-8284-aa8a263fc1a5?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1ae9826b-6b87-4dcc-8284-aa8a263fc1a5",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/1ae9826b-6b87-4dcc-8284-aa8a263fc1a5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7743a53dd047fa5c9233f3ddbf648a4b/barcode/image/1ae9826b-6b87-4dcc-8284-aa8a263fc1a5/caf9743f-5667-4501-a8d9-18256d321086.svg",
      "owner_id": "513d8551-a81a-436f-b192-721cbea128c1",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/513d8551-a81a-436f-b192-721cbea128c1"
        },
        "data": {
          "type": "customers",
          "id": "513d8551-a81a-436f-b192-721cbea128c1"
        }
      }
    }
  },
  "included": [
    {
      "id": "513d8551-a81a-436f-b192-721cbea128c1",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "O'Kon, Sawayn and Sipes",
        "email": "sawayn_and_o_kon_sipes@hauck-purdy.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=513d8551-a81a-436f-b192-721cbea128c1&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=513d8551-a81a-436f-b192-721cbea128c1"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=513d8551-a81a-436f-b192-721cbea128c1&filter[notable_type]=Customer"
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
          "owner_id": "da51c803-db9a-41af-817d-c862d72581fc",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "655c21fe-6687-4602-9c55-b8acf1ed2eea",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/655c21fe-6687-4602-9c55-b8acf1ed2eea",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f0019703fd959c2e1076d6438eb9fb52/barcode/image/655c21fe-6687-4602-9c55-b8acf1ed2eea/3de41c4b-b171-40e7-ad73-d112c7f06fcd.svg",
      "owner_id": "da51c803-db9a-41af-817d-c862d72581fc",
      "owner_type": "Customer"
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=da51c803-db9a-41af-817d-c862d72581fc&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=da51c803-db9a-41af-817d-c862d72581fc&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=da51c803-db9a-41af-817d-c862d72581fc&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/74bb81d5-a1db-4d47-bccc-64d2b1486195' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "74bb81d5-a1db-4d47-bccc-64d2b1486195",
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
    "id": "74bb81d5-a1db-4d47-bccc-64d2b1486195",
    "type": "barcodes",
    "attributes": {
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a3047bd38f7febcf80ce34795d3a35fa/barcode/image/74bb81d5-a1db-4d47-bccc-64d2b1486195/592603fc-f279-4c59-acc7-8250e3f6a783.svg",
      "owner_id": "2a53df31-a287-4255-9ad4-b3ed7dd051fc",
      "owner_type": "Customer"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/bb97e63a-e7b9-4578-961c-6f61b3635d14' \
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