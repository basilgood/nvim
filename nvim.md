## 1.1 Messages
- replace noice plugin with tiny-cmdline.nvim plugin
  it will show the `:` comline asa floating box centered , **20%** from the top.
- In sesnsible.lua add config for ui2 (uncomment it and add replace its options with the below options):
  - Short messages: corner popup uo to **30%** of the screen tall, gone after 5 sec.
  - Long output (errors, listing like `:ls`, `:verbose`, `:hi Normal`, shell commands and their output, progress): a scrollable
    pager up to **half** of the screen.
  - Search count, search pattern, completion, `:` completion list , and confirm prompts stay in the command line.
  - Output of a command I type goes to the command line too, whatever its kind.
    It expands over the bottom of the screen until the next day, and `Enter` moves it into the pager.
