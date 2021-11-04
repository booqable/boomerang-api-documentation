# Products

Products are items that are plannable on orders. They always belong to a product group and can only be created separately if the group has variations enabled.

Most of the settings are inherited from the associated product group. When the group has variations enabled, the `base_price_in_cents` field is not inherited from the group anymore but can be set individually.

## Endpoints
`GET /api/boomerang/products`

`GET /api/boomerang/products/{id}`

`POST /api/boomerang/products`

`PUT /api/boomerang/products/{id}`

`DELETE /api/boomerang/products/{id}`

## Fields
Every product has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>Name of the item (based on product group and `variations_values`)
`slug` | **String** `readonly`<br>Slug of the item
`sku` | **String**<br>Stock keeping unit
`type` | **String** `readonly`<br>One of `ProductGroup`, `Product`, `Bundle`
`lead_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable after a reservation
`product_type` | **String** `readonly`<br>**Inherited from product group**: One of `rental`, `consumable`, `service`
`tracking_type` | **String** `readonly`<br>**Inherited from product group**: Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean** `readonly`<br>**Inherited from product group**: Wheter stock items are tracked
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `readonly`<br>When the item was archived
`extra_information` | **String** `readonly`<br>**Inherited from product group**: Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`description` | **String** `readonly`<br>**Inherited from product group**: Description used in the online store
`show_in_store` | **Boolean** `readonly`<br>**Inherited from product group**: Whether to show this item in the online
`sorting_weight` | **Integer** `readonly`<br>**Inherited from product group**: Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer**<br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`price_type` | **String** `readonly`<br>**Inherited from product group**: One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`price_period` | **String** `readonly`<br>**Inherited from product group**: One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`deposit_in_cents` | **Integer**<br>The value to use for deposit calculations
`discountable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether item is taxable
`tag_list` | **Array** `readonly`<br>**Inherited from product group**: List of tags
`properties` | **Hash** `readonly`<br>**Inherited from product group**: Key value pairs of associated properties
`photo_id` | **Uuid**<br>The associated Photo
`quantity` | **Integer** `writeonly`<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`variation_values` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`allow_shortage` | **Boolean** `readonly`<br>**Inherited from product group**: Whether shortages are allowed
`shortage_limit` | **Integer** `readonly`<br>**Inherited from product group**: The maximum allowed shortage for any date range
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`product_group_id` | **Uuid**<br>The associated Product group
`tax_category_id` | **Uuid** `readonly`<br>The associated Tax category


## Relationships
Products have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`product_group` | **Product groups** `readonly`<br>Associated Product group
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`barcode` | **Barcodes**<br>Associated Barcode
`properties` | **Properties** `readonly`<br>Associated Properties


## Listing products



> How to fetch a list of products:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "71c45171-b42e-4bf3-b6a0-70b97e56bbb7",
      "type": "products",
      "attributes": {
        "name": "iPad Pro - blue",
        "slug": "ipad-pro-blue",
        "sku": null,
        "type": "Product",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [
          "blue"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "31cad424-f005-4812-9b6a-c394a4123638",
        "tax_category_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/31cad424-f005-4812-9b6a-c394a4123638"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=71c45171-b42e-4bf3-b6a0-70b97e56bbb7"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=31cad424-f005-4812-9b6a-c394a4123638"
          }
        }
      }
    },
    {
      "id": "057109b9-0192-4150-a9eb-3de90a1b9fc4",
      "type": "products",
      "attributes": {
        "name": "iPad Pro - green",
        "slug": "ipad-pro",
        "sku": "sku",
        "type": "Product",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [
          "green"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "31cad424-f005-4812-9b6a-c394a4123638",
        "tax_category_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/31cad424-f005-4812-9b6a-c394a4123638"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=057109b9-0192-4150-a9eb-3de90a1b9fc4"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=31cad424-f005-4812-9b6a-c394a4123638"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/search/items?filter%5Btype%5D=product&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/search/items?filter%5Btype%5D=product&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/search/items?filter%5Btype%5D=product&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/products`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-04T16:17:06Z`
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
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`trackable` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`allow_shortage` | **Boolean**<br>`eq`
`shortage_limit` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`product_type` | **Array**<br>`count`
`tracking_type` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`base_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`price_type` | **Array**<br>`count`
`price_period` | **Array**<br>`count`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discountable` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`photo`






## Fetching a product



> How to fetch a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products/76fe83be-f33d-48e3-b281-36bbbba98764' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "76fe83be-f33d-48e3-b281-36bbbba98764",
    "type": "products",
    "attributes": {
      "name": "iPad Pro - green",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "99732866-5e44-48bf-b778-b8e2a8b35e96",
      "tax_category_id": null
    },
    "relationships": {
      "photo": {
        "links": {
          "related": null
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/99732866-5e44-48bf-b778-b8e2a8b35e96"
        }
      },
      "tax_category": {
        "links": {
          "related": null
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=76fe83be-f33d-48e3-b281-36bbbba98764"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=99732866-5e44-48bf-b778-b8e2a8b35e96"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/products/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`






## Creating a product



> How to create a product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/products' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "products",
        "attributes": {
          "product_group_id": "805c961b-7bb8-474b-865a-cfc68faa9094",
          "variation_values": [
            "red"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2c136602-d156-4b7f-892b-c5bb2dde41bf",
    "type": "products",
    "attributes": {
      "name": "iPad Pro - red",
      "slug": "ipad-pro-red",
      "sku": null,
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "805c961b-7bb8-474b-865a-cfc68faa9094",
      "tax_category_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/products?data%5Battributes%5D%5Bproduct_group_id%5D=805c961b-7bb8-474b-865a-cfc68faa9094&data%5Battributes%5D%5Bvariation_values%5D%5B%5D=red&data%5Btype%5D=products&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/products?data%5Battributes%5D%5Bproduct_group_id%5D=805c961b-7bb8-474b-865a-cfc68faa9094&data%5Battributes%5D%5Bvariation_values%5D%5B%5D=red&data%5Btype%5D=products&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/products?data%5Battributes%5D%5Bproduct_group_id%5D=805c961b-7bb8-474b-865a-cfc68faa9094&data%5Battributes%5D%5Bvariation_values%5D%5B%5D=red&data%5Btype%5D=products&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/products`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][base_price_in_cents]` | **Integer**<br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][quantity]` | **Integer**<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`data[attributes][variation_values][]` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`






## Updating a product



> How to update a product:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/products/888aa53d-22d9-48ec-9e51-eac53c5f0fe5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "888aa53d-22d9-48ec-9e51-eac53c5f0fe5",
        "type": "products",
        "attributes": {
          "variation_values": [
            "red"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "888aa53d-22d9-48ec-9e51-eac53c5f0fe5",
    "type": "products",
    "attributes": {
      "name": "iPad Pro - red",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "ab03482f-1515-4cda-958a-c91cd3e5aade",
      "tax_category_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
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

`PUT /api/boomerang/products/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][base_price_in_cents]` | **Integer**<br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][quantity]` | **Integer**<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`data[attributes][variation_values][]` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`






## Archiving a product



> How to delete a product:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/products/69445121-f291-44da-93ed-087d940d23c3' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/products/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request does not accept any includes