output "subnet_id" {
    value = aws_subnet.subnetA.id
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "webserver_sg" {
    value = aws_security_group.webserver_sg.id
}

output "webserver_sg_id" {
    value = aws_security_group.webserver_sg.id
}

output "webserver_sg_arn" {
    value = aws_security_group.webserver_sg.arn
}