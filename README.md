# Knowledge-Graph-for-Source-and-Content-Reliability

This repository contains a demo of a knowledge graph implemented in Neo4j. 
The knowledge graph represents a collection of news articles with associated metadata.
The primary objective is to assess the objectivity of textual information, allowing users to ask questions about text objectivity, retrieve relevant information, and perform advanced analyses.

## Table of Contents
 [Overview](#overview)
 [Dataset](#dataset)
 [Setup](#setup)
 [Graph Structure](#graph-structure)
 [License](#license)

## Overview

Our approach revolves around utilizing knowledge graphs to enhance the capabilities of Language Models (LLMs) by providing structured, semantically rich data.

To create a knowledge graph for measuring the objectivity of textual information, we use outputs from various text analysis APIs in a multi-step process. This includes sentiment analysis, extraction of factual information, clickbait detection, source reputation and bias analysis, creating the knowledge graph, and scoring reliability and trustworthiness of a text. Users can submit queries for objectivity, sentiment analysis results, named entities, clickbait probability, or source reputation assessments. The system will allow filtering, sorting, and cross-referencing data to obtain precise results.

We explore potential real-world use cases where the Knowledge Graph Demo can be applied, including fake news detection, investigative journalism support, scientific research validation, product reviews validation, and legal case precedent evaluation.

## Dataset

The dataset used for this knowledge graph is a collection of news articles sourced from diverse domains and sources. The dataset's structure includes nodes representing articles, authors, publishers, countries, languages, tags, and categories, with relationships capturing associations between these entities. Preprocessing steps involve extracting relevant information from the articles, such as performing sentiment analysis, entity recognition, clickbait detection by using various text analysis APIs. The curated data is then structured and integrated into a knowledge graph for comprehensive analysis. 

## Setup

Setting up the Neo4j database with the knowledge graph data involves several steps, including installing Neo4j, loading the data, and configuring the database. Here's a step-by-step guide:

Step 1: Install Neo4j
Visit the Neo4j Download Page and download the appropriate version of Neo4j for your operating system.
Follow the installation instructions provided for your specific operating system.
Start the Neo4j server.

Step 2: Import the CSV File
Ensure that you have the CSV file SampleKG_7.1.csv containing the knowledge graph data in the "import" directory of your Neo4j installation.

Step 3: Start Neo4j Browser

Step 4: Import Data
In the Neo4j browser, run the Cypher queries to import data from the CSV file.

## Graph Structure

The knowledge graph is designed using Neo4j's property graph model, representing entities as nodes and relationships as edges. Key entities and relationships are identified based on our domain requirements. Properties and data types associated with each node and relationship type in the knowledge graph are defined as the following: 

Article:
Rationale: Represents the core unit of content, including its title, text, and various analytical scores. Essential for understanding the substance of the information.
Properties: Title, Text, Publication Date, Content Quality Score
Relationships: Written by (Author), Published by (Publisher), Belongs to (Topic), Tagged as (Tag), Mentions (Named Entity), Published in (Country), Analyzed for Content Quality (Content Quality Score).

Author:
Rationale: Central to assessing content reliability and potential biases. Understanding an author's background and reputation contributes to evaluating the credibility of the content.
Properties: Name, Reliability Score, Bias Score.
Relationships: Writes (Articles).

Publisher:
Rationale: Publishers play a significant role in shaping editorial policies and content perspectives. Examining the publisher helps discern potential institutional biases.
Properties: Name, Reliability Score.
Relationships: Publishes (Articles).

Topic:
Rationale: Identifies the central theme or subject matter of the content. Crucial for understanding the context and focus of the information.
Properties: Name.
Relationships: Includes (Articles).

Tag:
Rationale: Categorizes content based on its type (e.g., opinion, tweet, analysis). Useful for identifying different content genres and their associated characteristics.
Properties: Type (e.g., Opinion, Tweet, Analysis).
Relationships: Categorizes (Articles).

Named Entity:
Rationale: Entities such as people, organizations, or location play a vital role in content. Understanding their mentions provides insights into contextual relevance.
Properties: Name, Type (Location, Organization, Person).
Relationships: Mentioned in (Articles).

Language:
Properties: Name.
Relationships: Written in (Articles).

Country:
Rationale: Identifying the country of publication provides contextual information. Different countries may have distinct perspectives, influencing content bias.
Properties: Name.
Relationships: Published in (Articles).

Content Quality Score:
Rationale: Aggregate score reflecting clickbait, bias, and objectivity. Provides a quantitative measure of content quality and potential biases.
Properties: Clickbait Score, Bias Score, Objectivity Score.
Relationships: Analyzes (Articles).


<img width="452" alt="image" src="https://github.com/TrustLevel/Knowledge-Graph-for-Source-and-Content-Reliability/assets/80850851/77867a9b-660d-451b-b1c1-5543ca2bd679">


## License


