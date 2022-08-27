resource "aws_key_pair" "public_key" {
  key_name   = "exam_rsa.pub"
  public_key = file("/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/exam_rsa.pub")
}

