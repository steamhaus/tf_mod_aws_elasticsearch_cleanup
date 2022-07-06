data "aws_iam_policy_document" "policy" {
  statement {
    sid       = "LambdaLogCreation"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:*"]
  }

  statement {
    sid       = "ESPermission"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["es:*"]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.prefix}es-cleanup"
  path        = "/"
  description = "Policy for es-cleanup Lambda function"
  policy      = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  name = "${var.prefix}es-cleanup"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
