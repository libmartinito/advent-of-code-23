download:
	ruby scripts/download_input.rb $(day)

make_files:
	ruby scripts/generate_starting_files.rb $(day)

run:
	ruby solutions/day-$(day).rb $(part)

