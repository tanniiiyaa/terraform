
##creating users

variable "userlist" {
  default = ["buttercup", "blossom", "bubbles"]
}

resource "aws_iam_user" "iamuser" {
<<<<<<< HEAD:loops/count/count-iam-users.tf
  name  = var.userlist[count.index]
  count = length(var.userlist)
}
=======
    name = var.userlist[count.index]
    count = length(var.userlist)

}
>>>>>>> b6eba45d72efc0e836bc7b489d2f8af5d14d3fd6:loops/count/iam.tf
