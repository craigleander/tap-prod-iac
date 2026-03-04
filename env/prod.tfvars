# Production environment - use with: terraform plan -var-file=env/prod.tfvars
# use_existing_subnet = false for full create (e.g. after destroy); set true if tap-prod-subnet already exists

use_existing_subnet = false

project_id   = "{{ project_id }}"
region       = "{{ region }}"   # Mumbai
zone         = "{{ zone }}"
app_name     = "{{ application_name }}"
environment  = "{{ env }}"

# In CI: set via secret (e.g. GCP_SA_KEY or TF_VAR_gcp_credentials_path); path to JSON key file
gcp_credentials_path = "{{ credentials_file }}" # should be a json
# Identity running Terraform (client_email from key); needs iam.serviceAccountUser on GKE node SA
terraform_sa_email   = "{{ should be an email }}"

# Network (VPC / subnet)
subnet_cidr   = "{{ sibnet_cidr }}" #10.0.0.0/20
pods_cidr     = "{{ pods_cidr }}" #10.4.0.0/14
services_cidr = "{{ services_cidr }}" #10.8.0.0/20

# GKE
gke_zones              = ["asia-south1-a", "asia-south1-b", "asia-south1-c"]
gke_node_count         = 2
gke_machine_type       = "e2-medium"
gke_deletion_protection = false   # set true in prod to prevent accidental destroy

gcs_bucket_names  = ["tap-data", "tap-uploads"]
gcs_force_destroy = true   # allow destroy to delete buckets (set false in prod if needed)

cloud_sql_tier         = "db-f1-micro"
cloud_sql_db_name      = "tapdb"
cloud_sql_user_name    = "tapuser"
cloud_sql_user_password = "CHANGE_ME_TAP_PROD_2024" # Change in CI or use secret manager

redis_memory_size_gb = 1

pubsub_topic_names        = ["tap-events"]
pubsub_subscription_names = { "tap-events" = ["tap-events-sub"] }

