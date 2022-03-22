output "tags" {
  description = "Tags formatted to adhere to \"Architecture and DevOps - Resource Tagging\" standards."
  value       = local.tags
}

output "aws_default_tags" {
  description = "Subset of `tags`. Limited to 10 values in order to be used as `default_tags` in an AWS provider block."
  value       = local.aws_default_tags
}

output "legacy_tags" {
  description = "Tags formatted to adhere to \"HCT AWS Tagging Standard\" standards."
  value       = local.legacy_tags
}

output "tags_string" {
  description = "Returns a `;` delimited string of tags, e.g.: `tag1:value1;tag2:value2`. Only includes tags with non-null values."
  value       = join(";", [for key, value in local.tags : format("%s:%s", key, value) if key != null && value != null])
}
