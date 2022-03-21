# AWS Training - SharedVPC

## Description

Terraform の練習用 VPC 関連共通リソースを管理

VPC の数に制限があって無闇に VPC 作れないのでこういう形にしている

## Developer

### Terraform

#### backend 指定について

`backend.tf` にて `tfstate` ファイルを保持する `S3` バケットの指定をしていますが、ローカルやテスト環境の作成などで、
異なるバケットに `tfstate` を作りたい場合、以下の手順で実現できます。

```bash
cp backend.tfvars.example backend.tfvars
vi backend.tfvars # bucket の他に、ニーズに合わせて key, region なども設定できます
terraform init -backend-config="backend.tfvars"
```

#### profile 指定について

`var.aws_profile` (デフォルト値: `default`)に設定された `profile` を用いて AWS リソースを作成します。

`default` 以外の `profile` でリソースを作成したい場合は、以下の手順で設定してください。

```bash
cp terraform.tfvars.example terraform.tfvars
vi terraform.tfvars # aws_profile の設定
```

#### multi platform 対応

amd64 で `terraform init` した後に arm64 マシンで `terraform` を動かすとエラーになります

複数 platform に対応する lock ファイルを生成するためには以下コマンドで

`-platform` の引数増やせば対応 platform が増えます

```bash
terraform providers lock -platform=linux_arm64 -platform=linux_amd64
```

### tflint

最初に `src` 直下で以下コマンドで初期化

```bash
tflint --init
```

init 後は `src` 直下で以下コマンドにより `tflint` を実行出来ます

```bash
tflint
```

### tfsec

`src` 直下で以下コマンドにより `tfsec` を実行出来ます

```bash
tfsec .
```

### 開発中よく使うコマンド

以下 `terraform init` 後、かつ `src` 直下という前提

```bash
terraform fmt      # フォーマット
terraform validate # 静的構文チェック
tflint             # プロバイダ毎の不正値まで検査してくれる静的構文チェック
tfsec .            # セキュリティの静的構文チェック
terraform plan     # dry run
terraform apply    # リソース作成/更新
terraform destroy  # 全リソース削除
