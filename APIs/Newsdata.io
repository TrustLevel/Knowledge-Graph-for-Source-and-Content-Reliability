import json
import boto3
import requests
from neo4j import GraphDatabase

# Neo4j credentials. User and Password is hidden.
NEO4J_URI = "your_neo4j_uri"
NEO4J_USER = "your_neo4j_user"
NEO4J_PASSWORD = "your_neo4j_password"

# Newsdata.io API credentials
NEWSDATA_IO_API_KEY = "your_newsdata_io_api_key"
NEWSDATA_IO_API_ENDPOINT = "https://api.newsdata.io/v1"

def lambda_handler(event, context):
    # Connect to Neo4j database
    driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASSWORD))

    try:
        # Fetch news articles from Newsdata.io API
        news_articles = fetch_news_articles()

        # Process and update Neo4j with news articles
        for article in news_articles:
            processed_data = process_news_article(article)
            update_neo4j(driver, processed_data)

    finally:
        # Close the Neo4j driver
        driver.close()

def fetch_news_articles():
    url = f"{NEWSDATA_IO_API_ENDPOINT}/news?apikey={NEWSDATA_IO_API_KEY}"

    try:
        response = requests.get(url)
        response.raise_for_status()
        news_data = response.json()
        return news_data.get('articles', [])

    except requests.exceptions.RequestException as e:
        print(f"Error fetching news articles: {e}")
        return []

def process_news_article(article):
    # Extract relevant information from the Newsdata.io API response
    title = article.get('title', '')
    text = article.get('description', '')
    language = article.get('language', '')
    country = article.get('country', '')
    # Placeholder for more types

    # Example: Return processed data as a dictionary
    processed_data = {
        'processed_title': title,
        'processed_text': text,
        'language': language,
        'country': country,
    # Placeholder for more types    }

    return processed_data

def update_neo4j(driver, processed_data):
    with driver.session() as session:
        # Extract processed data
        processed_title = processed_data.get('processed_title', '')
        processed_text = processed_data.get('processed_text', '')
        language = processed_data.get('language', '')
        country = processed_data.get('country', '')

        # Execute Cypher queries to update Neo4j
        session.run("""
            MERGE (a:Article {title: $title, text: $text, language: $language, country: $country})
        """, title=processed_title, text=processed_text, language=language, country=country)

        # Create or update related nodes and relationships
        session.run("""
            MERGE (l:Language {name: $language})
            MERGE (c:Country {name: $country})
            MERGE (l)-[:Written_in]->(a)
            MERGE (c)-[:Published_in]->(a)
        """, language=language, country=country)
