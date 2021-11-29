# Price rules

A price rule contains a single pricing adjustment rule and belongs to a price ruleset.

A price rule can have one of these types:

- **range_of_days**: Adjust pricing for certain days of the week, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from_day`,`till_day`,`from_time,`till_time` and `value`.
- **range_of_dates**: Adjust pricing for certain calendar days, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from`,`till` and `value`.
- **pickup_day**: Rule determines if entire day is charged based on pickup day time, `match_strategy` must be `starts_within`, `charge` determines if day is charged when before `time` or not charged if after `time`.
- **return_day**: Rule determines if entire day is charged based on return day time, `match_strategy` must be `stops_within`, `charge` determines if day is charged when before `time` or not charged if after `time`.

and these match strategies:

- **starts_within**: Used with `pickup_day` rules
- **stops_within**: Used with `return_day` rules
- **within**: Rule is applied when the rule period fits within the order period.
- **overlap**: Rule is applied for the part of the rule period that overlaps the order period.
- **span**: Rule is applied when the rule period spans over the order period.

as well as these adjustment strategies:

- **charge**: Applies `charge` attribute to determine rule effect, either charges or doesn't charge. Used by `pickup_day` and `return_day` rules types.
- **percentage**: Applies `value` attribute to determine the percentage change to the pricing over the rule period. Used by `range_of_days`, `range_of_date` rule types.

## Endpoints
`POST /api/boomerang/price_rules`

`PUT /api/boomerang/price_rules/{id}`

`DELETE /api/boomerang/price_rules/{id}`

## Fields
Every price rule has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the rule
`rule_type` | **String**<br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `pickup_day`, `return_day`
`match_strategy` | **String**<br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`adjustment_strategy` | **String**<br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`value` | **Float**<br>Adjustment value in percent
`from` | **Datetime**<br>Defines start of period, used by `range_of_dates` rule type
`till` | **Datetime**<br>Defines end of period, used by `range_of_dates` rule type
`from_day` | **Integer**<br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`till_day` | **Integer**<br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`from_time` | **String**<br>Defines start of period time, `HH:mm` format, used by `range_of_days` rule type
`till_time` | **String**<br>Defines end of period time, `HH:mm` format, used by `range_of_days` rule type
`charge` | **Boolean**<br>Determines effect of rules using charge attribute
`stacked` | **Boolean**<br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`time` | **String**<br>Defines time for adjustment, `HH:mm` format, used by `pickup_day`, `return_day` rule types
`price_ruleset_id` | **Uuid**<br>The associated Price ruleset


## Relationships
Price rules have the following relationships:

Name | Description
- | -
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset


## Creating a price rule



> How to create a price rule:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/price_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "price_rules",
        "attributes": {
          "price_ruleset_id": "581d604d-8fe5-4b89-a068-f2aff55c9956",
          "name": "Off season",
          "rule_type": "range_of_dates",
          "match_strategy": "span",
          "value": 25,
          "from": "2021-10-29T09:04:01.326Z",
          "till": "2021-12-29T09:04:01.326Z"
        }
      },
      "include": "price_rules"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2d132cc8-58a7-4d18-9062-4151a9e0df38",
    "type": "price_rules",
    "attributes": {
      "created_at": "2021-11-29T09:04:01+00:00",
      "updated_at": "2021-11-29T09:04:01+00:00",
      "name": "Off season",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 25.0,
      "from": "2021-10-29T09:04:01+00:00",
      "till": "2021-12-29T09:04:01+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "price_ruleset_id": "581d604d-8fe5-4b89-a068-f2aff55c9956"
    },
    "relationships": {
      "price_ruleset": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/price_rules?data%5Battributes%5D%5Bfrom%5D=2021-10-29T09%3A04%3A01.326Z&data%5Battributes%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_ruleset_id%5D=581d604d-8fe5-4b89-a068-f2aff55c9956&data%5Battributes%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Btill%5D=2021-12-29T09%3A04%3A01.326Z&data%5Battributes%5D%5Bvalue%5D=25&data%5Btype%5D=price_rules&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rules?data%5Battributes%5D%5Bfrom%5D=2021-10-29T09%3A04%3A01.326Z&data%5Battributes%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_ruleset_id%5D=581d604d-8fe5-4b89-a068-f2aff55c9956&data%5Battributes%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Btill%5D=2021-12-29T09%3A04%3A01.326Z&data%5Battributes%5D%5Bvalue%5D=25&data%5Btype%5D=price_rules&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rules?data%5Battributes%5D%5Bfrom%5D=2021-10-29T09%3A04%3A01.326Z&data%5Battributes%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_ruleset_id%5D=581d604d-8fe5-4b89-a068-f2aff55c9956&data%5Battributes%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Btill%5D=2021-12-29T09%3A04%3A01.326Z&data%5Battributes%5D%5Bvalue%5D=25&data%5Btype%5D=price_rules&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/price_rules`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the rule
