# Bundle items

Bundle items define which products (variations) and product groups are included in a [Bundle](#bundles).
When bundles are booked on an order, the quantity and discount percentage defined
in a bundle item will be applied.

There are two types of bundle items:

  - _"fixed"_ or _"specified"_: The `product_id` is set and fixed, and the customer does not get to choose.
  These BundleItems do **not** need to be specified when [booking](#order-fulfillments-actions) a bundle.

  - _"unspecified"_: The `product_id` is `null`, and the customer gets to choose one of the product variations.
  These BundleItems **must** to be specified when [booking](#order-fulfillments-actions) a bundle.

<aside class="notice">
  Availability of the bundles feature depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`bundle` | **[Bundle](#bundles)** `required`<br>The Bundle this BundleItem is part of. 
`product` | **[Product](#products)** `optional`<br>When non-null, then this is the prespecified Product that will be booked. When null, then the user has to choose a product variation from the `product_group`. This relation is required when `product_group` does not have variations.
`product_group` | **[Product group](#product-groups)** `required`<br>When the `product` relation is non-null, then this is the ProductGroup that the Product belongs to. When the `product` relation is null, then this is the ProductGroup that the user has to choose a product variation from.


Check matching attributes under [Fields](#bundle-items-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether the bundle item is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the bundle item was archived. 
`bundle_id` | **uuid** `readonly-after-create`<br>The Bundle this BundleItem is part of. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`discount_percentage` | **float** <br>The discount percentage for this product when rented out as part of a bundle. 
`id` | **uuid** `readonly`<br>Primary key.
`position` | **integer** <br>Position of this bundle item within the bundle. I.e sorting relative to other bundle items. 
`product_group_id` | **uuid** `readonly-after-create`<br>When the `product` relation is non-null, then this is the ProductGroup that the Product belongs to. When the `product` relation is null, then this is the ProductGroup that the user has to choose a product variation from.
`product_id` | **uuid** `nullable`<br>When non-null, then this is the prespecified Product that will be booked. When null, then the user has to choose a product variation from the `product_group`. This relation is required when `product_group` does not have variations.
`quantity` | **integer** <br>The quantity of the product included in the bundle. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List bundle items


> How to fetch a list of bundle items:

```shell
  curl --get 'https://example.booqable.com/api/4/bundle_items'
       --header 'content-type: application/json'
       --data-urlencode 'filter[bundle_id]=b484afb9-abf3-4598-8fce-44d5d5c62784'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "3e60cc8c-7215-4b14-8a74-8fe96f550d33",
        "type": "bundle_items",
        "attributes": {
          "created_at": "2019-11-14T16:12:00.000000+00:00",
          "updated_at": "2019-11-14T16:12:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "quantity": 2,
          "discount_percentage": 15.0,
          "position": 1,
          "bundle_id": "b484afb9-abf3-4598-8fce-44d5d5c62784",
          "product_group_id": "935f7965-5c06-44eb-8472-f9aa3f1e036e",
          "product_id": "567ad7e5-6130-401e-84a8-d966a6ae6717"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/bundle_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_items]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=bundle,product,product_group`
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
`bundle_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`position` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_group_id` | **uuid** <br>`eq`, `not_eq`
`product_id` | **uuid** <br>`eq`, `not_eq`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>bundle</code></li>
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


## Fetch a bundle item


> How to fetch a bundle item:

```shell
  curl --get 'https://example.booqable.com/api/4/bundle_items/613a8167-828e-4728-8f62-810a41cd2ba5'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "613a8167-828e-4728-8f62-810a41cd2ba5",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2015-08-13T03:51:01.000000+00:00",
        "updated_at": "2015-08-13T03:51:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "2201586a-dcc4-4803-8d2c-2e6d02541f2b",
        "product_group_id": "08475ef9-150e-4113-8035-9a10812b06e9",
        "product_id": "56cf4f31-b9ac-4968-8899-b81f09e246a6"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_items]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=bundle,product,product_group`


### Includes

This request accepts the following includes:

<ul>
  <li><code>bundle</code></li>
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


## Create a bundle item


> How to create a bundle item:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bundle_items'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "bundle_items",
           "attributes": {
             "bundle_id": "aadf38b5-6d5e-4c54-8d7b-7cce2b00801a",
             "product_group_id": "9bc50456-e92e-4162-8610-8f8ca7323b5b",
             "product_id": "6fb4ee32-8b29-439a-856d-9847696afb13",
             "quantity": 2,
             "discount_percentage": 15
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "3b9d771b-6d67-42d8-83b3-289dedbb7a1e",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2018-09-16T12:53:01.000000+00:00",
        "updated_at": "2018-09-16T12:53:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "aadf38b5-6d5e-4c54-8d7b-7cce2b00801a",
        "product_group_id": "9bc50456-e92e-4162-8610-8f8ca7323b5b",
        "product_id": "6fb4ee32-8b29-439a-856d-9847696afb13"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/bundle_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_items]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=bundle,product,product_group`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][bundle_id]` | **uuid** <br>The Bundle this BundleItem is part of. 
`data[attributes][discount_percentage]` | **float** <br>The discount percentage for this product when rented out as part of a bundle. 
`data[attributes][position]` | **integer** <br>Position of this bundle item within the bundle. I.e sorting relative to other bundle items. 
`data[attributes][product_group_id]` | **uuid** <br>When the `product` relation is non-null, then this is the ProductGroup that the Product belongs to. When the `product` relation is null, then this is the ProductGroup that the user has to choose a product variation from.
`data[attributes][product_id]` | **uuid** <br>When non-null, then this is the prespecified Product that will be booked. When null, then the user has to choose a product variation from the `product_group`. This relation is required when `product_group` does not have variations.
`data[attributes][quantity]` | **integer** <br>The quantity of the product included in the bundle. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>bundle</code></li>
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


## Update a bundle item


> How to update a bundle item:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/bundle_items/b19d7917-4360-464c-8add-3d8003786467'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "b19d7917-4360-464c-8add-3d8003786467",
           "type": "bundle_items",
           "attributes": {
             "quantity": 3,
             "discount_percentage": 20
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b19d7917-4360-464c-8add-3d8003786467",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2015-01-21T01:26:00.000000+00:00",
        "updated_at": "2015-01-21T01:26:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 3,
        "discount_percentage": 20.0,
        "position": 1,
        "bundle_id": "f53691b2-481e-4f06-8b42-70a8260e0bea",
        "product_group_id": "997ec012-e358-4a2c-8bb9-97674479ed4f",
        "product_id": "73f4eef3-b748-4cd0-8f75-0e013f461872"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_items]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=bundle,product,product_group`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][bundle_id]` | **uuid** <br>The Bundle this BundleItem is part of. 
`data[attributes][discount_percentage]` | **float** <br>The discount percentage for this product when rented out as part of a bundle. 
`data[attributes][position]` | **integer** <br>Position of this bundle item within the bundle. I.e sorting relative to other bundle items. 
`data[attributes][product_group_id]` | **uuid** <br>When the `product` relation is non-null, then this is the ProductGroup that the Product belongs to. When the `product` relation is null, then this is the ProductGroup that the user has to choose a product variation from.
`data[attributes][product_id]` | **uuid** <br>When non-null, then this is the prespecified Product that will be booked. When null, then the user has to choose a product variation from the `product_group`. This relation is required when `product_group` does not have variations.
`data[attributes][quantity]` | **integer** <br>The quantity of the product included in the bundle. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>bundle</code></li>
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


## Delete a bundle item


> How to delete a bundle item:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/bundle_items/791f0c17-84d2-4362-8ad5-b097d71cf9e6'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "791f0c17-84d2-4362-8ad5-b097d71cf9e6",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-05-16T17:50:00.000000+00:00",
        "updated_at": "2021-05-16T17:50:00.000000+00:00",
        "archived": true,
        "archived_at": "2021-05-16T17:50:00.000000+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "04391a33-673f-4548-89e1-44e58bdfb28a",
        "product_group_id": "bb5d0ce6-7858-4bcf-8875-352bd5587852",
        "product_id": "98855843-4132-4178-8120-0393eaf5604f"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_items]=created_at,updated_at,archived`


### Includes

This request does not accept any includes