# Python 3.14 Desktop Automation Offline Wheelhouse

[![Python 3.14](https://img.shields.io/badge/python-3.14.0-blue.svg)](https://www.python.org/)
[![Platform](https://img.shields.io/badge/platform-windows--64--bit-lightgrey.svg)]()
[![Offline Ready](https://img.shields.io/badge/offline-100%25%20air--gapped-brightgreen.svg)]()

Complete standalone **Python 3.14.0** runtime and pre-compiled **offline wheelhouse** (`.whl` files) for Windows Desktop Automation, including **PyAutoGUI**, **PyWinAuto**, **PyWin32**, **Pillow**, and **Microsoft UIAutomation**.

Designed for deployment on offline, air-gapped, or restricted enterprise machines without requiring internet access or compiler tools.

---

## 📦 What's Inside

```text
python-14-env-wheelhouse/
├── python-3.14.0-amd64.zip   # Full official Python 3.14.0 standalone distribution archive
├── wheelhouse/               # 17 pre-built offline wheels (.whl) for Python 3.14
├── wheelbase/                # Mirror directory of wheelhouse
├── requirements.txt          # Pinned dependency requirements
├── install_offline.bat       # 1-click batch installer (auto-extracts Python + installs wheels)
├── install_offline.ps1       # PowerShell offline installer
├── test_automation.py        # Sanity verification script for all automation tools
└── README.md                 # Documentation and deployment instructions
```

---

## 🛠️ Included Packages & Versions

| Package | Version | Purpose |
| :--- | :--- | :--- |
| **`python`** | 3.14.0 | Official CPython 64-bit standalone runtime |
| **`pip`** | 26.3 | Python package installer |
| **`pywinauto`** | 0.6.9 | Windows GUI automation (Win32 & UIA backends) |
| **`pyautogui`** | 0.9.54 | Cross-platform GUI automation (mouse, keyboard, screens) |
| **`pywin32`** | 312 | Native Win32 API extensions for Python 3.14 |
| **`pillow`** | 13.0.0 | High-performance image processing (for PyAutoGUI screenshotting) |
| **`comtypes`** | 1.5.0 | COM client for Windows UI Automation |
| **`uiautomation`** | 2.0.29 | Direct Microsoft UIAutomation control |
| **`keyboard`** | 0.13.5 | Global keyboard event listeners and hotkeys |
| **`mouse`** | 0.7.1 | Global mouse hooks and positioning |
| **`screeninfo`** | 0.8.1 | Multi-monitor geometry and resolution detection |
| **`pygetwindow`** | 0.0.9 | Window handle and geometry management |
| **`pyscreeze`** | 1.0.1 | Screenshotting engine |
| **`pyperclip`** | 1.11.0 | System clipboard copy/paste access |
| **`pyrect`** | 0.2.0 | Rectangle geometric primitives |
| **`pytweening`** | 1.2.0 | Tweening animation curves for mouse smoothing |
| **`pymsgbox`** | 2.0.1 | Native popup alert boxes |
| **`six`** | 1.17.0 | Compatibility utility |

---

## 🚀 Quick Start on Any Machine

### Step 1: Clone or Copy this Repository
On the target machine:
```shell
git clone https://github.com/AniketCog001/python-14-env-wheelhouse.git
cd python-14-env-wheelhouse
```
*(Or download the repository ZIP / transfer via USB)*

### Step 2: Install Offline (No Internet Required)

#### Option A — 1-Click Batch (Command Prompt)
Double-click or run:
```cmd
install_offline.bat
```
*Automatically unzips `python-3.14.0-amd64.zip` into `Python314` (if not already extracted), installs all offline wheels from `wheelhouse/`, configures `pywin32`, and runs the verification test.*

#### Option B — PowerShell
```powershell
.\install_offline.ps1
```

#### Option C — Using Existing Python
If Python 3.14 is already installed on the machine:
```shell
pip install --no-index --find-links=wheelhouse -r requirements.txt
```

---

## 🔍 Verification Test

To verify that all desktop automation packages are functioning properly:

```shell
python test_automation.py
```

Expected output:
```text
Running on Python: 3.14.0 ...
 [OK] pywinauto v0.6.9
 [OK] pyautogui v0.9.54
      Primary Display Resolution: 1920x1080
 [OK] Pillow (PIL) v13.0.0
 [OK] pywin32 (win32api, win32gui)
 [OK] comtypes v1.5.0
 [OK] uiautomation
 [OK] keyboard vinstalled
 [OK] mouse vinstalled
 [OK] screeninfo detected 1 monitor(s)

All Desktop Automation packages are fully functional!
```
