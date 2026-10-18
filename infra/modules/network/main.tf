
resource "aws_vpc" "clusvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = local.name }
}

resource "aws_internet_gateway" "clusigw" {
  vpc_id = aws_vpc.clusvpc.id
  tags   = { Name = local.name }
}




# ---------- Subnets ----------
resource "aws_subnet" "public" {
  count = var.az_count

  vpc_id                  = aws_vpc.clusvpc.id
  availability_zone       = local.azs[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 100)  #if VPC_cidr=/16 this cidr=/16+8=24 (count.index + 100) the number of subnet from 2^8 you have
  map_public_ip_on_launch = false

  tags = {
    Name                                  = "${local.name}-public-${local.azs[count.index]}"
    "kubernetes.io/role/elb"              = "1"
  }
}

resource "aws_subnet" "private" {
  count = var.az_count

  vpc_id            = aws_vpc.clusvpc.id
  availability_zone = local.azs[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index) #Cidr of private subnet is larger than public one because the each pod have private ip

}




# ---------- NAT (single NAT gateway to save cost) ----------
resource "aws_eip" "nateip" {
  count = local.nat_count
  domain     = "vpc"
  depends_on = [aws_internet_gateway.clusigw]
  tags       = { Name = "${local.name}-nateip-${count.index}" }
}

resource "aws_nat_gateway" "nat" {
  count = local.nat_count
  allocation_id = aws_eip.nateip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.clusigw]
  tags          = { Name = "${local.name}-nat-${count.index}" }
}





# ---------- Route tables ----------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.clusvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.clusigw.id
  }

  tags = { Name = "${local.name}-public" }
}

resource "aws_route_table" "private" {

  count = local.nat_count
  vpc_id = aws_vpc.clusvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = { Name = "${local.name}-private-${count.index}" }
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = var.az_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[(local.nat_count>1)?count.index:0].id
}
