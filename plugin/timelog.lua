local timelog_file = 'timelog.md'
local current_task_label = nil -- Variable to store the current task label

local function send_notification(message)
  vim.notify(message, 'INFO', { title = 'Time Logger' })
end

local function is_task_in_progress(task_label)
  local file, err = io.open(timelog_file, 'r')
  if not file then
    send_notification('Error opening file: ' .. err)
    return false
  end

  local in_progress = false
  for line in file:lines() do
    if
      line:match('%[Task:%s*' .. task_label .. '%s*%]')
      and line:match('Start Time:')
      and not line:match('Stop Time:')
    then
      in_progress = true
      break
    end
  end
  file:close()
  return in_progress
end

local function log_start_time()
  local task_label = vim.fn.input('Enter task label (leave empty to cancel): ') -- Prompt for task label

  if task_label == '' then
    send_notification('Task creation cancelled.')
    return
  end

  if is_task_in_progress(task_label) then
    local choice =
      vim.fn.input("Task '" .. task_label .. "' is already in progress. Do you want to continue? (yes/no): ")
    if choice:lower() ~= 'yes' then
      send_notification('Continuing with a new task.')
      task_label = vim.fn.input('Enter new task label: ') -- Prompt for a new task label
      if task_label == '' then
        send_notification('Task creation cancelled.')
        return -- Exit if the new input is also empty
      end
    end
  end

  current_task_label = task_label -- Set the current task label
  local start_time = os.date('%Y-%m-%d %H:%M:%S') -- Get the current time
  local log_entry = '[Task:] ' .. current_task_label .. '\n    Start Time: ' .. start_time .. '\n' -- Format the log entry

  local file, err = io.open(timelog_file, 'a')
  if not file then
    send_notification('Error opening file: ' .. err)
    return
  end

  file:write(log_entry)
  file:close()
  send_notification('Logged Start Time: ' .. start_time .. ' for task: ' .. current_task_label)
end

local function log_stop_time()
  if not current_task_label then
    send_notification('No task is currently being logged. Please start a task first.')
    return
  end

  local stop_time = os.date('%Y-%m-%d %H:%M:%S') -- Get the current time
  local log_entry = '    Stop Time: ' .. stop_time .. '\n' -- Format the log entry

  local file, err = io.open(timelog_file, 'a')
  if not file then
    send_notification('Error opening file: ' .. err)
    return
  end

  file:write(log_entry)
  file:close()
  send_notification('Logged Stop Time: ' .. stop_time .. ' for task: ' .. current_task_label)

  current_task_label = nil
end

local function show_summary()
  local file, err = io.open(timelog_file, 'r')
  if not file then
    send_notification('Error opening file: ' .. err)
    return
  end

  local total_time = 0
  local start_times = {}

  for line in file:lines() do
    local start_time = line:match('Start Time: (.+)')
    local stop_time = line:match('Stop Time: (.+)')

    if start_time then
      table.insert(
        start_times,
        os.time({
          year = string.sub(start_time, 1, 4),
          month = string.sub(start_time, 6, 7),
          day = string.sub(start_time, 9, 10),
          hour = string.sub(start_time, 12, 13),
          min = string.sub(start_time, 15, 16),
          sec = string.sub(start_time, 18, 19),
        })
      )
    end

    if stop_time and #start_times > 0 then
      local stop_time_epoch = os.time({
        year = string.sub(stop_time, 1, 4),
        month = string.sub(stop_time, 6, 7),
        day = string.sub(stop_time, 9, 10),
        hour = string.sub(stop_time, 12, 13),
        min = string.sub(stop_time, 15, 16),
        sec = string.sub(stop_time, 18, 19),
      })
      total_time = total_time + (stop_time_epoch - start_times[#start_times])
      table.remove(start_times)
    end
  end
  file:close()
  send_notification('Total time: ' .. os.date('%H:%M:%S', total_time))
end

-- Key mappings
vim.keymap.set('n', '<C-n>', log_start_time, { noremap = true, silent = true })
vim.keymap.set('n', '<C-m>', log_stop_time, { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', show_summary, { noremap = true, silent = true })