`data[attributes][rule_type]` | **String**<br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `pickup_day`, `return_day`
`data[attributes][match_strategy]` | **String**<br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`data[attributes][adjustment_strategy]` | **String**<br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`data[attributes][value]` | **Float**<br>Adjustment value in percent
`data[attributes][from]` | **Datetime**<br>Defines start of period, used by `range_of_dates` rule type
`data[attributes][till]` | **Datetime**<br>Defines end of period, used by `range_of_dates` rule type
`data[attributes][from_day]` | **Integer**<br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][till_day]` | **Integer**<br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][from_time]` | **String**<br>Defines start of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][till_time]` | **String**<br>Defines end of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][charge]` | **Boolean**<br>Determines effect of rules using charge attribute
`data[attributes][stacked]` | **Boolean**<br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`data[attributes][time]` | **String**<br>Defines time for adjustment, `HH:mm` format, used by `pickup_day`, `return_day` rule types
`data[attributes][price_ruleset_id]` | **Uuid**<br>The associated Price ruleset


### Includes

This request does not accept any includes
## Updating a price rule



> How to update a price rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rules/5cbdb5cb-ed73-4557-ade0-c969abc4bb1a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5cbdb5cb-ed73-4557-ade0-c969abc4bb1a",
        "type": "price_rules",
        "attributes": {
          "value": 10
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5cbdb5cb-ed73-4557-ade0-c969abc4bb1a",
    "type": "price_rules",
    "attributes": {
      "created_at": "2021-11-29T09:04:01+00:00",
      "updated_at": "2021-11-29T09:04:01+00:00",
      "name": "Holidays",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 10.0,
      "from": "2030-12-01T00:00:00+00:00",
      "till": "2031-01-31T00:00:00+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "price_ruleset_id": "9818c357-f4e9-493a-b88e-19630351d4e1"
    },
    "relationships": {
      "price_ruleset": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Updating a price rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rules/eae4797e-cd8d-470c-a1a3-b553db9c353d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eae4797e-cd8d-470c-a1a3-b553db9c353d",
        "type": "price_rules",
        "attributes": {
          "id": "eae4797e-cd8d-470c-a1a3-b553db9c353d",
          "name": "Off season"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eae4797e-cd8d-470c-a1a3-b553db9c353d",
    "type": "price_rules",
    "attributes": {
      "created_at": "2021-11-29T09:04:02+00:00",
      "updated_at": "2021-11-29T09:04:02+00:00",
      "name": "Off season",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 5.0,
      "from": "2030-12-01T00:00:00+00:00",
      "till": "2031-01-31T00:00:00+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "price_ruleset_id": "5d3cfd60-4fdf-4ee8-b478-e4eb4b73d38d"
    },
    "relationships": {
      "price_ruleset": {
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

`PUT /api/boomerang/price_rules/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the rule
`data[attributes][rule_type]` | **String**<br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `pickup_day`, `return_day`
`data[attributes][match_strategy]` | **String**<br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`data[attributes][adjustment_strategy]` | **String**<br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`data[attributes][value]` | **Float**<br>Adjustment value in percent
`data[attributes][from]` | **Datetime**<br>Defines start of period, used by `range_of_dates` rule type
`data[attributes][till]` | **Datetime**<br>Defines end of period, used by `range_of_dates` rule type
`data[attributes][from_day]` | **Integer**<br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][till_day]` | **Integer**<br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][from_time]` | **String**<br>Defines start of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][till_time]` | **String**<br>Defines end of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][charge]` | **Boolean**<br>Determines effect of rules using charge attribute
`data[attributes][stacked]` | **Boolean**<br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`data[attributes][time]` | **String**<br>Defines time for adjustment, `HH:mm` format, used by `pickup_day`, `return_day` rule types
`data[attributes][price_ruleset_id]` | **Uuid**<br>The associated Price ruleset


### Includes

This request does not accept any includes
## Archiving a price rule



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rules/abd34442-9b8e-4f89-b7f3-2a56bafcbe8e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_rules/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rules]=id,created_at,updated_at`


### Includes

This request does not accept any includes