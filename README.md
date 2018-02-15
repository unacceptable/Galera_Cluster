# Documentation

Steps to get the cluster running:

```
cd Terraform
```

Copy Secrets example file to a .tf file

```
cp -a secrets.tf{-example,}
```

Also consider copying the `creds.tf-example` so that you don't have to type the region every time you do a terraform apply.

```
cp -a creds.tf{-example,}
```

Perform a terraform apply after initializing the environment

```
terraform init
```

```
terraform apply
```

Well that was easy!
