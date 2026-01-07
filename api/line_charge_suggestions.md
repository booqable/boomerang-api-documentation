# Line charge suggestions

Line charge suggestions are potential charge lengths for a Line.

For simple products, the suggested charge lengths and prices are based on the
configured `price_type` and `price_period` of the ProductGroup.

For products using price structures (tiered pricing), the charge lengths
and prices are basically the same as the configured PriceTiles.

For Bundles, pricing depends on the chosen Product variations.
Therefore this API requires a `line_id`, so that the returned price
can be calculated based on the chosen Product variations.

## Relationships
Name | Description
-- | --
`line` | **[Line](#lines)** `required`<br>The Line that this suggestion is for. 


Check matching attributes under [Fields](#line-charge-suggestions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`charge_label` | **string** `readonly`<br>The label corresponding to the `charge_length`. If the Item has tiered pricing, this is the label of a configured PriceTile. 
`charge_length` | **integer** `readonly`<br>The suggested charge length in seconds. 
`created_at` | **datetime** `readonly`<br>The date and time when this suggestion was calculated. 
`id` | **uuid** `readonly`<br>Primary key.
`line_id` | **uuid** <br>The Line that this suggestion is for. 
`price_each_in_cents` | **integer** `readonly`<br>The price that would be charged if the suggested charge length is used. 


## List suggestions


> How to fetch a list of charge suggestions for a line:

```shell
  curl --get 'https://example.booqable.com/api/4/line_charge_suggestions'
       --header 'content-type: application/json'
       --data-urlencode 'filter[line_id]=2ecfa77f-fcf3-4edb-8617-a39730f6055e'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "6d73c915-59f9-44e5-83d6-77e5946e26fe",
        "type": "line_charge_suggestions",
        "attributes": {
          "created_at": "2018-04-25T04:08:00.000000+00:00",
          "charge_length": 86400,
          "charge_label": "very short",
          "price_each_in_cents": 100,
          "line_id": "2ecfa77f-fcf3-4edb-8617-a39730f6055e"
        },
        "relationships": {}
      },
      {
        "id": "f6e84b69-8152-486c-8a10-b45e9e90a5fd",
        "type": "line_charge_suggestions",
        "attributes": {
          "created_at": "2018-04-25T04:08:00.000000+00:00",
          "charge_length": 172800,
          "charge_label": "short",
          "price_each_in_cents": 200,
          "line_id": "2ecfa77f-fcf3-4edb-8617-a39730f6055e"
        },
        "relationships": {}
      },
      {
        "id": "8bf65eb0-f809-4b4d-87a0-769800945375",
        "type": "line_charge_suggestions",
        "attributes": {
          "created_at": "2018-04-25T04:08:00.000000+00:00",
          "charge_length": 259200,
          "charge_label": "longer",
          "price_each_in_cents": 250,
          "line_id": "2ecfa77f-fcf3-4edb-8617-a39730f6055e"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/line_charge_suggestions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[line_charge_suggestions]=created_at,charge_length,charge_label`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=line`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`charge_label` | **string** <br>`eq`
`charge_length` | **integer** <br>`eq`
`created_at` | **datetime** <br>`eq`
`line_id` | **uuid** `required`<br>`eq`
`price_each_in_cents` | **integer** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>line</code></li>
</ul>

