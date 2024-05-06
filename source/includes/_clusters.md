# Clusters

A cluster is a group of locations that share their inventory (and availability). Stock can move between locations within the same cluster, meaning they can be picked up at one location and returned to another.

## Endpoints
`DELETE /api/boomerang/clusters/{id}`

`GET /api/boomerang/clusters/{id}`

`GET /api/boomerang/clusters`

`PUT /api/boomerang/clusters/{id}`

`POST /api/boomerang/clusters`

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


## Deleting a cluster

To delete a cluster make sure no active locations are associated with it anymore.


> A failure due to a cluster still being associated with locations:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/4974c97f-a3df-40e6-a0d4-81f6ea120256' \
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
          "253994cd-8988-43ef-b5b0-9774f2eb3363"
        ]
      }
    }
  ]
}
```


> How to delete a cluster:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/b8a77a8c-5279-4e4b-ada8-774581ff3f08' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b8a77a8c-5279-4e4b-ada8-774581ff3f08",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-05-06T09:22:45+00:00",
      "updated_at": "2024-05-06T09:22:45+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=b8a77a8c-5279-4e4b-ada8-774581ff3f08"
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






## Fetching a cluster



> How to fetch a single cluster:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters/6d3976dd-de86-422c-8d76-9e526e85245b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6d3976dd-de86-422c-8d76-9e526e85245b",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-05-06T09:22:45+00:00",
      "updated_at": "2024-05-06T09:22:45+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=6d3976dd-de86-422c-8d76-9e526e85245b"
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
      "id": "f042af34-b121-4bad-8b31-41ebf4272612",
      "type": "clusters",
      "attributes": {
        "created_at": "2024-05-06T09:22:46+00:00",
        "updated_at": "2024-05-06T09:22:46+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {
        "locations": {
          "links": {
            "related": "api/boomerang/locations?filter[cluster_id]=f042af34-b121-4bad-8b31-41ebf4272612"
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






## Updating a cluster



> How to update a cluster:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/clusters/f9b984ce-dfe3-4f75-b6b6-b7603b5297b2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f9b984ce-dfe3-4f75-b6b6-b7603b5297b2",
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
    "id": "f9b984ce-dfe3-4f75-b6b6-b7603b5297b2",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-05-06T09:22:46+00:00",
      "updated_at": "2024-05-06T09:22:46+00:00",
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
    "id": "405b01dd-74fb-463f-9ecd-30a613d084cf",
    "type": "clusters",
    "attributes": {
      "created_at": "2024-05-06T09:22:47+00:00",
      "updated_at": "2024-05-06T09:22:47+00:00",
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





