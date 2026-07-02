# sap-btp-config-example
Implements a SAP BTP Account structure, Environments and Services as per specifications in a YAML or JSON configuration file.  This implementation demonstrates a **configuration-first** approach to SAP BTP infrastructure provisioning where a YAML or JSON configuration defines **what** needs to be deployed, and generic Terraform modules detail **how** the infrastructure is deployed.

The configuration-first approach makes automate SAP BTP infrastructure provisioning accessible to SAP architects and administrators without requiring them to learn and apply Terraform skills. Theycan utilise their SAP and BTP domain knowledge to create a configuration that is applied through a GitOps pipeline.

The repository follows the standard structure of the configuration-first pattern:
```
sap-btp-config-example/
├── config/             # Configuration file(s) — the operator interface
├── deploy/             # Terraform entry point — reads config, calls modules
├── modules/            # Reusable Terraform modules for BTP resources
├── run.sh              # Execution wrapper
└── .pre-commit-config.yaml
```
This structure reflects the pattern's core principle: configuration is separated from implementation. The `config/` directory is where operators work; the `modules/` directory is where the implementation lives and where Terraform practitioners focus their expertise.

The configuration file in `config/` expresses the desired BTP account landscape as a data document. This document includes the global account where this landscape is to be deployed, the global `labels` to be applied throughout, and `services` detais that the global account is entitled to. The account model is laid out with directories and subaccounts in the required containtment hierarchy. Within a subaccount configuration block, the `user_role_assignments` element lists one or more role-collections along with the list of users each to be assigned. The `environments` element lists the runtimes to be configured and `services` lists the entitled services to be subscribed within the subaccount. The `has_identity_service` element identifies subaccounts hosting CIS services and `configure_trust_with` defines the CIS target to establish trust with.

This configuration is readable by a BTP architect or administrator without Terraform knowledge. The schema maps to BTP's conceptual model — global account, directories, subaccounts, environments, entitlements, and service instances — rather than to provider resource types. Adding a new subaccount is a matter of adding a new entry under `subaccounts`, not writing new HCL.
