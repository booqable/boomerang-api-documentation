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
      "id": "58153567-5096-4118-bdb0-788b237d27b7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-27T12:57:15+00:00",
        "updated_at": "2021-12-27T12:57:15+00:00",
        "number": "http://bqbl.it/58153567-5096-4118-bdb0-788b237d27b7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/05ff7fe9bafa04d18a9e513bba03101e/barcode/image/58153567-5096-4118-bdb0-788b237d27b7/364e7cee-9eff-4bc8-b0b6-9e3d9d5d70f8.svg",
        "owner_id": "c19d6d16-eed9-4b99-b266-e12b17c8195e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c19d6d16-eed9-4b99-b266-e12b17c8195e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F878ee227-c7b1-4cf2-90d2-58b41fccf24f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "878ee227-c7b1-4cf2-90d2-58b41fccf24f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-27T12:57:16+00:00",
        "updated_at": "2021-12-27T12:57:16+00:00",
        "number": "http://bqbl.it/878ee227-c7b1-4cf2-90d2-58b41fccf24f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4f66680c2942a080143bd85b19cfa372/barcode/image/878ee227-c7b1-4cf2-90d2-58b41fccf24f/b314d720-acb1-4bf5-8a9a-034c32adab10.svg",
        "owner_id": "1952da05-930f-478f-821c-30ca6d820c87",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1952da05-930f-478f-821c-30ca6d820c87"
          },
          "data": {
            "type": "customers",
            "id": "1952da05-930f-478f-821c-30ca6d820c87"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1952da05-930f-478f-821c-30ca6d820c87",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-27T12:57:16+00:00",
        "updated_at": "2021-12-27T12:57:16+00:00",
        "number": 1,
        "name": "Reynolds-Weimann",
        "email": "reynolds_weimann@walker-king.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=1952da05-930f-478f-821c-30ca6d820c87&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1952da05-930f-478f-821c-30ca6d820c87&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1952da05-930f-478f-821c-30ca6d820c87&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F878ee227-c7b1-4cf2-90d2-58b41fccf24f&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F878ee227-c7b1-4cf2-90d2-58b41fccf24f&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F878ee227-c7b1-4cf2-90d2-58b41fccf24f&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-27T12:57:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/795e5029-2d01-43ba-8a42-b1fcadfb754a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "795e5029-2d01-43ba-8a42-b1fcadfb754a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-27T12:57:17+00:00",
      "updated_at": "2021-12-27T12:57:17+00:00",
      "number": "http://bqbl.it/795e5029-2d01-43ba-8a42-b1fcadfb754a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/df2a6028d335a4f90459e8383e2eac3f/barcode/image/795e5029-2d01-43ba-8a42-b1fcadfb754a/bc6202fa-035b-421d-ab75-09f6ab866547.svg",
      "owner_id": "d3b896a0-7065-4727-9c04-2d906189f221",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d3b896a0-7065-4727-9c04-2d906189f221"
        },
        "data": {
          "type": "customers",
          "id": "d3b896a0-7065-4727-9c04-2d906189f221"
        }
      }
    }
  },
  "included": [
    {
      "id": "d3b896a0-7065-4727-9c04-2d906189f221",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-27T12:57:16+00:00",
        "updated_at": "2021-12-27T12:57:17+00:00",
        "number": 1,
        "name": "Botsford and Sons",
        "email": "sons.and.botsford@witting-schoen.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=d3b896a0-7065-4727-9c04-2d906189f221&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d3b896a0-7065-4727-9c04-2d906189f221&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d3b896a0-7065-4727-9c04-2d906189f221&filter[owner_type]=customers"
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
          "owner_id": "7521d571-bf77-4930-8788-ecc081ea651e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a7b83155-ae00-4598-a7a5-401c0dc3a835",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-27T12:57:17+00:00",
      "updated_at": "2021-12-27T12:57:17+00:00",
      "number": "http://bqbl.it/a7b83155-ae00-4598-a7a5-401c0dc3a835",
      "barcode_type": "qr_code",
      "image_url": "/uploads/198bc508984cfffc17eb92ee698f10ba/barcode/image/a7b83155-ae00-4598-a7a5-401c0dc3a835/76a19a5e-2615-431c-87be-df1fa436f1df.svg",
      "owner_id": "7521d571-bf77-4930-8788-ecc081ea651e",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=7521d571-bf77-4930-8788-ecc081ea651e&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=7521d571-bf77-4930-8788-ecc081ea651e&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=7521d571-bf77-4930-8788-ecc081ea651e&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/65f6776c-4448-4e65-b8e7-fdfdf7fe7640' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "65f6776c-4448-4e65-b8e7-fdfdf7fe7640",
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
    "id": "65f6776c-4448-4e65-b8e7-fdfdf7fe7640",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-27T12:57:18+00:00",
      "updated_at": "2021-12-27T12:57:18+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3d69d0d42918131f03b76c41197e616d/barcode/image/65f6776c-4448-4e65-b8e7-fdfdf7fe7640/782d373b-1cf6-4772-8a87-990c30a8bbc6.svg",
      "owner_id": "c9c30383-afcc-4c96-9202-e14c3c79b9f6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f17be4ce-82f1-41b5-a583-6d6362192db9' \
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