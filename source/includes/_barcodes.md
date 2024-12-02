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
`owner` | **[Customer](#customers), [Product](#products), [Order](#orders), [Stock item](#stock-items)** <br>Associated Owner


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
      "id": "11909165-54f0-40a0-be86-af900c8b480d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-12-02T13:01:00.277035+00:00",
        "updated_at": "2024-12-02T13:01:00.277035+00:00",
        "number": "http://bqbl.it/11909165-54f0-40a0-be86-af900c8b480d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-7.lvh.me:/barcodes/11909165-54f0-40a0-be86-af900c8b480d/image",
        "owner_id": "1ac83f23-e56d-42ec-8457-62d3a8a3024c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5fb46f31-7e5b-4e91-bc58-e7a25350dd57&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5fb46f31-7e5b-4e91-bc58-e7a25350dd57",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-12-02T13:00:58.538329+00:00",
        "updated_at": "2024-12-02T13:00:58.538329+00:00",
        "number": "http://bqbl.it/5fb46f31-7e5b-4e91-bc58-e7a25350dd57",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-5.lvh.me:/barcodes/5fb46f31-7e5b-4e91-bc58-e7a25350dd57/image",
        "owner_id": "b8822c0d-ab4b-4c03-9644-f83ecb0eac49",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "b8822c0d-ab4b-4c03-9644-f83ecb0eac49"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b8822c0d-ab4b-4c03-9644-f83ecb0eac49",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T13:00:58.472038+00:00",
        "updated_at": "2024-12-02T13:00:58.540442+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjlhZDU4ZmItYTExZi00YzczLThiMzktNDkzMzJhM2FhNDdi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "29ad58fb-a11f-4c73-8b39-49332a3aa47b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-12-02T13:00:59.494284+00:00",
        "updated_at": "2024-12-02T13:00:59.494284+00:00",
        "number": "http://bqbl.it/29ad58fb-a11f-4c73-8b39-49332a3aa47b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-6.lvh.me:/barcodes/29ad58fb-a11f-4c73-8b39-49332a3aa47b/image",
        "owner_id": "89ce3e8b-ba8a-4b3d-a251-6713777d713e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "89ce3e8b-ba8a-4b3d-a251-6713777d713e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "89ce3e8b-ba8a-4b3d-a251-6713777d713e",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T13:00:59.424476+00:00",
        "updated_at": "2024-12-02T13:00:59.497298+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-6@doe.test",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7b15388b-571d-4420-b46e-e4e179bbcdd8?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7b15388b-571d-4420-b46e-e4e179bbcdd8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T13:00:55.754608+00:00",
      "updated_at": "2024-12-02T13:00:55.754608+00:00",
      "number": "http://bqbl.it/7b15388b-571d-4420-b46e-e4e179bbcdd8",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-2.lvh.me:/barcodes/7b15388b-571d-4420-b46e-e4e179bbcdd8/image",
      "owner_id": "ae844267-e51d-4627-adc2-cbc61377156a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "ae844267-e51d-4627-adc2-cbc61377156a"
        }
      }
    }
  },
  "included": [
    {
      "id": "ae844267-e51d-4627-adc2-cbc61377156a",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T13:00:55.645216+00:00",
        "updated_at": "2024-12-02T13:00:55.757002+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-1@doe.test",
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
          "owner_id": "0785b11f-168c-4a27-a869-29f290bf7adc",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b08620e1-1720-4104-838b-e971a3e302e7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T13:01:01.194779+00:00",
      "updated_at": "2024-12-02T13:01:01.194779+00:00",
      "number": "http://bqbl.it/b08620e1-1720-4104-838b-e971a3e302e7",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-8.lvh.me:/barcodes/b08620e1-1720-4104-838b-e971a3e302e7/image",
      "owner_id": "0785b11f-168c-4a27-a869-29f290bf7adc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dbb5b244-96f7-4e9f-8bfc-6c3bdaf68855' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dbb5b244-96f7-4e9f-8bfc-6c3bdaf68855",
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
    "id": "dbb5b244-96f7-4e9f-8bfc-6c3bdaf68855",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T13:00:56.756687+00:00",
      "updated_at": "2024-12-02T13:00:56.858313+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-3.lvh.me:/barcodes/dbb5b244-96f7-4e9f-8bfc-6c3bdaf68855/image",
      "owner_id": "dbc1f9dd-0b6d-4fad-8b7c-4328eefdf5db",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2ff4dd44-7de7-4f51-ba75-d79ce759d062' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2ff4dd44-7de7-4f51-ba75-d79ce759d062",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-12-02T13:00:57.597175+00:00",
      "updated_at": "2024-12-02T13:00:57.597175+00:00",
      "number": "http://bqbl.it/2ff4dd44-7de7-4f51-ba75-d79ce759d062",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-4.lvh.me:/barcodes/2ff4dd44-7de7-4f51-ba75-d79ce759d062/image",
      "owner_id": "7e5c8e3c-6274-4ba5-9cc4-e6e618c63997",
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









