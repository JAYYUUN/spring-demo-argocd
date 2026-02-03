# Argo CD GitOps Deployment with Terraform

Terraform을 사용해 Argo CD를 설치하고,
Argo CD Application을 통해 GitOps 방식으로 Kubernetes 애플리케이션을 배포하는 프로젝트입니다.

---

## 프로젝트 개요

- Terraform으로 Argo CD 설치 (Helm 사용)
- Argo CD Application 리소스를 Terraform으로 관리
- Git 저장소를 Source of Truth로 사용하는 GitOps 구조
- Kubernetes 클러스터(EKS 등)에 애플리케이션 자동 동기화

---

## 아키텍처 개념

Git Repository (k8s manifests)
        ↓
Argo CD Application (CRD)
        ↓
Argo CD Application Controller
        ↓
Kubernetes Cluster (Deployment / Service / Pod)

- Git의 상태가 정답(Desired State)
- 클러스터 상태가 Git과 다르면 Argo CD가 자동으로 복구

---

## 디렉터리 구조

argocd/
├── .gitignore
├── argocd-application.tf      # Argo CD Application 정의
├── argocd-helm.tf             # Argo CD Helm 설치
├── argocd-values.yaml         # Argo CD Helm values
├── k8s-providers.tf           # Kubernetes / Helm provider 설정
├── provider.tf                # AWS provider 설정
├── variables.tf               # 변수 정의
├── versions.tf                # Terraform / provider 버전
├── terraform.tfvars           # 변수 값
└── README.md

주의:
.terraform/, terraform.tfstate, kubectl.exe 등은
Git에 커밋하지 않고 .gitignore로 관리합니다.

---

## 사용 기술

- Terraform
- Kubernetes
- Argo CD
- Helm
- GitHub
- Amazon EKS (선택)

---

## 사전 준비

- Terraform 설치
- Kubernetes 클러스터 접근 권한
- kubectl 설치 및 kubeconfig 설정
- GitHub 계정

---

## 배포 방법

1. Terraform 초기화

terraform init

2. 리소스 생성

terraform apply

---

## Argo CD Application 설명

Terraform에서 다음과 같은 Argo CD Application을 생성합니다.

- Git Repo: https://github.com/JAYYUUN/spring-demo-eks2
- Path: k8s/
- Target Branch: main
- Destination Namespace: default
- Sync Policy
  - Automated Sync
  - Self Heal
  - Prune Enabled

Git 변경 사항이 자동으로 클러스터에 반영됩니다.

---

## 상태 확인 방법

Argo CD Pod 확인

kubectl get pods -n argocd

Application 상태 확인

kubectl get applications -n argocd
kubectl describe application spring-app -n argocd

실제 애플리케이션 Pod 확인

kubectl get pods -n default

---

## GitOps 동작 예시

- Git에서 Deployment 수정 → 자동 반영
- 클러스터에서 수동 변경 → Argo CD가 원래 상태로 복구
- Git에서 리소스 삭제 → 클러스터에서도 삭제

---

## 참고 사항

- Argo CD는 Pod를 직접 관리하지 않고 Deployment 등 상위 리소스를 관리
- Application은 앱이 아니라 앱을 관리하는 선언적 리소스

---

## 목적

이 프로젝트는 다음을 목표로 합니다.

- GitOps 개념 이해
- Argo CD 동작 원리 학습
- Terraform + Kubernetes + Argo CD 연계 실습
- 클라우드 / DevOps 포트폴리오 구성

---

## 참고 링크

- https://argo-cd.readthedocs.io/
- https://developer.hashicorp.com/terraform
