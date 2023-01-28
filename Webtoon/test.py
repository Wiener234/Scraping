import requests

r = requests.get(
    'https://www.webtoons.com/de/fantasy/lumine/ep100/viewer?title_no=2847&episode_no=100')

print(r.url)
print(r.cookies)
