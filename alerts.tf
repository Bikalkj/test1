data "local_file" "alert_profiles_data" {
  filename = "${path.module}/alert_profiles.json"
}

locals {
  alert_profiles = jsondecode(data.local_file.alert_profiles_data.content)
}

resource "prismacloudcompute_alertprofile" "test" {
  for_each = { for idx, profile in local.alert_profiles : idx => profile }

  name               = each.value.name
  enabled            = each.value.enabled
  alert_profile_type = each.value.alert_profile_type

  // ... other properties and configurations

  alert_triggers {
    access {
      enabled   = true
      all_rules = true
    }

    admission {
      enabled   = true
      all_rules = true
    }

    app_embedded_defender_runtime {
      enabled   = true
      all_rules = true
    }

    cloud_native_network_firewall {
      enabled = true
    }

    container_and_image_compliance {
      enabled   = true
      all_rules = true
    }

    container_runtime {
      enabled   = true
      all_rules = true
    }

    defender_health {
      enabled = true
    }

    host_compliance {
      enabled   = true
      all_rules = true
    }

    host_runtime {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_app_embedded_defender_all_rules", false)
    }

    host_vulnerabilities {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_app_embedded_defender_all_rules", false)
    }
    image_vulnerabilities {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_app_embedded_defender_all_rules", false)
      rules     = ["rule1", "rule2"]
    }

    incidents {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
    }

    kubernetes_audits {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_app_embedded_defender_all_rules", false)
    }

    serverless_runtime {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_app_embedded_defender_all_rules", false)
    }

    waas_firewall_app_embedded_defender {
      enabled   = lookup(each.value, "waas_firewall_app_embedded_defender_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_app_embedded_defender_all_rules", false)
    }

    waas_firewall_container {
      enabled   = lookup(each.value, "waas_firewall_container_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_container_all_rules", false)
    }

    waas_firewall_host {
      enabled   = lookup(each.value, "waas_firewall_host_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_host_all_rules", false)
    }

    waas_firewall_serverless {
      enabled   = lookup(each.value, "waas_firewall_serverless_enabled", false)
      all_rules = lookup(each.value, "waas_firewall_serverless_all_rules", false)
    }

    waas_health {
      enabled   = lookup(each.value, "waas_health_enabled", false)
    }



    // ... additional alert triggers
  }
}