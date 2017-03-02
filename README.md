# VPC terraform

VPC with 1 public / 1 private subnets and a [bastion](https://www.sans.org/security-resources/idfaq/what-is-a-bastion-host/2/11).

## Usage

```
$ source env
$ terraform plan
$ terraform apply
```

## Resources

* [http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario2.html]
* [Using SSH Through A Bastion Host Transparently](https://10mi2.wordpress.com/2015/01/14/using-ssh-through-a-bastion-host-transparently/)
