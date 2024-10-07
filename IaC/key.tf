# Chave acesso para EC2 (precisa liberar a porta 22 no SG)
resource "aws_key_pair" "key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
