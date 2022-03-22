resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.all.names)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.all.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_tag_prefix}-public-${substr(data.aws_availability_zones.all.names[count.index], -1, -1)}"
  }
}

resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.all.names)

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.all.names[count.index]
  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block, 8, count.index + length(data.aws_availability_zones.all.names)
  )

  tags = {
    Name = "${local.name_tag_prefix}-private-${substr(data.aws_availability_zones.all.names[count.index], -1, -1)}"
  }
}
