# 💊 Clinical Drug Intelligence Platform
### End-to-End Healthcare Analytics using Snowflake Cortex LLM & AI

![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=flat&logo=streamlit&logoColor=white)

---

## 🔍 Project Overview
An end-to-end healthcare analytics platform analyzing **215,000+ real patient 
drug reviews** using Snowflake Cortex AI LLM functions — entirely inside 
Snowflake with no external ML infrastructure.

## 📊 Dataset
- **Source:** UCI Drug Review Dataset (Drugs.com) — Kaggle
- **License:** CC BY 4.0
- **Size:** 215,063 patient reviews
- **Link:** kaggle.com/datasets/jessicali9530/kuc-hackathon-winter-2018

## ⚙️ Tech Stack
| Layer | Technology |
|---|---|
| Cloud Platform | Snowflake |
| AI / LLM Engine | Snowflake Cortex AI |
| LLM Functions | SENTIMENT · SUMMARIZE · COMPLETE |
| Visualization | Streamlit in Snowflake |
| Language | SQL + Python |
| Dataset | UCI Drug Review (Kaggle) |

## 🚀 Key Features
- **Sentiment Analysis** — CORTEX.SENTIMENT() on 215K reviews in one SQL query
- **AI Summaries** — CORTEX.SUMMARIZE() per drug-condition pair
- **Clinical Insights** — CORTEX.COMPLETE() generates structured clinical reports
- **Drug Comparison** — Head-to-head AI analysis of any two drugs
- **AI Chat Interface** — Ask anything about the dataset in natural language
- **6-Tab Dashboard** — Built natively in Streamlit in Snowflake

## 📈 Results
- Pearson Correlation (AI Sentiment vs Human Rating): **r = 0.75+**
- 215K records sentiment-scored in under 3 minutes
- Built as a portfolio project on public healthcare data

## 📂 Project Structure
snowflake-cortex-drug-analytics/
├── sql/
│   ├── 01_setup_database.sql
│   ├── 02_load_data.sql
│   ├── 03_eda_queries.sql
│   ├── 04_cortex_sentiment.sql
│   ├── 05_cortex_summarize.sql
│   └── 06_cortex_complete.sql
├── streamlit/
│   └── drug_dashboard.py
├── screenshots/
│   └── [dashboard screenshots]
├── data/
│   └── sample_reviews.csv
└── README.md

## ▶️ How to Run
1. Create a free Snowflake trial at app.snowflake.com
2. Download the dataset from Kaggle (link above)
3. Run SQL scripts in order from sql/ folder (01 → 06)
4. Deploy drug_dashboard.py via Streamlit in Snowflake

## ⚠️ Disclaimer
Built as a portfolio/learning project to demonstrate real-world 
application of Snowflake Cortex AI on public healthcare data. 
Not intended for actual clinical use.
