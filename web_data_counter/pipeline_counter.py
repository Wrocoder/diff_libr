from collections import Counter

import nltk
import pandas as pd
import requests
from bs4 import BeautifulSoup
from nltk.corpus import stopwords

nltk.download('stopwords')


class WebScraper:
    def __init__(self, url):
        self.url = url

    def extract_article_text(self):
        response = requests.get(self.url)
        html_content = response.content
        soup = BeautifulSoup(html_content, "html.parser")
        article_text = soup.get_text()
        return article_text


class TextProcessor:
    def __init__(self, nltk_stopwords):
        self.nltk_stopwords = nltk_stopwords

    def tokenize_and_clean(self, text):
        words = text.split()
        filtered_words = [word.lower() for word in words if word.isalpha() and word.lower() not in self.nltk_stopwords]
        return filtered_words


class ETLPipeline:
    def __init__(self, url):
        self.url = url
        # self.nltk_stopwords = set(stopwords.words("english"))
        self.nltk_stopwords = set(stopwords.words("russian"))

    def run(self):
        scraper = WebScraper(self.url)
        article_text = scraper.extract_article_text()

        processor = TextProcessor(self.nltk_stopwords)
        filtered_words = processor.tokenize_and_clean(article_text)

        word_freq = Counter(filtered_words)
        df = pd.DataFrame(word_freq.items(), columns=["Words", "Frequencies"])
        df = df.sort_values(by="Frequencies", ascending=False)
        return df


if __name__ == "__main__":
    # article_url = "https://github.com/OBenner/data-engineering-interview-questions/blob/master/content/data-structure.md"
    article_url = 'https://dokumen.pub/python-python-9785907114418.html'
    pipeline = ETLPipeline(article_url)
    result_df = pipeline.run()
    print(result_df)
