#!/bin/python3

import requests
from bs4 import BeautifulSoup
import cloudscraper


print(__name__)

def get_number():
    num = input('Enter Number: ')
    return(num)

if __name__ == '__main__':
    scraper = cloudscraper.CloudScraper()
    r = scraper.get('https://nhentai.net/g/%s/1'%(get_number()))
    print(r)
