from selenium import webdriver

desiredCapabilities={
    "browserName":"chrome"
}

driver = webdriver.Remote(command_executor='http://10.0.0.2:4444/wd/hub',desired_capabilities = desiredCapabilities)
driver.get("https://www.google.co.in/")
print(driver.title)
driver.quit()