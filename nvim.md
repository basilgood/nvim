## 1.1 Messages

Command line: `tiny-cmdline.nvim` (`lua/plugins/ui.lua`) draws the `:` command line as a floating box,
centered horizontally, 20% from the top of the screen.

ui2 message routing is enabled in `lua/plugins/sensible.lua` (`enable_ui2_messages`):
- Short messages: corner popup up to **30%** of the screen tall, gone after 5 seconds.
- Long output (errors, listings like `:ls`, `:verbose`, `:hi Normal`, shell commands and their output,
  progress): a scrollable pager up to **half** of the screen.
- Search count, search pattern, completion, `:` completion list and confirm prompts stay in the command line.
- Output of a command typed on the command line stays in the command line, whatever its kind.
