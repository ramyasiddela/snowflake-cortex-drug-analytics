{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red108\green0\blue181;\red0\green0\blue0;\red32\green36\blue45;
\red91\green98\blue116;\red16\green19\blue24;\red4\green57\blue181;\red14\green110\blue109;\red15\green112\blue1;
}
{\*\expandedcolortbl;;\cssrgb\c50588\c0\c76078;\cssrgb\c0\c0\c0;\cssrgb\c16863\c18824\c23137;
\cssrgb\c43137\c46275\c52941;\cssrgb\c7843\c9412\c12157;\cssrgb\c0\c31765\c76078;\cssrgb\c0\c50196\c50196;\cssrgb\c0\c50196\c0;
}
\margl1440\margr1440\vieww33660\viewh21120\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs48 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 DATABASE\cf0 \strokec3  HEALTHCARE_AI_DB\cf4 \strokec4 ;\cf0 \strokec3  \
\cf2 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 SCHEMA\cf0 \strokec3  DRUG_ANALYTICS\cf4 \strokec4 ;\cf0 \strokec3  \
\cf2 \strokec2 USE\cf0 \strokec3  WAREHOUSE CORTEX_WH\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 1: Aggregate reviews per drug-condition pair\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf2 \strokec2 CREATE\cf0 \strokec3  \cf6 \strokec6 OR\cf0 \strokec3  \cf2 \strokec2 REPLACE\cf0 \strokec3  \cf2 \strokec2 TABLE\cf0 \strokec3  DRUG_CONDITION_AGGREGATED \cf2 \strokec2 AS\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  \
DRUG_NAME\cf4 \strokec4 ,\cf0 \strokec3  \
CONDITION\cf4 \strokec4 ,\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf7 \strokec7 COUNT\cf4 \strokec4 (\cf6 \strokec6 *\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  REVIEW_COUNT\cf4 \strokec4 ,\cf0 \strokec3  \
\cf7 \strokec7 ROUND\cf4 \strokec4 (\cf7 \strokec7 AVG\cf4 \strokec4 (\cf0 \strokec3 RATING\cf4 \strokec4 ),\cf0 \strokec3  \cf8 \strokec8 2\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
\cf7 \strokec7 ROUND\cf4 \strokec4 (\cf7 \strokec7 AVG\cf4 \strokec4 (\cf0 \strokec3 SENTIMENT_SCORE\cf4 \strokec4 ),\cf0 \strokec3  \cf8 \strokec8 3\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_SENTIMENT\cf4 \strokec4 ,\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 LEFT\cf4 \strokec4 (\cf0 \strokec3  LISTAGG\cf4 \strokec4 (\cf0 \strokec3 REVIEW\cf4 \strokec4 ,\cf0 \strokec3  \cf9 \strokec9 ' | '\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 WITHIN\cf0 \strokec3  \cf2 \strokec2 GROUP\cf0 \strokec3  \cf4 \strokec4 (\cf2 \strokec2 ORDER\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  USEFUL_COUNT \cf2 \strokec2 DESC\cf4 \strokec4 ),\cf0 \strokec3  \cf8 \strokec8 8000\cf0 \strokec3  \cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  COMBINED_REVIEWS \
\cf2 \strokec2 FROM\cf0 \strokec3  DRUG_REVIEWS_WITH_SENTIMENT \
\cf2 \strokec2 WHERE\cf0 \strokec3  CONDITION \cf6 \strokec6 IS\cf0 \strokec3  \cf6 \strokec6 NOT\cf0 \strokec3  \cf8 \strokec8 NULL\cf0 \strokec3  \
\cf2 \strokec2 GROUP\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  DRUG_NAME\cf4 \strokec4 ,\cf0 \strokec3  \
CONDITION \cf2 \strokec2 HAVING\cf0 \strokec3  \cf7 \strokec7 COUNT\cf4 \strokec4 (\cf6 \strokec6 *\cf4 \strokec4 )\cf0 \strokec3  \cf6 \strokec6 >=\cf0 \strokec3  \cf8 \strokec8 10\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 2: Generate AI summaries using Cortex SUMMARIZE\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 CREATE\cf0 \strokec3  \cf6 \strokec6 OR\cf0 \strokec3  \cf2 \strokec2 REPLACE\cf0 \strokec3  \cf2 \strokec2 TABLE\cf0 \strokec3  DRUG_AI_SUMMARIES \cf2 \strokec2 AS\cf0 \strokec3  \
\cf2 \strokec2 SELECT\cf0 \strokec3  \
DRUG_NAME\cf4 \strokec4 ,\cf0 \strokec3  \
CONDITION\cf4 \strokec4 ,\cf0 \strokec3  \
REVIEW_COUNT\cf4 \strokec4 ,\cf0 \strokec3  \
AVG_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
AVG_SENTIMENT\cf4 \strokec4 ,\cf0 \strokec3  \
SNOWFLAKE\cf4 \strokec4 .\cf0 \strokec3 CORTEX\cf4 \strokec4 .\cf0 \strokec3 SUMMARIZE\cf4 \strokec4 (\cf0 \strokec3 COMBINED_REVIEWS\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AI_SUMMARY \
\cf2 \strokec2 FROM\cf0 \strokec3  DRUG_CONDITION_AGGREGATED \
\cf2 \strokec2 LIMIT\cf0 \strokec3  \cf8 \strokec8 500\cf4 \strokec4 ;\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf5 \strokec5 -- Step 3: View top rated drugs with AI summaries\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  \
DRUG_NAME\cf4 \strokec4 ,\cf0 \strokec3  \
CONDITION\cf4 \strokec4 ,\cf0 \strokec3  \
REVIEW_COUNT\cf4 \strokec4 ,\cf0 \strokec3  \
AVG_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
AI_SUMMARY \cf2 \strokec2 FROM\cf0 \strokec3  DRUG_AI_SUMMARIES\
 \cf2 \strokec2 WHERE\cf0 \strokec3  AVG_RATING \cf6 \strokec6 >=\cf0 \strokec3  \cf8 \strokec8 8\cf0 \strokec3  \
\cf2 \strokec2 ORDER\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  REVIEW_COUNT \cf2 \strokec2 DESC\cf0 \strokec3  \
\cf2 \strokec2 LIMIT\cf0 \strokec3  \cf8 \strokec8 10\cf4 \strokec4 ;}