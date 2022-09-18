## GCP compute
## Regions
Logical groupings of zones

```bash
$ gcloud compute regions list 
```

## Zones
Physical locations within a region

```bash
gcloud compute zones list
```

## Images
Provides a preconfigured operating system and software stack

```bash
$ gcloud compute images list
```

## Machine type
A machine type is a combination of CPU, memory, and local SSDs

```bash
$ gcloud compute machine-types list
``` 


## Compute

### Create ssh keys
```bash
ssh-keygen -t ed25519 -C "rustedchipmunk" -f ssh-gcp -q -N ''
```

```bash
gcloud compute os-login ssh-keys add \
    --key-file=ssh-gcp.pub
```

Get posix account
```bash
gcloud compute os-login describe-profile --format='value(posixAccounts[0].username)'

```

### Virtual Machine instance
```bash
export GCP_PROJECT_ZONE=us-central1-a
gcloud compute instances create server \
 --machine-type "n1-standard-1" \
 --image-project "centos-cloud" \
 --image "centos-stream-8-v20220822" \
 --subnet "default" \
 --zone $GCP_PROJECT_ZONE \
 --metadata "enable-oslogin=TRUE"
```

### List Virtual Machines
```bash
gcloud compute instances list
```
Get server compute instance
```bash
gcloud compute instances describe server \
    --zone $GCP_PROJECT_ZONE \
    --format='value(networkInterfaces[0].accessConfigs[0].natIP)'
```

### SSH into Virtual Machine
With User Account
```bash
ssh -i ssh-gcp $(gcloud compute os-login describe-profile \
    --format='value(posixAccounts[0].username)')@$(gcloud compute instances describe server \
    --zone $GCP_PROJECT_ZONE \
    --format='value(networkInterfaces[0].accessConfigs[0].natIP)')
```

With Service account
```bash
export GCP_PROJECT_ID=$(gcloud config get-value project)
export GCP_SA_NAME=sa-gcp
ssh -i ssh-gcp sa_$(gcloud iam service-accounts describe \
    $GCP_SA_NAME@$GCP_PROJECT_ID.iam.gserviceaccount.com \
    --format='value(oauth2ClientId)')@$(gcloud compute instances describe server \
    --zone $GCP_PROJECT_ZONE \
    --format='value(networkInterfaces[0].accessConfigs[0].natIP)')

# Subnets
A range of IP addresses in your VPC network

```bash
gcloud compute networks subnets create my-subnet --network default --range
```