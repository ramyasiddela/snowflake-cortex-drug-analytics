{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;\f1\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red108\green0\blue181;\red0\green0\blue0;\red32\green36\blue45;
\red91\green98\blue116;\red16\green19\blue24;\red15\green112\blue1;\red14\green110\blue109;}
{\*\expandedcolortbl;;\cssrgb\c50588\c0\c76078;\cssrgb\c0\c0\c0;\cssrgb\c16863\c18824\c23137;
\cssrgb\c43137\c46275\c52941;\cssrgb\c7843\c9412\c12157;\cssrgb\c0\c50196\c0;\cssrgb\c0\c50196\c50196;}
\margl1440\margr1440\vieww33660\viewh21120\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs48 \cf2 \expnd0\expndtw0\kerning0
USE\cf3  \cf2 DATABASE\cf3  HEALTHCARE_AI_DB\cf4 ;\cf3 \
\'a0\cf2 USE\cf3  \cf2 SCHEMA\cf3  DRUG_ANALYTICS\cf4 ;\cf3  \
\cf2 USE\cf3  WAREHOUSE CORTEX_WH\cf4 ;\cf3 \
\'a0\cf5 -- Generate structured clinical insight reports\cf3  \
\cf2 CREATE\cf3  \cf6 OR\cf3  \cf2 REPLACE\cf3  \cf2 TABLE\cf3  DRUG_CLINICAL_INSIGHTS \cf2 AS\cf3  \
\cf2 SELECT\cf3  \
DRUG_NAME\cf4 ,\cf3  \
CONDITION\cf4 ,\cf3  \
REVIEW_COUNT\cf4 ,\cf3  \
AVG_RATING\cf4 ,\cf3 \
\'a0AVG_SENTIMENT\cf4 ,\cf3  \
AI_SUMMARY\cf4 ,\cf3  \
SNOWFLAKE\cf4 .\cf3 CORTEX\cf4 .\cf3 COMPLETE\cf4 (\cf3  \cf7 'claude-sonnet-4-5'\cf4 ,\cf3  \
CONCAT\cf4 (\cf3  \cf7 'You are a clinical pharmacist AI assistant. '\cf4 ,\cf3  \cf7 'Analyze the following patient review summary for the drug '\cf4 ,\cf3  DRUG_NAME\cf4 ,\cf3  \cf7 ' prescribed for '\cf4 ,\cf3  CONDITION\cf4 ,\cf3  \cf7 '. '\cf4 ,\cf3  \cf7 'Patient review summary: '\cf4 ,\cf3  AI_SUMMARY\cf4 ,\cf3  \cf7 ' '\cf4 ,\cf3  \cf7 'Average patient rating: '\cf4 ,\cf3  AVG_RATING::\cf2 VARCHAR\cf4 ,\cf3  \cf7 ' out of 10. '\cf4 ,\cf3  \cf7 'Provide a structured clinical insight with these sections: '\cf4 ,\cf3  \cf7 '1. EFFICACY: How effective is this drug per patient experience? '\cf4 ,\cf3  \cf7 '2. SIDE EFFECTS: What side effects are patients commonly reporting? '\cf4 ,\cf3  \cf7 '3. PATIENT SATISFACTION: What drives satisfaction or dissatisfaction? '\cf4 ,\cf3  \cf7 '4. CLINICAL RECOMMENDATION: Would you recommend this drug? '\cf4 ,\cf3  \cf7 'Keep each section to 2 sentences. Be factual and clinical in tone.'\cf3  \cf4 )\cf3  \
\cf4 )\cf3  \
\cf2 AS\cf3  CLINICAL_INSIGHT_REPORT \
\cf2 FROM\cf3  DRUG_AI_SUMMARIES \
\cf2 WHERE\cf3  REVIEW_COUNT \cf6 >=\cf3  \cf8 20\cf3  \
\cf2 LIMIT\cf3  \cf8 100\cf4 ;\cf3  \
\cf5 -- View results\cf3  \
\cf2 SELECT\cf3  \
DRUG_NAME\cf4 ,\cf3  \
CONDITION\cf4 ,\cf3  \
AVG_RATING\cf4 ,\cf3  \
CLINICAL_INSIGHT_REPORT \cf2 FROM\cf3  DRUG_CLINICAL_INSIGHTS \
\cf2 ORDER\cf3  \cf2 BY\cf3  AVG_RATING \
\cf2 DESC\cf3  \
\cf2 LIMIT\cf3  \cf8 10\cf4 ;
\f1\fs32 \cf3 \
}