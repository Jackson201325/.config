local status_ok, leap = pcall(require, "leap")
if not status_ok then
	print("Leap not op")
	return
end

leap.add_default_mappings()

leap.setup({})
