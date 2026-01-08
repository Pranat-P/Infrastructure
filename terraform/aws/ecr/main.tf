module "ecr" {
  source   = "terraform-aws-modules/ecr/aws"
  version  = "2.4.0"
  for_each = toset(var.repository_names)

  attach_repository_policy        = var.attach_repository_policy
  create_repository_policy        = var.create_repository_policy
  registry_scan_type              = var.registry_scan_type
  repository_image_tag_mutability = var.repository_image_tag_mutability

  repository_name = each.value

  repository_lifecycle_policy = jsonencode({
    "rules" : concat(
      [for idx in range(length(var.tag_patterns)) : {
        "rulePriority" : idx + 2,
        "description" : "Keeps ten tagged images, expires all others",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPatternList" : [var.tag_patterns[idx]],
          "countType" : "imageCountMoreThan",
          "countNumber" : 10
        },
        "action" : {
          "type" : "expire"
        }
      }],
      [
        {
          "rulePriority" : 2147483646,
          "description" : "Keeps ten tagged images for custom*, expires all others",
          "selection" : {
            "tagStatus" : "tagged",
            "tagPatternList" : ["manual*"],
            "countType" : "imageCountMoreThan",
            "countNumber" : 10
          },
          "action" : {
            "type" : "expire"
          }
        },
        {
          "rulePriority" : 2147483647,
          "description" : "Remove all other images older than five days",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "sinceImagePushed",
            "countUnit" : "days",
            "countNumber" : 5
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    )
  })

  tags = var.default_tags
}
