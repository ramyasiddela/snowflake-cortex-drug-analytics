{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red108\green0\blue181;\red0\green0\blue0;\red32\green36\blue45;
\red91\green98\blue116;\red16\green19\blue24;\red14\green110\blue109;\red15\green112\blue1;\red4\green57\blue181;
}
{\*\expandedcolortbl;;\cssrgb\c50588\c0\c76078;\cssrgb\c0\c0\c0;\cssrgb\c16863\c18824\c23137;
\cssrgb\c43137\c46275\c52941;\cssrgb\c7843\c9412\c12157;\cssrgb\c0\c50196\c50196;\cssrgb\c0\c50196\c0;\cssrgb\c0\c31765\c76078;
}
\margl1440\margr1440\vieww33660\viewh17680\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs48 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 DATABASE\cf0 \strokec3  HEALTHCARE_AI_DB\cf4 \strokec4 ;\cf0 \strokec3  \
\cf2 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 SCHEMA\cf0 \strokec3  DRUG_ANALYTICS\cf4 \strokec4 ;\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf2 \strokec2 USE\cf0 \strokec3  WAREHOUSE CORTEX_WH\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 1: Create sentiment-enriched table\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 CREATE\cf0 \strokec3  \cf6 \strokec6 OR\cf0 \strokec3  \cf2 \strokec2 REPLACE\cf0 \strokec3  \cf2 \strokec2 TABLE\cf0 \strokec3  DRUG_REVIEWS_WITH_SENTIMENT \
\cf2 \strokec2 AS\cf0 \strokec3  \cf2 \strokec2 SELECT\cf0 \strokec3  \
UNIQUE_ID\cf4 \strokec4 ,\cf0 \strokec3  \
DRUG_NAME\cf4 \strokec4 ,\cf0 \strokec3  \
CONDITION\cf4 \strokec4 ,\cf0 \strokec3  \
REVIEW\cf4 \strokec4 ,\cf0 \strokec3  \
RATING\cf4 \strokec4 ,\cf0 \strokec3  \
REVIEW_DATE\cf4 \strokec4 ,\cf0 \strokec3  \
USEFUL_COUNT\cf4 \strokec4 ,\cf0 \strokec3  \
SNOWFLAKE\cf4 \strokec4 .\cf0 \strokec3 CORTEX\cf4 \strokec4 .\cf0 \strokec3 SENTIMENT\cf4 \strokec4 (\cf0 \strokec3 REVIEW\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  SENTIMENT_SCORE\cf4 \strokec4 ,\cf0 \strokec3  \
\cf2 \strokec2 CASE\cf0 \strokec3  \
\cf2 \strokec2 WHEN\cf0 \strokec3  SNOWFLAKE\cf4 \strokec4 .\cf0 \strokec3 CORTEX\cf4 \strokec4 .\cf0 \strokec3 SENTIMENT\cf4 \strokec4 (\cf0 \strokec3 REVIEW\cf4 \strokec4 )\cf0 \strokec3  \cf6 \strokec6 >=\cf0 \strokec3  \cf7 \strokec7 0.3\cf0 \strokec3  \cf2 \strokec2 THEN\cf0 \strokec3  \cf8 \strokec8 'POSITIVE'\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf2 \strokec2 WHEN\cf0 \strokec3  SNOWFLAKE\cf4 \strokec4 .\cf0 \strokec3 CORTEX\cf4 \strokec4 .\cf0 \strokec3 SENTIMENT\cf4 \strokec4 (\cf0 \strokec3 REVIEW\cf4 \strokec4 )\cf0 \strokec3  \cf6 \strokec6 <=\cf0 \strokec3  \cf6 \strokec6 -\cf7 \strokec7 0.3\cf0 \strokec3  \cf2 \strokec2 THEN\cf0 \strokec3  \cf8 \strokec8 'NEGATIVE'\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 ELSE\cf0 \strokec3  \cf8 \strokec8 'NEUTRAL'\cf0 \strokec3  \cf2 \strokec2 END\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  SENTIMENT_LABEL\
\cf2 \strokec2 FROM\cf0 \strokec3  RAW_DRUG_REVIEWS \
\cf2 \strokec2 WHERE\cf0 \strokec3  REVIEW \cf6 \strokec6 IS\cf0 \strokec3  \cf6 \strokec6 NOT\cf0 \strokec3  \cf7 \strokec7 NULL\cf0 \strokec3  \cf6 \strokec6 AND\cf0 \strokec3  LENGTH\cf4 \strokec4 (\cf0 \strokec3 REVIEW\cf4 \strokec4 )\cf0 \strokec3  \cf6 \strokec6 >\cf0 \strokec3  \cf7 \strokec7 20\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 2: Validate sentiment vs patient rating\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  \
SENTIMENT_LABEL\cf4 \strokec4 ,\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf9 \strokec9 COUNT\cf4 \strokec4 (\cf6 \strokec6 *\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  REVIEW_COUNT\cf4 \strokec4 ,\cf0 \strokec3  \
\cf9 \strokec9 ROUND\cf4 \strokec4 (\cf9 \strokec9 AVG\cf4 \strokec4 (\cf0 \strokec3 RATING\cf4 \strokec4 ),\cf7 \strokec7 2\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_PATIENT_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
\cf9 \strokec9 ROUND\cf4 \strokec4 (\cf9 \strokec9 AVG\cf4 \strokec4 (\cf0 \strokec3 SENTIMENT_SCORE\cf4 \strokec4 ),\cf7 \strokec7 3\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_SENTIMENT_SCORE \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 FROM\cf0 \strokec3  DRUG_REVIEWS_WITH_SENTIMENT \
\cf2 \strokec2 GROUP\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  SENTIMENT_LABEL \
\cf2 \strokec2 ORDER\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  AVG_PATIENT_RATING \cf2 \strokec2 DESC\cf4 \strokec4 ;}