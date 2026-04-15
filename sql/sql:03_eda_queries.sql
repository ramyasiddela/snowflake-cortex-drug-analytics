{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red108\green0\blue181;\red0\green0\blue0;\red32\green36\blue45;
\red91\green98\blue116;\red4\green57\blue181;\red16\green19\blue24;\red14\green110\blue109;}
{\*\expandedcolortbl;;\cssrgb\c50588\c0\c76078;\cssrgb\c0\c0\c0;\cssrgb\c16863\c18824\c23137;
\cssrgb\c43137\c46275\c52941;\cssrgb\c0\c31765\c76078;\cssrgb\c7843\c9412\c12157;\cssrgb\c0\c50196\c50196;}
\margl1440\margr1440\vieww33660\viewh19760\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs48 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 DATABASE\cf0 \strokec3  HEALTHCARE_AI_DB\cf4 \strokec4 ;\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf2 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 SCHEMA\cf0 \strokec3  DRUG_ANALYTICS\cf4 \strokec4 ;\
\cf0 \strokec3  \cf2 \strokec2 USE\cf0 \strokec3  WAREHOUSE CORTEX_WH\cf4 \strokec4 ;\
\cf0 \strokec3  \cf5 \strokec5 -- 1. Basic stats\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf6 \strokec6 COUNT\cf4 \strokec4 (\cf7 \strokec7 *\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  TOTAL_REVIEWS\cf4 \strokec4 ,\cf0 \strokec3  \
\cf6 \strokec6 COUNT\cf4 \strokec4 (\cf2 \strokec2 DISTINCT\cf0 \strokec3  DRUG_NAME\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  UNIQUE_DRUGS\cf4 \strokec4 ,\cf0 \strokec3  \
\cf6 \strokec6 COUNT\cf4 \strokec4 (\cf2 \strokec2 DISTINCT\cf0 \strokec3  CONDITION\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  UNIQUE_CONDITIONS\cf4 \strokec4 ,\cf0 \strokec3  \
\cf6 \strokec6 ROUND\cf4 \strokec4 (\cf6 \strokec6 AVG\cf4 \strokec4 (\cf0 \strokec3 RATING\cf4 \strokec4 ),\cf0 \strokec3  \cf8 \strokec8 2\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
\cf6 \strokec6 MIN\cf4 \strokec4 (\cf0 \strokec3 RATING\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  MIN_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
\cf6 \strokec6 MAX\cf4 \strokec4 (\cf0 \strokec3 RATING\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  MAX_RATING\cf4 \strokec4 ,\cf0 \strokec3  \
\cf6 \strokec6 ROUND\cf4 \strokec4 (\cf6 \strokec6 AVG\cf4 \strokec4 (\cf0 \strokec3 LENGTH\cf4 \strokec4 (\cf0 \strokec3 REVIEW\cf4 \strokec4 )),\cf0 \strokec3  \cf8 \strokec8 0\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_REVIEW_LENGTH_CHARS \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 FROM\cf0 \strokec3  RAW_DRUG_REVIEWS\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- 2. Top 10 most reviewed drugs\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  \
DRUG_NAME\cf4 \strokec4 ,\cf0 \strokec3  \cf6 \strokec6 COUNT\cf4 \strokec4 (\cf7 \strokec7 *\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  REVIEW_COUNT\cf4 \strokec4 ,\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf6 \strokec6 ROUND\cf4 \strokec4 (\cf6 \strokec6 AVG\cf4 \strokec4 (\cf0 \strokec3 RATING\cf4 \strokec4 ),\cf8 \strokec8 2\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  AVG_RATING \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 FROM\cf0 \strokec3  RAW_DRUG_REVIEWS \
\cf2 \strokec2 GROUP\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  DRUG_NAME\
\cf2 \strokec2 ORDER\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  REVIEW_COUNT \
\cf2 \strokec2 DESC\cf0 \strokec3  \cf2 \strokec2 LIMIT\cf0 \strokec3  \cf8 \strokec8 10\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- 3. Top 10 medical conditions\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  CONDITION\cf4 \strokec4 ,\cf0 \strokec3  \cf6 \strokec6 COUNT\cf4 \strokec4 (\cf7 \strokec7 *\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  REVIEW_COUNT \cf2 \strokec2 FROM\cf0 \strokec3  RAW_DRUG_REVIEWS \
\cf2 \strokec2 WHERE\cf0 \strokec3  CONDITION \cf7 \strokec7 IS\cf0 \strokec3  \cf7 \strokec7 NOT\cf0 \strokec3  \cf8 \strokec8 NULL\cf0 \strokec3  \
\cf2 \strokec2 GROUP\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  CONDITION \
\cf2 \strokec2 ORDER\cf0 \strokec3  \cf2 \strokec2 BY\cf0 \strokec3  REVIEW_COUNT \cf2 \strokec2 DESC\cf0 \strokec3  \cf2 \strokec2 LIMIT\cf0 \strokec3  \cf8 \strokec8 10\cf4 \strokec4 ;}