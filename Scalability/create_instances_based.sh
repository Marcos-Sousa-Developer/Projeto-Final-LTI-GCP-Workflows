#CREATE INSTANCE BASED ON EXISTING INSTANCE -> UBUNTU LTS

gcloud compute instances create load-balancer-2 \
    --project=greatergoods \
    --zone=europe-southwest1-a \
    --machine-type=e2-medium \
    --network-interface=network-tier=PREMIUM,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account={YOUR_SERCIE_ACCOUNT} \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name={YOUR_INSTANCE_TO_COPY},image=projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20230415,mode=rw,size=10,type=projects/greatergoods/zones/europe-southwest1-a/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=ec-src=vm_add-gcloud \
    --reservation-affinity=any