import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import threading
import time
import random
import logging
import queue
import re
from datetime import datetime
from fake_useragent import UserAgent

# Selenium Imports
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager

# --- Setup Logging ---
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')
logger = logging.getLogger(__name__)

class TrafficEngine:
    """The 'Brain' that handles browser automation."""
    def __init__(self, log_queue):
        self.log_queue = log_queue
        self.running = False
        self.ua = UserAgent()

    def log_to_ui(self, message):
        self.log_queue.put(f"[{datetime.now().strftime('%H:%M:%S')}] {message}")

    def get_driver(self, headless=False):
        chrome_options = Options()
        if headless:
            chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument(f"user-agent={self.ua.random}")
        
        service = Service(ChromeDriverManager().install())
        return webdriver.Chrome(service=service, options=chrome_options)

    def run_ecommerce_task(self, platform, url, views, duration):
        self.running = True
        self.log_to_ui(f"🚀 Starting {platform} Bot for: {url}")
        
        for i in range(views):
            if not self.running: break
            driver = None
            try:
                driver = self.get_driver(headless=False)
                driver.get(url)
                
                # Human-like interaction: Random scrolling
                for _ in range(random.randint(2, 5)):
                    scroll_amount = random.randint(300, 700)
                    driver.execute_script(f"window.scrollBy(0, {scroll_amount});")
                    time.sleep(2)
                
                time.sleep(duration)
                self.log_to_ui(f"✅ {platform} View {i+1}/{views} Successful")
            except Exception as e:
                self.log_to_ui(f"❌ Error: {str(e)}")
            finally:
                if driver: driver.quit()
                time.sleep(random.randint(5, 10))
        
        self.log_to_ui(f"🏁 {platform} Task Completed.")
        self.running = False

class BotManagerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("🛍️ E-Commerce Traffic Bot v2.0")
        self.root.geometry("1000x750")
        
        self.log_queue = queue.Queue()
        self.engine = TrafficEngine(self.log_queue)
        
        self.setup_ui()
        self.start_log_monitor()

    def setup_ui(self):
        # Notebook for Tabs
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        # 1. E-Commerce Tab
        self.ecom_frame = ttk.Frame(self.notebook)
        self.notebook.add(self.ecom_frame, text="🛍️ E-Commerce")
        self.create_ecom_ui(self.ecom_frame)

        # 3. Log Area (Always Visible)
        log_frame = ttk.LabelFrame(self.root, text="Real-Time Activity Logs")
        log_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        self.log_display = scrolledtext.ScrolledText(log_frame, height=12, state='disabled', bg="#1e1e1e", fg="#00ff00")
        self.log_display.pack(fill=tk.BOTH, expand=True)

    def create_ecom_ui(self, frame):
        ttk.Label(frame, text="Select Platform:").pack(pady=5)
        self.platform_var = tk.StringVar(value="TikTok Shop")
        platform_cb = ttk.Combobox(frame, textvariable=self.platform_var, values=["TikTok Shop", "Shopee", "Lazada"])
        platform_cb.pack(pady=5)

        ttk.Label(frame, text="Product URL:").pack(pady=5)
        self.ecom_url = ttk.Entry(frame, width=70)
        self.ecom_url.pack(pady=5)

        ttk.Button(frame, text="▶ Start E-Commerce Bot", command=self.start_ecom).pack(pady=20)

    def start_log_monitor(self):
        def monitor():
            while True:
                try:
                    msg = self.log_queue.get(block=False)
                    self.log_display.configure(state='normal')
                    self.log_display.insert(tk.END, msg + "\n")
                    self.log_display.see(tk.END)
                    self.log_display.configure(state='disabled')
                except queue.Empty:
                    pass
                time.sleep(0.1)
        threading.Thread(target=monitor, daemon=True).start()

    def start_ecom(self):
        url = self.ecom_url.get()
        if not url: return messagebox.showwarning("Warning", "Please enter a URL")
        
        thread = threading.Thread(target=self.engine.run_ecommerce_task, 
                                  args=(self.platform_var.get(), url, 5, 20), daemon=True)
        thread.start()

if __name__ == "__main__":
    root = tk.Tk()
    style = ttk.Style()
    style.theme_use('clam')
    app = BotManagerGUI(root)
    root.mainloop()
