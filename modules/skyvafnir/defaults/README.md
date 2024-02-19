# defaults

### a Skývafnir Terraform Module

A module for maintaining default naming and tagging conventions for other modules.

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                | Description                                                                                                                                                                                 | Type           | Default                                                                                                                                                                                                                                               | Required |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_caller"></a> [caller](#input_caller)                                                 | The name of the caller of the module. (best supplied via `basename(path.module)`.<br>    Populates the `part-of-module` tag.                                                                | `string`       | n/a                                                                                                                                                                                                                                                   |   yes    |
| <a name="input_instance"></a> [instance](#input_instance)                                           | Purpose or identifier for the application, workload or service.                                                                                                                             | `string`       | n/a                                                                                                                                                                                                                                                   |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                           | Organization code.                                                                                                                                                                          | `string`       | n/a                                                                                                                                                                                                                                                   |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                       | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                                               | `map(string)`  | n/a                                                                                                                                                                                                                                                   |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                       | Tier of the environment.                                                                                                                                                                    | `string`       | n/a                                                                                                                                                                                                                                                   |   yes    |
| <a name="input_append_random_pet"></a> [append_random_pet](#input_append_random_pet)                | Whether to append a random pet name to the resource name.                                                                                                                                   | `bool`         | `false`                                                                                                                                                                                                                                               |    no    |
| <a name="input_default_tag_override"></a> [default_tag_override](#input_default_tag_override)       | Any tags that should be present on created resources. Will override local.default_tags                                                                                                      | `map(string)`  | `null`                                                                                                                                                                                                                                                |    no    |
| <a name="input_iac_support_email"></a> [iac_support_email](#input_iac_support_email)                | An email address. Used to populate the `iac_support_email` tag.                                                                                                                             | `string`       | `"support@skyvafnir.cloud"`                                                                                                                                                                                                                           |    no    |
| <a name="input_name_override"></a> [name_override](#input_name_override)                            | Override the name of the resource. This ia an escape hatch in case the name generated by the module is not suitable.                                                                        | `string`       | `null`                                                                                                                                                                                                                                                |    no    |
| <a name="input_prefix"></a> [prefix](#input_prefix)                                                 | Prefix to add to the resource name.                                                                                                                                                         | `string`       | `""`                                                                                                                                                                                                                                                  |    no    |
| <a name="input_production_identifiers"></a> [production_identifiers](#input_production_identifiers) | List of identifiers that indicate a production environment.<br>    Used to determine whether tier should be omitted from naming.<br>    Set to empty list to always include tier in naming. | `list(string)` | <pre>\[<br>  "prod",<br>  "prd",<br>  "production"<br>\]</pre>                                                                                                                                                                                        |    no    |
| <a name="input_provisioned_by"></a> [provisioned_by](#input_provisioned_by)                         | The name of the tool that is provisioning the resource.<br>    Populates the `provisioned-by` tag.                                                                                          | `string`       | `"skyvafnir-terraform"`                                                                                                                                                                                                                               |    no    |
| <a name="input_resource_abbreviation"></a> [resource_abbreviation](#input_resource_abbreviation)    | The abbreviation for the resource.  This is used to generate the resource name.                                                                                                             | `string`       | `"YOU SHOULD REALLY SET THIS VARIABLE IF YOU EVER SEE THIS IN A PLAN. I'M NOT KIDDING. IT'S IMPORTANT. REALLY. SET IT. NOW. PLEASE. THANKS. I'LL WAIT. NO, REALLY. I'LL WAIT. I'VE GOT ALL DAY. I'M NOT GOING ANYWHERE. I'LL JUST SIT HERE AND WAIT"` |    no    |

## Outputs

| Name                                                                                                                             | Description                                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| <a name="output_environment"></a> [environment](#output_environment)                                                             | The environment identifier i.e. \[org_code\]-\[tier\]-\[instance\]                                                                |
| <a name="output_prefix"></a> [prefix](#output_prefix)                                                                            | The default resource_name prefix - in case you need it.                                                                           |
| <a name="output_project"></a> [project](#output_project)                                                                         | The project identifier i.e. \[org_code\]-\[tier\]                                                                                 |
| <a name="output_resource_name"></a> [resource_name](#output_resource_name)                                                       | The name of the resource.                                                                                                         |
| <a name="output_resource_name_prefixed"></a> [resource_name_prefixed](#output_resource_name_prefixed)                            | The name of the resource with a org_code prefix.                                                                                  |
| <a name="output_resource_name_template"></a> [resource_name_template](#output_resource_name_template)                            | The resource name template without the `resource_abbreviation`, i.e.<br>  `org-<%s>-<<br>  Use `format` render the template.<br>` |
| <a name="output_resource_name_template_prefixed"></a> [resource_name_template_prefixed](#output_resource_name_template_prefixed) | The resource name template. Use `format` render the template..                                                                    |
| <a name="output_suffix"></a> [suffix](#output_suffix)                                                                            | The default resource_name suffix as a list - in case you need it (for the naming module.                                          |
| <a name="output_tags"></a> [tags](#output_tags)                                                                                  | The tags to be used on the resource.                                                                                              |
| <a name="output_tier_identifier"></a> [tier_identifier](#output_tier_identifier)                                                 | The tier identifier (empty for production tiers)                                                                                  |

## Resources

| Name                                                                                                           | Type     |
| -------------------------------------------------------------------------------------------------------------- | -------- |
| [random_pet.random_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1  |
| <a name="requirement_random"></a> [random](#requirement_random)          | >=3.0.0 |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_random"></a> [random](#provider_random) | 3.6.0   |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
```
# Module scaffolded via skyvafnir-module-template
Author:    gzur
Version:   0.1.0
Timestamp: 2023-05-10T13:42:35
```
-->
