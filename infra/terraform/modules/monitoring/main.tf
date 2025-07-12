# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/ec2/eshop-logs"
  retention_in_days = var.log_retention_days
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alerts" {
  name = "alerts-topic"
}

# SNS Email Subscription
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email  # ex: your_email@example.com
}

# CloudWatch Alarm: High CPU on instance
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}
