cd scripts
batch_size=12
num_epochs=8
seed=1525

uv run train_evaluator.py \
--train_file ../data/popqa/train_popqa.txt \
--save_path eval_path --batch_size $batch_size \
--num_epochs $num_epochs --seed $seed
