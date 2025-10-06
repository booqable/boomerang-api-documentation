# Collections

Collections are used to create a hierarchy of products.

To change the ordering of items within a collection, use [Sortings](#sortings).

## Relationships
Name | Description
-- | --
`collection_items` | **[Collection items](#collection-items)** `hasmany`<br>All items that make up this collection. Each collection item adds either a [ProductGroup](#product-groups) or a [Bundle](#bundles) to this collection. 


Check matching attributes under [Fields](#collections-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`all_children` | **array** `readonly` `extra`<br>All child collections. 
`all_parents` | **array** `readonly` `extra`<br>All parent collections. 
`collection_type` | **enum** `readonly-after-create`<br>Dynamic collections are automatically updated. Static collections are defined by the user.<br> One of: `static`, `dynamic`.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`depth` | **integer** `readonly`<br>How deep this collection sits in the hierarchy. Depth 1 represents top-level collections, depth 2 represents children, and depth 3 represents grandchildren. Nesting is limited to 3 levels. 
`description` | **string** <br>A description of this collection. 
`external_image_url` | **string** `writeonly`<br>URL to an image on the web, use this field to add a photo. 
`hierarchical_name` | **array[string]** `readonly` `extra`<br>Names of all parents, with the name of this collection as last. 
`id` | **uuid** `readonly`<br>Primary key.
`image_base64` | **string** `writeonly`<br>Base64 encoded photo, use this field to add a photo. 
`image_large_url` | **string** `readonly`<br>URL of the large image for this collection. 
`image_url` | **string** `readonly`<br>URL of the image for this collection. 
`item_count` | **integer** <br>Number of collection items in this collection that are visible in the store. Only includes items where `show_in_store` is `true`. Includes collection items in this collection, but not in nested collections.<br>This count is automatically recalculated when items are added, removed, or when their `show_in_store` status changes. 
`name` | **string** <br>Name of this collection. 
`parent_id` | **uuid** <br>The ID of the parent collection. 
`position` | **integer** `readonly`<br>Relative position of this collection among its siblings within the same parent collection. 
`remote_image_url` | **string** `writeonly`<br>URL to an image on the web, use this field to add a photo. 
`remove_image` | **boolean** `writeonly`<br>Remove the current image. 
`seo_description` | **string** <br>SEO description. 
`seo_title` | **string** <br>SEO title. 
`show_in_store` | **boolean** <br>Whether to show this collection in the online store. 
`slug` | **string** <br>Slug used in online store URLs. 
`system` | **boolean** <br>When `true`, this collection is generated and maintained automatically by Booqable. System collections cannot be updated or deleted. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List collections


> How to fetch collections:

```shell
  curl --get 'https://example.booqable.com/api/4/collections'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "e8b928ec-172a-4655-80f9-eea1a1be9c89",
        "type": "collections",
        "attributes": {
          "created_at": "2015-11-17T02:13:02.000000+00:00",
          "updated_at": "2015-11-17T02:13:02.000000+00:00",
          "name": "All Seasons",
          "slug": "all-seasons",
          "description": null,
          "seo_title": null,
          "seo_description": null,
          "collection_type": "manual",
          "system": false,
          "item_count": 0,
          "show_in_store": true,
          "parent_id": null,
          "depth": 1,
          "position": null,
          "image_url": null,
          "image_large_url": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/collections`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collections]=all_parents,all_children,hierarchical_name`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collections]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`collection_type` | **enum** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`depth` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`hierarchical_q` | **string** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`parent_id` | **uuid** <br>`eq`, `not_eq`
`position` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **boolean** <br>`eq`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`system` | **boolean** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a collection


> How to fetch a single collection:

```shell
  curl --get 'https://example.booqable.com/api/4/collections/e747596e-eb84-4e15-8b4e-9b160d64633c'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "e747596e-eb84-4e15-8b4e-9b160d64633c",
      "type": "collections",
      "attributes": {
        "created_at": "2021-12-02T10:21:01.000000+00:00",
        "updated_at": "2021-12-02T10:21:01.000000+00:00",
        "name": "All Seasons",
        "slug": "all-seasons",
        "description": null,
        "seo_title": null,
        "seo_description": null,
        "collection_type": "manual",
        "system": false,
        "item_count": 0,
        "show_in_store": true,
        "parent_id": null,
        "depth": 1,
        "position": null,
        "image_url": null,
        "image_large_url": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/collections/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collections]=all_parents,all_children,hierarchical_name`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collections]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=collection_items`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>collection_items</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Create a collection


> How to create a collection:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/collections'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "collections",
           "attributes": {
             "name": "Spring Collection"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "067fbd40-bc13-4aec-8426-a75cc1a273f8",
      "type": "collections",
      "attributes": {
        "created_at": "2019-04-23T15:23:58.000000+00:00",
        "updated_at": "2019-04-23T15:23:58.000000+00:00",
        "name": "Spring Collection",
        "slug": "spring-collection",
        "description": null,
        "seo_title": null,
        "seo_description": null,
        "collection_type": null,
        "system": false,
        "item_count": 0,
        "show_in_store": true,
        "parent_id": null,
        "depth": 1,
        "position": null,
        "image_url": null,
        "image_large_url": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/collections`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collections]=all_parents,all_children,hierarchical_name`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collections]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=collection_items`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][collection_type]` | **enum** <br>Dynamic collections are automatically updated. Static collections are defined by the user.<br> One of: `static`, `dynamic`.
`data[attributes][external_image_url]` | **string** <br>URL to an image on the web, use this field to add a photo. 
`data[attributes][image_base64]` | **string** <br>Base64 encoded photo, use this field to add a photo. 
`data[attributes][item_count]` | **integer** <br>Number of collection items in this collection that are visible in the store. Only includes items where `show_in_store` is `true`. Includes collection items in this collection, but not in nested collections.<br>This count is automatically recalculated when items are added, removed, or when their `show_in_store` status changes. 
`data[attributes][name]` | **string** <br>Name of this collection. 
`data[attributes][parent_id]` | **uuid** <br>The ID of the parent collection. 
`data[attributes][remote_image_url]` | **string** <br>URL to an image on the web, use this field to add a photo. 
`data[attributes][remove_image]` | **boolean** <br>Remove the current image. 
`data[attributes][seo_description]` | **string** <br>SEO description. 
`data[attributes][seo_title]` | **string** <br>SEO title. 
`data[attributes][show_in_store]` | **boolean** <br>Whether to show this collection in the online store. 
`data[attributes][slug]` | **string** <br>Slug used in online store URLs. 
`data[attributes][system]` | **boolean** <br>When `true`, this collection is generated and maintained automatically by Booqable. System collections cannot be updated or deleted. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>collection_items</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Update a collection


> How to update a collection:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/collections/6ee95651-79a3-47df-875d-6bceb66cb4e6'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "6ee95651-79a3-47df-875d-6bceb66cb4e6",
           "type": "collections",
           "attributes": {
             "name": "Fall Collection"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "6ee95651-79a3-47df-875d-6bceb66cb4e6",
      "type": "collections",
      "attributes": {
        "created_at": "2026-04-06T17:47:00.000000+00:00",
        "updated_at": "2026-04-06T17:47:00.000000+00:00",
        "name": "Fall Collection",
        "slug": "all-seasons",
        "description": null,
        "seo_title": null,
        "seo_description": null,
        "collection_type": "manual",
        "system": false,
        "item_count": 0,
        "show_in_store": true,
        "parent_id": null,
        "depth": 1,
        "position": null,
        "image_url": null,
        "image_large_url": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/collections/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collections]=all_parents,all_children,hierarchical_name`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collections]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=collection_items`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][collection_type]` | **enum** <br>Dynamic collections are automatically updated. Static collections are defined by the user.<br> One of: `static`, `dynamic`.
`data[attributes][external_image_url]` | **string** <br>URL to an image on the web, use this field to add a photo. 
`data[attributes][image_base64]` | **string** <br>Base64 encoded photo, use this field to add a photo. 
`data[attributes][item_count]` | **integer** <br>Number of collection items in this collection that are visible in the store. Only includes items where `show_in_store` is `true`. Includes collection items in this collection, but not in nested collections.<br>This count is automatically recalculated when items are added, removed, or when their `show_in_store` status changes. 
`data[attributes][name]` | **string** <br>Name of this collection. 
`data[attributes][parent_id]` | **uuid** <br>The ID of the parent collection. 
`data[attributes][remote_image_url]` | **string** <br>URL to an image on the web, use this field to add a photo. 
`data[attributes][remove_image]` | **boolean** <br>Remove the current image. 
`data[attributes][seo_description]` | **string** <br>SEO description. 
`data[attributes][seo_title]` | **string** <br>SEO title. 
`data[attributes][show_in_store]` | **boolean** <br>Whether to show this collection in the online store. 
`data[attributes][slug]` | **string** <br>Slug used in online store URLs. 
`data[attributes][system]` | **boolean** <br>When `true`, this collection is generated and maintained automatically by Booqable. System collections cannot be updated or deleted. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>collection_items</code>
    <ul>
      <li>
          <code>item</code>
          <ul>
            <li><code>photo</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Delete a collection

To delete a collection make sure there are no nested collections anymore.

> How to delete a collection:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/collections/df45847d-b793-411a-82a7-2344685a75df'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "df45847d-b793-411a-82a7-2344685a75df",
      "type": "collections",
      "attributes": {
        "created_at": "2022-02-26T11:23:14.000000+00:00",
        "updated_at": "2022-02-26T11:23:14.000000+00:00",
        "name": "All Seasons",
        "slug": "all-seasons",
        "description": null,
        "seo_title": null,
        "seo_description": null,
        "collection_type": "manual",
        "system": false,
        "item_count": 0,
        "show_in_store": true,
        "parent_id": null,
        "depth": 1,
        "position": null,
        "image_url": null,
        "image_large_url": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/collections/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collections]=all_parents,all_children,hierarchical_name`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collections]=created_at,updated_at,name`


### Includes

This request does not accept any includes