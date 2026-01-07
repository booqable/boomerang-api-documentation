# Refundable payment charges

Refundable Payment Charges provide a prioritized list of payment charges that can be refunded for a specific order.

This virtual resource analyzes all charges associated with an order and determines the optimal charges to refund,
considering the amount, deposit, and various business rules.

## Relationships
Name | Description
-- | --
`payment_charge` | **[Payment charge](#payment-charges)** `required`<br>The [PaymentCharge](#payment-charges) that this refundable charge represents. 


Check matching attributes under [Fields](#refundable-payment-charges-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`max_refundable_amount_in_cents` | **integer** <br>The maximum amount in cents that can be refunded from this charge.<br>This represents the refundable portion of the regular amount (not deposit). 
`max_refundable_deposit_in_cents` | **integer** <br>The maximum deposit amount in cents that can be refunded from this charge.<br>This represents the refundable portion of the deposit. 
`max_refundable_total_in_cents` | **integer** <br>The total amount in cents that can be refunded from this charge.<br>This is the sum of `max_refundable_amount_in_cents` and `max_refundable_deposit_in_cents`. 
`payment_charge_id` | **uuid** <br>The [PaymentCharge](#payment-charges) that this refundable charge represents. 
`position` | **integer** <br>The sequential position (1..n) of this charge in the prioritized list.<br>Lower positions (starting at 1) indicate higher priority charges that should be considered first for refunding. The positions are assigned based on the sorting of charges by priority type, refundable amount, and timestamp. 
`priority_type` | **string** <br>A string indicating the priority category of this charge.<br>Possible values: - `optimal`: Can cover both amount and deposit in a single refund - highest priority. - `full_amount`: Can cover the full amount to be refunded. - `full_deposit`: Can cover the full deposit to be refunded. - `partial_amount`: Can partially cover the amount to be refunded. - `partial_deposit`: Can partially cover the deposit to be refunded. - `partial`: Can cover some part of the refund but not the full amount or deposit. 


## Retrieve prioritized refundable payment charges


> How to retrieve prioritized refundable payment charges:

```shell
  curl --get 'https://example.booqable.com/api/4/refundable_payment_charges'
       --header 'content-type: application/json'
       --data-urlencode 'filter[amount_in_cents]=10000'
       --data-urlencode 'filter[deposit_in_cents]=5000'
       --data-urlencode 'filter[order_id]=d93eb469-fa75-4544-87c6-87a74339bc75'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "4fdcfc3c-eaea-47b5-845c-72e48194b5a2",
        "type": "refundable_payment_charges",
        "attributes": {
          "position": 1,
          "priority_type": "optimal",
          "max_refundable_amount_in_cents": 15000,
          "max_refundable_deposit_in_cents": 7500,
          "max_refundable_total_in_cents": 22500,
          "payment_charge_id": "367e21a5-6799-497b-892c-c7412f0d6184"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/refundable_payment_charges`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[refundable_payment_charges]=position,priority_type,max_refundable_amount_in_cents`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=payment_charge`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`amount_in_cents` | **integer** `required`<br>`eq`
`deposit_in_cents` | **integer** `required`<br>`eq`
`max_refundable_amount_in_cents` | **integer** <br>`eq`
`max_refundable_deposit_in_cents` | **integer** <br>`eq`
`max_refundable_total_in_cents` | **integer** <br>`eq`
`order_id` | **string** `required`<br>`eq`
`payment_charge_id` | **uuid** <br>`eq`
`position` | **integer** <br>`eq`
`priority_type` | **string** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>payment_charge</code>
    <ul>
      <li><code>payment_method</code></li>
    </ul>
  </li>
</ul>

