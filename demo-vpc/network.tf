resource "aws_subnet" "demo-subnet-public-1" {
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.100.0.0/26"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "${var.AWS_REGION}a"
}

# resource "aws_internet_gateway" "demo-igw" {
#   vpc_id = module.vpc.vpc_id
# }

 resource "aws_route_table" "demo-public-crt" {
   vpc_id = module.vpc.vpc_id
   route {
     cidr_block = "0.0.0.0/0"
     #gateway_id = aws_internet_gateway.demo-igw.id
     gateway_id  = module.vpc.igw_id
   }
 }

 resource "aws_route_table_association" "demo-crta-public-subnet-1" {
   subnet_id      = aws_subnet.demo-subnet-public-1.id
   #route_table_id = aws_route_table.demo-public-crt.id
   route_table_id = aws_route_table.demo-public-crt.id
 }