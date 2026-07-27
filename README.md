# Automated Proxmox Deployment Pipeline (Terraform & Ansible)

Dieses Repository enthält eine vollständig automatisierte Infrastructure-as-Code- (IaC) und Configuration-Management-Pipeline für den Aufbau und Betrieb von virtuellen Servern auf einem Proxmox-VE-Cluster.

## Architektur & Workflow

Die Bereitstellung erfolgt in zwei aufeinanderfolgenden Stufen führungslos (Non-Interactive):

1. **Infrastructure as Code (Terraform):**
   - Klonen eines schlanken Debian-Templates auf dem Proxmox-Host.
   - Zuweisung von Hardware-Ressourcen (CPU, RAM, Netzwerkbrücke).
   - Injektion der statischen IP-Adresse (`10.0.10.13`) und des öffentlichen SSH-Schlüssels über Cloud-Init.
2. **Configuration Management (Ansible):**
   - Automatischer Verbindungsaufbau per SSH-Schlüssel als standardmäßiger Systembenutzer.
   - Aktualisierung der Debian-Paketquellen und Systempakete.
   - Installation der Docker-Engine und der zugehörigen Abhängigkeiten.
   - Bereitstellung und Start eines hochverfügbaren Nginx-Webservers als Container auf Port 8080.

## Projektstruktur

| Datei | Beschreibung |
| :--- | :--- |
| `main.tf` | Terraform-Konfiguration für die Proxmox-VM-Bereitstellung und Cloud-Init-Integration. |
| `playbook.yml` | Ansible-Playbook für die Systemkonfiguration, Docker-Installation und Container-Deployment. |
| `.gitignore` | Ausschluss von sensiblen Daten (z. B. lokale State-Dateien, SSH-Schlüssel). |

## Voraussetzungen

- **Proxmox VE Cluster** mit konfiguriertem Cloud-Init-Template (z. B. ID 9000).
- **Terraform** und **Ansible** auf dem ausführenden System (z. B. lokales Admin-System / Raspberry Pi) installiert.
- Generiertes SSH-Schlüsselpaar (`~/.ssh/id_ed25519`).

## Ausführung

1. Repository klonen und in das Verzeichnis wechseln:
   ```bash
   git clone [https://github.com/fayssalmj/proxmox-devops-lab.git](https://github.com/fayssalmj/proxmox-devops-lab.git)
   cd proxmox-devops-lab

    Terraform initialisieren:
    Bash

    terraform init

    Automatisierte Pipeline starten:
    Bash

    terraform apply

    Den Vorgang mit yes bestätigen. Die VM wird bereitgestellt und im Anschluss automatisch durch Ansible konfiguriert.

Verifizierung

Nach ca. 2 Minuten ist der Server betriebsbereit. Die Funktion kann per SSH oder über den Webbrowser geprüft werden:

    Webbrowser: http://10.0.10.13:8080

    SSH & Docker Status:
    Bash

    ssh -i ~/.ssh/id_ed25519 fayssal@10.0.10.13
    sudo docker ps

Autor: Fayssal Mjahed

Fachinformatiker für Systemintegration / Junior DevOps Engineer
