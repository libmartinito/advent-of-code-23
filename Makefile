download:
	ruby scripts/download_input.rb $(day)

run:
	ruby solutions/day-$(day).rb $(part)

