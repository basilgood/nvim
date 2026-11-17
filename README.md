# Time Track - Markdown Time Tracking for Neovim

A Neovim plugin for time tracking using structured Markdown files with automated report generation.

## Features

- Track time entries in human-readable Markdown format
- Generate automated reports (daily, weekly, project, category, custom range)
- Month calendar view with daily totals
- Project and category-based analysis
- Reports saved as Markdown files

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "your-username/time-track.nvim",
  config = function()
    require("time-track").setup({
      data_dir = "~/time-tracking",
      reports_dir = "~/time-tracking/reports",
    })
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "your-username/time-track.nvim",
  config = function()
    require("time-track").setup({
      data_dir = "~/time-tracking",
      reports_dir = "~/time-tracking/reports",
    })
  end,
}
```

## Configuration

```lua
require("time-track").setup({
  -- Directory where time entry files are stored (default: ~/time-tracking)
  data_dir = "~/time-tracking",

  -- Directory where reports are saved (default: ~/time-tracking/reports)
  reports_dir = "~/time-tracking/reports",

  -- Week start day (default: "sunday")
  week_start = "monday",
})
```

## Usage

### Time Entry Format

Create daily files in your `data_dir` with the format `YYYY-MM-DD.md`:

# 2026-03-22

## Website Redesign
**09:00 - 10:30** (1.5h) - Navigation component
- category: Development
- tags: frontend, react

**10:45 - 12:00** (1.25h) - Header styling
- category: Design
- tags: css, responsive

## Meeting
**14:00 - 15:00** (1h) - Sprint planning
- category: Meeting
- tags: planning

### Commands

| Command | Arguments | Description |
|---------|-----------|-------------|
| `:TimeTrackMonth` | `[YYYY-MM]` | Show month calendar |
| `:TimeTrackDaily` | `[YYYY-MM-DD]` | Generate daily report |
| `:TimeTrackWeekly` | `[YYYY-WW]` | Generate weekly report |
| `:TimeTrackProject` | `<project-name>` | Generate project report |
| `:TimeTrackCategory` | `<category-name>` | Generate category report |
| `:TimeTrackRange` | `<start> <end>` | Generate custom range report |

### Examples

```vim
" Show current month calendar
:TimeTrackMonth

" Show specific month
:TimeTrackMonth 2026-03

" Generate daily report for today
:TimeTrackDaily

" Generate daily report for specific date
:TimeTrackDaily 2026-03-22

" Generate weekly report
:TimeTrackWeekly

" Generate project report
:TimeTrackProject "Website Redesign"

" Generate category report
:TimeTrackCategory Development

" Generate custom range report
:TimeTrackRange 2026-03-01 2026-03-31
```

## Report Output

Reports are saved as Markdown files in your `reports_dir` and automatically opened in Neovim.

Example daily report:

# Daily Report: 2026-03-22

## Summary
- **Total Hours:** 6.75
- **Projects:** 2
- **Categories:** 3

## Entries

| Time | Duration | Project | Category | Description |
|------|----------|---------|----------|-------------|
| 09:00–10:30 | 1.50h | Website Redesign | Development | Navigation component |
| 10:45-h12:00 | 1.25h | Website Redesign | Design | Header styling |
| 14:00-h15:00 | 1.00h | Meeting | Meeting | Sprint planning |

## By Project

| Project | Hours | % of Total |
|---------|-------|------------|
| Website Redesign | 4.75h | 70.4% |
| Meeting | 1.00h | 14.8% |

## By Category

| Category | Hours | % of Total |
|----------|-------|------------|
| Development | 2.50h | 37.0% |
| Design | 1.25h | 18.5% |
| Meeting | 1.00h | 14.8% |

## License

MIT
