# Iteratively run shell commands from a template
# -----
# Given a template such as 'ls {}' this command will repeatedly
# ask for input and execute the template with '{}' replaced by
# the input. For example, with template 'ls {}' if '-a' is entiered
# in the prompt, the script will execute 'ls -a', show the result
# and ask for input again.

# Usage: ruby iter.ruby [template]
#   - template: a string with '{}' denoting places to be replaced.

require 'readline'

template = ARGV.join(' ')
while true do
  line = Readline.readline("> ", true)
  system(template.gsub(/{}/, line))
end

