import asyncio
import aiohttp
import aiofiles
from urllib.parse import urljoin, urlparse
from bs4 import BeautifulSoup
import csv
import sys

dead_links_found = False


async def is_internal_link(url, base_url):
    return urlparse(url).netloc == urlparse(base_url).netloc


async def get_links(session, url):
    try:
        async with session.get(url, allow_redirects=True) as response:
            if response.status == 200:
                text = await response.text()
                soup = BeautifulSoup(text, 'html.parser')
                return [link.get('href') for link in soup.find_all('a') if link.get('href')]
            else:
                return []
    except Exception as e:
        return []


async def log_dead_link(origin, link, code):
    async with aiofiles.open('dead_links.csv', 'a', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        await writer.writerow([origin, link, code])
    print(f"(Dead link) {origin} -> {link} ({code})")
    global dead_links_found
    dead_links_found = True  # Indicate a dead link was found


async def validate_and_follow_links(session, url, visited_urls, origin_url=None):
    if url in visited_urls:
        return

    print(f"Checking: {url}")
    visited_urls.add(url)
    links = await get_links(session, url)

    for link in links:
        full_link = urljoin(url, link)
        if full_link not in visited_urls:
            try:
                async with session.get(full_link, allow_redirects=True) as response:
                    if response.status != 200:
                        await log_dead_link(origin_url or url, full_link, response.status)
            except Exception as e:
                await log_dead_link(origin_url or url, full_link, "Failed to connect")

            if await is_internal_link(full_link, url):
                await validate_and_follow_links(session, full_link, visited_urls, origin_url=url)


async def main():
    base_url = "http://localhost:1313"
    visited_urls = set()
    async with aiohttp.ClientSession() as session:
        await validate_and_follow_links(session, base_url, visited_urls)

    global dead_links_found
    if dead_links_found:
        sys.exit(1)  # Exit with code 1 if any dead links were found


if __name__ == "__main__":
    asyncio.run(main())
