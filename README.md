# gov-infra

## Terraform Modules for Public Institutions in Iceland

This repository is a library of foundational Terraform modules tailored for public institutions in Iceland. 
Once completed, these modules will align with Iceland's strategic principles for cloud adoption, ensuring that public 
institutions will be able to fully leverage the benefits of cloud solutions.

## Repository structure
This repository is organized as follows:
- **[./modules](./modules)** contains re-usable Terraform modules that can be used as building blocks for provisioning 
  cloud infrastructure.
- **[./examples](./examples)** contains examples of coherent infrastructure setups using the modules
  provided in the `./modules` directory.

## Background and purpose

In 2021, Iceland introduced its ["Strategic Cloud Policies"](https://island.is/en/o/digital-iceland/Cloud-Policy-Icelandic-Public-Sector) to promote the efficient use of public cloud services across the Icelandic government and public sector. These policies highlight key principles:
- **Efficient Utilization:** Cloud solutions should be employed to their maximum potential.
- **Fact-Based Decision Making:** Choices should be driven by data and evidence.
- **Applicability:** Cloud solutions should be used where they bring the most value.
- **Trust and Cost Control:** Use trusted service providers and maintain oversight on costs.
- **Data Protection:** Prioritize the safety of data and services.
- **Continuous Improvement:** Regularly evaluate and enhance cloud-based operations.
- **Collaboration and Training:** Foster teamwork and continuous learning.

Following the introduction of these principles, in 2022, The Icelandic Ministry of Finance and Economic Affairs initiated 
the ["Governance Framework"](https://www.stjornarradid.is/library/02-Rit--skyrslur-og-skrar/Governance%20Framework%20for%20Azure%20in%20GovIceland%20v1.0%20-%20OpenVersion.pdf) for Microsoft Azure services.

### How This Repository Will Help

Once fully developed, the `gov-infra` repository will:

- **Standardize Management Architecture:** The Terraform modules will provide templates for the required management 
  structures, such as management groups, subscriptions, and resource groups.
  
- **Guide Usage Policies:** Through the modules, institutions will be guided on implementing recommended technical 
  policies, aligning with the Governance Framework's directives.

- **Accelerate Cloud Delivery:** By offering ready-to-use Terraform modules tailored for public institutions, the 
  repository will significantly reduce the time and effort required to set up cloud infrastructure. This streamlined 
  approach will enable institutions to rapidly deploy cloud solutions, ensuring that projects can be delivered faster 
  and public services can be modernized more efficiently.
