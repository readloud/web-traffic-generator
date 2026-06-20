import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog
import threading
import time
import random
import logging
import queue
import re
from datetime import datetime
from bs4 import BeautifulSoup
from fake_useragent import UserAgent

# Selenium Imports
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager

# --- Configuration & Logging ---
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[logging.FileHandler('bot.log'), logging.StreamHandler()]
)
logger = logging.getLogger(__name__)

class TrafficEngine:
    """Handles the actual browser automation for various platforms."""
    def __init__(self, log_queue):
        self.log_queue = log_queue
        self.running = False
        self.ua = UserAgent()

    def log(self, message):
        self.log_queue.put(f"[{datetime.now().strftime('%H:%M:%S')}] {message}")

    def get_driver(self, headless=True):
        chrome_options = Options()
        if headless:
            chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument(f"user-agent={self.ua.random}")
        
        service = Service(ChromeDriverManager().install())
        return webdriver.Chrome(service=service, options=chrome_options)

    def run_youtube_viewer(self, url, views, duration):
        self.running = True
        for i in range(views):
            if not self.running: break
            driver = None
            try:
                self.log(f"Starting YouTube View {i+1}/{views}")
                driver = self.get_driver(headless=False) # Headless often blocks YT
                driver.get(url)
                time.sleep(duration)
                self.log(f"View {i+1} completed successfully.")
            except Exception as e:
                self.log(f"Error on view {i+1}: {str(e)}")
            finally:
                if driver: driver.quit()
                time.sleep(random.randint(5, 15))
        self.running = False

class BotManagerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Youtube Traffic Bot v2.0")
        self.root.geometry("900x700")
        
        self.log_queue = queue.Queue()
        self.engine = TrafficEngine(self.log_queue)
        
        self.setup_ui()
        self.start_log_monitor()

    def setup_ui(self):
        # Tabs
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        # YouTube Tab
        self.yt_frame = ttk.Frame(self.notebook)
        self.notebook.add(self.yt_frame, text="📺 YouTube")
        
        ttk.Label(self.yt_frame, text="Video URL:").pack(pady=5)
        self.yt_url = ttk.Entry(self.yt_frame, width=60)
        self.yt_url.pack(pady=5)
        self.yt_url.insert(0, "https://www.youtube.com/watch?v=dQw4w9WgXcQ")

        ttk.Label(self.yt_frame, text="Number of Views:").pack()
        self.yt_views = ttk.Spinbox(self.yt_frame, from_=1, to=1000)
        self.yt_views.set(100)
        self.yt_views.pack()

        ttk.Label(self.yt_frame, text="Watch Duration (sec):").pack()
        self.yt_time = ttk.Spinbox(self.yt_frame, from_=10, to=3600)
        self.yt_time.set(60)
        self.yt_time.pack()

        ttk.Button(self.yt_frame, text="▶ Start YouTube Bot", command=self.start_youtube).pack(pady=20)

        # Log Area
        log_frame = ttk.LabelFrame(self.root, text="System Logs")
        log_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        self.log_display = scrolledtext.ScrolledText(log_frame, height=15, state='disabled')
        self.log_display.pack(fill=tk.BOTH, expand=True)

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

    def start_youtube(self):
        url = self.yt_url.get()
        views = int(self.yt_views.get())
        duration = int(self.yt_time.get())
        
        if not re.match(r'^https?://', url):
            messagebox.showerror("Error", "Invalid URL")
            return

        # Run in thread to prevent GUI freezing
        thread = threading.Thread(
            target=self.engine.run_youtube_viewer, 
            args=(url, views, duration), 
            daemon=True
        )
        thread.start()
        messagebox.showinfo("Started", "YouTube Bot is running in the background.")

if __name__ == "__main__":
    root = tk.Tk()
    # Apply a modern theme if available
    style = ttk.Style()
    if 'clam' in style.theme_names():
        style.theme_use('clam')
        
    app = BotManagerGUI(root)
    root.mainloop()
