# Recommendations

Recommendations define which products are suggested alongside a given product group on the web shop.
They are used to drive cross-sell behavior: when a customer views a product, the recommended
products are shown as suggestions to add to their order.

Each recommendation links a source [ProductGroup](#product-groups) to a target
[ProductGroup](#product-groups). The source is the product being viewed; the target is the
product being suggested.

Recommendations are ordered by `position`, which is managed through the back office.
A target product group can only appear once per source (uniqueness is enforced), and a product
group cannot recommend itself.

Recommendations can be created and deleted via the API. Updating a recommendation is not
supported — to change a suggestion, delete and recreate it.

## Relationships
Name | Description
-- | --
`source_product_group` | **[Product group](#product-groups)** `required`<br>The [ProductGroup](#product-groups) that is being viewed. Recommendations are fetched by filtering on this product group: `GET /api/4/recommendations?filter[source_product_group_id]=id`.<br>Writable only on creation. Cannot be changed after the recommendation is created. 
`target_product_group` | **[Product group](#product-groups)** `required`<br>The [ProductGroup](#product-groups) that is being recommended. This is the product that will appear as a suggestion when the source product group is viewed.<br>To find every product group that recommends a given product, filter by this relation: `GET /api/4/recommendations?filter[target_product_group_id]=id`.<br>Writable only on creation. Cannot be changed after the recommendation is created. Each target product group can only appear once per source — duplicate combinations are rejected. 


Check matching attributes under [Fields](#recommendations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`position` | **integer** `readonly`<br>The display order of this recommendation relative to other recommendations for the same source product group. Lower values appear first. Read-only via the API — managed through the back office only. 
`source_product_group_id` | **uuid** `readonly-after-create`<br>The [ProductGroup](#product-groups) that is being viewed. Recommendations are fetched by filtering on this product group: `GET /api/4/recommendations?filter[source_product_group_id]=id`.<br>Writable only on creation. Cannot be changed after the recommendation is created. 
`target_product_group_id` | **uuid** `readonly-after-create`<br>The [ProductGroup](#product-groups) that is being recommended. This is the product that will appear as a suggestion when the source product group is viewed.<br>To find every product group that recommends a given product, filter by this relation: `GET /api/4/recommendations?filter[target_product_group_id]=id`.<br>Writable only on creation. Cannot be changed after the recommendation is created. Each target product group can only appear once per source — duplicate combinations are rejected. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List recommendations


> List recommendations for a product group:

```shell
  curl --get 'https://example.booqable.com/api/4/recommendations'
       --header 'content-type: application/json'
       --data-urlencode 'filter[source_product_group_id]=90dc35c9-35c7-4dd9-8608-6e0b8413a4d8'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "fbda3eb5-14ad-422a-8363-ce4cd6fd3e7a",
        "type": "recommendations",
        "attributes": {
          "created_at": "2024-08-04T13:36:02.000000+00:00",
          "updated_at": "2024-08-04T13:36:02.000000+00:00",
          "position": 1,
          "source_product_group_id": "90dc35c9-35c7-4dd9-8608-6e0b8413a4d8",
          "target_product_group_id": "088a4c42-2ba9-41ed-8702-0369782c0ea8"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

> List product groups recommending a given target:

```shell
  curl --get 'https://example.booqable.com/api/4/recommendations'
       --header 'content-type: application/json'
       --data-urlencode 'filter[target_product_group_id]=62c3ac7c-6719-4aac-8b5f-5d699652cb78'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "a53bd287-0f47-4645-8a9c-7706c3e91c11",
        "type": "recommendations",
        "attributes": {
          "created_at": "2020-06-07T09:36:05.000000+00:00",
          "updated_at": "2020-06-07T09:36:05.000000+00:00",
          "position": 1,
          "source_product_group_id": "68a3023d-b907-4ad6-8e91-5fab5a36f130",
          "target_product_group_id": "62c3ac7c-6719-4aac-8b5f-5d699652cb78"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/recommendations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[recommendations]=created_at,updated_at,position`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=source_product_group,target_product_group`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`source_product_group_id` | **uuid** <br>`eq`, `not_eq`
`target_product_group_id` | **uuid** <br>`eq`, `not_eq`
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
    <code>source_product_group</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
  <li>
    <code>target_product_group</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
</ul>


## Create a recommendation


> Create a recommendation:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/recommendations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "recommendations",
           "attributes": {
             "source_product_group_id": "342a1eca-eb47-438f-8cc6-185b0575683c",
             "target_product_group_id": "b9941e5a-0ea1-4ac1-8d4b-5fe77f159baa"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "fb38ae63-e683-45ae-8e7d-cf0240f343f0",
      "type": "recommendations",
      "attributes": {
        "created_at": "2026-06-25T23:10:01.000000+00:00",
        "updated_at": "2026-06-25T23:10:01.000000+00:00",
        "position": 1,
        "source_product_group_id": "342a1eca-eb47-438f-8cc6-185b0575683c",
        "target_product_group_id": "b9941e5a-0ea1-4ac1-8d4b-5fe77f159baa"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/recommendations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[recommendations]=created_at,updated_at,position`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=target_product_group`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][source_product_group_id]` | **uuid** <br>The [ProductGroup](#product-groups) that is being viewed. Recommendations are fetched by filtering on this product group: `GET /api/4/recommendations?filter[source_product_group_id]=id`.<br>Writable only on creation. Cannot be changed after the recommendation is created. 
`data[attributes][target_product_group_id]` | **uuid** <br>The [ProductGroup](#product-groups) that is being recommended. This is the product that will appear as a suggestion when the source product group is viewed.<br>To find every product group that recommends a given product, filter by this relation: `GET /api/4/recommendations?filter[target_product_group_id]=id`.<br>Writable only on creation. Cannot be changed after the recommendation is created. Each target product group can only appear once per source — duplicate combinations are rejected. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>target_product_group</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
</ul>


## Delete a recommendation


> Delete a recommendation:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/recommendations/6ab22c5b-ae38-4464-8199-b70232391a70'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "6ab22c5b-ae38-4464-8199-b70232391a70",
      "type": "recommendations",
      "attributes": {
        "created_at": "2022-06-14T13:50:00.000000+00:00",
        "updated_at": "2022-06-14T13:50:00.000000+00:00",
        "position": 2,
        "source_product_group_id": "d200635f-4483-4df8-82d4-d6e39ba66c25",
        "target_product_group_id": "541f366b-0938-46fe-8ec7-4d18d9837c2a"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/recommendations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[recommendations]=created_at,updated_at,position`


### Includes

This request does not accept any includes