# Locations

A location is a place (like a store) where customers pick up
and return orders or a warehouse that only stocks inventory.

<aside class="notice">
  Note: The maximum number of active locations depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`carriers` | **[App carriers](#app-carriers)** `hasmany`<br>The carriers that can do delivery from this location. 


Check matching attributes under [Fields](#locations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`address_line_1` | **string** <br>First address line. 
`address_line_2` | **string** <br>Second address line. 
`archived` | **boolean** `readonly`<br>Whether location is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the location was archived. 
`city` | **string** <br>Address city. 
`code` | **string** <br>Code used to identify the location. 
`confirm_has_orders` | **boolean** `writeonly`<br>A flag to confirm an address update when the location has orders. 
`country` | **string** <br>Address country. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`delivery_enabled` | **boolean** `readonly`<br>Whether the location supports delivery. 
`fulfillment_capabilities` | **array[string]** `readonly`<br>The fulfillment process options available from this location.<br>At least one from: `delivery`, `pickup`. 
`id` | **uuid** `readonly`<br>Primary key.
`location_type` | **enum** <br>Determines if the location can be seen in the online store.<br> One of: `rental`, `internal`.
`main_address` | **hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information. 
`main_address_attributes` | **hash** `writeonly`<br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information. 
`name` | **string** <br>Name of the location. 
`pickup_enabled` | **boolean** <br>Whether the location supports pickup. 
`region` | **string** <br>Address region. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`zipcode` | **string** <br>Address ZIP code. 


## List locations


> How to fetch locations:

```shell
  curl --get 'https://example.booqable.com/api/4/locations'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f6399631-79bf-4a64-8deb-169a36a274ae",
        "type": "locations",
        "attributes": {
          "created_at": "2020-04-09T06:23:00.000000+00:00",
          "updated_at": "2020-04-09T06:23:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Warehouse",
          "code": "LOC1000032",
          "location_type": "rental",
          "address_line_1": "Blokhuisplein 40",
          "address_line_2": "Department II",
          "zipcode": "8911LJ",
          "city": "Leeuwarden",
          "region": "Friesland",
          "country": "Netherlands",
          "pickup_enabled": true,
          "delivery_enabled": false,
          "fulfillment_capabilities": [
            "pickup"
          ],
          "main_address": {
            "meets_validation_requirements": true,
            "first_name": null,
            "last_name": null,
            "address1": "Blokhuisplein 40",
            "address2": "Department II",
            "city": "Leeuwarden",
            "region": "Friesland",
            "zipcode": "8911LJ",
            "country": "Netherlands",
            "country_id": "a21c7b3f-031d-4642-8128-3950e505170e",
            "province_id": null,
            "latitude": null,
            "longitude": null,
            "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden\nNetherlands"
          }
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/locations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[locations]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=clusters,carriers`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`code` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`fulfillment_capabilities` | **array[string]** <br>`any_of`
`id` | **uuid** <br>`eq`, `not_eq`
`location_type` | **enum** <br>`eq`
`main_address` | **hash** <br>`eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
  <li><code>clusters</code></li>
</ul>


## Fetch a location


> How to fetch a single location:

```shell
  curl --get 'https://example.booqable.com/api/4/locations/954bf312-7f80-4c5a-8547-8626943b877c'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "954bf312-7f80-4c5a-8547-8626943b877c",
      "type": "locations",
      "attributes": {
        "created_at": "2023-01-14T17:38:02.000000+00:00",
        "updated_at": "2023-01-14T17:38:02.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Warehouse",
        "code": "LOC1000033",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "pickup_enabled": true,
        "delivery_enabled": false,
        "fulfillment_capabilities": [
          "pickup"
        ],
        "main_address": {
          "meets_validation_requirements": true,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuisplein 40",
          "address2": "Department II",
          "city": "Leeuwarden",
          "region": "Friesland",
          "zipcode": "8911LJ",
          "country": "Netherlands",
          "country_id": "7bd3e269-0893-4070-84ec-02621281dfb7",
          "province_id": null,
          "latitude": null,
          "longitude": null,
          "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden\nNetherlands"
        }
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/locations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[locations]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=clusters,carriers`


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
  <li><code>clusters</code></li>
</ul>


## Create a location


> How to create a location:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/locations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "locations",
           "attributes": {
             "name": "Store",
             "code": "STR",
             "location_type": "rental",
             "address_line_1": "Blokhuisplein 40",
             "address_line_2": "Department II",
             "zipcode": "8911LJ",
             "city": "Leeuwarden",
             "region": "Friesland",
             "country": "Netherlands"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "5be434a1-6596-4ee2-85bd-bacf7f605a45",
      "type": "locations",
      "attributes": {
        "created_at": "2026-11-25T21:28:03.000000+00:00",
        "updated_at": "2026-11-25T21:28:03.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Store",
        "code": "STR",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "pickup_enabled": true,
        "delivery_enabled": false,
        "fulfillment_capabilities": [
          "pickup"
        ],
        "main_address": {
          "meets_validation_requirements": true,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuisplein 40",
          "address2": "Department II",
          "city": "Leeuwarden",
          "region": "Friesland",
          "zipcode": "8911LJ",
          "country": "Netherlands",
          "country_id": "d26f5233-d408-4d98-8d55-137351a9e4b6",
          "province_id": null,
          "latitude": null,
          "longitude": null,
          "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden\nNetherlands"
        }
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/locations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[locations]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=clusters,carriers`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address_line_1]` | **string** <br>First address line. 
`data[attributes][address_line_2]` | **string** <br>Second address line. 
`data[attributes][city]` | **string** <br>Address city. 
`data[attributes][code]` | **string** <br>Code used to identify the location. 
`data[attributes][confirm_has_orders]` | **boolean** <br>A flag to confirm an address update when the location has orders. 
`data[attributes][country]` | **string** <br>Address country. 
`data[attributes][location_type]` | **enum** <br>Determines if the location can be seen in the online store.<br> One of: `rental`, `internal`.
`data[attributes][main_address]` | **hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information. 
`data[attributes][main_address_attributes]` | **hash** <br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information. 
`data[attributes][name]` | **string** <br>Name of the location. 
`data[attributes][pickup_enabled]` | **boolean** <br>Whether the location supports pickup. 
`data[attributes][region]` | **string** <br>Address region. 
`data[attributes][zipcode]` | **string** <br>Address ZIP code. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
  <li><code>clusters</code></li>
</ul>


## Update a location


> How to update a location:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/locations/403f9cbe-54ea-430e-8c50-e38c2f513535'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "403f9cbe-54ea-430e-8c50-e38c2f513535",
           "type": "locations",
           "attributes": {
             "name": "Old warehouse"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "403f9cbe-54ea-430e-8c50-e38c2f513535",
      "type": "locations",
      "attributes": {
        "created_at": "2020-12-17T00:44:00.000000+00:00",
        "updated_at": "2020-12-17T00:44:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Old warehouse",
        "code": "LOC1000035",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "pickup_enabled": true,
        "delivery_enabled": false,
        "fulfillment_capabilities": [
          "pickup"
        ],
        "main_address": {
          "meets_validation_requirements": true,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuisplein 40",
          "address2": "Department II",
          "city": "Leeuwarden",
          "region": "Friesland",
          "zipcode": "8911LJ",
          "country": "Netherlands",
          "country_id": "d39353e1-4919-44c6-8f39-ec34e382e68d",
          "province_id": null,
          "latitude": null,
          "longitude": null,
          "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden\nNetherlands"
        }
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/locations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[locations]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=clusters,carriers`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address_line_1]` | **string** <br>First address line. 
`data[attributes][address_line_2]` | **string** <br>Second address line. 
`data[attributes][city]` | **string** <br>Address city. 
`data[attributes][code]` | **string** <br>Code used to identify the location. 
`data[attributes][confirm_has_orders]` | **boolean** <br>A flag to confirm an address update when the location has orders. 
`data[attributes][country]` | **string** <br>Address country. 
`data[attributes][location_type]` | **enum** <br>Determines if the location can be seen in the online store.<br> One of: `rental`, `internal`.
`data[attributes][main_address]` | **hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information. 
`data[attributes][main_address_attributes]` | **hash** <br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information. 
`data[attributes][name]` | **string** <br>Name of the location. 
`data[attributes][pickup_enabled]` | **boolean** <br>Whether the location supports pickup. 
`data[attributes][region]` | **string** <br>Address region. 
`data[attributes][zipcode]` | **string** <br>Address ZIP code. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
  <li><code>clusters</code></li>
</ul>


## Archive a location

To archive a location make sure that:

- There is no active stock at the location
- There are no running or future orders for this location
- This is not the last active location

> How to archive a location:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/locations/3f258b5c-005d-4808-81c2-954da48df0cb'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "3f258b5c-005d-4808-81c2-954da48df0cb",
      "type": "locations",
      "attributes": {
        "created_at": "2020-03-03T14:31:02.000000+00:00",
        "updated_at": "2020-03-03T14:31:02.000000+00:00",
        "archived": true,
        "archived_at": "2020-03-03T14:31:02.000000+00:00",
        "name": "Warehouse",
        "code": "LOC1000036",
        "location_type": "rental",
        "address_line_1": "Blokhuisplein 40",
        "address_line_2": "Department II",
        "zipcode": "8911LJ",
        "city": "Leeuwarden",
        "region": "Friesland",
        "country": "Netherlands",
        "pickup_enabled": true,
        "delivery_enabled": false,
        "fulfillment_capabilities": [
          "pickup"
        ],
        "main_address": {
          "meets_validation_requirements": true,
          "first_name": null,
          "last_name": null,
          "address1": "Blokhuisplein 40",
          "address2": "Department II",
          "city": "Leeuwarden",
          "region": "Friesland",
          "zipcode": "8911LJ",
          "country": "Netherlands",
          "country_id": "560394ea-598c-43e6-8936-f4c3e2efffa1",
          "province_id": null,
          "latitude": null,
          "longitude": null,
          "value": "Blokhuisplein 40\nDepartment II\n8911LJ Leeuwarden\nNetherlands"
        }
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Failure due to a future order:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/locations/0b51712b-bd56-43d4-8e58-08b818262a12'
       --header 'content-type: application/json'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "location_has_orders",
        "status": "422",
        "title": "Location has orders",
        "detail": "This location has running or future orders",
        "meta": {
          "blocking": [
            {
              "orders": [
                {
                  "id": "0d8a3816-e267-4375-8cd1-cf1340de963d"
                }
              ]
            }
          ]
        }
      }
    ]
  }
```

> Failure due to active stock at location:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/locations/d5edee8a-8801-48cd-8087-14b1d659a294'
       --header 'content-type: application/json'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "location_has_stock",
        "status": "422",
        "title": "Location has stock",
        "detail": "This location has active stock",
        "meta": {
          "item_ids": [
            "3e62df61-af47-4c9b-8279-1dfb80db2936"
          ]
        }
      }
    ]
  }
```

### HTTP Request

`DELETE /api/4/locations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[locations]=created_at,updated_at,archived`


### Includes

This request does not accept any includes