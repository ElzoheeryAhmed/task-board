
# ---------- StorageClass for the database StatefulSet ----------
resource "kubernetes_storage_class_v1" "gp3" {
  metadata {
    name = var.name
  }

  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = var.reclaim_policy
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type      = var.volume_type
    encrypted = tostring(var.encrypted)
    fsType    = var.fs_type
  }

}
