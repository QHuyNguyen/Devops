#resource "tls_private_key" "ed25519-key" {
#  algorithm = "ED25519"
#}

resource "aws_key_pair" "this" {
  key_name   = var.keypair_name
  #public_key = trimspace(tls_private_key.ed25519-key.public_key_openssh)
  public_key = file("${path.module}/id_ed25519_qhuynguyen.pub")
  
  #provisioner "local-exec" { # Create "myKey.pem" to your computer!!
  #  command = "echo '${trimspace(tls_private_key.ed25519-key.private_key_pem)}' > ./${aws_key_pair.this.key_name}.pem"
  #}
}

#resource "local_sensitive_file" "this" {
#  content  = tls_private_key.ed25519-key.private_key_openssh
#  filename = "${path.module}/sshkey-${aws_key_pair.this.key_name}"
#}