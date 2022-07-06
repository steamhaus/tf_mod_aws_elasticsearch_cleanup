tf_mod_aws_elasticsearch_cleanup
================================

A Terraform module to ensure that ElasticSearch does not run out of disk space.

What this module does
---------------------

- Creates a named Lambda function that handles the deletion of items
- Creates an IAM role and policy that grants the function access to ES
- Creates a Cloudwatch event rule that triggers the function on a schedule

What this module doesn't do
---------------------------

- Create an SNS topic to send failures notifications to

Input Variables
---------------

*Required*

* `es_endpoint` - Elasticsearch endpoint.
* `index` - Prefix of the index names. e.g. `logstash` if your indices look
like `logstash-2017.10.30`.
* `delete_after` - How many days old to keep.
* `index_format` - Variable section of the index names. e.g. `%Y.%m.%d` if
you indices look like `logstash-2017.10.30`.

*Optional*

* `sns_alert` - SNS topic ARN to send failure alerts to.
* `prefix` - A prefix for the resource names, this helps create multiple
instances of this stack for different environments and regions.
* `schedule` - Schedule expression for running the cleanup function.
* `python_version` - Python version to be used. Defaults to 2.7
Default is once a day at 03:00 GMT.
See: http://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html

Usage
-----

```
module "es_cleanup" {
  source = "git::https://github.com/steamhaus/tf_mod_aws_elasticsearch_cleanup"

  prefix       = "test-eu-west-1-"
  es_endpoint  = "test-es-XXXXXXX.eu-west-1.es.amazonaws.com"
  sns_alert    = "arn:aws:sns:eu-west-1:123456789012:alertme"
  index        = "logstash"
  delete_after = 7
  index_format = "%Y.%m.%d"
  python_version = "3.6"
}
```
