# Clusters

A cluster is a group of locations that share their inventory (and availability). Stock can move between locations within the same cluster, meaning they can be picked up at one location and returned to another.

## Endpoints
`GET /api/boomerang/clusters/{id}`

`DELETE /api/boomerang/clusters/{id}`

`POST /api/boomerang/clusters`

`PUT /api/boomerang/clusters/{id}`

`GET /api/boomerang/clusters`

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


## Fetching a cluster



> How to fetch a single cluster:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters/e69559d9-9006-4122-8675-ab49c7b44db6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e69559d9-9006-4122-8675-ab49c7b44db6",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-06-03T09:30:08.821574+00:00",
      "updated_at": "2024-06-03T09:30:08.821574+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=e69559d9-9006-4122-8675-ab49c7b44db6"
        }
      }
    }
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






## Deleting a cluster

To delete a cluster make sure no active locations are associated with it anymore.


> A failure due to a cluster still being associated with locations:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/64f4d7d4-4702-4e37-bf1f-511eeb9a8927' \
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
          "67f8adbe-1609-4517-a267-4898fecd9253"
        ]
      }
    }
  ]
}
```


> How to delete a cluster:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/ed55d4bc-7fad-4d41-894a-379367d9798f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ed55d4bc-7fad-4d41-894a-379367d9798f",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-06-03T09:30:10.498747+00:00",
      "updated_at": "2024-06-03T09:30:10.498747+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=ed55d4bc-7fad-4d41-894a-379367d9798f"
        }
      }
    }
  },
  "meta": {}
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
    "id": "590adba2-60c5-4aa6-8997-af25c14ac4b3",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-06-03T09:30:11.481406+00:00",
      "updated_at": "2024-06-03T09:30:11.481406+00:00",
      "name": "Amsterdam",
      "location_ids": []
    },
    "relationships": {
      "locations": {
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
    --url 'https://example.booqable.com/api/boomerang/clusters/ba5fc634-793a-4f96-bccf-83dd0716c925' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ba5fc634-793a-4f96-bccf-83dd0716c925",
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
    "id": "ba5fc634-793a-4f96-bccf-83dd0716c925",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-06-03T09:30:12.285999+00:00",
      "updated_at": "2024-06-03T09:30:12.340313+00:00",
      "name": "Rotterdam",
      "location_ids": []
    },
    "relationships": {
      "locations": {
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
      "id": "fa3ff6cb-9f7b-4362-b2b8-cc7bf452bc48",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-06-03T09:30:13.361987+00:00",
        "updated_at": "2024-06-03T09:30:13.361987+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {
        "locations": {
          "links": {
            "related": "api/boomerang/locations?filter[cluster_id]=fa3ff6cb-9f7b-4362-b2b8-cc7bf452bc48"
          }
        }
      }
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





