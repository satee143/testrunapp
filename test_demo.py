from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
import time
from selenium.webdriver.chrome.options import Options as ChromeOptions


def test_google_c():
    chrome_options =ChromeOptions()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(ChromeDriverManager().install(),options=chrome_options)
    driver.get("https://google.com")
    time.sleep(2)
    title=driver.title
    assert title=='Google'
    driver.close()
