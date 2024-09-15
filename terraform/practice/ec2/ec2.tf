resource "aws_instance" "expense" {

  ami                    = "ami-0b4f379183e5706b9"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.expense_allow_all.id]


}

