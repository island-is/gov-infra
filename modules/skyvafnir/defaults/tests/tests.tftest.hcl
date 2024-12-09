
variables {
  source                = "../"
  caller                = "test-caller"
  instance              = "instance"
  org_code              = "test_org"
  resource_abbreviation = "abbrv"
  tags                  = { test_tag = "test_value" }
  tier                  = "test_tier"
}


run "verify_base" {
  command = plan

  # tags
  assert {
    condition     = output.tags["test_tag"] == "test_value"
    error_message = "Output tags is incorrect"
  }

  # resource_name
  assert {
    condition = output.resource_name == join("-", [
      var.org_code,
      var.instance,
      var.tier,
      var.resource_abbreviation,
    ])
    error_message = "Output resource_name is incorrect"
  }

  # resource_name_template
  assert {
    condition = output.resource_name_template == join("-", [
      var.org_code,
      var.instance,
      var.tier,
      "%s",
    ])
    error_message = "Output resource_name_template is incorrect"
  }

  # prefix
  assert {
    condition     = output.prefix == var.org_code
    error_message = "Output prefix is incorrect."
  }
  assert {
    condition     = join("-", output.suffix) == join("-", [var.instance, var.tier])
    error_message = "Output suffix is incorrect, got [${join(", ", output.suffix)}]"
  }
  # project
  assert {
    condition     = output.project == join("-", [var.org_code, var.tier, var.instance])
    error_message = "Output project is incorrect"
  }
  # environment
  assert {
    condition     = output.environment == join("-", [var.org_code, var.tier])
    error_message = "Output environment is incorrect"
  }
  # tier_identifier
  assert {
    condition     = output.tier_identifier == var.tier
    error_message = "Output tier_identifier is incorrect"
  }
}

run "verify_tier_in_name_toggle" {
  command = plan

  variables {
    tier                  = "prod"
    include_tier_in_names = false
  }
  assert {
    condition     = output.tier_identifier == ""
    error_message = "Output tier_identifier should be empty."
  }

}