 Model 7:28 AM
Create file `~/wiki/services.md`. Keep it simple.

### Services Wiki

| Name | Command | Why |
| :--- | :--- | :--- |
| **Search** | `sudo systemctl start docker` | Run SearXNG |
| **VMs** | `sudo systemctl start libvirtd` | Run Virt-Manager |
| **VPN** | `sudo systemctl start tailscaled` | Remote Access |
| **AI** | `sudo systemctl start ollama` | Local LLM |
| **Security** | `sudo systemctl start fail2ban` | Protect SSH |

### Caveman Tips:
1. **SearXNG**: If you use daily, keep Docker on. If heat high, stop it.
2. **Avahi**: Safe to `disable --now`. It finds printers/Macs on network. You no need.
3. **Ollama**: 3B model in RAM is fine, but Ollama background process checks GPU/CPU often. `stop` when not chatting.
4. **Fail2ban**: Only need if `sshd` is open to public web. If only Tailscale, Tailscale has own security. Can stop both.
