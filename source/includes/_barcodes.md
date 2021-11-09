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
      "id": "da7fdb33-d534-4601-804d-e91602184afd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-09T11:43:55+00:00",
        "updated_at": "2021-11-09T11:43:55+00:00",
        "number": "http://bqbl.it/da7fdb33-d534-4601-804d-e91602184afd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b9772988e7756c87ad23931dee148c62/barcode/image/da7fdb33-d534-4601-804d-e91602184afd/ad9aceae-6add-49d7-932a-4f422d655e4c.svg",
        "owner_id": "97c9ae19-a371-4c78-82ac-26441215cfdc",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/97c9ae19-a371-4c78-82ac-26441215cfdc"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa909a1ab-007b-47ae-ac2c-4162a91b5938&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a909a1ab-007b-47ae-ac2c-4162a91b5938",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-09T11:43:55+00:00",
        "updated_at": "2021-11-09T11:43:55+00:00",
        "number": "http://bqbl.it/a909a1ab-007b-47ae-ac2c-4162a91b5938",
        "barcode_type": "qr_code",
        "image_url": "/uploads/910672d93014f724ffb82b87c30ac0c1/barcode/image/a909a1ab-007b-47ae-ac2c-4162a91b5938/962b799c-a928-4ad9-b547-46abc6abfea8.svg",
        "owner_id": "b56fe363-9ad9-4baf-ab01-1d85dd0160e6",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b56fe363-9ad9-4baf-ab01-1d85dd0160e6"
          },
          "data": {
            "type": "customers",
            "id": "b56fe363-9ad9-4baf-ab01-1d85dd0160e6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b56fe363-9ad9-4baf-ab01-1d85dd0160e6",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T11:43:55+00:00",
        "updated_at": "2021-11-09T11:43:55+00:00",
        "number": 1,
        "name": "Ondricka-Stokes",
        "email": "stokes_ondricka@tillman.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=b56fe363-9ad9-4baf-ab01-1d85dd0160e6&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b56fe363-9ad9-4baf-ab01-1d85dd0160e6"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=b56fe363-9ad9-4baf-ab01-1d85dd0160e6&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa909a1ab-007b-47ae-ac2c-4162a91b5938&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa909a1ab-007b-47ae-ac2c-4162a91b5938&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa909a1ab-007b-47ae-ac2c-4162a91b5938&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-09T11:43:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/03430fa5-15a9-4cf0-9caf-f3819be2690d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "03430fa5-15a9-4cf0-9caf-f3819be2690d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-09T11:43:56+00:00",
      "updated_at": "2021-11-09T11:43:56+00:00",
      "number": "http://bqbl.it/03430fa5-15a9-4cf0-9caf-f3819be2690d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ec7f5fa0e2108a3e35124f05f1907b34/barcode/image/03430fa5-15a9-4cf0-9caf-f3819be2690d/51e81b6a-f54d-45cd-9a47-5553b60ce630.svg",
      "owner_id": "8e19df04-371f-4993-a303-639ead68140c",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8e19df04-371f-4993-a303-639ead68140c"
        },
        "data": {
          "type": "customers",
          "id": "8e19df04-371f-4993-a303-639ead68140c"
        }
      }
    }
  },
  "included": [
    {
      "id": "8e19df04-371f-4993-a303-639ead68140c",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T11:43:55+00:00",
        "updated_at": "2021-11-09T11:43:56+00:00",
        "number": 1,
        "name": "Macejkovic, O'Conner and Quitzon",
        "email": "and.quitzon.macejkovic.conner.o@ryan.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=8e19df04-371f-4993-a303-639ead68140c&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8e19df04-371f-4993-a303-639ead68140c"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=8e19df04-371f-4993-a303-639ead68140c&filter[notable_type]=Customer"
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
          "owner_id": "dda320c6-920a-4816-ab20-f655b9935e9e",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e4dcd4bf-b3b2-40eb-bf52-1b1ce2edd38a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-09T11:43:56+00:00",
      "updated_at": "2021-11-09T11:43:56+00:00",
      "number": "http://bqbl.it/e4dcd4bf-b3b2-40eb-bf52-1b1ce2edd38a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/33a6c56bcd8ade74045a820154d04b7f/barcode/image/e4dcd4bf-b3b2-40eb-bf52-1b1ce2edd38a/57d1a6a5-78e1-4479-862b-b22cc6bd176f.svg",
      "owner_id": "dda320c6-920a-4816-ab20-f655b9935e9e",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=dda320c6-920a-4816-ab20-f655b9935e9e&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=dda320c6-920a-4816-ab20-f655b9935e9e&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=dda320c6-920a-4816-ab20-f655b9935e9e&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/084525c5-ebc5-4126-9713-83b676562fe1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "084525c5-ebc5-4126-9713-83b676562fe1",
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
    "id": "084525c5-ebc5-4126-9713-83b676562fe1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-09T11:43:56+00:00",
      "updated_at": "2021-11-09T11:43:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/53a6414171a2f43cfdb0550ee935c781/barcode/image/084525c5-ebc5-4126-9713-83b676562fe1/3bf27fcc-c27d-42fc-b910-fef9b8a13e05.svg",
      "owner_id": "2c9dd7e3-3d5c-4322-8e0e-4152021f31b5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/362557c7-c34d-40a8-a029-13f81557ba2f' \
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