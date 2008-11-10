module Clojure::Util
  module_function
    
  # Given a body of text, a line, and a column, returns the absolute offset of the line+column in the text
  def get_absolute_offset(str, line, col)
    split = str.split("\n")
    split[0...line-1].join("\n").length + col
  end
  
  def connect_terminal(screen_name)
    script = nil
    if ENV['TM_TERMINAL'] =~ /^iterm$/i || Clojure::Util.is_running('iTerm')
      script = iterm_script(screen_name)
    else
      script = terminal_script(screen_name)
    end
    open("|osascript", "w") { |io| io << script }
  end
  
  def is_running(process)
    all = `ps -U "$USER" -o ucomm`
    all.to_a[1..-1].find { |cmd| process == cmd.strip }
  end


  def terminal_script(screen)
    return <<-APPLESCRIPT
      tell application "Terminal"
        activate
        do script "screen -x #{e_sh screen}"
      end tell
  APPLESCRIPT
  end

  def iterm_script(screen)
    return <<-APPLESCRIPT
      tell application "iTerm"
        activate
        if exists the first terminal then
          set myterm to the first terminal
        else
          set myterm to (make new terminal)
        end if
        
        tell myterm
          activate current session
          launch session "Default Session"

          tell the last session
            write text "screen -x #{e_sh screen}"
          end tell
        end tell
        
      end tell
  APPLESCRIPT
  end
end
