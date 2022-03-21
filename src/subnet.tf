resource "aws_subnet" "public" {
  count = length(local.az)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = local.az[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_tag_prefix}-public-${local.az_suffix[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count = length(local.az)

  vpc_id            = aws_vpc.main.id
  availability_zone = local.az[count.index]
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + length(local.az))

  tags = {
    Name = "${local.name_tag_prefix}-private-${local.az_suffix[count.index]}"
  }
}
