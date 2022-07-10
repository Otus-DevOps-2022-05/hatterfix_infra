variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  type        = string
  default     = "ru-central1-a"
}
variable bucket_account_key_file {
  description = "tf-bucket_key.json"
}
variable access_key {
  description = "bucket account access_key"
}
variable secret_key {
  description = "bucket account secret_key"
}
