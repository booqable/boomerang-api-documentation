# Clusters

A cluster is a group of locations that share their inventory (and availability). Stock can move between locations within the same cluster, meaning they can be picked up at one location and returned to another.

## Endpoints
`GET /api/boomerang/clusters`

`GET /api/boomerang/clusters/{id}`

`POST /api/boomerang/clusters`

`PUT /api/boomerang/clusters/{id}`

`DELETE /api/boomerang/clusters/{id}`

## Fields
Every cluster has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the cluster
`location_ids` | **Array** <br>The locations that belong to this cluster


## Relationships
Clusters have the following relationships:

Name | Description
-- | --
`locations` | **Locations** `readonly`<br>Associated Locations


## Listing clusters



> How to fetch clusters:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a1ece2e3-26cd-4d9b-b431-9a1c00a9bd5c",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-11-25T09:32:20.072834+00:00",
        "updated_at": "2024-11-25T09:32:20.072834+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=created_at,updated_at,name`
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
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`locations`






## Fetching a cluster



> How to fetch a single cluster:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters/2977796f-d8a8-4654-8f13-e31a7306d2d7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2977796f-d8a8-4654-8f13-e31a7306d2d7",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-11-25T09:32:18.112592+00:00",
      "updated_at": "2024-11-25T09:32:18.112592+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`locations`






## Creating a cluster



> How to create a cluster:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/clusters' \
    --header 'content-type: application/json' \
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
    "id": "7a1a7732-2c76-4023-a66d-8e3b0919bc03",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-11-25T09:32:17.476133+00:00",
      "updated_at": "2024-11-25T09:32:17.476133+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the cluster
`data[attributes][location_ids][]` | **Array** <br>The locations that belong to this cluster


### Includes

This request accepts the following includes:

`locations`






## Updating a cluster



> How to update a cluster:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/clusters/993a9ceb-3405-48a7-98d1-bdd2e3d4fe8d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "993a9ceb-3405-48a7-98d1-bdd2e3d4fe8d",
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
    "id": "993a9ceb-3405-48a7-98d1-bdd2e3d4fe8d",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-11-25T09:32:16.520122+00:00",
      "updated_at": "2024-11-25T09:32:16.556517+00:00",
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
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the cluster
`data[attributes][location_ids][]` | **Array** <br>The locations that belong to this cluster


### Includes

This request accepts the following includes:

`locations`






## Deleting a cluster

To delete a cluster make sure no active locations are associated with it anymore.


> How to delete a cluster:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/4ecf0353-c580-4bc9-9fb3-18763504f005' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4ecf0353-c580-4bc9-9fb3-18763504f005",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-11-25T09:32:18.704343+00:00",
      "updated_at": "2024-11-25T09:32:18.704343+00:00",
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
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/555c46f8-3f29-42f3-bcb1-46657fc330e8' \
    --header 'content-type: application/json' \
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
          "75bcb69d-9f2a-4e4f-bde2-45a0c785689c"
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
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`locations`





