
##creating users

variable "userlist" {
  default = ["buttercup", "blossom", "bubbles"]
}

resource "aws_iam_user" "iamuser" {
  name  = var.userlist[count.index]
  count = length(var.userlist)
}
