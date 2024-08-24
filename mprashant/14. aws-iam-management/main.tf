terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  user_data = yamldecode(file("./users.yaml")).users

  user_role_pair = flatten([
    for users in local.user_data:
    [
      for role in users.roles:
        {
          user = users.username
          role = role
        }
    ]
  ])
}

resource "aws_iam_user" "users" {
  for_each = toset(local.user_data[*].username)
  name = each.value
}

resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [ 
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

resource "aws_iam_user_policy_attachment" "policy_attach" {
  # jatin-AdministratorAccess = { role = "AdministratorAccess", user = "jatin" }
  for_each = {
    for pair in local.user_role_pair:
      "${pair.user}-${pair.role}" => pair
  }

  user = aws_iam_user.users[each.value.user].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}