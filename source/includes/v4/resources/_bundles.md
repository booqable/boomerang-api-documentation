# Bundles

Bundles allow for a single product to be made up of multiple other products.
This makes it possible to offer customers a set of products that logically
go together as a single package, for a single price, and with a combined
availability.

Bundles are composed from [BundleItems](#bundle-items), which describe
which products are included, how many of them, and the discount for each product.

There are two types of bundles:

  - _"fixed"_ or _"specified"_: The products are fixed, and the customer does not get to choose.

  - _"unspecified"_: One or more of the products in the bundle has multiple product variations,
  and the customer gets to choose from them. In this case, pricing and availability of the
  bundle depends on the customer's selected product variation.

<aside class="notice">
  Availability of the bundles feature depends on the current pricing plan.
</aside>

<aside class="warning">
  When Bundles are in use sorting of lines on orders and documents becomes non-trivial.
  See the <a href="#lines">Line</a> resource for details.
</aside>

## Relationships
Name | Description
-- | --
`bundle_items` | **[Bundle items](#bundle-items)** `hasmany`<br>The bundle items that make up this bundle. 
`inventory_levels` | **[Inventory levels](#inventory-levels)** `hasmany`<br>Availability of this bundle. Because bundles do not exist on a physical level (they are a collection of products), the returned availability will be the maximum number of bundles that can be made from the available products (bundle availability is restricted by the least available product). 
`photo` | **[Photo](#photos)** `optional`<br>Primary photo of this bundle. 
`photos` | **[Photos](#photos)** `hasmany`<br>All photos of this bundle. The primary `photo` must be selected from this set. 
`tax_category` | **[Tax category](#tax-categories)** `optional`<br>Tax category for tax calculations. When present, this tax category overrides the tax category of the individual products. 


Check matching attributes under [Fields](#bundles-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether the bundle is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the bundle was archived. 
`bundle_items_attributes` | **array** `writeonly`<br>Writing to this attribute allows to create or update bundle items at the same time as the bundle itself. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`description` | **string** `nullable`<br>Description used in the online store. 
`discountable` | **boolean** <br>Whether discounts should be applied to items in this bundle. 
`excerpt` | **string** `nullable`<br>Excerpt used in the online store. 
`extra_information` | **string** `nullable`<br>Extra information about the bundle, shown on orders and documents. 
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Name of the bundle. 
`photo_base64` | **string** `writeonly`<br>Base64 encoded photo, use this field to store a main photo. 
`photo_id` | **uuid** `readonly` `nullable`<br>Primary photo of this bundle. 
`photo_url` | **string** `readonly`<br>Main photo URL. 
`product_type` | **enum** `readonly`<br>Always `bundle`. This attribute exists because bundles are a kind of [Item](#items).<br> Always `bundle`
`remote_photo_url` | **string** `writeonly`<br>URL to an image on the web. 
`seo_description` | **string** `nullable`<br>SEO meta description tag. 
`seo_title` | **string** `nullable`<br>SEO title tag. 
`show_in_store` | **boolean** <br>Whether to show this item in the online store. 
`slug` | **string** <br>Slug of the bundle. 
`sorting_weight` | **integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists. 
`tag_list` | **array** <br>List of tags. 
`tax_category_id` | **uuid** `nullable`<br>Tax category for tax calculations. When present, this tax category overrides the tax category of the individual products. 
`taxable` | **boolean** <br>Whether this bundle is taxable. 
`type` | **string** `readonly`<br>Always `bundles`. This attribute exists because bundles are a kind of [Item](#items). 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List bundles


> How to fetch a list of bundles:

```shell
  curl --get 'https://example.booqable.com/api/4/bundles'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "18ffd1b4-8468-4bad-82c1-1e7f370f600f",
        "type": "bundles",
        "attributes": {
          "created_at": "2020-11-21T17:08:01.000000+00:00",
          "updated_at": "2020-11-21T17:08:01.000000+00:00",
          "archived": false,
          "archived_at": null,
          "type": "bundles",
          "name": "iPad Bundle",
          "slug": "ipad-bundle",
          "product_type": "bundle",
          "extra_information": null,
          "photo_url": null,
          "description": null,
          "excerpt": null,
          "show_in_store": true,
          "sorting_weight": 0,
          "discountable": true,
          "taxable": true,
          "seo_title": null,
          "seo_description": null,
          "tag_list": [],
          "photo_id": null,
          "tax_category_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/bundles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundles]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,inventory_levels`
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
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discountable` | **boolean** <br>`eq`
`excerpt` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_id` | **uuid** <br>`eq`, `not_eq`
`product_type` | **enum** <br>`eq`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **boolean** <br>`eq`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **string** <br>`eq`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`taxable` | **boolean** <br>`eq`
`type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`archived` | **array** <br>`count`
`discountable` | **array** <br>`count`
`product_type` | **array** <br>`count`
`show_in_store` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_category_id` | **array** <br>`count`
`taxable` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>inventory_levels</code></li>
  <li><code>photo</code></li>
</ul>


## Search bundles

Use advanced search to make logical filter groups with and/or operators.

> How to search for bundles:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bundles/search'
       --header 'content-type: application/json'
       --data '{
         "fields": {
           "bundles": "id"
         },
         "filter": {
           "conditions": {
             "operator": "or",
             "attributes": [
               {
                 "operator": "and",
                 "attributes": [
                   {
                     "discountable": true
                   },
                   {
                     "taxable": true
                   }
                 ]
               },
               {
                 "operator": "and",
                 "attributes": [
                   {
                     "show_in_store": true
                   },
                   {
                     "taxable": true
                   }
                 ]
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "ea409533-a730-4d13-8149-036b51248925"
      },
      {
        "id": "16552c0c-85c9-4d79-81d8-862b15da8a16"
      },
      {
        "id": "714cbc42-5133-4ee2-8945-1fb6391bfbc8"
      }
    ]
  }
```

### HTTP Request

`POST /api/4/bundles/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundles]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,inventory_levels`
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
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discountable` | **boolean** <br>`eq`
`excerpt` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_id` | **uuid** <br>`eq`, `not_eq`
`product_type` | **enum** <br>`eq`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **boolean** <br>`eq`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **string** <br>`eq`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`taxable` | **boolean** <br>`eq`
`type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`archived` | **array** <br>`count`
`discountable` | **array** <br>`count`
`product_type` | **array** <br>`count`
`show_in_store` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_category_id` | **array** <br>`count`
`taxable` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>inventory_levels</code></li>
  <li><code>photo</code></li>
</ul>


## Fetch a bundle


> How to fetch a bundle:

```shell
  curl --get 'https://example.booqable.com/api/4/bundles/7a7aeed9-35dd-40fe-8ece-5551e24ce953'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "7a7aeed9-35dd-40fe-8ece-5551e24ce953",
      "type": "bundles",
      "attributes": {
        "created_at": "2027-01-01T09:13:00.000000+00:00",
        "updated_at": "2027-01-01T09:13:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "type": "bundles",
        "name": "iPad Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundles]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,bundle_items,tax_category`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>bundle_items</code>
    <ul>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
      <li>
          <code>product_group</code>
          <ul>
            <li><code>photo</code></li>
            <li>
                  <code>products</code>
                  <ul>
                    <li><code>photo</code></li>
                  </ul>
            </li>
          </ul>
      </li>
    </ul>
  </li>
  <li><code>photo</code></li>
  <li><code>tax_category</code></li>
</ul>


## Create a bundle


> How to create a bundle with bundle items:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bundles'
       --header 'content-type: application/json'
       --data '{
         "include": "bundle_items",
         "data": {
           "type": "bundles",
           "attributes": {
             "name": "iPad Pro Bundle",
             "bundle_items_attributes": [
               {
                 "quantity": 2,
                 "discount_percentage": 10,
                 "product_group_id": "1a247a34-c748-422e-8f6e-1a6d3992c656",
                 "product_id": "ca3c0fbf-03ac-4a05-8a65-d5bab132b59d"
               },
               {
                 "quantity": 2,
                 "discount_percentage": 15,
                 "product_group_id": "bf793cc3-ff25-497e-8a92-6cf9a8d99fa0",
                 "product_id": "07b0cf35-6809-4bec-8350-2dbe5a39a565"
               }
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "2f4b77bd-2e6d-4454-8933-babc61ed151f",
      "type": "bundles",
      "attributes": {
        "created_at": "2020-05-21T17:38:00.000000+00:00",
        "updated_at": "2020-05-21T17:38:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "type": "bundles",
        "name": "iPad Pro Bundle",
        "slug": "ipad-pro-bundle",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {
        "bundle_items": {
          "data": [
            {
              "type": "bundle_items",
              "id": "df0b9888-284d-4211-8aa3-7c4bd3922ad5"
            },
            {
              "type": "bundle_items",
              "id": "f6e42e06-fab0-4f46-8f8e-ea8a9422304b"
            },
            {
              "type": "bundle_items",
              "id": "ae082f3d-ff30-456b-8adb-5b4919c8417a"
            },
            {
              "type": "bundle_items",
              "id": "0a030633-4d84-4191-8e44-c52eb68d811a"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "df0b9888-284d-4211-8aa3-7c4bd3922ad5",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2020-05-21T17:38:00.000000+00:00",
          "updated_at": "2020-05-21T17:38:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 10.0,
          "position": 1,
          "bundle_id": "2f4b77bd-2e6d-4454-8933-babc61ed151f",
          "product_group_id": "1a247a34-c748-422e-8f6e-1a6d3992c656",
          "product_id": "ca3c0fbf-03ac-4a05-8a65-d5bab132b59d"
        },
        "relationships": {}
      },
      {
        "id": "f6e42e06-fab0-4f46-8f8e-ea8a9422304b",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2020-05-21T17:38:00.000000+00:00",
          "updated_at": "2020-05-21T17:38:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 15.0,
          "position": 2,
          "bundle_id": "2f4b77bd-2e6d-4454-8933-babc61ed151f",
          "product_group_id": "bf793cc3-ff25-497e-8a92-6cf9a8d99fa0",
          "product_id": "07b0cf35-6809-4bec-8350-2dbe5a39a565"
        },
        "relationships": {}
      },
      {
        "id": "ae082f3d-ff30-456b-8adb-5b4919c8417a",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2020-05-21T17:38:00.000000+00:00",
          "updated_at": "2020-05-21T17:38:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 10.0,
          "position": 3,
          "bundle_id": "2f4b77bd-2e6d-4454-8933-babc61ed151f",
          "product_group_id": "1a247a34-c748-422e-8f6e-1a6d3992c656",
          "product_id": "ca3c0fbf-03ac-4a05-8a65-d5bab132b59d"
        },
        "relationships": {}
      },
      {
        "id": "0a030633-4d84-4191-8e44-c52eb68d811a",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2020-05-21T17:38:00.000000+00:00",
          "updated_at": "2020-05-21T17:38:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 15.0,
          "position": 4,
          "bundle_id": "2f4b77bd-2e6d-4454-8933-babc61ed151f",
          "product_group_id": "bf793cc3-ff25-497e-8a92-6cf9a8d99fa0",
          "product_id": "07b0cf35-6809-4bec-8350-2dbe5a39a565"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/bundles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundles]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,bundle_items,tax_category`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][bundle_items_attributes][]` | **array** <br>Writing to this attribute allows to create or update bundle items at the same time as the bundle itself. 
`data[attributes][discountable]` | **boolean** <br>Whether discounts should be applied to items in this bundle. 
`data[attributes][excerpt]` | **string** <br>Excerpt used in the online store. 
`data[attributes][extra_information]` | **string** <br>Extra information about the bundle, shown on orders and documents. 
`data[attributes][name]` | **string** <br>Name of the bundle. 
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo, use this field to store a main photo. 
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web. 
`data[attributes][seo_description]` | **string** <br>SEO meta description tag. 
`data[attributes][seo_title]` | **string** <br>SEO title tag. 
`data[attributes][show_in_store]` | **boolean** <br>Whether to show this item in the online store. 
`data[attributes][slug]` | **string** <br>Slug of the bundle. 
`data[attributes][sorting_weight]` | **integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists. 
`data[attributes][tag_list][]` | **array** <br>List of tags. 
`data[attributes][tax_category_id]` | **uuid** <br>Tax category for tax calculations. When present, this tax category overrides the tax category of the individual products. 
`data[attributes][taxable]` | **boolean** <br>Whether this bundle is taxable. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>bundle_items</code>
    <ul>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
      <li>
          <code>product_group</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
  <li><code>photo</code></li>
  <li><code>tax_category</code></li>
</ul>


## Update a bundle


> How to update a bundle with bundle items:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/bundles/ed81707b-f578-4a6e-82e8-062f3b5ae2d9'
       --header 'content-type: application/json'
       --data '{
         "include": "bundle_items",
         "data": {
           "id": "ed81707b-f578-4a6e-82e8-062f3b5ae2d9",
           "type": "bundles",
           "attributes": {
             "name": "iPad Pro Bundle",
             "bundle_items_attributes": [
               {
                 "id": "3357b030-9385-4491-843f-9bd93e88723a",
                 "_destroy": true
               },
               {
                 "quantity": 2,
                 "discount_percentage": 15,
                 "product_group_id": "a9609021-9ac0-45e8-8bfa-03c58a577154",
                 "product_id": "abff6839-af87-4377-857e-2b217552945d"
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ed81707b-f578-4a6e-82e8-062f3b5ae2d9",
      "type": "bundles",
      "attributes": {
        "created_at": "2023-01-20T01:56:00.000000+00:00",
        "updated_at": "2023-01-20T01:56:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "type": "bundles",
        "name": "iPad Pro Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {
        "bundle_items": {
          "data": [
            {
              "type": "bundle_items",
              "id": "ddfe9f02-abf5-48bd-8fba-334decb8c339"
            },
            {
              "type": "bundle_items",
              "id": "d5abce78-6f6d-46ef-8e46-876a07eb7133"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "ddfe9f02-abf5-48bd-8fba-334decb8c339",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2023-01-20T01:56:00.000000+00:00",
          "updated_at": "2023-01-20T01:56:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 15.0,
          "position": 2,
          "bundle_id": "ed81707b-f578-4a6e-82e8-062f3b5ae2d9",
          "product_group_id": "a9609021-9ac0-45e8-8bfa-03c58a577154",
          "product_id": "abff6839-af87-4377-857e-2b217552945d"
        },
        "relationships": {}
      },
      {
        "id": "d5abce78-6f6d-46ef-8e46-876a07eb7133",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2023-01-20T01:56:00.000000+00:00",
          "updated_at": "2023-01-20T01:56:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 15.0,
          "position": 3,
          "bundle_id": "ed81707b-f578-4a6e-82e8-062f3b5ae2d9",
          "product_group_id": "a9609021-9ac0-45e8-8bfa-03c58a577154",
          "product_id": "abff6839-af87-4377-857e-2b217552945d"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundles]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,bundle_items,tax_category`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][bundle_items_attributes][]` | **array** <br>Writing to this attribute allows to create or update bundle items at the same time as the bundle itself. 
`data[attributes][discountable]` | **boolean** <br>Whether discounts should be applied to items in this bundle. 
`data[attributes][excerpt]` | **string** <br>Excerpt used in the online store. 
`data[attributes][extra_information]` | **string** <br>Extra information about the bundle, shown on orders and documents. 
`data[attributes][name]` | **string** <br>Name of the bundle. 
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo, use this field to store a main photo. 
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web. 
`data[attributes][seo_description]` | **string** <br>SEO meta description tag. 
`data[attributes][seo_title]` | **string** <br>SEO title tag. 
`data[attributes][show_in_store]` | **boolean** <br>Whether to show this item in the online store. 
`data[attributes][slug]` | **string** <br>Slug of the bundle. 
`data[attributes][sorting_weight]` | **integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists. 
`data[attributes][tag_list][]` | **array** <br>List of tags. 
`data[attributes][tax_category_id]` | **uuid** <br>Tax category for tax calculations. When present, this tax category overrides the tax category of the individual products. 
`data[attributes][taxable]` | **boolean** <br>Whether this bundle is taxable. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>bundle_items</code>
    <ul>
      <li>
          <code>product</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
      <li>
          <code>product_group</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
  <li><code>photo</code></li>
  <li><code>tax_category</code></li>
</ul>


## Archive a bundle


> How to delete a bundle:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/bundles/ec090d58-5e64-4db7-89ae-80f6bcdd3d22'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ec090d58-5e64-4db7-89ae-80f6bcdd3d22",
      "type": "bundles",
      "attributes": {
        "created_at": "2023-08-27T09:39:03.000000+00:00",
        "updated_at": "2023-08-27T09:39:03.000000+00:00",
        "archived": true,
        "archived_at": "2023-08-27T09:39:03.000000+00:00",
        "type": "bundles",
        "name": "iPad Bundle",
        "slug": "ec090d58-5e64-4db7-89ae-80f6bcdd3d22",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundles]=created_at,updated_at,archived`


### Includes

This request does not accept any includes