resource "aws_iam_group" "administrators" {
  name = var.group_name                                               
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = var.policy_name                                             
#   users      = [aws_iam_user.user.name]
#   roles      = [aws_iam_role.role.name]
  groups     = [aws_iam_group.administrators.name]
  policy_arn = var.policy_arn                                         
}

resource "aws_iam_user" "admin1" {
  name = var.user_name1                                                              
}

resource "aws_iam_user" "admin2" {
  name = var.user_name2                                                              
}

resource "aws_iam_group_membership" "administrators-users" {
  name = var.membership_name                                           

  users = [
    aws_iam_user.admin1.name,
    aws_iam_user.admin2.name,
  ]

  group = aws_iam_group.administrators.name
}

output "warning" {
  value = "WARNING: make sure you're not using the AdministratorAccess policy for other users/groups/roles. If this is the case, don't run terraform destroy, but manually unlink the created resources"
}