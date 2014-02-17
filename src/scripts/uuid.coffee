# Taken from https://gist.github.com/bmc/1893440

# RFC1422-compliant Javascript UUID function. Generates a UUID from a random
# number (which means it might not be entirely unique, though it should be
# good enough for many uses). See http://stackoverflow.com/questions/105034
uuid = ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = if c is 'x' then r else (r & 0x3|0x8)
    v.toString(16)
  )
