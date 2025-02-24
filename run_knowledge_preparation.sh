#!/bin/sh
cd scripts
dataset=popqa
OPENAI_KEY=
SEARCH_KEY=
model_path=t5-large

uv run internal_knowledge_preparation.py \
  --model_path $model_path \
  --input_queries ../data/$dataset/sources \
  --input_retrieval ../data/$dataset/retrieved_psgs \
  --decompose_mode selection \
  --output_file ../data/$dataset/ref/correct

uv run external_knowledge_preparation.py \
  --model_path $model_path \
  --input_queries ../data/$dataset/sources \
  --openai_key $OPENAI_KEY \
  --search_key $SEARCH_KEY \
  --task $dataset \
  --output_file ../data/$dataset/ref/incorrect

# --mode wiki \

uv run combined_knowledge_preparation.py \
  --correct_path ../data/$dataset/ref/correct \
  --incorrect_path ../data/$dataset/ref/incorrect \
  --ambiguous_path ../data/$dataset/ref/ambiguous
