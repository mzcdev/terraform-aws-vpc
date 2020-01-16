# subnet public

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id = local.vpc_id

  availability_zone = var.public_subnets[count.index].zone

  cidr_block = var.public_subnets[count.index].cidr

  tags = merge(
    {
      Name = format(
        "%s-public-%s",
        var.name,
        element(split("", var.public_subnets[count.index].zone), length(var.public_subnets[count.index].zone) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  route_table_id = element(aws_route_table.public.*.id, var.single_route_table ? 0 : count.index)

  subnet_id = aws_subnet.public[count.index].id
}
