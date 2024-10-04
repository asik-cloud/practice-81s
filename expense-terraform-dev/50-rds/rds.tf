module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.resource_name

  engine            = "mysql"
  engine_version    = "8.0.35"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name = "transactions"
  username = "root"
  password = "ExpenseApp1"
  port     = "3306"
  manage_master_user_password = false

  vpc_security_group_ids = [local.mysql_sg_id]
  skip_final_snapshot = true

  tags = merge(
    var.common_tags,
    var.rds_tags
  )

  db_subnet_group_name = local.db_subnet_group_name
  parameters = [
    {
      name = "character_set_client"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}