# Clusters

A cluster is a group of locations that share their inventory (and availability).
Stock can move between locations within the same cluster, meaning they can be
picked up at one location and returned to another.

## Relationships
Name | Description
-- | --
`locations` | **[Locations](#locations)** `hasmany`<br>The locations that make up this cluster.


Check matching attributes under [Fields](#clusters-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`location_ids` | **array** `readonly-after-create`<br>The locations that belong to this cluster.
`name` | **string** <br>Name of the cluster.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing clusters


> How to fetch clusters:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/clusters'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "c85988b4-e5f9-4b7b-8e84-59dc91306d07",
        "type": "clusters",
        "attributes": {
          "created_at": "2017-04-19T16:54:00.000000+00:00",
          "updated_at": "2017-04-19T16:54:00.000000+00:00",
          "name": "Main",
          "location_ids": []
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/clusters`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[clusters]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=locations`
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
`location_id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`locations`






## Fetching a cluster


> How to fetch a single cluster:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/clusters/242d27bb-1ff5-41ca-80d5-dd4a2c675525'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "242d27bb-1ff5-41ca-80d5-dd4a2c675525",
      "type": "clusters",
      "attributes": {
        "created_at": "2014-08-27T15:06:00.000000+00:00",
        "updated_at": "2014-08-27T15:06:00.000000+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/clusters/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[clusters]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=locations`


### Includes

This request accepts the following includes:

`locations`






## Creating a cluster


> How to create a cluster:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/clusters'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "clusters",
           "attributes": {
             "name": "Amsterdam"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "a4eb298e-c8b8-4b40-85cf-ec9dbbf68a92",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-06-20T05:57:00.000000+00:00",
        "updated_at": "2024-06-20T05:57:00.000000+00:00",
        "name": "Amsterdam",
        "location_ids": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/clusters`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[clusters]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=locations`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][location_ids][]` | **array** <br>The locations that belong to this cluster.
`data[attributes][name]` | **string** <br>Name of the cluster.


### Includes

This request accepts the following includes:

`locations`






## Updating a cluster


> How to update a cluster:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/clusters/df280d1c-34d7-4b2d-89d8-289bf254f317'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "df280d1c-34d7-4b2d-89d8-289bf254f317",
           "type": "clusters",
           "attributes": {
             "name": "Rotterdam"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "df280d1c-34d7-4b2d-89d8-289bf254f317",
      "type": "clusters",
      "attributes": {
        "created_at": "2020-06-22T20:42:09.000000+00:00",
        "updated_at": "2020-06-22T20:42:09.000000+00:00",
        "name": "Rotterdam",
        "location_ids": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/clusters/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[clusters]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=locations`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][location_ids][]` | **array** <br>The locations that belong to this cluster.
`data[attributes][name]` | **string** <br>Name of the cluster.


### Includes

This request accepts the following includes:

`locations`






## Deleting a cluster

To delete a cluster make sure no active locations are associated with it anymore.

> How to delete a cluster:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/clusters/79f093e1-f668-4a70-8e91-6f10c351314a'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "79f093e1-f668-4a70-8e91-6f10c351314a",
      "type": "clusters",
      "attributes": {
        "created_at": "2019-06-18T06:27:00.000000+00:00",
        "updated_at": "2019-06-18T06:27:00.000000+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> A failure due to a cluster still being associated with locations:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/clusters/475d542a-ad19-4eea-87be-bdc3a2726baf'
       --header 'content-type: application/json'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "cluster_has_locations",
        "status": "422",
        "title": "Cluster has locations",
        "detail": "This cluster has 1 or more active locations",
        "meta": {
          "location_ids": [
            "cfa08864-2479-40cd-81ac-e6426c3c303a"
          ]
        }
      }
    ]
  }
```

### HTTP Request

`DELETE /api/boomerang/clusters/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[clusters]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=locations`


### Includes

This request accepts the following includes:

`locations`





