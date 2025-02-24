#!/bin/sh

cd scripts

dataset=popqa
python CRAG_Inference.py \
--generator_path selfrag_llama \
--evaluator_path t5-large \
--input_file ../data/$dataset/test_$dataset.txt \
--output_file ../data/$dataset/output/crag \
--internal_knowledge_path ../data/$dataset/ref/correct \
--external_knowledge_path ../data/$dataset/ref/incorrect \
--combined_knowledge_path ../data/$dataset/ref/ambiguous \
--task $dataset --method crag --device cpu:0 \
--ndocs 10 --batch_size 8 --upper_threshold 0.592 --lower_threshold 0.995
