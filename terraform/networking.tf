data "aws_vpc" "defaultvpc" {
    id = "vpc-3d1db144"
}

variable "subnets" {
    default = [50, 60]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["eu-west-1a", "eu-west-1b"]
}

resource "aws_subnet" "eks-cluster-subnet" {
    count = length(var.subnets)
    vpc_id            = data.aws_vpc.defaultvpc.id
    availability_zone = element(var.azs, count.index)
    cidr_block        = cidrsubnet(data.aws_vpc.defaultvpc.cidr_block, 8, element(var.subnets, count.index))
}

resource "aws_route_table" "local-only" {
  vpc_id = data.aws_vpc.defaultvpc.id

  # since this is exactly the route AWS will create, the route will be adopted
}

resource "aws_route_table_association" "local-eks" {
  subnet_id      = aws_subnet.eks-cluster-subnet[1].id
  route_table_id = aws_route_table.local-only.id
}