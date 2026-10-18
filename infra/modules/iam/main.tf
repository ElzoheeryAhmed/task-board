# ---------- EKS control plane role ----------

#
resource "aws_iam_role" "cluster" {
  name               = "${local.name}-eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.eks_assume.json  #Pull policy from AWS
}

#------------------------------
# We define what this role do attach    policies to it 
resource "aws_iam_role_policy_attachment" "cluster" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}




# ---------- Worker node role ----------

#
resource "aws_iam_role" "node" {
  name               = "${local.name}-eks-node"
  assume_role_policy = data.aws_iam_policy_document.node_assume.json #Pull Policy from AWS
}

#----------------------------------------------------------------
# For each node give it these three policies
resource "aws_iam_role_policy_attachment" "node" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ])

  role       = aws_iam_role.node.name
  policy_arn = each.value
}



# ---------- OIDC provider (lets pods use IAM roles) ----------


resource "aws_iam_openid_connect_provider" "eks" {
  url             = var.oidc_issuer_url
  client_id_list  = ["sts.amazonaws.com"] #The issued token is intended for STS"
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]  #lets AWS verify the identity of the OIDC issuer’s TLS certificate.
}




# ---------- EBS CSI driver role (for the database volumes) ----------


resource "aws_iam_role" "ebs_csi" {
  name               = "${local.name}-ebs-csi"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_assume.json #Pull policy from  AWS
}

#----------------------------------------------------
resource "aws_iam_role_policy_attachment" "ebs_csi" {
  role       = aws_iam_role.ebs_csi.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
