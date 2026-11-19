# Locations

A location is a place (like a store) where customers pick up
and return orders or a warehouse that only stocks inventory.

<aside class="notice">
  Note: The maximum number of active locations depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`carriers` | **[App carriers](https://developers.booqable.com/v4.html#app-carriers)** `hasmany`<br>The carriers that can do delivery from this location. 


Check matching attributes under [Fields](https://developers.booqable.com/v4.html#locations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`add_carrier_ids` | **array_of_uuids** `writeonly`<br>The IDs of delivery carriers to add to this location. Carriers that are not listed stay as they are. An already linked carrier is ignored. The carriers change in the same save as the other attributes, so `pickup_enabled: false` with at least one carrier creates a delivery only location, or switches a location to delivery only, in one request. Adding a carrier needs a main address (see `main_address_attributes`); without one the request fails with a `main_address` error. An unknown ID, or an archived carrier that is not linked yet, fails with a `carrier_ids` error. 
`address_line_1` | **string** <br>First address line. 
`address_line_2` | **string** <br>Second address line. 
`archived` | **boolean** `readonly`<br>Whether location is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the location was archived. 
`city` | **string** <br>Address city. 
`code` | **string** <br>Code used to identify the location, stored in uppercase. A new or changed code takes at most 3 characters; a longer code saved earlier stays valid. 
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
`remove_carrier_ids` | **array_of_uuids** `writeonly`<br>The IDs of delivery carriers to remove from this location, when updating it. Carriers that are not listed stay as they are. A carrier that is not linked, or that is also listed in `add_carrier_ids`, is ignored. A location without carriers keeps pickup, even when `pickup_enabled` is `false`. 
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
          "code": "00Y",
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
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=carriers`
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
        "code": "00Z",
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
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=carriers`


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
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
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=carriers`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][add_carrier_ids]` | **array_of_uuids** <br>The IDs of delivery carriers to add to this location. Carriers that are not listed stay as they are. An already linked carrier is ignored. The carriers change in the same save as the other attributes, so `pickup_enabled: false` with at least one carrier creates a delivery only location, or switches a location to delivery only, in one request. Adding a carrier needs a main address (see `main_address_attributes`); without one the request fails with a `main_address` error. An unknown ID, or an archived carrier that is not linked yet, fails with a `carrier_ids` error. 
`data[attributes][address_line_1]` | **string** <br>First address line. 
`data[attributes][address_line_2]` | **string** <br>Second address line. 
`data[attributes][city]` | **string** <br>Address city. 
`data[attributes][code]` | **string** <br>Code used to identify the location, stored in uppercase. A new or changed code takes at most 3 characters; a longer code saved earlier stays valid. 
`data[attributes][confirm_has_orders]` | **boolean** <br>A flag to confirm an address update when the location has orders. 
`data[attributes][country]` | **string** <br>Address country. 
`data[attributes][location_type]` | **enum** <br>Determines if the location can be seen in the online store.<br> One of: `rental`, `internal`.
`data[attributes][main_address]` | **hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information. 
`data[attributes][main_address_attributes]` | **hash** <br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information. 
`data[attributes][name]` | **string** <br>Name of the location. 
`data[attributes][pickup_enabled]` | **boolean** <br>Whether the location supports pickup. 
`data[attributes][region]` | **string** <br>Address region. 
`data[attributes][remove_carrier_ids]` | **array_of_uuids** <br>The IDs of delivery carriers to remove from this location, when updating it. Carriers that are not listed stay as they are. A carrier that is not linked, or that is also listed in `add_carrier_ids`, is ignored. A location without carriers keeps pickup, even when `pickup_enabled` is `false`. 
`data[attributes][zipcode]` | **string** <br>Address ZIP code. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
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
        "code": "011",
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

> How to switch a location to delivery only:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/locations/b3fd4bfb-497a-4d23-86f6-c2e510736bae'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "b3fd4bfb-497a-4d23-86f6-c2e510736bae",
           "type": "locations",
           "attributes": {
             "pickup_enabled": false,
             "add_carrier_ids": [
               "703a28a0-f5a2-4c20-8252-2bb6ce42c440"
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b3fd4bfb-497a-4d23-86f6-c2e510736bae",
      "type": "locations",
      "attributes": {
        "created_at": "2025-06-15T13:04:00.000000+00:00",
        "updated_at": "2025-06-15T13:04:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Store",
        "code": "013",
        "location_type": "rental",
        "address_line_1": "123 Street",
        "address_line_2": null,
        "zipcode": "1234 AB",
        "city": "Test city",
        "region": null,
        "country": "Netherlands",
        "pickup_enabled": false,
        "delivery_enabled": true,
        "fulfillment_capabilities": [
          "delivery"
        ],
        "main_address": {
          "meets_validation_requirements": true,
          "first_name": null,
          "last_name": null,
          "address1": "123 Street",
          "address2": null,
          "city": "Test city",
          "region": null,
          "zipcode": "1234 AB",
          "country": "Netherlands",
          "country_id": "492b2404-7142-4008-8cd1-772895167c9d",
          "province_id": null,
          "latitude": "0",
          "longitude": "0",
          "value": "123 Street\n1234 AB Test city\nNetherlands"
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
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=carriers`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][add_carrier_ids]` | **array_of_uuids** <br>The IDs of delivery carriers to add to this location. Carriers that are not listed stay as they are. An already linked carrier is ignored. The carriers change in the same save as the other attributes, so `pickup_enabled: false` with at least one carrier creates a delivery only location, or switches a location to delivery only, in one request. Adding a carrier needs a main address (see `main_address_attributes`); without one the request fails with a `main_address` error. An unknown ID, or an archived carrier that is not linked yet, fails with a `carrier_ids` error. 
`data[attributes][address_line_1]` | **string** <br>First address line. 
`data[attributes][address_line_2]` | **string** <br>Second address line. 
`data[attributes][city]` | **string** <br>Address city. 
`data[attributes][code]` | **string** <br>Code used to identify the location, stored in uppercase. A new or changed code takes at most 3 characters; a longer code saved earlier stays valid. 
`data[attributes][confirm_has_orders]` | **boolean** <br>A flag to confirm an address update when the location has orders. 
`data[attributes][country]` | **string** <br>Address country. 
`data[attributes][location_type]` | **enum** <br>Determines if the location can be seen in the online store.<br> One of: `rental`, `internal`.
`data[attributes][main_address]` | **hash** <br>A hash with the address fields. Use it when fetching a location. See `address` property type for more information. 
`data[attributes][main_address_attributes]` | **hash** <br>A hash with the address fields. Use it when creating or updating a location. See `address` property type for more information. 
`data[attributes][name]` | **string** <br>Name of the location. 
`data[attributes][pickup_enabled]` | **boolean** <br>Whether the location supports pickup. 
`data[attributes][region]` | **string** <br>Address region. 
`data[attributes][remove_carrier_ids]` | **array_of_uuids** <br>The IDs of delivery carriers to remove from this location, when updating it. Carriers that are not listed stay as they are. A carrier that is not linked, or that is also listed in `add_carrier_ids`, is ignored. A location without carriers keeps pickup, even when `pickup_enabled` is `false`. 
`data[attributes][zipcode]` | **string** <br>Address ZIP code. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>carriers</code></li>
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
        "code": "014",
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