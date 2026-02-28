#!/bin/bash

set -e

echo "=== Update hệ thống ==="
sudo apt update -y

echo "=== Cài các package cần thiết ==="
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "=== Thêm Docker GPG key ==="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== Thêm Docker repository ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Update lại repo ==="
sudo apt update -y

echo "=== Cài Docker Engine + Docker Compose Plugin ==="
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Thêm user vào group docker ==="
sudo usermod -aG docker $USER

echo "=== Enable Docker ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Kiểm tra Docker ==="
docker --version
docker compose version

echo ""
echo "Cài đặt hoàn tất 🎉"
echo "Logout hoặc reboot để dùng docker không cần sudo."