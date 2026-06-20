## pip install selenium webdriver-manager fake-useragent beautifulsoup4 requests websocket-client
import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
from bs4 import BeautifulSoup
from fake_useragent import UserAgent
from datetime import datetime
from typing import Dict, List, Optional
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import threading
import time
import random
import requests
import json
import logging
import queue
import os
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import websocket

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class BotManagerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Multi-Platform Bot Manager v1.0")
        self.root.geometry("900x700")
        
        # Configure styles
        self.setup_styles()
        
        # Active bots tracking
        self.active_bots = {}
        self.bot_threads = {}
        self.log_queue = queue.Queue()
        
        # Start log monitor
        self.start_log_monitor()
        
        self.setup_ui()
        
    def setup_styles(self):
        """Setup custom styles for the GUI"""
        style = ttk.Style()
        style.theme_use('clam')
        
        # Configure colors
        style.configure('Title.TLabel', font=('Arial', 14, 'bold'))
        style.configure('Status.TLabel', font=('Arial', 10))
        style.configure('Green.TButton', foreground='green')
        style.configure('Red.TButton', foreground='red')
        
    def setup_ui(self):
        # Main container
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Title
        title_label = ttk.Label(main_frame, text="🤖 Multi-Platform Bot Manager", 
                               style='Title.TLabel')
        title_label.pack(pady=(0, 10))
        
        # Status bar
        self.status_var = tk.StringVar(value="Ready")
        status_bar = ttk.Label(main_frame, textvariable=self.status_var, 
                              relief=tk.SUNKEN, anchor=tk.W, style='Status.TLabel')
        status_bar.pack(side=tk.BOTTOM, fill=tk.X, pady=(5, 0))
        
        # Notebook for different bots
        self.notebook = ttk.Notebook(main_frame)
        self.notebook.pack(fill=tk.BOTH, expand=True)
        
        # Website Bot Tab
        self.website_frame = ttk.Frame(self.notebook)
        self.setup_website_tab(self.website_frame)
        self.notebook.add(self.website_frame, text="🌐 Website Visitor")
        
        # YouTube Bot Tab
        self.youtube_frame = ttk.Frame(self.notebook)
        self.setup_youtube_tab(self.youtube_frame)
        self.notebook.add(self.youtube_frame, text="📺 YouTube Viewer")
        
        # Live Stream Tab
        self.live_frame = ttk.Frame(self.notebook)
        self.setup_live_tab(self.live_frame)
        self.notebook.add(self.live_frame, text="🔴 Live Stream")
        
        # Settings Tab
        self.settings_frame = ttk.Frame(self.notebook)
        self.setup_settings_tab(self.settings_frame)
        self.notebook.add(self.settings_frame, text="⚙️ Settings")
        
        # Control Panel
        self.setup_control_panel(main_frame)
        
        # Log Area
        self.setup_log_area(main_frame)
        
    def setup_control_panel(self, parent):
        """Setup global control panel"""
        control_frame = ttk.LabelFrame(parent, text="Global Controls", padding="10")
        control_frame.pack(fill=tk.X, pady=(10, 5))
        
        # Start All button
        self.start_all_btn = ttk.Button(control_frame, text="▶️ Start All Bots",
                                       command=self.start_all_bots,
                                       style='Green.TButton')
        self.start_all_btn.grid(row=0, column=0, padx=5, pady=5)
        
        # Stop All button
        self.stop_all_btn = ttk.Button(control_frame, text="⏹️ Stop All Bots",
                                      command=self.stop_all_bots,
                                      style='Red.TButton')
        self.stop_all_btn.grid(row=0, column=1, padx=5, pady=5)
        
        # Clear Logs button
        ttk.Button(control_frame, text="🗑️ Clear Logs",
                  command=self.clear_logs).grid(row=0, column=2, padx=5, pady=5)
        
        # Save Logs button
        ttk.Button(control_frame, text="💾 Save Logs",
                  command=self.save_logs).grid(row=0, column=3, padx=5, pady=5)
        
    def setup_website_tab(self, parent):
        """Setup Website Visitor tab"""
        # URL Input
        ttk.Label(parent, text="Website / Product URL:").grid(row=0, column=0, sticky=tk.W, padx=5, pady=5)
        self.website_url = ttk.Entry(parent, width=60)
        self.website_url.grid(row=0, column=1, columnspan=3, padx=5, pady=5, sticky=tk.EW)
        
        # Test URL button
        ttk.Button(parent, text="Test URL",
                  command=self.test_website_url).grid(row=0, column=4, padx=5, pady=5)
        
        # Duration
        ttk.Label(parent, text="Visit Duration (seconds):").grid(row=1, column=0, sticky=tk.W, padx=5, pady=5)
        self.website_duration = ttk.Spinbox(parent, from_=10, to=3600, width=10)
        self.website_duration.set("60")
        self.website_duration.grid(row=1, column=1, padx=5, pady=5, sticky=tk.W)
        
        # Visit Count
        ttk.Label(parent, text="Number of Visits:").grid(row=1, column=2, sticky=tk.W, padx=5, pady=5)
        self.website_visits = ttk.Spinbox(parent, from_=1, to=100, width=10)
        self.website_visits.set("100")
        self.website_visits.grid(row=1, column=3, padx=5, pady=5, sticky=tk.W)
        
        # Random Delay
        ttk.Label(parent, text="Delay between visits (seconds):").grid(row=2, column=0, sticky=tk.W, padx=5, pady=5)
        self.website_delay_min = ttk.Spinbox(parent, from_=1, to=60, width=8)
        self.website_delay_min.set("5")
        self.website_delay_min.grid(row=2, column=1, padx=5, pady=5, sticky=tk.W)
        
        ttk.Label(parent, text="to").grid(row=2, column=2, padx=2)
        self.website_delay_max = ttk.Spinbox(parent, from_=1, to=300, width=8)
        self.website_delay_max.set("15")
        self.website_delay_max.grid(row=2, column=3, padx=5, pady=5, sticky=tk.W)
        
        # Headless mode checkbox
        self.headless_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(parent, text="Headless Mode", 
                       variable=self.headless_var).grid(row=3, column=0, columnspan=2, sticky=tk.W, padx=5, pady=5)
        
        # Control buttons
        button_frame = ttk.Frame(parent)
        button_frame.grid(row=4, column=0, columnspan=5, pady=20)
        
        self.website_start_btn = ttk.Button(button_frame, text="▶️ Start Visiting",
                                           command=self.start_website_bot)
        self.website_start_btn.pack(side=tk.LEFT, padx=5)
        
        self.website_stop_btn = ttk.Button(button_frame, text="⏹️ Stop Visiting",
                                          command=lambda: self.stop_bot('website'),
                                          state=tk.DISABLED)
        self.website_stop_btn.pack(side=tk.LEFT, padx=5)
        
        # Configure grid weights
        parent.columnconfigure(1, weight=1)
        parent.columnconfigure(3, weight=1)
        
    def setup_youtube_tab(self, parent):
        """Setup YouTube Viewer tab"""
        # Search or URL
        ttk.Label(parent, text="YouTube URL or Search Term:").grid(row=0, column=0, sticky=tk.W, padx=5, pady=5)
        self.youtube_input = ttk.Entry(parent, width=60)
        self.youtube_input.grid(row=0, column=1, columnspan=3, padx=5, pady=5, sticky=tk.EW)
        
        # Duration per video
        ttk.Label(parent, text="Watch Duration per video (seconds):").grid(row=1, column=0, sticky=tk.W, padx=5, pady=5)
        self.youtube_duration = ttk.Spinbox(parent, from_=10, to=600, width=10)
        self.youtube_duration.set("60")
        self.youtube_duration.grid(row=1, column=1, padx=5, pady=5, sticky=tk.W)
        
        # Number of videos
        ttk.Label(parent, text="Number of Videos:").grid(row=1, column=2, sticky=tk.W, padx=5, pady=5)
        self.youtube_count = ttk.Spinbox(parent, from_=1, to=50, width=10)
        self.youtube_count.set("100")
        self.youtube_count.grid(row=1, column=3, padx=5, pady=5, sticky=tk.W)
        
        # Watch mode
        ttk.Label(parent, text="Watch Mode:").grid(row=2, column=0, sticky=tk.W, padx=5, pady=5)
        self.youtube_mode = ttk.Combobox(parent, values=["Sequential", "Random"], width=15, state="readonly")
        self.youtube_mode.set("Sequential")
        self.youtube_mode.grid(row=2, column=1, padx=5, pady=5, sticky=tk.W)
        
        # Control buttons
        button_frame = ttk.Frame(parent)
        button_frame.grid(row=3, column=0, columnspan=5, pady=20)
        
        self.youtube_start_btn = ttk.Button(button_frame, text="▶️ Start YouTube Bot",
                                           command=self.start_youtube_bot)
        self.youtube_start_btn.pack(side=tk.LEFT, padx=5)
        
        self.youtube_stop_btn = ttk.Button(button_frame, text="⏹️ Stop YouTube Bot",
                                          command=lambda: self.stop_bot('youtube'),
                                          state=tk.DISABLED)
        self.youtube_stop_btn.pack(side=tk.LEFT, padx=5)
        
        parent.columnconfigure(1, weight=1)
        
    def setup_live_tab(self, parent):
        """Setup Live Stream tab"""
        # Platform selection
        ttk.Label(parent, text="Platform:").grid(row=0, column=0, sticky=tk.W, padx=5, pady=5)
        self.live_platform = ttk.Combobox(parent, 
                                         values=["Generic", "Twitch", "YouTube Live", "Facebook Live", "Instagram Live"], 
                                         width=20, state="readonly")
        self.live_platform.set("Generic")
        self.live_platform.grid(row=0, column=1, padx=5, pady=5, sticky=tk.W)
        
        # Stream URL
        ttk.Label(parent, text="Stream URL/ID:").grid(row=1, column=0, sticky=tk.W, padx=5, pady=5)
        self.live_url = ttk.Entry(parent, width=60)
        self.live_url.grid(row=1, column=1, columnspan=3, padx=5, pady=5, sticky=tk.EW)
        
        # Duration
        ttk.Label(parent, text="Engagement Duration (minutes):").grid(row=2, column=0, sticky=tk.W, padx=5, pady=5)
        self.live_duration = ttk.Spinbox(parent, from_=1, to=240, width=10)
        self.live_duration.set("120")
        self.live_duration.grid(row=2, column=1, padx=5, pady=5, sticky=tk.W)
        
        # Engagement intensity
        ttk.Label(parent, text="Engagement Intensity:").grid(row=2, column=2, sticky=tk.W, padx=5, pady=5)
        self.live_intensity = ttk.Combobox(parent, 
                                          values=["Low", "Medium", "High"], 
                                          width=15, state="readonly")
        self.live_intensity.set("Medium")
        self.live_intensity.grid(row=2, column=3, padx=5, pady=5, sticky=tk.W)
        
        # Interaction types
        ttk.Label(parent, text="Interaction Types:").grid(row=3, column=0, sticky=tk.W, padx=5, pady=5)
        
        interaction_frame = ttk.Frame(parent)
        interaction_frame.grid(row=3, column=1, columnspan=3, sticky=tk.W, padx=5, pady=5)
        
        self.live_likes = tk.BooleanVar(value=True)
        self.live_comments = tk.BooleanVar(value=True)
        self.live_shares = tk.BooleanVar(value=False)
        self.live_reactions = tk.BooleanVar(value=True)
        
        ttk.Checkbutton(interaction_frame, text="Likes", variable=self.live_likes).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(interaction_frame, text="Comments", variable=self.live_comments).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(interaction_frame, text="Shares", variable=self.live_shares).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(interaction_frame, text="Reactions", variable=self.live_reactions).pack(side=tk.LEFT, padx=5)
        
        # Control buttons
        button_frame = ttk.Frame(parent)
        button_frame.grid(row=4, column=0, columnspan=5, pady=20)
        
        self.live_start_btn = ttk.Button(button_frame, text="▶️ Start Live Engagement",
                                        command=self.start_live_bot)
        self.live_start_btn.pack(side=tk.LEFT, padx=5)
        
        self.live_stop_btn = ttk.Button(button_frame, text="⏹️ Stop Live Engagement",
                                       command=lambda: self.stop_bot('live'),
                                       state=tk.DISABLED)
        self.live_stop_btn.pack(side=tk.LEFT, padx=5)
        
        parent.columnconfigure(1, weight=1)
        
    def setup_settings_tab(self, parent):
        """Setup Settings tab"""
        # Proxy settings
        proxy_frame = ttk.LabelFrame(parent, text="Proxy Settings", padding="10")
        proxy_frame.pack(fill=tk.X, padx=5, pady=5)
        
        ttk.Label(proxy_frame, text="HTTP Proxy:").grid(row=0, column=0, sticky=tk.W, pady=2)
        self.proxy_http = ttk.Entry(proxy_frame, width=50)
        self.proxy_http.grid(row=0, column=1, pady=2, padx=5)
        
        ttk.Label(proxy_frame, text="HTTPS Proxy:").grid(row=1, column=0, sticky=tk.W, pady=2)
        self.proxy_https = ttk.Entry(proxy_frame, width=50)
        self.proxy_https.grid(row=1, column=1, pady=2, padx=5)
        
        # User Agent settings
        ua_frame = ttk.LabelFrame(parent, text="User Agent Settings", padding="10")
        ua_frame.pack(fill=tk.X, padx=5, pady=5)
        
        self.ua_random = tk.BooleanVar(value=True)
        ttk.Checkbutton(ua_frame, text="Use Random User Agent", 
                       variable=self.ua_random).grid(row=0, column=0, sticky=tk.W, pady=2)
        
        ttk.Label(ua_frame, text="Custom User Agent:").grid(row=1, column=0, sticky=tk.W, pady=2)
        self.ua_custom = ttk.Entry(ua_frame, width=50)
        self.ua_custom.grid(row=1, column=1, pady=2, padx=5)
        
        # Save settings button
        ttk.Button(parent, text="💾 Save Settings",
                  command=self.save_settings).pack(pady=20)
        
    def setup_log_area(self, parent):
        """Setup log display area"""
        log_frame = ttk.LabelFrame(parent, text="Activity Log", padding="10")
        log_frame.pack(fill=tk.BOTH, expand=True, pady=(5, 0))
        
        self.log_area = scrolledtext.ScrolledText(log_frame, height=15, wrap=tk.WORD)
        self.log_area.pack(fill=tk.BOTH, expand=True)
        
        # Add tag configurations for different log levels
        self.log_area.tag_config("INFO", foreground="black")
        self.log_area.tag_config("WARNING", foreground="orange")
        self.log_area.tag_config("ERROR", foreground="red")
        self.log_area.tag_config("SUCCESS", foreground="green")
        
    def start_log_monitor(self):
        """Start monitoring the log queue"""
        def check_queue():
            while not self.log_queue.empty():
                log_entry = self.log_queue.get()
                level = log_entry.get('level', 'INFO')
                message = log_entry.get('message', '')
                self.add_log(message, level)
            self.root.after(100, check_queue)
        
        self.root.after(100, check_queue)
    
    def add_log(self, message: str, level: str = "INFO"):
        """Add message to log area"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        log_message = f"[{timestamp}] {message}\n"
        
        self.log_area.insert(tk.END, log_message, level)
        self.log_area.see(tk.END)
        
        # Update status bar for important messages
        if level in ["ERROR", "SUCCESS"]:
            self.status_var.set(message)
    
    def log(self, message: str, level: str = "INFO"):
        """Thread-safe logging"""
        self.log_queue.put({"message": message, "level": level})
    
    def test_website_url(self):
        """Test if website URL is accessible"""
        url = self.website_url.get()
        if not url:
            messagebox.showwarning("Warning", "Please enter a URL")
            return
        
        try:
            response = requests.head(url, timeout=5)
            if response.status_code == 200:
                self.log(f"✓ URL is accessible: {url}", "SUCCESS")
            else:
                self.log(f"⚠️ URL returned status: {response.status_code}", "WARNING")
        except Exception as e:
            self.log(f"✗ Error accessing URL: {str(e)}", "ERROR")
    
    def start_website_bot(self):
        """Start website bot"""
        url = self.website_url.get()
        if not url:
            messagebox.showwarning("Warning", "Please enter a website URL")
            return
        
        try:
            duration = int(self.website_duration.get())
            visits = int(self.website_visits.get())
            delay_min = int(self.website_delay_min.get())
            delay_max = int(self.website_delay_max.get())
            headless = self.headless_var.get()
            
            if delay_min > delay_max:
                messagebox.showwarning("Warning", "Minimum delay should be less than maximum delay")
                return
            
        except ValueError:
            messagebox.showerror("Error", "Please enter valid numbers")
            return
        
        # Update UI
        self.website_start_btn.config(state=tk.DISABLED)
        self.website_stop_btn.config(state=tk.NORMAL)
        
        # Create and start bot
        bot = WebsiteVisitorBot(headless=headless)
        self.active_bots['website'] = bot
        
        # Start in separate thread
        thread = threading.Thread(
            target=self.run_website_bot,
            args=(bot, url, duration, visits, delay_min, delay_max),
            daemon=True
        )
        self.bot_threads['website'] = thread
        thread.start()
        
        self.log(f"Starting website bot: {url} ({visits} visits)", "INFO")
    
    def run_website_bot(self, bot, url, duration, visits, delay_min, delay_max):
        """Run website bot logic"""
        try:
            for i in range(visits):
                if not hasattr(bot, 'running') or not bot.running:
                    break
                    
                self.log(f"Visit {i+1}/{visits} starting...", "INFO")
                bot.visit_website(url, duration)
                
                if i < visits - 1:  # Don't delay after last visit
                    delay = random.randint(delay_min, delay_max)
                    self.log(f"Waiting {delay} seconds before next visit...", "INFO")
                    time.sleep(delay)
            
            self.log("Website bot completed successfully", "SUCCESS")
            
        except Exception as e:
            self.log(f"Website bot error: {str(e)}", "ERROR")
        finally:
            # Update UI
            self.root.after(0, self.on_bot_finished, 'website')
    
    def start_youtube_bot(self):
        """Start YouTube bot"""
        input_text = self.youtube_input.get()
        if not input_text:
            messagebox.showwarning("Warning", "Please enter YouTube URL or search term")
            return
        
        try:
            duration = int(self.youtube_duration.get())
            count = int(self.youtube_count.get())
        except ValueError:
            messagebox.showerror("Error", "Please enter valid numbers")
            return
        
        # Update UI
        self.youtube_start_btn.config(state=tk.DISABLED)
        self.youtube_stop_btn.config(state=tk.NORMAL)
        
        # Create and start bot
        bot = YouTubeViewBot()
        self.active_bots['youtube'] = bot
        
        # Determine if input is URL or search term
        if 'youtube.com' in input_text or 'youtu.be' in input_text:
            videos = [input_text]
        else:
            videos = bot.search_videos(input_text, count)
        
        thread = threading.Thread(
            target=self.run_youtube_bot,
            args=(bot, videos, duration, count),
            daemon=True
        )
        self.bot_threads['youtube'] = thread
        thread.start()
        
        self.log(f"Starting YouTube bot for {len(videos)} videos", "INFO")
    
    def run_youtube_bot(self, bot, videos, duration, count):
        """Run YouTube bot logic"""
        try:
            mode = self.youtube_mode.get()
            
            if mode == "Random":
                selected_videos = random.sample(videos, min(count, len(videos)))
            else:
                selected_videos = videos[:count]
            
            for i, video_url in enumerate(selected_videos):
                if not hasattr(bot, 'running') or not bot.running:
                    break
                    
                self.log(f"Watching video {i+1}/{len(selected_videos)}", "INFO")
                bot.simulate_view(video_url, watch_time=duration)
                
                if i < len(selected_videos) - 1:
                    time.sleep(random.randint(5, 15))
            
            self.log("YouTube bot completed successfully", "SUCCESS")
            
        except Exception as e:
            self.log(f"YouTube bot error: {str(e)}", "ERROR")
        finally:
            self.root.after(0, self.on_bot_finished, 'youtube')
    
    def start_live_bot(self):
        """Start live stream bot"""
        platform = self.live_platform.get()
        url = self.live_url.get()
        
        if not url:
            messagebox.showwarning("Warning", "Please enter stream URL/ID")
            return
        
        try:
            duration_minutes = int(self.live_duration.get())
            duration = duration_minutes * 60  # Convert to seconds
        except ValueError:
            messagebox.showerror("Error", "Please enter valid duration")
            return
        
        # Update UI
        self.live_start_btn.config(state=tk.DISABLED)
        self.live_stop_btn.config(state=tk.NORMAL)
        
        # Create and start bot
        bot = SocialMediaLiveBot(platform.lower())
        
        # Configure interactions
        interaction_types = []
        if self.live_likes.get():
            interaction_types.append('like')
        if self.live_comments.get():
            interaction_types.append('comment')
        if self.live_shares.get():
            interaction_types.append('share')
        if self.live_reactions.get():
            interaction_types.append('reaction')
        
        bot.interaction_types = interaction_types
        bot.intensity = self.live_intensity.get().lower()
        
        self.active_bots['live'] = bot
        
        thread = threading.Thread(
            target=self.run_live_bot,
            args=(bot, url, duration),
            daemon=True
        )
        self.bot_threads['live'] = thread
        thread.start()
        
        self.log(f"Starting {platform} live stream engagement", "INFO")
    
    def run_live_bot(self, bot, live_id, duration):
        """Run live bot logic"""
        try:
            bot.simulate_live_engagement(live_id, duration)
            self.log("Live stream bot completed successfully", "SUCCESS")
        except Exception as e:
            self.log(f"Live stream bot error: {str(e)}", "ERROR")
        finally:
            self.root.after(0, self.on_bot_finished, 'live')
    
    def on_bot_finished(self, bot_name: str):
        """Handle bot completion"""
        if bot_name in self.active_bots:
            bot = self.active_bots[bot_name]
            if hasattr(bot, 'close'):
                try:
                    bot.close()
                except:
                    pass
            del self.active_bots[bot_name]
        
        # Update UI
        if bot_name == 'website':
            self.website_start_btn.config(state=tk.NORMAL)
            self.website_stop_btn.config(state=tk.DISABLED)
        elif bot_name == 'youtube':
            self.youtube_start_btn.config(state=tk.NORMAL)
            self.youtube_stop_btn.config(state=tk.DISABLED)
        elif bot_name == 'live':
            self.live_start_btn.config(state=tk.NORMAL)
            self.live_stop_btn.config(state=tk.DISABLED)
    
    def stop_bot(self, bot_name: str):
        """Stop specific bot"""
        if bot_name in self.active_bots:
            bot = self.active_bots[bot_name]
            if hasattr(bot, 'running'):
                bot.running = False
            if hasattr(bot, 'disconnect'):
                try:
                    bot.disconnect()
                except:
                    pass
            
            self.log(f"Stopping {bot_name} bot...", "INFO")
            self.on_bot_finished(bot_name)
    
    def start_all_bots(self):
        """Start all configured bots"""
        # Check which bots have configurations
        bots_to_start = []
        
        if self.website_url.get():
            bots_to_start.append(('website', self.start_website_bot))
        if self.youtube_input.get():
            bots_to_start.append(('youtube', self.start_youtube_bot))
        if self.live_url.get():
            bots_to_start.append(('live', self.start_live_bot))
        
        if not bots_to_start:
            messagebox.showinfo("Info", "No bots configured to start")
            return
        
        for bot_name, start_func in bots_to_start:
            start_func()
            time.sleep(1)  # Small delay between starting bots
        
        self.log(f"Started {len(bots_to_start)} bot(s)", "SUCCESS")
    
    def stop_all_bots(self):
        """Stop all running bots"""
        for bot_name in list(self.active_bots.keys()):
            self.stop_bot(bot_name)
        
        self.log("All bots stopped", "INFO")
    
    def clear_logs(self):
        """Clear log area"""
        self.log_area.delete(1.0, tk.END)
        self.log("Logs cleared", "INFO")
    
    def save_logs(self):
        """Save logs to file"""
        try:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"bot_logs_{timestamp}.txt"
            
            with open(filename, 'w', encoding='utf-8') as f:
                f.write(self.log_area.get(1.0, tk.END))
            
            self.log(f"Logs saved to {filename}", "SUCCESS")
        except Exception as e:
            self.log(f"Error saving logs: {str(e)}", "ERROR")
    
    def save_settings(self):
        """Save settings to file"""
        settings = {
            'proxy_http': self.proxy_http.get(),
            'proxy_https': self.proxy_https.get(),
            'ua_random': self.ua_random.get(),
            'ua_custom': self.ua_custom.get()
        }
        
        try:
            with open('bot_settings.json', 'w') as f:
                json.dump(settings, f, indent=2)
            self.log("Settings saved successfully", "SUCCESS")
        except Exception as e:
            self.log(f"Error saving settings: {str(e)}", "ERROR")
    
    def load_settings(self):
        """Load settings from file"""
        try:
            if os.path.exists('bot_settings.json'):
                with open('bot_settings.json', 'r') as f:
                    settings = json.load(f)
                
                self.proxy_http.insert(0, settings.get('proxy_http', ''))
                self.proxy_https.insert(0, settings.get('proxy_https', ''))
                self.ua_random.set(settings.get('ua_random', True))
                self.ua_custom.insert(0, settings.get('ua_custom', ''))
              
                self.youtube_input.insert(0, settings.get('youtube_input', 'https://www.youtube.com/shorts/JI7VsFwCgcw'))
                self.youtube_duration.set(settings.get('view_duration_sec', 120))
                self.youtube_count.set(settings.get('watch_time_min"', 30))
                
                self.log("settings loaded successfully", "INFO")
        except Exception as e:
            self.log(f"Error settings Not Found: {str(e)}", "WARNING")
            
# Bot Implementations
class WebsiteVisitorBot:
    def __init__(self, headless=True):
        self.running = True
        self.headless = headless
        
        chrome_options = Options()
        if headless:
            chrome_options.add_argument("--headless=new")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--disable-blink-features=AutomationControlled")
        chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
        chrome_options.add_experimental_option('useAutomationExtension', False)
        
        # Set random window size
        width = random.randint(1200, 1920)
        height = random.randint(800, 1080)
        chrome_options.add_argument(f"--window-size={width},{height}")
        
        try:
            self.driver = webdriver.Chrome(
                service=Service(ChromeDriverManager().install()),
                options=chrome_options
            )
            self.driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
        except Exception as e:
            logger.error(f"Failed to initialize WebDriver: {e}")
            raise
    
    def visit_website(self, url, duration=30):
        """Visit a website for specified duration"""
        try:
            if not self.running:
                return
            
            logger.info(f"Visiting {url}")
            self.driver.get(url)
            time.sleep(random.randint(3, 7))
            
            # Random mouse movements and scrolling
            scroll_count = random.randint(3, 8)
            for i in range(scroll_count):
                if not self.running:
                    break
                    
                scroll_amount = random.randint(200, 800)
                self.driver.execute_script(f"window.scrollBy(0, {scroll_amount});")
                time.sleep(random.uniform(1.5, 4.5))
            
            # Random clicks on links (if available and safe)
            try:
                links = self.driver.find_elements(By.TAG_NAME, "a")
                if links:
                    safe_links = [link for link in links[:10] if link.is_displayed() and link.is_enabled()]
                    if safe_links:
                        link = random.choice(safe_links)
                        href = link.get_attribute('href')
                        if href and not href.startswith(('javascript:', 'mailto:', 'tel:')):
                            link.click()
                            time.sleep(duration // 2)
                            logger.info(f"Clicked on link: {href[:50]}...")
            except:
                pass
            
            # Simulate reading time
            remaining_time = duration - (scroll_count * 2)
            if remaining_time > 0:
                time.sleep(remaining_time)
            
            logger.info(f"Finished visiting {url}")
            
        except Exception as e:
            logger.error(f"Error visiting {url}: {e}")
            raise
    
    def close(self):
        """Cleanup resources"""
        self.running = False
        try:
            if hasattr(self, 'driver'):
                self.driver.quit()
        except:
            pass

class YouTubeViewBot:
    def __init__(self):
        self.ua = UserAgent()
        self.session = requests.Session()
        self.running = True
        
        # Configure session
        self.session.headers.update({
            'Accept-Language': 'en-US,en;q=0.9',
            'Accept-Encoding': 'gzip, deflate',
            'DNT': '1',
            'Connection': 'keep-alive',
            'Upgrade-Insecure-Requests': '1'
        })
    
    def get_video_info(self, video_url):
        """Extract video information"""
        headers = {'User-Agent': self.ua.random}
        response = self.session.get(video_url, headers=headers)
        soup = BeautifulSoup(response.content, 'html.parser')
        
        title = soup.find('title').text
        return {'title': title.replace(' - YouTube', '').strip()}
    
    def simulate_view(self, video_url, watch_time=30, views=1):
        """Simulate video views"""
        if not self.running:
            return
            
        for i in range(views):
            try:
                if not self.running:
                    break
                    
                headers = {'User-Agent': self.ua.random}
                response = self.session.get(video_url, headers=headers, timeout=10)
                
                if response.status_code == 200:
                    info = self.get_video_info(video_url)
                    logger.info(f"View {i+1}: Watching '{info['title']}'")
                    
                    # Simulate progressive watch time
                    segments = random.randint(3, 6)
                    segment_time = watch_time // segments
                    
                    for seg in range(segments):
                        if not self.running:
                            break
                        time.sleep(segment_time)
                        
                        # Random actions during watching
                        if random.random() > 0.7:  # 30% chance
                            action = random.choice(['pause', 'seek_forward', 'seek_backward'])
                            logger.debug(f"  Action: {action}")
                else:
                    logger.warning(f"View {i+1}: Failed with status {response.status_code}")
                    
                if i < views - 1:
                    time.sleep(random.randint(5, 15))
                    
            except Exception as e:
                logger.error(f"Error during view {i+1}: {e}")
    
    def search_videos(self, keyword, max_results=10):
        """Search YouTube videos"""
        search_url = f"https://www.youtube.com/results?search_query={keyword}"
        headers = {'User-Agent': self.ua.random}
        
        try:
            response = self.session.get(search_url, headers=headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            videos = []
            for link in soup.find_all('a', href=True):
                href = link['href']
                if '/watch?v=' in href and '&' not in href.split('?')[1]:
                    full_url = f"https://www.youtube.com{href}"
                    if full_url not in videos:
                        videos.append(full_url)
                        if len(videos) >= max_results:
                            break
            
            logger.info(f"Found {len(videos)} videos for search: '{keyword}'")
            return videos
            
        except Exception as e:
            logger.error(f"Error searching videos: {e}")
            return []

class SocialMediaLiveBot:
    def __init__(self, platform="generic"):
        self.platform = platform
        self.running = True
        self.session = requests.Session()
        self.interaction_types = ['like', 'comment', 'reaction']
        self.intensity = 'medium'
        
        # Configure intensity settings
        self.intensity_settings = {
            'low': {'delay_min': 20, 'delay_max': 40, 'chance': 0.3},
            'medium': {'delay_min': 10, 'delay_max': 25, 'chance': 0.6},
            'high': {'delay_min': 5, 'delay_max': 15, 'chance': 0.8}
        }
    
    def simulate_live_engagement(self, live_id: str, duration: int = 300):
        """Simulate engagement in a live stream"""
        start_time = time.time()
        engagement_count = 0
        
        logger.info(f"Starting {self.platform} live engagement for: {live_id}")
        logger.info(f"Duration: {duration} seconds | Intensity: {self.intensity}")
        
        intensity_config = self.intensity_settings.get(self.intensity, self.intensity_settings['medium'])
        
        while time.time() - start_time < duration and self.running:
            try:
                # Determine if we should engage based on chance
                if random.random() > intensity_config['chance']:
                    delay = random.uniform(intensity_config['delay_min'], intensity_config['delay_max'])
                    time.sleep(delay)
                    continue
                
                # Select interaction type
                available_types = [t for t in self.interaction_types if t in ['like', 'comment', 'reaction', 'share']]
                if not available_types:
                    available_types = ['like', 'comment']
                
                engagement_type = random.choice(available_types)
                
                # Execute engagement
                if engagement_type == 'like':
                    success = self.send_like(live_id)
                elif engagement_type == 'comment':
                    success = self.send_comment(live_id)
                elif engagement_type == 'share':
                    success = self.send_share(live_id)
                elif engagement_type == 'reaction':
                    success = self.send_reaction(live_id)
                else:
                    success = False
                
                if success:
                    engagement_count += 1
                    logger.debug(f"Sent {engagement_type} to {live_id}")
                
                # Random delay between engagements
                delay = random.uniform(intensity_config['delay_min'], intensity_config['delay_max'])
                time.sleep(delay)
                
            except Exception as e:
                logger.error(f"Engagement error: {e}")
                time.sleep(10)
        
        logger.info(f"Engagement completed. Total actions: {engagement_count}")
        return engagement_count
    
    def send_like(self, live_id: str):
        """Send a like to the live stream"""
        try:
            # Simulate API call
            time.sleep(random.uniform(0.5, 1.5))
            return True
        except:
            return False
    
    def send_comment(self, live_id: str):
        """Send a comment to the live stream"""
        comments = {
            'generic': [
                "Great stream!", "Love this content!", "Can you explain that again?",
                "Awesome!", "Thanks for the info!", "🔥🔥🔥", "This is amazing!",
                "Keep it up!", "What's next?", "I learned so much!"
            ],
            'gaming': [
                "Nice play!", "GG!", "That was epic!", "Clutch!",
                "What's your rank?", "Can you show your settings?", "Sick move!"
            ],
            'educational': [
                "Great explanation!", "Very informative!", "Can you go more in-depth?",
                "Thanks for sharing!", "This helps a lot!", "Clear and concise!"
            ]
        }
        
        try:
            # Select comment based on context
            category = random.choice(['generic', 'gaming', 'educational'])
            comment = random.choice(comments[category])
            
            # Simulate typing delay
            typing_delay = len(comment) * 0.05
            time.sleep(typing_delay + random.uniform(0.5, 1.0))
            
            logger.debug(f"Commented: {comment}")
            return True
        except:
            return False
    
    def send_share(self, live_id: str):
        """Share the live stream"""
        try:
            time.sleep(random.uniform(1.0, 2.0))
            logger.debug(f"Shared stream: {live_id}")
            return True
        except:
            return False
    
    def send_reaction(self, live_id: str):
        """Send a reaction (emoji)"""
        reactions = ['❤️', '😂', '😮', '😢', '👏', '🔥', '🎉', '👍', '🤔', '💯']
        reaction = random.choice(reactions)
        
        try:
            time.sleep(random.uniform(0.3, 0.8))
            logger.debug(f"Reacted with: {reaction}")
            return True
        except:
            return False
    
    def disconnect(self):
        """Disconnect from stream"""
        self.running = False

# Main application
if __name__ == "__main__":
    root = tk.Tk()
    
    # Set application icon and title
    root.iconbitmap()  # Add icon path if available
    
    app = BotManagerGUI(root)
    
    # Load saved settings
    app.load_settings()
        
    # Handle window close
    def on_closing():
        app.stop_all_bots()
        root.destroy()
    
    root.protocol("WM_DELETE_WINDOW", on_closing)
    root.mainloop()
