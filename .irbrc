begin
  # tab completion
  require 'irb/completion'
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

  # we need rubygems first
  require 'rubygems'

  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end
