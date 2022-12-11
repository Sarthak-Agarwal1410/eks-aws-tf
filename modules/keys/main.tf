resource "aws_key_pair" "key" {
  key_name   = var.name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDR1nKzrYV7sZrf9J16NdDiP6sWxmLUqN/wiEl0/xCPyZsCC6z3/2CvUdf3w1h7KIRYDMfLOxI+/4KGgYXFYMqlaoAZ5wq6AZws/1xyJUhb8QJ2SkRkIZ2+6NjFUQqel/NCbYCzpqL6lqcnyWc3sb80nQE5iXczRDSaQdWW+nP3SYyhkyQg2yVJAbHH7RQFuAtCsOi/gIVDZ+MbLm2e0o7aIRFOM+ToRfQtzPIwuJasFazaDpcqVFzw7qjC/v4EE4bsALXIQqqkC6ofWYESjEQDjRxNJr2rSC1Ti14WT/9fWLPSfHtzQ45wHCdNtgQv1szaxbcEjzwl6NaiOT2MRjW3kkPknJcI0UfRs63LOso2lLLZfp5mWL2rE9BFNfa6+fNFDvi8gvBgSeaAmx75RmNVA5Fl/26KiJaZdw9XAEPB8DxI097d09/pUZyUhs/x52H6ghRmcBY/ZnUeL3PzxFAT55kmJqjhGOkWaHwqRQG0pX0+2PHHx0uathp4rs+vgqk= suraj@rubik"
  tags = {
    Name = "${var.name}"
  }
}
