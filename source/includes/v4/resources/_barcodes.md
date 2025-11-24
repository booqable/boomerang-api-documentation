# Barcodes

You can assign Barcodes to Product (variations), individually tracked StockItems,
and Customers (for use on a customer card, for example).

A QR code is always generated for each Order. This QR code can be included in emails
for speedy pickup and printed on packing slips for easier logistics.

Barcodes cannot be added to ProductGroups. Instead Barcodes can be added to individual
Products within the ProductGroup. This is also true when a ProductGroup does not have
variations enabled. In that case a Barcode is added to the single Product in the group.

<aside class="notice">
  Availability of barcodes and barcode-scanning depends on the current pricing plan.
</aside>

## Supported formats

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

Note that when using URLs as numbers, it's advised to base64 encode the number before filtering.

## Relationships
Name | Description
-- | --
`owner` | **[Customer](#customers), [Product](#products), [Order](#orders), [Stock item](#stock-items)** `required`<br>The resource pointed to by this Barcode. 


Check matching attributes under [Fields](#barcodes-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`barcode_type` | **enum** <br>Barcode format. See resource description above for pros/cons of each format.<br> One of: `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`image_url` | **string** `readonly`<br>A link to an image of the Barcode. 
`number` | **string** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering. 
`owner_id` | **uuid** `readonly-after-create`<br>The resource pointed to by this Barcode. 
`owner_type` | **enum** `readonly-after-create`<br>The resource type of the owner.<br>One of: `customers`, `products`, `orders`, `stock_items`.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List barcodes


> How to fetch a list of barcodes:

```shell
  curl --get 'https://example.booqable.com/api/4/barcodes'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "c3fbfdf6-d756-4d88-89c7-974df32dc31f",
        "type": "barcodes",
        "attributes": {
          "created_at": "2026-11-20T19:16:00.000000+00:00",
          "updated_at": "2026-11-20T19:16:00.000000+00:00",
          "number": "http://bqbl.it/c3fbfdf6-d756-4d88-89c7-974df32dc31f",
          "barcode_type": "qr_code",
          "image_url": "http://company-name-28.lvh.me/barcodes/c3fbfdf6-d756-4d88-89c7-974df32dc31f/image",
          "owner_id": "2318a321-06f9-4303-8d23-b46cfb189aeb",
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
  curl --get 'https://example.booqable.com/api/4/barcodes'
       --header 'content-type: application/json'
       --data-urlencode 'filter[number]=http://bqbl.it/9882a0de-d425-4c34-8a53-f65dd35dd375'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "9882a0de-d425-4c34-8a53-f65dd35dd375",
        "type": "barcodes",
        "attributes": {
          "created_at": "2021-09-12T13:49:00.000000+00:00",
          "updated_at": "2021-09-12T13:49:00.000000+00:00",
          "number": "http://bqbl.it/9882a0de-d425-4c34-8a53-f65dd35dd375",
          "barcode_type": "qr_code",
          "image_url": "http://company-name-29.lvh.me/barcodes/9882a0de-d425-4c34-8a53-f65dd35dd375/image",
          "owner_id": "48f38dad-4082-4377-8d28-c793e2d1c814",
          "owner_type": "customers"
        },
        "relationships": {
          "owner": {
            "data": {
              "type": "customers",
              "id": "48f38dad-4082-4377-8d28-c793e2d1c814"
            }
          }
        }
      }
    ],
    "included": [
      {
        "id": "48f38dad-4082-4377-8d28-c793e2d1c814",
        "type": "customers",
        "attributes": {
          "created_at": "2021-09-12T13:49:00.000000+00:00",
          "updated_at": "2021-09-12T13:49:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 1,
          "name": "John Doe",
          "email": "john-2@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {},
          "tag_list": [],
          "stripe_id": null,
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
  curl --get 'https://example.booqable.com/api/4/barcodes'
       --header 'content-type: application/json'
       --data-urlencode 'filter[number]=aHR0cDovL2JxYmwuaXQvMGFkMWE2NzUtZWNmOS00MDJlLWI4NzItNTg4NjRjNDEzMzk4'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "78a5e268-fca0-450a-855f-49f29ef29ef3",
        "type": "barcodes",
        "attributes": {
          "created_at": "2023-09-26T19:48:00.000000+00:00",
          "updated_at": "2023-09-26T19:48:00.000000+00:00",
          "number": "http://bqbl.it/78a5e268-fca0-450a-855f-49f29ef29ef3",
          "barcode_type": "qr_code",
          "image_url": "http://company-name-30.lvh.me/barcodes/78a5e268-fca0-450a-855f-49f29ef29ef3/image",
          "owner_id": "ab6232e0-b056-4bf8-8bc7-99c41f2782de",
          "owner_type": "customers"
        },
        "relationships": {
          "owner": {
            "data": {
              "type": "customers",
              "id": "ab6232e0-b056-4bf8-8bc7-99c41f2782de"
            }
          }
        }
      }
    ],
    "included": [
      {
        "id": "ab6232e0-b056-4bf8-8bc7-99c41f2782de",
        "type": "customers",
        "attributes": {
          "created_at": "2023-09-26T19:48:00.000000+00:00",
          "updated_at": "2023-09-26T19:48:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 2,
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
          "stripe_id": null,
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

`GET /api/4/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[barcodes]=created_at,updated_at,number`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`barcode_type` | **enum** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`number` | **string** <br>`eq`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **enum** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>owner</code>
    <ul>
      <li><code>photo</code></li>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Fetch a barcode


> How to fetch a barcode:

```shell
  curl --get 'https://example.booqable.com/api/4/barcodes/60d46666-056c-4072-8fd0-cae57d7a90ff'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "60d46666-056c-4072-8fd0-cae57d7a90ff",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-11-26T10:01:03.000000+00:00",
        "updated_at": "2023-11-26T10:01:03.000000+00:00",
        "number": "http://bqbl.it/60d46666-056c-4072-8fd0-cae57d7a90ff",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-31.lvh.me/barcodes/60d46666-056c-4072-8fd0-cae57d7a90ff/image",
        "owner_id": "9a08fa5a-eddb-4502-8e1e-60dbd303cb58",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "9a08fa5a-eddb-4502-8e1e-60dbd303cb58"
          }
        }
      }
    },
    "included": [
      {
        "id": "9a08fa5a-eddb-4502-8e1e-60dbd303cb58",
        "type": "customers",
        "attributes": {
          "created_at": "2023-11-26T10:01:03.000000+00:00",
          "updated_at": "2023-11-26T10:01:03.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 1,
          "name": "John Doe",
          "email": "john-5@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {},
          "tag_list": [],
          "stripe_id": null,
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

`GET /api/4/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[barcodes]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>owner</code>
    <ul>
      <li><code>photo</code></li>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Create a barcode


> How to create a barcode:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/barcodes'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "barcodes",
           "attributes": {
             "barcode_type": "qr_code",
             "owner_id": "9d177e60-f890-4d0a-8dc6-44d61d8cca22",
             "owner_type": "customers"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "954b9fd3-271d-4ab4-8a7e-87e89b15c0a0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2019-09-24T03:44:00.000000+00:00",
        "updated_at": "2019-09-24T03:44:00.000000+00:00",
        "number": "http://bqbl.it/954b9fd3-271d-4ab4-8a7e-87e89b15c0a0",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-32.lvh.me/barcodes/954b9fd3-271d-4ab4-8a7e-87e89b15c0a0/image",
        "owner_id": "9d177e60-f890-4d0a-8dc6-44d61d8cca22",
        "owner_type": "customers"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/barcodes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[barcodes]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][barcode_type]` | **enum** <br>Barcode format. See resource description above for pros/cons of each format.<br> One of: `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`.
`data[attributes][number]` | **string** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering. 
`data[attributes][owner_id]` | **uuid** <br>The resource pointed to by this Barcode. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>One of: `customers`, `products`, `orders`, `stock_items`.


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>owner</code>
    <ul>
      <li><code>photo</code></li>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Update a barcode


> How to update a barcode:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/barcodes/d4f58d8f-2318-44f4-8097-9dbe2a9ddaf2'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "d4f58d8f-2318-44f4-8097-9dbe2a9ddaf2",
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
      "id": "d4f58d8f-2318-44f4-8097-9dbe2a9ddaf2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-11T03:09:01.000000+00:00",
        "updated_at": "2021-10-11T03:09:01.000000+00:00",
        "number": "https://myfancysite.com",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-33.lvh.me/barcodes/d4f58d8f-2318-44f4-8097-9dbe2a9ddaf2/image",
        "owner_id": "a8f4104c-a6da-44d0-8505-a590b71bb780",
        "owner_type": "customers"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[barcodes]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][barcode_type]` | **enum** <br>Barcode format. See resource description above for pros/cons of each format.<br> One of: `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`.
`data[attributes][number]` | **string** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering. 
`data[attributes][owner_id]` | **uuid** <br>The resource pointed to by this Barcode. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>One of: `customers`, `products`, `orders`, `stock_items`.


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>owner</code>
    <ul>
      <li><code>photo</code></li>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Destroy a barcode


> How to delete a barcode:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/barcodes/ac988a7e-ebdc-45af-8638-9783aeb4594e'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ac988a7e-ebdc-45af-8638-9783aeb4594e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-27T06:20:00.000000+00:00",
        "updated_at": "2023-03-27T06:20:00.000000+00:00",
        "number": "http://bqbl.it/ac988a7e-ebdc-45af-8638-9783aeb4594e",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-34.lvh.me/barcodes/ac988a7e-ebdc-45af-8638-9783aeb4594e/image",
        "owner_id": "20fbc832-70a9-45dd-84fd-848ee269b502",
        "owner_type": "customers"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[barcodes]=created_at,updated_at,number`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>owner</code>
    <ul>
      <li><code>photo</code></li>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>

