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
      "id": "52e6db8d-57ac-495a-b6bb-aab7dd30e27f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-12T09:22:44.491013+00:00",
        "updated_at": "2024-08-12T09:22:44.491013+00:00",
        "number": "http://bqbl.it/52e6db8d-57ac-495a-b6bb-aab7dd30e27f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-14.lvh.me:/barcodes/52e6db8d-57ac-495a-b6bb-aab7dd30e27f/image",
        "owner_id": "221283c6-5e5d-4611-bd1c-b7f62aca7ebd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff4827f83-1edb-4c95-a37e-8311ccddf760&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f4827f83-1edb-4c95-a37e-8311ccddf760",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-12T09:22:43.559741+00:00",
        "updated_at": "2024-08-12T09:22:43.559741+00:00",
        "number": "http://bqbl.it/f4827f83-1edb-4c95-a37e-8311ccddf760",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-13.lvh.me:/barcodes/f4827f83-1edb-4c95-a37e-8311ccddf760/image",
        "owner_id": "af0397ec-3d83-4fab-b4ca-7f0818520f56",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "af0397ec-3d83-4fab-b4ca-7f0818520f56"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "af0397ec-3d83-4fab-b4ca-7f0818520f56",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-12T09:22:43.346208+00:00",
        "updated_at": "2024-08-12T09:22:43.561487+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-11@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNDVkN2EwYTYtOWRmMS00NWIxLTk0MDYtOWMyNTU2Zjg4Yzhl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "45d7a0a6-9df1-45b1-9406-9c2556f88c8e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-08-12T09:22:45.616174+00:00",
        "updated_at": "2024-08-12T09:22:45.616174+00:00",
        "number": "http://bqbl.it/45d7a0a6-9df1-45b1-9406-9c2556f88c8e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-15.lvh.me:/barcodes/45d7a0a6-9df1-45b1-9406-9c2556f88c8e/image",
        "owner_id": "ac20fe22-1691-4c2a-8a6d-0948519eae99",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "ac20fe22-1691-4c2a-8a6d-0948519eae99"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ac20fe22-1691-4c2a-8a6d-0948519eae99",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-12T09:22:45.554064+00:00",
        "updated_at": "2024-08-12T09:22:45.617869+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-14@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/213158cb-daa8-4312-85fb-c80f2f83da2b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "213158cb-daa8-4312-85fb-c80f2f83da2b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-12T09:22:46.307293+00:00",
      "updated_at": "2024-08-12T09:22:46.307293+00:00",
      "number": "http://bqbl.it/213158cb-daa8-4312-85fb-c80f2f83da2b",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-16.lvh.me:/barcodes/213158cb-daa8-4312-85fb-c80f2f83da2b/image",
      "owner_id": "f2309e05-f0b6-40c7-affa-e3d6e2f3174c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "f2309e05-f0b6-40c7-affa-e3d6e2f3174c"
        }
      }
    }
  },
  "included": [
    {
      "id": "f2309e05-f0b6-40c7-affa-e3d6e2f3174c",
      "type": "customers",
      "attributes": {
        "created_at": "2024-08-12T09:22:46.230919+00:00",
        "updated_at": "2024-08-12T09:22:46.309890+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-15@doe.test",
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
          "owner_id": "f168fe17-ab73-43af-acb0-cb5fac726a27",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "26790d9f-819c-4946-9a3a-79c372b7923e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-12T09:22:47.068368+00:00",
      "updated_at": "2024-08-12T09:22:47.068368+00:00",
      "number": "http://bqbl.it/26790d9f-819c-4946-9a3a-79c372b7923e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-17.lvh.me:/barcodes/26790d9f-819c-4946-9a3a-79c372b7923e/image",
      "owner_id": "f168fe17-ab73-43af-acb0-cb5fac726a27",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/497ca31d-088a-4f2c-bae1-c2283b669b48' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "497ca31d-088a-4f2c-bae1-c2283b669b48",
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
    "id": "497ca31d-088a-4f2c-bae1-c2283b669b48",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-12T09:22:41.254926+00:00",
      "updated_at": "2024-08-12T09:22:41.404619+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-11.lvh.me:/barcodes/497ca31d-088a-4f2c-bae1-c2283b669b48/image",
      "owner_id": "2c56dece-6657-4b18-9308-788e844ef9b0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cfa4976b-2dd4-4324-870b-f2a0d21c6216' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cfa4976b-2dd4-4324-870b-f2a0d21c6216",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-08-12T09:22:42.392311+00:00",
      "updated_at": "2024-08-12T09:22:42.392311+00:00",
      "number": "http://bqbl.it/cfa4976b-2dd4-4324-870b-f2a0d21c6216",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-12.lvh.me:/barcodes/cfa4976b-2dd4-4324-870b-f2a0d21c6216/image",
      "owner_id": "fd412476-abfb-40ce-a722-9eb00e5849f2",
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









