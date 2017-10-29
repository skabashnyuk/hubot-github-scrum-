# Description
#   Manage Scrum sprints on github
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot scrum status

# Notes:
#   <optional notes required for the script>
#
# Author:
#   Sergii Kabashniuk <skabashniuk@redhat.com>


SCRUM_TEAM = process.env.HUBOT_GH_SCRUM_TEAM
#SCRUM_REPO = process.env.HUBOT_GH_SCRUM_REPO
SCRUM_REPO = "codenvy/planning"

module.exports = (robot) ->

 robot.respond /scrum/, (msg) ->
    robot.ghscrum.status msg, 159, SCRUM_REPO
