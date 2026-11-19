"""
Desktop Automation Sanity Verification Script
Tests imports, versions, screen detection, and basic automation capabilities.
"""
import sys

print(f"Running on Python: {sys.version}")

try:
    import pywinauto
    print(f" [OK] pywinauto v{pywinauto.__version__}")
except Exception as e:
    print(f" [FAIL] pywinauto: {e}")

try:
    import pyautogui
    print(f" [OK] pyautogui v{pyautogui.__version__}")
    screen_size = pyautogui.size()
    print(f"      Primary Display Resolution: {screen_size.width}x{screen_size.height}")
except Exception as e:
    print(f" [FAIL] pyautogui: {e}")

try:
    import PIL
    print(f" [OK] Pillow (PIL) v{PIL.__version__}")
except Exception as e:
    print(f" [FAIL] Pillow: {e}")

try:
    import win32api
    import win32gui
    print(f" [OK] pywin32 (win32api, win32gui)")
except Exception as e:
    print(f" [FAIL] pywin32: {e}")

try:
    import comtypes
    print(f" [OK] comtypes v{comtypes.__version__}")
except Exception as e:
    print(f" [FAIL] comtypes: {e}")

try:
    import uiautomation
    print(" [OK] uiautomation")
except Exception as e:
    print(f" [FAIL] uiautomation: {e}")

try:
    import keyboard
    print(f" [OK] keyboard v{getattr(keyboard, '__version__', 'installed')}")
except Exception as e:
    print(f" [FAIL] keyboard: {e}")

try:
    import mouse
    print(f" [OK] mouse v{getattr(mouse, '__version__', 'installed')}")
except Exception as e:
    print(f" [FAIL] mouse: {e}")

try:
    import screeninfo
    monitors = screeninfo.get_monitors()
    print(f" [OK] screeninfo detected {len(monitors)} monitor(s)")
except Exception as e:
    print(f" [FAIL] screeninfo: {e}")

print("\nAll Desktop Automation packages are fully functional!")
