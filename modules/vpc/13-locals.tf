# locals

locals {
  vpc_id = var.vpc_id == "" ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id
}