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

### Virtual Machine instance
```bash
gcloud compute instances create server \
 --machine-type "n1-standard-1" \
 --image-project "centos-cloud" \
 --image "centos-stream-8-v20220822" \
 --subnet "default" \
 --zone "us-central1-a"
```


# Subnets
A range of IP addresses in your VPC network

```bash
gcloud compute networks subnets create my-subnet --network default --range
