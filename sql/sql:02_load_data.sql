{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red108\green0\blue181;\red0\green0\blue0;\red32\green36\blue45;
\red91\green98\blue116;\red16\green19\blue24;\red15\green112\blue1;\red14\green110\blue109;\red162\green55\blue4;
\red4\green57\blue181;}
{\*\expandedcolortbl;;\cssrgb\c50588\c0\c76078;\cssrgb\c0\c0\c0;\cssrgb\c16863\c18824\c23137;
\cssrgb\c43137\c46275\c52941;\cssrgb\c7843\c9412\c12157;\cssrgb\c0\c50196\c0;\cssrgb\c0\c50196\c50196;\cssrgb\c70196\c29020\c0;
\cssrgb\c0\c31765\c76078;}
\margl1440\margr1440\vieww33660\viewh21120\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs48 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 DATABASE\cf0 \strokec3  HEALTHCARE_AI_DB\cf4 \strokec4 ;\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf2 \strokec2 USE\cf0 \strokec3  \cf2 \strokec2 SCHEMA\cf0 \strokec3  DRUG_ANALYTICS\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 USE\cf0 \strokec3  WAREHOUSE CORTEX_WH\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 1: Create Internal Stage\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 CREATE\cf0 \strokec3  \cf6 \strokec6 OR\cf0 \strokec3  \cf2 \strokec2 REPLACE\cf0 \strokec3  STAGE DRUG_REVIEWS_STAGE \
FILE_FORMAT \cf6 \strokec6 =\cf0 \strokec3  \cf4 \strokec4 (\cf0 \strokec3  \
\cf2 \strokec2 TYPE\cf0 \strokec3  \cf6 \strokec6 =\cf0 \strokec3  \cf7 \strokec7 'CSV'\cf0 \strokec3  \
FIELD_DELIMITER \cf6 \strokec6 =\cf0 \strokec3  \cf7 \strokec7 ','\cf0 \strokec3  \
SKIP_HEADER \cf6 \strokec6 =\cf0 \strokec3  \cf8 \strokec8 1\cf0 \strokec3  \
FIELD_OPTIONALLY_ENCLOSED_BY \cf6 \strokec6 =\cf0 \strokec3  \cf7 \strokec7 '"'\cf0 \strokec3  \
NULL_IF \cf6 \strokec6 =\cf0 \strokec3  \cf4 \strokec4 (\cf7 \strokec7 'NULL'\cf4 \strokec4 ,\cf0 \strokec3  \cf7 \strokec7 'null'\cf4 \strokec4 ,\cf0 \strokec3  \cf7 \strokec7 ''\cf4 \strokec4 )\cf0 \strokec3  \
EMPTY_FIELD_AS_NULL \cf6 \strokec6 =\cf0 \strokec3  \cf8 \strokec8 TRUE\cf0 \strokec3  \cf4 \strokec4 );\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 2: Upload files via SnowSQL CLI\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf5 \strokec5 -- PUT file://drugsComTrain_raw.csv @DRUG_REVIEWS_STAGE;\
\cf0 \strokec3  \cf5 \strokec5 -- PUT file://drugsComTest_raw.csv @DRUG_REVIEWS_STAGE;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 3: Load staged files into table\cf0 \strokec3  \
COPY \cf2 \strokec2 INTO\cf0 \strokec3  RAW_DRUG_REVIEWS \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 FROM\cf0 \strokec3  \cf9 \strokec9 @DRUG_REVIEWS_STAGE\cf0 \strokec3  \
PATTERN \cf6 \strokec6 =\cf0 \strokec3  \cf7 \strokec7 '.*drugsComTrain.*|.*drugsComTest.*'\cf0 \strokec3  \
ON_ERROR \cf6 \strokec6 =\cf0 \strokec3  \cf7 \strokec7 'CONTINUE'\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -- Step 4: Verify load\
\pard\pardeftab720\partightenfactor0
\cf0 \strokec3  \cf2 \strokec2 SELECT\cf0 \strokec3  \cf10 \strokec10 COUNT\cf4 \strokec4 (\cf6 \strokec6 *\cf4 \strokec4 )\cf0 \strokec3  \cf2 \strokec2 AS\cf0 \strokec3  TOTAL_RECORDS \cf2 \strokec2 FROM\cf0 \strokec3  RAW_DRUG_REVIEWS\cf4 \strokec4 ;\cf0 \strokec3  \
\pard\pardeftab720\partightenfactor0
\cf2 \strokec2 SELECT\cf0 \strokec3  \cf6 \strokec6 *\cf0 \strokec3  \cf2 \strokec2 FROM\cf0 \strokec3  RAW_DRUG_REVIEWS \cf2 \strokec2 LIMIT\cf0 \strokec3  \cf8 \strokec8 5\cf4 \strokec4 ;}