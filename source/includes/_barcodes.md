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
      "id": "f0dcf893-26de-4d18-a4ab-4269b043e849",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/f0dcf893-26de-4d18-a4ab-4269b043e849",
        "barcode_type": "qr_code",
        "image_url": "/uploads/373df9b6be9313fd7c3868ec3f90cc4c/barcode/image/f0dcf893-26de-4d18-a4ab-4269b043e849/4e5674de-a34b-4cb0-a024-05390a770a88.svg",
        "owner_id": "b0673db6-e93b-492f-bdd6-4c5135740e24",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b0673db6-e93b-492f-bdd6-4c5135740e24"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9a0552fb-42cb-47cc-8d6f-5aedddb9388f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9a0552fb-42cb-47cc-8d6f-5aedddb9388f",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/9a0552fb-42cb-47cc-8d6f-5aedddb9388f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fdb75f0b18888089bee746499cafe9c4/barcode/image/9a0552fb-42cb-47cc-8d6f-5aedddb9388f/5ada3362-bf2b-4602-aefe-39b67772e791.svg",
        "owner_id": "7ae37027-8c8c-448e-abad-960d60eee0c8",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7ae37027-8c8c-448e-abad-960d60eee0c8"
          },
          "data": {
            "type": "customers",
            "id": "7ae37027-8c8c-448e-abad-960d60eee0c8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7ae37027-8c8c-448e-abad-960d60eee0c8",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Walker-Hilll",
        "email": "hilll_walker@morar.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=7ae37027-8c8c-448e-abad-960d60eee0c8&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7ae37027-8c8c-448e-abad-960d60eee0c8"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=7ae37027-8c8c-448e-abad-960d60eee0c8&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9a0552fb-42cb-47cc-8d6f-5aedddb9388f&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9a0552fb-42cb-47cc-8d6f-5aedddb9388f&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9a0552fb-42cb-47cc-8d6f-5aedddb9388f&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-27T11:02:32Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6d6b9538-4d45-4e18-ba54-6e3c4426195e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6d6b9538-4d45-4e18-ba54-6e3c4426195e",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/6d6b9538-4d45-4e18-ba54-6e3c4426195e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/23587241e2ed63777fdffb46f677d51f/barcode/image/6d6b9538-4d45-4e18-ba54-6e3c4426195e/bdd31b28-86ae-4ce2-aea7-ffcd9204fd3b.svg",
      "owner_id": "ec235b14-89d4-4102-9eb4-fed8612ca7b4",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ec235b14-89d4-4102-9eb4-fed8612ca7b4"
        },
        "data": {
          "type": "customers",
          "id": "ec235b14-89d4-4102-9eb4-fed8612ca7b4"
        }
      }
    }
  },
  "included": [
    {
      "id": "ec235b14-89d4-4102-9eb4-fed8612ca7b4",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Wiza LLC",
        "email": "llc_wiza@ortiz.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=ec235b14-89d4-4102-9eb4-fed8612ca7b4&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ec235b14-89d4-4102-9eb4-fed8612ca7b4"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=ec235b14-89d4-4102-9eb4-fed8612ca7b4&filter[notable_type]=Customer"
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
          "owner_id": "5a14e8d8-92b0-45c0-9f5f-ed7ee296c99b",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c71e5b8d-3535-4e15-bd64-e6c6095436ec",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/c71e5b8d-3535-4e15-bd64-e6c6095436ec",
      "barcode_type": "qr_code",
      "image_url": "/uploads/547c71c1f6c554c5e15f3165d1a49f36/barcode/image/c71e5b8d-3535-4e15-bd64-e6c6095436ec/c178dc46-743e-4cbe-a3d8-92bf3dad393c.svg",
      "owner_id": "5a14e8d8-92b0-45c0-9f5f-ed7ee296c99b",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=5a14e8d8-92b0-45c0-9f5f-ed7ee296c99b&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=5a14e8d8-92b0-45c0-9f5f-ed7ee296c99b&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=5a14e8d8-92b0-45c0-9f5f-ed7ee296c99b&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fef762ee-afcf-4197-a03b-956d40c1fd10' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fef762ee-afcf-4197-a03b-956d40c1fd10",
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
    "id": "fef762ee-afcf-4197-a03b-956d40c1fd10",
    "type": "barcodes",
    "attributes": {
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/00b45b6b679055439f7e7ffd89f03e28/barcode/image/fef762ee-afcf-4197-a03b-956d40c1fd10/ef280c47-582c-4f57-9dde-e5c1753f3323.svg",
      "owner_id": "5604a6ff-e76f-44b7-aef8-064f2d916544",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/12a9e3eb-689b-4105-b9b1-6209be4ceb06' \
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