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
`owner` | **Customer, Product, Order, Stock item** <br>Associated Owner


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
      "id": "12b7f9f8-f43a-4350-b695-a424bcfffb6d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-28T09:24:54.431337+00:00",
        "updated_at": "2024-10-28T09:24:54.431337+00:00",
        "number": "http://bqbl.it/12b7f9f8-f43a-4350-b695-a424bcfffb6d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-94.lvh.me:/barcodes/12b7f9f8-f43a-4350-b695-a424bcfffb6d/image",
        "owner_id": "8aad84c3-6e8f-47b1-b7e3-f97478f297db",
        "owner_type": "customers"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F049377e4-3c09-4580-9ec9-0c3015f58854&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "049377e4-3c09-4580-9ec9-0c3015f58854",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-28T09:24:53.852016+00:00",
        "updated_at": "2024-10-28T09:24:53.852016+00:00",
        "number": "http://bqbl.it/049377e4-3c09-4580-9ec9-0c3015f58854",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-93.lvh.me:/barcodes/049377e4-3c09-4580-9ec9-0c3015f58854/image",
        "owner_id": "e361d788-24a5-44d7-b0a8-03d7d70807ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "e361d788-24a5-44d7-b0a8-03d7d70807ec"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e361d788-24a5-44d7-b0a8-03d7d70807ec",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-28T09:24:53.803533+00:00",
        "updated_at": "2024-10-28T09:24:53.854047+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-10@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODkxMGI0MTQtYWQ5NS00NDRjLTg5MWEtZTFlOTM1NmZlNDA4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8910b414-ad95-444c-891a-e1e9356fe408",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-10-28T09:24:55.288314+00:00",
        "updated_at": "2024-10-28T09:24:55.288314+00:00",
        "number": "http://bqbl.it/8910b414-ad95-444c-891a-e1e9356fe408",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-95.lvh.me:/barcodes/8910b414-ad95-444c-891a-e1e9356fe408/image",
        "owner_id": "2f0b736f-5847-4718-a79f-3f0447a3ecc3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "2f0b736f-5847-4718-a79f-3f0447a3ecc3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2f0b736f-5847-4718-a79f-3f0447a3ecc3",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-28T09:24:55.236755+00:00",
        "updated_at": "2024-10-28T09:24:55.290363+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-13@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f2f03656-ae79-423c-97d9-52c541ffc509?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f2f03656-ae79-423c-97d9-52c541ffc509",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-28T09:24:52.941039+00:00",
      "updated_at": "2024-10-28T09:24:52.941039+00:00",
      "number": "http://bqbl.it/f2f03656-ae79-423c-97d9-52c541ffc509",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-92.lvh.me:/barcodes/f2f03656-ae79-423c-97d9-52c541ffc509/image",
      "owner_id": "1d5feae7-e907-4e31-b18e-deb7fe1cf5fc",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "1d5feae7-e907-4e31-b18e-deb7fe1cf5fc"
        }
      }
    }
  },
  "included": [
    {
      "id": "1d5feae7-e907-4e31-b18e-deb7fe1cf5fc",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-28T09:24:52.867738+00:00",
        "updated_at": "2024-10-28T09:24:52.944046+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-9@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
          "owner_id": "0b106cd3-91aa-496e-83c2-b54d4e82d774",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "634e47cf-7f03-4f3f-88b7-a5e04f7d5028",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-28T09:24:56.988381+00:00",
      "updated_at": "2024-10-28T09:24:56.988381+00:00",
      "number": "http://bqbl.it/634e47cf-7f03-4f3f-88b7-a5e04f7d5028",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-97.lvh.me:/barcodes/634e47cf-7f03-4f3f-88b7-a5e04f7d5028/image",
      "owner_id": "0b106cd3-91aa-496e-83c2-b54d4e82d774",
      "owner_type": "customers"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e1cb7cef-5dea-45a5-a98f-0552af25d354' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e1cb7cef-5dea-45a5-a98f-0552af25d354",
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
    "id": "e1cb7cef-5dea-45a5-a98f-0552af25d354",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-28T09:24:55.998892+00:00",
      "updated_at": "2024-10-28T09:24:56.097185+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-96.lvh.me:/barcodes/e1cb7cef-5dea-45a5-a98f-0552af25d354/image",
      "owner_id": "1a5946de-f20c-46aa-903c-cebb47ce36a6",
      "owner_type": "customers"
    },
    "relationships": {}
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










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/03828757-dff2-49cc-9fdb-1057a53d7322' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "03828757-dff2-49cc-9fdb-1057a53d7322",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-10-28T09:24:57.822177+00:00",
      "updated_at": "2024-10-28T09:24:57.822177+00:00",
      "number": "http://bqbl.it/03828757-dff2-49cc-9fdb-1057a53d7322",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-98.lvh.me:/barcodes/03828757-dff2-49cc-9fdb-1057a53d7322/image",
      "owner_id": "40fccb92-1490-4b04-b549-bd5102fb0d27",
      "owner_type": "customers"
    },
    "relationships": {}
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









