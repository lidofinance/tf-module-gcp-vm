# Google Cloud VM Module

This Terraform module creates a Google Compute Engine instance with optional external IP and additional disk management features. It supports attaching an external disk, backup policies, and configuring network interfaces with or without an external IP.

## Features

- Provision a Google Compute Engine instance.
- Optionally create an external IP for the instance.
- Attach an additional disk with optional snapshot scheduling and backup policy.
- Configure SSH keys, service accounts, labels, and network settings.
- Support for custom machine types, disk types, and automatic backups.

## Usage

```hcl
module "eth_api" {
  source              = "git::https://github.com/lidofinance/tf-module-gcp-vm.git?ref=v0.0.1"
  name                = "instance-name"
  env                 = terraform.workspace
  machine_type        = "n1-standard-1"
  backup_enable       = False
  description         = "Some description of VM"
  image               = "centos-stream-9"
  network             = "vpc-prod"
  subnetwork          = "sub-main-prod"
  external_ip         = true
  labels = {
    team = "devops",
    env = "prod"
  }
  tags = [
    allow-cf-ingress,
    allow-ssh-ingress
  ]
  zone = "europe-north1-a"
}
```

## Inputs

| Name                  | Description                                                                                                                      | Type         | Default       | Required |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------ | ------------- | -------- |
| name                  | Name of the instance                                                                                                             | string       | n/a           | yes      |
| env                   | Environment (e.g., dev, prod)                                                                                                    | string       | n/a           | yes      |
| network               | VPC Network for the instance                                                                                                     | string       | n/a           | yes      |
| subnetwork            | Subnetwork for the instance                                                                                                      | string       | n/a           | yes      |
| zone                  | Zone for the instance                                                                                                            | string       | n/a           | yes      |
| image                 | [The image to use for the boot disk](https://cloud.google.com/compute/docs/images/os-details)                                    | string       | n/a           | yes      |
| machine_type          | [Machine type for the instance](https://cloud.google.com/compute/docs/networking/configure-vm-with-high-bandwidth-configuration) | string       | e2-standard-2 | no       |
| extra_disk_name       | Custom name for the additional disk                                                                                              | string       | ""            | no       |
| extra_disk_size       | Size of the additional disk (GB), set to 0 to disable                                                                            | number       | 0             | no       |
| extra_disk_type       | Type of the additional disk (pd-ssd, pd-balanced, etc.)                                                                          | string       | "pd-balanced" | no       |
| extra_disk_snapshot   | Optional snapshot to restore the additional disk from                                                                            | string       | ""            | no       |
| boot_disk_size        | Size of the boot disk (GB)                                                                                                       | number       | 50            | no       |
| boot_disk_type        | Type of the boot disk (pd-balanced, pd-balanced, pd-ssd etc.)                                                                    | string       | "pd-ssd"      | no       |
| boot_disk_auto_delete | Whether to auto-delete the boot disk when the instance is deleted                                                                | bool         | false         | no       |
| deletion_protection   | Enable deletion protection for the instance                                                                                      | bool         | false         | no       |
| tags                  | List of tags to assign to the instance                                                                                           | list(string) | []            | no       |
| description           | Description for the instance                                                                                                     | string       | ""            | no       |
| ssh_keys              | List of SSH keys allowed to access the instance                                                                                  | list(object) | []            | no       |
| service_account_email | Service account email to attach to the instance                                                                                  | string       | false         | no       |
| backup_enable         | Enable backup policy for the additional disk                                                                                     | bool         | false         | no       |

## Outputs

| Name      | Description                                          |
| --------- | ---------------------------------------------------- |
| vm_ext_ip | The external IP of the instance (if applicable)      |
| vm_int_ip | The internal IP of the instance                      |
| vm_name   | The name of the instance                             |
| labels    | Labels assigned to the instance                      |
| team      | The value of the team label assigned to the instance |

## How to Create a Release

Before triggering the release workflow, ensure the following:

1. The message with which the PR was merged into the main branch has a sufficient description of the functionality of the new release.
2. You changes merged in main branch.
3. The tag you are going to apply has the [SEMVER](https://semver.org/) format
   - Format: X.Y.Z (e.g., 1.0.0, 0.2.3)
   - No prefix (v or otherwise).

### Release creation

Create and push a Git tag that follows semantic versioning.

1. Switch to main branch

```
git checkout main
```

2. Tag Your Commit

```
git tag 0.1.0
```

> [!IMPORTANT]
> Make sure you're tagging a commit on the main branch.

3. Push your tag

```
git push --tag origin main
```
