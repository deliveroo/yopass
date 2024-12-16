# Automate generating and retrieving a test secret from Yopass
# Simulates adding a secret in the form field, submitting the Encrypt Message button
# Retrieve secret from Redis cache by browsing to one-time generated URL and compare input and output match

from playwright.sync_api import sync_playwright, Playwright
from bs4 import BeautifulSoup

# Set test secret
test_secret = 'this is a test secret'

def check_yopass_secret(playwright: Playwright):
    try:
        chromium = playwright.chromium
        browser = chromium.launch(headless=True)
        page = browser.new_page()

        page.goto("http://yopass")
        page.get_by_role("textbox").fill(test_secret)
        page.locator("button:has-text(\"Encrypt Message\")").click()
        page.wait_for_load_state("networkidle")

        # Get the page content
        content = page.content()
        secret_link = BeautifulSoup(content, 'html.parser')
        retrieve_secret_url = secret_link.find('td', text='One-click link').find_next_sibling('td').text
        
        if retrieve_secret_url:
            # Retrieve the secret from Redis and check if it matches the test secret
            secret_page = browser.new_page()
            secret_page.goto(retrieve_secret_url)
            secret_page.wait_for_load_state("networkidle")
            secret_link_content = secret_page.content()
            secret_link = BeautifulSoup(secret_link_content, 'html.parser')
            secret_retrieved = secret_link.find('p', attrs={'data-test-id': 'preformatted-text-secret'}).text
            
            if secret_retrieved == test_secret:
                print("PASS")
            else:
                print("FAIL")
        else:       
            print('URL not found in the response')
    finally:    
        # Close the browser
        browser.close()

with sync_playwright() as playwright:
    check_yopass_secret(playwright)
