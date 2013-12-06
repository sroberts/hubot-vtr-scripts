# Description:
#   Generate Yara Rule with strings
#
#   None
#
# Configuration:
#   None…
#
# Commands:
#   hubot yara template - Generates default rule template
#   hubot yara new name:category str1, str2, str3
#
# Author:
#   Scott J Roberts - @sroberts

module.exports = (robot) ->
  robot.respond /yara template/i, (msg) ->
    # Default Values
    yara_rule_name = "rule_name"
    yara_rule_category = "category"
    yara_meta_author = "Hubot"
    yara_meta_date = "2013-01-01"
    yara_meta_description = "Default Rule Template"
    yara_strings_list = ['foo', 'bar', 'baz']

    # If there's strings generate rule with strings

    # Generate Strings Section
    # yara_conditions = 0
    # yara_strings_parsed = ""
    #
    # for yara_string in yara_strings_list
    #   yara_strings_parsed += "    string#{yara_conditions} '#{yara_string}'\n"
    #   yara_conditions++

    new_rule = """
    rule #{yara_rule_name} : #{yara_rule_category}
    {
      meta:
        author = '#{yara_meta_author}'
        date = '#{yara_meta_date}'
        description = '#{yara_meta_description}'
      strings:
        $string0 = "foo"
        $string1 = "bar"
        $string2 = "baz" wide
    condition:
        3 of them
    }
    """
    msg.send new_rule

  robot.respond /yara new ([A-Za-z0-9\:]+) (.*)/i, (msg) ->
    # Default Values
    msg.send "Creating new Yara signature"
    # msg.send msg.match[1]
    # msg.send msg.match[2]
    #
    # yara_rule_name_category = msg.match[1].toLowerCase()
    # yara_meta_author =  msg.message.user
    # yara_meta_date = new Date
    # yara_meta_description = "Default Rule Template"
    # yara_strings_list = msg.match[2].split ",".replace /^\s+|\s+$/g, ""
    #
    # new_rule = """
    # rule #{yara_rule_name_category}
    # {
    #   meta:
    #     author = '#{yara_meta_author}'
    #     date = '#{yara_meta_date}'
    #     description = '#{yara_meta_description}'
    #   strings:
    #     $string0 = "foo"
    #     $string1 = "bar"
    #     $string2 = "baz" wide
    # condition:
    #     any of them
    # }
    # """
    # msg.send new_rule
